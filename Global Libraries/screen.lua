stdout	= print

function pprint(...)
	stdout(...)
	local out	= ""
	for _,v in ipairs({...}) do 
		out	=	out .. (_==1 and "" or "    ") .. tostring(v)
	end
	var.store("print", out)
end


function Pr(n, d, s, ex)
	local nc	= tonumber(n)
	if nc and nc<math.abs(nc) then
		return s-ex-(type(n)== "number" and math.abs(n) or (.01*s*math.abs(nc)))
	else
		return (type(n)=="number" and n or (type(n)=="string" and .01*s*nc or d))
	end
end

-- Apply an extension on a class, and return our new frankenstein 
function addExtension(oldclass, extension)
	local newclass	= class(oldclass)
	for key, data in pairs(extension) do
		newclass[key]	= data
	end
	return newclass
end

clipRectData	= {}

function gc_clipRect(gc, what, x, y, w, h)
	if what == "set" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		
	elseif what == "subset" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		x	= clipRectData.old.x<x and x or clipRectData.old.x
		y	= clipRectData.old.y<y and y or clipRectData.old.y
		h	= clipRectData.old.y+clipRectData.old.h > y+h and h or clipRectData.old.y+clipRectData.old.h-y
		w	= clipRectData.old.x+clipRectData.old.w > x+w and w or clipRectData.old.x+clipRectData.old.w-x
		what = "set"
		
	elseif what == "restore" and clipRectData.old then
		--gc:clipRect("reset")
		what = "set"
		x	= clipRectData.old.x
		y	= clipRectData.old.y
		h	= clipRectData.old.h
		w	= clipRectData.old.w
	elseif what == "restore" then
		what = "reset"
	end
	
	gc:clipRect(what, x, y, w, h)
	if x and y and w and h then clipRectData.current = {x=x,y=y,w=w,h=h} end
end

------------------------------------------------------------------
--                        Screen  Class                         --
------------------------------------------------------------------

Screen	=	class()

Screens	=	{}

function push_screen(screen, ...)
	current_screen():screenLoseFocus()
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function only_screen(screen, ...)
	current_screen():screenLoseFocus()
	Screens	=	{screen}
	platform.window:invalidate()
	screen:pushed(...)	
end

function remove_screen(...)
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens)
	current_screen():screenGetFocus()
	return res
end

function current_screen()
	return Screens[#Screens] or DummyScreen
end

function Screen:init(xx,yy,ww,hh)
	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	
	self:ext()
	self:size(0)
end

function Screen:ext()
end

function Screen:size()
	local screenH	=	platform.window:height()
	local screenW	=	platform.window:width()

	if screenH	== 0 then screenH=212 end
	if screenW	== 0 then screenW=318 end

	self.x	=	math.floor(Pr(self.xx, 0, screenW)+.5)
	self.y	=	math.floor(Pr(self.yy, 0, screenH)+.5)
	self.w	=	math.floor(Pr(self.ww, screenW, screenW, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, screenH, screenH, 0)+.5)
end


function Screen:pushed() end
function Screen:removed() end
function Screen:screenLoseFocus() end
function Screen:screenGetFocus() end

function Screen:draw(gc)
	self:size()
	self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey()	end
function Screen:enterKey()	end
function Screen:backspaceKey()	end
function Screen:escapeKey()	end
function Screen:tabKey()	end
function Screen:backtabKey()	end
function Screen:charIn(char)	end


function Screen:mouseDown()	end
function Screen:mouseUp()	end
function Screen:mouseMove()	end
function Screen:contextMenu()	end

function Screen:appended() end

function Screen:destroy()
	self	= nil
end

------------------------------------------------------------------
--                   WidgetManager Extension                    --
------------------------------------------------------------------

WidgetManager	= {}

function WidgetManager:ext()
	self.widgets	=	{}
	self.focus	=	0
end

function WidgetManager:appendWidget(widget, xx, yy) 
	widget.xx	=	xx
	widget.yy	=	yy
	widget.parent	=	self
	widget:size()
	
	table.insert(self.widgets, widget)
	widget.pid	=	#self.widgets
	
	widget:appended(self)
	return self
end

function WidgetManager:getWidget()
	return self.widgets[self.focus]
end

function WidgetManager:drawWidgets(gc) 
	for _, widget in pairs(self.widgets) do
		widget:size()
		widget:draw(gc)
		
		gc:setColorRGB(0,0,0)
	end
end

function WidgetManager:postPaint(gc) 
end

function WidgetManager:draw(gc)
	self:size()
	self:paint(gc)
	self:drawWidgets(gc)
	self:postPaint(gc)
end


function WidgetManager:loop(n) end

function WidgetManager:stealFocus(n)
	local oldfocus=self.focus
	if oldfocus~=0 then
		local veto	= self:getWidget():loseFocus(n)
		if veto == -1 then
			return -1, oldfocus
		end
		self:getWidget().hasFocus	=	false
		self.focus	= 0
	end
	return 0, oldfocus
end

function WidgetManager:focusChange() end

function WidgetManager:switchFocus(n, b)
	if n~=0 and #self.widgets>0 then
		local veto, focus	= self:stealFocus(n)
		if veto == -1 then
			return -1
		end
		
		local looped
		self.focus	=	focus + n
		if self.focus>#self.widgets then
			self.focus	=	1
			looped	= true
		elseif self.focus<1 then
			self.focus	=	#self.widgets
			looped	= true
		end	
		if looped and self.noloop and not b then
			self.focus	= focus
			self:loop(n)
		else
			self:getWidget().hasFocus	=	true	
			self:getWidget():getFocus(n)
		end
	end
	self:focusChange()
end


function WidgetManager:arrowKey(arrow)	
	if self.focus~=0 then
		self:getWidget():arrowKey(arrow)
	end
	self:invalidate()
end

function WidgetManager:enterKey()	
	if self.focus~=0 then
		self:getWidget():enterKey()
	end
	self:invalidate()
end

function WidgetManager:backspaceKey()
	if self.focus~=0 then
		self:getWidget():backspaceKey()
	end
	self:invalidate()
end

function WidgetManager:escapeKey()	
	if self.focus~=0 then
		self:getWidget():escapeKey()
	end
	self:invalidate()
end

function WidgetManager:tabKey()	
	self:switchFocus(1)
	self:invalidate()
end

function WidgetManager:backtabKey()	
	self:switchFocus(-1)
	self:invalidate()
end

function WidgetManager:charIn(char)
	if self.focus~=0 then
		self:getWidget():charIn(char)
	end
	self:invalidate()
end

function WidgetManager:getWidgetIn(x, y)
	for n, widget in pairs(self.widgets) do
		local wox	= widget.ox or 0
		local woy	= widget.oy or 0
		if x>=widget.x-wox and y>=widget.y-wox and x<widget.x+widget.w-wox and y<widget.y+widget.h-woy then
			return n, widget
		end
	end 
end

function WidgetManager:mouseDown(x, y) 
	local n, widget	=	self:getWidgetIn(x, y)
	if n then
		if self.focus~=0 and self.focus~=n then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	n
		
		widget.hasFocus	=	true
		widget:getFocus()

		widget:mouseDown(x, y)
		self:focusChange()
	else
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus() end
		self.focus	=	0
	end
end
function WidgetManager:mouseUp(x, y)
	if self.focus~=0 then
		self:getWidget():mouseUp(x, y)
	end
	self:invalidate()
end
function WidgetManager:mouseMove(x, y)
	if self.focus~=0 then
		self:getWidget():mouseMove(x, y)
	end
end

--------------------------
-- Our new frankenstein --
--------------------------

WScreen	= addExtension(Screen, WidgetManager)



--Dialog screen

Dialog	=	class(WScreen)

function Dialog:init(title,xx,yy,ww,hh)
	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	self.title	=	title
	self:size()
	
	self.widgets	=	{}
	self.focus	=	0
end

function Dialog:paint(gc)
	self.xx	= (pww()-self.w)/2
	self.yy	= (pwh()-self.h)/2
	self.x, self.y	= self.xx, self.yy
	
	gc:setFont("sansserif","r",10)
	gc:setColorRGB(224,224,224)
	gc:fillRect(self.x, self.y, self.w, self.h)

	for i=1, 14,2 do
		gc:setColorRGB(32+i*3, 32+i*4, 32+i*3)
		gc:fillRect(self.x, self.y+i, self.w,2)
	end
	gc:setColorRGB(32+16*3, 32+16*4, 32+16*3)
	gc:fillRect(self.x, self.y+15, self.w, 10)
	
	gc:setColorRGB(128,128,128)
	gc:drawRect(self.x, self.y, self.w, self.h)
	gc:drawRect(self.x-1, self.y-1, self.w+2, self.h+2)
	
	gc:setColorRGB(96,100,96)
	gc:fillRect(self.x+self.w+1, self.y, 1, self.h+2)
	gc:fillRect(self.x, self.y+self.h+2, self.w+3, 1)
	
	gc:setColorRGB(104,108,104)
	gc:fillRect(self.x+self.w+2, self.y+1, 1, self.h+2)
	gc:fillRect(self.x+1, self.y+self.h+3, self.w+3, 1)
	gc:fillRect(self.x+self.w+3, self.y+2, 1, self.h+2)
	gc:fillRect(self.x+2, self.y+self.h+4, self.w+2, 1)
			
	gc:setColorRGB(255,255,255)
	gc:drawString(self.title, self.x + 4, self.y+2, "top")
	
	self:postPaint(gc)
end

function Dialog:postPaint() end







---
-- The dummy screen
---

DummyScreen	= Screen()


------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc)	
    allWentWell, generalErrMsg = pcall(onpaint, gc)
    if not allWentWell and errorHandler then
        errorHandler.display = true
        errorHandler.errorMessage = generalErrMsg
    end
end

function onpaint(gc)
	for _, screen in pairs(Screens) do
		screen:draw(gc)	
	end
	if errorHandler.display then
	    errorPopup(gc)
	end
end

function on.resize(x, y)
	-- Global Ratio Constants for On-Calc (shouldn't be used often though...)
	kXRatio = x/320
	kYRatio = y/212
end

function on.timer()			current_screen():timer()		 end
function on.arrowKey(arrw)	current_screen():arrowKey(arrw)  end
function on.enterKey()		current_screen():enterKey()		 end
function on.escapeKey()		current_screen():escapeKey()	 end
function on.tabKey()		current_screen():tabKey()		 end
function on.backtabKey()	current_screen():backtabKey()	 end
function on.charIn(ch)		current_screen():charIn(ch)		 end
function on.backspaceKey()	current_screen():backspaceKey()  end
function on.contextMenu()	current_screen():contextMenu()   end
function on.mouseDown(x,y)	current_screen():mouseDown(x,y)	 end
function on.mouseUp(x,y)	current_screen():mouseUp(x,y)	 end
function on.mouseMove(x,y)	current_screen():mouseMove(x,y)  end

