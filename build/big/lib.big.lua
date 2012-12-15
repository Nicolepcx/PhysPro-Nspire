
----------

local tstart = timer.start
function timer.start(ms)
    if not timer.isRunning then
        tstart(ms)
    end
    timer.isRunning = true
end

local tstop = timer.stop
function timer.stop()
    timer.isRunning = false
    tstop()
end


if platform.hw then
    timer.multiplier = platform.hw() < 4 and 3.2 or 1
else
    timer.multiplier = platform.isDeviceModeRendering() and 3.2 or 1
end

function on.timer()
    --current_screen():timer()
    local j = 1
    while j <= #timer.tasks do -- for each task
        if timer.tasks[j][2]() then -- delete it if has ended
            table.remove(timer.tasks, j)
            sj = j - 1
        end
        j = j + 1
    end
    if #timer.tasks > 0 then
        platform.window:invalidate()
    else
        --for _,screen in pairs(Screens) do
        --    screen:size()
        --end
        timer.stop()
    end
end

timer.tasks = {}

timer.addTask = function(object, task) timer.start(0.01) table.insert(timer.tasks, { object, task }) end

function timer.purgeTasks(object)
    local j = 1
    while j <= #timer.tasks do
        if timer.tasks[j][1] == object then
            table.remove(timer.tasks, j)
            j = j - 1
        end
        j = j + 1
    end
end


---------- Animable Object class
Object = class()
function Object:init(x, y, w, h, r)
    self.tasks = {}
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r = r
    self.visible = true
end

function Object:PushTask(task, t, ms, callback)
    table.insert(self.tasks, { task, t, ms, callback })
    timer.start(0.01)
    if #self.tasks == 1 then
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:PopTask()
    table.remove(self.tasks, 1)
    if #self.tasks > 0 then
        local task, t, ms, callback = unpack(self.tasks[1])
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:purgeTasks()
    for i = 1, #self.tasks do
        self.tasks[i] = nil
    end
    collectgarbage()
    timer.purgeTasks(self)
    self.tasks = {}
    return self
end

function Object:paint(gc)
    -- to override
end

speed = 1

function Object:__Animate(t, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    if not t or type(t) ~= "table" then print("Error: Target position is " .. type(t)) return end
    if not t.x then t.x = self.x end
    if not t.y then t.y = self.y end
    if not t.w then t.w = self.w end
    if not t.h then t.h = self.h end
    if not t.r then t.r = self.r else t.r = math.pi * t.r / 180 end
    local xinc = (t.x - self.x) / ms
    local xside = xinc >= 0 and 1 or -1
    local yinc = (t.y - self.y) / ms
    local yside = yinc >= 0 and 1 or -1
    local winc = (t.w - self.w) / ms
    local wside = winc >= 0 and 1 or -1
    local hinc = (t.h - self.h) / ms
    local hside = hinc >= 0 and 1 or -1
    local rinc = (t.r - self.r) / ms
    local rside = rinc >= 0 and 1 or -1
    timer.addTask(self, function()
        local b1, b2, b3, b4, b5 = false, false, false, false, false
        if (self.x + xinc * speed) * xside < t.x * xside then self.x = self.x + xinc * speed else b1 = true end
        if self.y * yside < t.y * yside then self.y = self.y + yinc * speed else b2 = true end
        if self.w * wside < t.w * wside then self.w = self.w + winc * speed else b3 = true end
        if self.h * hside < t.h * hside then self.h = self.h + hinc * speed else b4 = true end
        if self.r * rside < t.r * rside then self.r = self.r + rinc * speed else b5 = true end
        if self.w < 0 then self.w = 0 end
        if self.h < 0 then self.h = 0 end
        if b1 and b2 and b3 and b4 and b5 then
            self.x, self.y, self.w, self.h, self.r = t.x, t.y, t.w, t.h, t.r
            self:PopTask()
            if callback then callback(self) end
            return true
        end
        return false
    end)
    return true
end

function Object:__Delay(_, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    local t = 0
    timer.addTask(self, function()
        if t < ms then
            t = t + 1
            return false
        else
            self:PopTask()
            if callback then callback(self) end
            return true
        end
    end)
    return true
end

function Object:__setVisible(t, _, _)
    timer.addTask(self, function()
        self.visible = t
        self:PopTask()
        return true
    end)
    return true
end

function Object:Animate(t, ms, callback)
    self:PushTask(self.__Animate, t, ms, callback)
    return self
end

function Object:Delay(ms, callback)
    self:PushTask(self.__Delay, false, ms, callback)
    return self
end

function Object:setVisible(t)
    self:PushTask(self.__setVisible, t, 1, false)
    return self
end
------------------------------------------------------------------
--                  Overall Global Variables                    --
------------------------------------------------------------------
--
-- Uses BetterLuaAPI : https://github.com/adriweb/BetterLuaAPI-for-TI-Nspire
--

a_acute = string.uchar(225)
a_circ  = string.uchar(226)
a_tilde = string.uchar(227)
a_diaer = string.uchar(228)
a_ring  = string.uchar(229)
e_acute = string.uchar(233)
e_grave = string.uchar(232)
o_acute = string.uchar(243) 
o_circ  = string.uchar(244)
l_alpha = string.uchar(945)
l_beta = string.uchar(946)
l_omega = string.uchar(2126)
sup_plus = string.uchar(8314)
sup_minus = string.uchar(8315)
right_arrow = string.uchar(8594)


Color = {
    ["black"] = {0, 0, 0},
    ["red"] = {255, 0, 0},
    ["green"] = {0, 255, 0},
    ["blue "] = {0, 0, 255},
    ["white"] = {255, 255, 255},
    ["brown"] = {165,42,42},
    ["cyan"] = {0,255,255},
    ["darkblue"] = {0,0,139},
    ["darkred"] = {139,0,0},
    ["fuchsia"] = {255,0,255},
    ["gold"] = {255,215,0},
    ["gray"] = {127,127,127},
    ["grey"] = {127,127,127},
    ["lightblue"] = {173,216,230},
    ["lightgreen"] = {144,238,144},
    ["magenta"] = {255,0,255},
    ["maroon"] = {128,0,0},
    ["navyblue"] = {159,175,223},
    ["orange"] = {255,165,0},
    ["palegreen"] = {152,251,152},
    ["pink"] = {255,192,203},
    ["purple"] = {128,0,128},
    ["royalblue"] = {65,105,225},
    ["salmon"] = {250,128,114},
    ["seagreen"] = {46,139,87},
    ["silver"] = {192,192,192},
    ["turquoise"] = {64,224,208},
    ["violet"] = {238,130,238},
    ["yellow"] = {255,255,0}
}
Color.mt = {__index = function () return {0,0,0} end}
setmetatable(Color,Color.mt)

function copyTable(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function deepcopy(t) -- This function recursively copies a table's contents, and ensures that metatables are preserved. That is, it will correctly clone a pure Lua object.
    if type(t) ~= 'table' then return t end
    local mt = getmetatable(t)
    local res = {}
    for k,v in pairs(t) do
        if type(v) == 'table' then
        v = deepcopy(v)
        end
    res[k] = v
    end
    setmetatable(res,mt)
    return res
end -- from http://snippets.luacode.org/snippets/Deep_copy_of_a_Lua_Table_2

function utf8(nbr)
    return string.uchar(nbr)
end

function test(arg)
    return arg and 1 or 0
end

function screenRefresh()
    return platform.window:invalidate()
end

function pww()
    return platform.window:width()
end

function pwh()
    return platform.window:height()
end

function drawPoint(gc, x, y)
    gc:fillRect(x, y, 1, 1)
end

function drawCircle(gc, x, y, diameter)
    gc:drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

function drawCenteredString(gc, str)
    gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), .5*pwh(), "middle")
end

function drawXCenteredString(gc, str, y)
    gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), y, "top")
end

function setColor(gc,theColor)
    if type(theColor) == "string" then
        theColor = string.lower(theColor)
        if type(Color[theColor]) == "table" then gc:setColorRGB(unpack(Color[theColor])) end
    elseif type(theColor) == "table" then
        gc:setColorRGB(unpack(theColor))
    end
end

function verticalBar(gc,x)
    gc:fillRect(gc,x,0,1,pwh())
end

function horizontalBar(gc,y)
    gc:fillRect(gc,0,y,pww(),1)
end

function nativeBar(gc, screen, y)
    gc:setColorRGB(128,128,128)
    gc:fillRect(screen.x+5, screen.y+y, screen.w-10, 2)
end

function drawSquare(gc,x,y,l)
    gc:drawPolyLine(gc,{(x-l/2),(y-l/2), (x+l/2),(y-l/2), (x+l/2),(y+l/2), (x-l/2),(y+l/2), (x-l/2),(y-l/2)})
end

function drawRoundRect(gc,x,y,wd,ht,rd)  -- wd = width, ht = height, rd = radius of the rounded corner
    x = x-wd/2  -- let the center of the square be the origin (x coord)
    y = y-ht/2 -- same for y coord
    if rd > ht/2 then rd = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max rd)
    gc:drawLine(x + rd, y, x + wd - (rd), y);
    gc:drawArc(x + wd - (rd*2), y + ht - (rd*2), rd*2, rd*2, 270, 90);
    gc:drawLine(x + wd, y + rd, x + wd, y + ht - (rd));
    gc:drawArc(x + wd - (rd*2), y, rd*2, rd*2,0,90);
    gc:drawLine(x + wd - (rd), y + ht, x + rd, y + ht);
    gc:drawArc(x, y, rd*2, rd*2, 90, 90);
    gc:drawLine(x, y + ht - (rd), x, y + rd);
    gc:drawArc(x, y + ht - (rd*2), rd*2, rd*2, 180, 90);
end

function fillRoundRect(gc,x,y,wd,ht,radius)  -- wd = width and ht = height -- renders badly when transparency (alpha) is not at maximum >< will re-code later
    if radius > ht/2 then radius = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
    gc:fillPolygon({(x-wd/2),(y-ht/2+radius), (x+wd/2),(y-ht/2+radius), (x+wd/2),(y+ht/2-radius), (x-wd/2),(y+ht/2-radius), (x-wd/2),(y-ht/2+radius)})
    gc:fillPolygon({(x-wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y+ht/2), (x-wd/2+radius),(y+ht/2), (x-wd/2+radius),(y-ht/2)})
    x = x-wd/2  -- let the center of the square be the origin (x coord)
    y = y-ht/2 -- same
    gc:fillArc(x + wd - (radius*2), y + ht - (radius*2), radius*2, radius*2, 1, -91);
    gc:fillArc(x + wd - (radius*2), y, radius*2, radius*2,-2,91);
    gc:fillArc(x, y, radius*2, radius*2, 85, 95);
    gc:fillArc(x, y + ht - (radius*2), radius*2, radius*2, 180, 95);
end


-- Fullscreen 'Library'

doNotDisplayIcon = true

icon=image.new("\020\0\0\0\020\0\0\0\0\0\0\0\040\0\0\0\016\0\001\000wwwwwwwwwwwwww\223\251\222\251\189\251\188\251\188\251\221\255\221\255\254\255wwwwwwwwwwwwwwwwwwww\156\243\024\227\215\218\214\218\247\222\025\227Z\235\156\243wwwwwwwwwwwwwwwwwwwwww\024\227S\202s\206\181\214\214\218\248\2229\2279\231Z\235Z\235wwwwwwwwwwwwwwwwwwZ\235\207\185\016\194R\202s\206\148\210\214\218\214\218\214\2229\231Z\235:\231wwwwwwwwwwwwww\190\251\239\189\239\189\148\210\148\210\156\247\148\214\214\218\147\210\181\218{\239\025\227Z\235|\239wwwwwwwwwwww\149\214\239\189\239\189\239\189\206\185{\239\206\185R\202R\202\148\214{\239\247\2229\227Z\231wwwwwwwwww\189\255\016\194\239\189\239\189\239\189\206\185{\239\173\181\016\194\016\194s\210Z\235\214\218\247\222\025\227\189\247wwwwwwww8\243\016\194\239\189\239\189\240\189\206\189{\239\206\185\016\194\207\185s\2109\235\148\210\214\218\024\223{\239wwwwww\254\255\244\238\239\189\206\185\207\185\206\185\140\177z\239\008\161\008\161\198\152\016\194\214\218\173\181\017\194t\206:\231wwwwww\188\2556\247\016\194\206\185k\173)\165\231\156{\239\132\144\133\144c\140\239\193\148\210\008\161l\173\239\1899\231wwwwwwx\255\154\255\240\189\231\156\132\144C\136B\136k\173\0\128B\136!\132\165\148\231\156B\136\165\148K\173\156\243wwwwww6\255\154\255\024\227\198\152c\140\206\185\206\185\173\181\207\185k\173)\165\206\185\239\189J\169c\140\173\181\222\251wwwwww6\255x\255ww\140\177\0\128\148\210\016\194\173\181R\202\173\181\206\185R\202\239\189\231\156\164\152\213\218wwwwwwwwx\2556\255ww\222\251J\169\008\161c\140c\140c\140c\140c\140c\140\008\169O\230o\234\178\242z\251wwwwww\221\255\209\250wwwwww\239\189\132\144d\140B\136d\140\132\144B\136\202\213\012\234\012\230\012\230-\234\189\251wwwwww\242\2506\255wwwwww\156\243\149\210\016\194\240\1892\202\247\222\236\221\147\222r\2220\214\146\222\245\238wwwwww\188\255\141\250\243\250wwwwwwwwwwwwww\021\251\168\221\136\217\169\213\236\213O\222Y\243wwwwwwww\188\255\142\250m\250\244\250X\255y\2557\255\177\250)\246(\246K\242\168\229\134\229\134\229\178\238wwwwwwwwwwwwwwW\255\175\250k\250J\250K\250\141\250\242\250y\255ww\188\2557\251z\251wwwwwwwwwwwwwwwwwwww\222\255\222\255\222\255wwwwwwwwwwwwwwwwwwwwww")

local pw    = getmetatable(platform.window)
function pw:invalidateAll()
    if self.setFocus then
        self:setFocus(false)
        self:setFocus(true)
    end
end

function on.draw(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(18, 5, 20, 20)
    gc:drawImage(icon, 18, 5)
end

if not platform.withGC then
    function platform.withGC(func, ...)
        local gc = platform.gc()
        gc:begin()
        func(..., gc)
        gc:finish()
    end
end



stdout = print

function pprint(...)
        stdout(...)
        local out        = ""
        for _,v in ipairs({...}) do 
                out = out .. (_==1 and "" or "    ") .. tostring(v)
        end
        var.store("print", out)
end


function Pr(n, d, s, ex)
        local nc = tonumber(n)
        if nc and nc<math.abs(nc) then
                return s-ex-(type(n)== "number" and math.abs(n) or (.01*s*math.abs(nc)))
        else
                return (type(n)=="number" and n or (type(n)=="string" and .01*s*nc or d))
        end
end

-- Apply an extension on a class, and return our new frankenstein 
function addExtension(oldclass, extension)
        local newclass        = class(oldclass)
        for key, data in pairs(extension) do
                newclass[key]        = data
        end
        return newclass
end

clipRectData = {}

function gc_clipRect(gc, what, x, y, w, h)
        if what == "set" and clipRectData.current then
                clipRectData.old = clipRectData.current
                
        elseif what == "subset" and clipRectData.current then
                clipRectData.old = clipRectData.current
                x = clipRectData.old.x<x and x or clipRectData.old.x
                y = clipRectData.old.y<y and y or clipRectData.old.y
                h = clipRectData.old.y+clipRectData.old.h > y+h and h or clipRectData.old.y+clipRectData.old.h-y
                w = clipRectData.old.x+clipRectData.old.w > x+w and w or clipRectData.old.x+clipRectData.old.w-x
                what = "set"
                
        elseif what == "restore" and clipRectData.old then
                --gc:clipRect("reset")
                what = "set"
                x = clipRectData.old.x
                y = clipRectData.old.y
                h = clipRectData.old.h
                w = clipRectData.old.w
        elseif what == "restore" then
                what = "reset"
        end
        
        gc:clipRect(what, x, y, w, h)
        if x and y and w and h then clipRectData.current = {x=x,y=y,w=w,h=h} end
end

------------------------------------------------------------------
--                        Screen  Class                         --
------------------------------------------------------------------

Screen = class(Object)

Screens = {}

function scrollScreen(screen, d, callback)
  --  print("scrollScreen.  number of screens : ", #Screens)
    local dir = d or 1
    screen.x=dir*kXSize
    screen:Animate( {x=0}, 10, callback )
end

function insertScreen(screen, ...)
  --  print("insertScreen")
        screen:size()
    if current_screen() ~= DummyScreen then
        current_screen():screenLoseFocus()
        local coeff = pushFromBack and 1 or -1
            current_screen():Animate( {x=coeff*kXSize}, 10)
    end
        table.insert(Screens, screen)

        platform.window:invalidate()
        current_screen():pushed(...)
end

function insertScreen_direct(screen, ...)
  --  print("insertScreen_direct")
        screen:size()
        table.insert(Screens, screen)
        platform.window:invalidate()
        current_screen():pushed(...)
end

function push_screen(screen, ...)
    --print("push_screen")
    local args = ...
    local theScreen = current_screen()
    pushFromBack = false
    insertScreen(screen, ...)
    scrollScreen(screen, 1, function() remove_screen_previous(theScreen) end)
end

function push_screen_back(screen, ...)
    --print("push_screen_back")
    local theScreen = current_screen()
    pushFromBack = true
    insertScreen(screen, ...)
    scrollScreen(screen, -1, function() remove_screen_previous(theScreen) end)
end

function push_screen_direct(screen, ...)
   -- print("push_screen_direct")
        table.insert(Screens, screen)
        platform.window:invalidate()
        current_screen():pushed(...)
end

function only_screen(screen, ...)
   -- print("only_screen")
    remove_screen(current_screen())
        Screens = {}
        push_screen(screen, ...)
        platform.window:invalidate()
end

function only_screen_back(screen, ...)
 --   print("only_screen_back")
    --Screens = {}
        push_screen_back(screen, ...)
        platform.window:invalidate()
end

function remove_screen_previous(...)
  --  print("remove_screen_previous")
        platform.window:invalidate()
        current_screen():removed(...)
        res=table.remove(Screens, #Screens-1)
        current_screen():screenGetFocus()
        return res
end

function remove_screen(...)
  --  print("remove_screen")
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

        self.yy = yy
        self.xx = xx
        self.hh = hh
        self.ww = ww
        
        self:ext()
        self:size(0)
        
        Object.init(self, self.x, self.y, self.w, self.h, 0)
end

function Screen:ext()
end

function Screen:size()
        local screenH = platform.window:height()
        local screenW =  platform.window:width()

        if screenH == 0 then screenH=212 end
        if screenW == 0 then screenW=318 end

        self.x        =        math.floor(Pr(self.xx, 0, screenW)+.5)
        self.y        =        math.floor(Pr(self.yy, 0, screenH)+.5)
        self.w        =        math.floor(Pr(self.ww, screenW, screenW, 0)+.5)
        self.h        =        math.floor(Pr(self.hh, screenH, screenH, 0)+.5)
end


function Screen:pushed() end
function Screen:removed() end
function Screen:screenLoseFocus() end
function Screen:screenGetFocus() end

function Screen:draw(gc)
        --self:size()
        self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
        platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey()        end
function Screen:enterKey()        end
function Screen:backspaceKey()        end
function Screen:clearKey()         end
function Screen:escapeKey()        end
function Screen:tabKey()        end
function Screen:backtabKey()        end
function Screen:charIn(char)        end


function Screen:mouseDown()        end
function Screen:mouseUp()        end
function Screen:mouseMove()        end
function Screen:contextMenu()        end

function Screen:appended() end

function Screen:resize(w,h) end

function Screen:destroy()
        self        = nil
end

------------------------------------------------------------------
--                   WidgetManager Extension                    --
------------------------------------------------------------------

WidgetManager        = {}

function WidgetManager:ext()
        self.widgets        =        {}
        self.focus        =        0
end

function WidgetManager:resize(w,h)
    if self.x then  --already inited
        self:size()
    end
end

function WidgetManager:appendWidget(widget, xx, yy) 
        widget.xx        =        xx
        widget.yy        =        yy
        widget.parent        =        self
        widget:size()
        
        table.insert(self.widgets, widget)
        widget.pid        =        #self.widgets
        
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
        --self:size()
        self:paint(gc)
        self:drawWidgets(gc)
        self:postPaint(gc)
end


function WidgetManager:loop(n) end

function WidgetManager:stealFocus(n)
        local oldfocus=self.focus
        if oldfocus~=0 then
                local veto        = self:getWidget():loseFocus(n)
                if veto == -1 then
                        return -1, oldfocus
                end
                self:getWidget().hasFocus        =        false
                self.focus        = 0
        end
        return 0, oldfocus
end

function WidgetManager:focusChange() end

function WidgetManager:switchFocus(n, b)
        if n~=0 and #self.widgets>0 then
                local veto, focus        = self:stealFocus(n)
                if veto == -1 then
                        return -1
                end
                
                local looped
                self.focus        =        focus + n
                if self.focus>#self.widgets then
                        self.focus        =        1
                        looped        = true
                elseif self.focus<1 then
                        self.focus        =        #self.widgets
                        looped        = true
                end        
                if looped and self.noloop and not b then
                        self.focus        = focus
                        self:loop(n)
                else
                        self:getWidget().hasFocus        =        true        
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
    else
        if self.widgets and self.widgets[1] then   -- ugh, quite a bad hack for the mouseUp at (0,0) when cursor isn't shown (grrr TI) :/
            self.widgets[1]:enterKey()
        end
    end
    self:invalidate()
end

function WidgetManager:clearKey()        
        if self.focus~=0 then
                self:getWidget():clearKey()
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
        local wox        = widget.ox or 0
        local woy        = widget.oy or 0
        if x>=widget.x-wox and y>=widget.y-wox and x<widget.x+widget.w-wox and y<widget.y+widget.h-woy then
            return n, widget
        end
    end 
end

function WidgetManager:mouseDown(x, y) 
    local n, widget        =        self:getWidgetIn(x, y)
    if n then
        if self.focus~=0 and self.focus~=n then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
        self.focus = n
        
        widget.hasFocus = true
        widget:getFocus()

        widget:mouseDown(x, y)
        self:focusChange()
        else
            if self.focus~=0 then 
            self:getWidget().hasFocus = false 
            self:getWidget():loseFocus() end
            self.focus        =        0
        end
end

function WidgetManager:mouseUp(x, y)
    if self.focus~=0 then
        --self:getWidget():mouseUp(x, y)
    end
    for _, widget in pairs(self.widgets) do
        widget:mouseUp(x,y) -- well, mouseUp is a release of a button, so everything previously "clicked" should be released, for every widget, even if the mouse has moved (and thus changed widget)
        -- eventually, a better way for this would be to keep track of the last widget active and do it to this one only...
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

WScreen        = addExtension(Screen, WidgetManager)

--Dialog screen

Dialog = class(WScreen)

function Dialog:init(title,xx,yy,ww,hh)

        self.yy        =        yy
        self.xx        =        xx
        self.hh        =        hh
        self.ww        =        ww
        self.title        =        title
        self:size()
        
        self.widgets        =        {}
        self.focus        =        0
            
end

function Dialog:paint(gc)
        self.xx        = (pww()-self.w)/2
        self.yy        = (pwh()-self.h)/2
        self.x, self.y        = self.xx, self.yy
        
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

DummyScreen        = Screen()


------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc)        
    allWentWell, generalErrMsg = pcall(onpaint, gc)
    if not allWentWell and errorHandler then
        errorHandler.display = true
        errorHandler.errorMessage = generalErrMsg
    end
    if platform.hw and platform.hw() < 4 and not doNotDisplayIcon then 
        platform.withGC(on.draw)
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

function on.resize(w, h)
    -- Global Ratio Constants for On-Calc (shouldn't be used often though...)
    kXRatio = w/320
    kYRatio = h/212
    
    kXSize, kYSize = w, h

    for _,screen in pairs(Screens) do
        screen:resize(w,h)
    end
end

function on.arrowKey(arrw) current_screen():arrowKey(arrw) end
function on.enterKey() current_screen():enterKey() end
function on.escapeKey() current_screen():escapeKey() end
function on.tabKey() current_screen():tabKey() end
function on.backtabKey() current_screen():backtabKey() end
function on.charIn(ch) current_screen():charIn(ch) end
function on.backspaceKey() current_screen():backspaceKey() end
function on.contextMenu() current_screen():contextMenu() end
function on.mouseDown(x,y) current_screen():mouseDown(x,y) end
function on.mouseUp(x,y) 
    if (x == 0 and y == 0) then 
        current_screen():enterKey()
    else
        current_screen():mouseUp(x,y)
    end
end
function on.mouseMove(x,y) current_screen():mouseMove(x,y) end
function on.clearKey() current_screen():clearKey() end

function uCol(col)
    return col[1] or 0, col[2] or 0, col[3] or 0
end

function textLim(gc, text, max)
    local ttext, out = "",""
    local width    = gc:getStringWidth(text)
    if width<max then
        return text, width
    else
        for i=1, #text do
            ttext    = text:usub(1, i)
            if gc:getStringWidth(ttext .. "..")>max then
                break
            end
            out = ttext
        end
        return out .. "..", gc:getStringWidth(out .. "..")
    end
end


------------------------------------------------------------------
--                        Widget  Class                         --
------------------------------------------------------------------

Widget = class(Screen)

function Widget:init()
    self.dw = 10
    self.dh = 10
    
    self:ext()
end

function Widget:setSize(w, h)
    self.ww = w or self.ww
    self.hh = h or self.hh
end

function Widget:setPos(x, y)
    self.xx = x or self.xx
    self.yy = y or self.yy
end

function Widget:size(n)
    if n then return end
    self.w = math.floor(Pr(self.ww, self.dw, self.parent.w, 0)+.5)
    self.h = math.floor(Pr(self.hh, self.dh, self.parent.h, 0)+.5)
    
    self.rx    =    math.floor(Pr(self.xx, 0, self.parent.w, self.w)+.5)
    self.ry    =    math.floor(Pr(self.yy, 0, self.parent.h, self.h)+.5)
    self.x    =    self.parent.x + self.rx
    self.y    =    self.parent.y + self.ry
end

function Widget:giveFocus()
    if self.parent.focus~=0 then
        local veto    = self.parent:stealFocus()
        if veto == -1 then
            return -1
        end        
    end
    
    self.hasFocus    =    true
    self.parent.focus    =    self.pid
    self:getFocus()
end

function Widget:getFocus() end
function Widget:loseFocus() end
function Widget:clearKey()     end

function Widget:enterKey() 
    self.parent:switchFocus(1)
end
function Widget:arrowKey(arrow)
    if arrow=="up" then 
        self.parent:switchFocus(self.focusUp or -1)
    elseif arrow=="down"  then
        self.parent:switchFocus(self.focusDown or 1)
    elseif arrow=="left" then 
        self.parent:switchFocus(self.focusLeft or -1)
    elseif arrow=="right"  then
        self.parent:switchFocus(self.focusRight or 1)    
    end
end


WWidget    = addExtension(Widget, WidgetManager)


------------------------------------------------------------------
--                        Sample Widget                         --
------------------------------------------------------------------

-- First, create a new class based on Widget
box    =    class(Widget)

-- Init. You should define self.dh and self.dw, in case the user doesn't supply correct width/height values.
-- self.ww and self.hh can be a number or a string. If it's a number, the width will be that amount of pixels.
-- If it's a string, it will be interpreted as % of the parent screen size.
-- These values will be used to calculate self.w and self.h (don't write to this, it will overwritten everytime the widget get's painted)
-- self.xx and self.yy will be set when appending the widget to a screen. This value support the same % method (in a string)
-- They will be used to calculate self.x and self.h 
function box:init(ww,hh,t)
    self.dh    = 10
    self.dw    = 10
    self.ww    = ww
    self.hh    = hh
    self.t    = t
end

-- Paint. Here you can paint your widget stuff
-- Variable you can use:
-- self.x, self.y    : numbers, x and y coordinates of the widget relative to screen. So it's the actual pixel position on the screen.
-- self.w, self.h    : numbers, w and h of widget
-- many others

function box:paint(gc)
    gc:setColorRGB(0,0,0)
    
    -- Do I have focus?
    if self.hasFocus then
        -- Yes, draw a filled black square
        gc:fillRect(self.x, self.y, self.w, self.h)
    else
        -- No, draw only the outline
        gc:drawRect(self.x, self.y, self.w, self.h)
    end
    
    gc:setColorRGB(128,128,128)
    if self.t then
        gc:drawString(self.t,self.x+2,self.y+2,"top")
    end
end


------------------------------------------------------------------
--                         Input Widget                         --
------------------------------------------------------------------


sInput    =    class(Widget)

function sInput:init()
    self.dw    =    100
    self.dh    =    20
    
    self.value    =    ""    
    self.bgcolor    =    {255,255,255}
    self.disabledcolor    = {128,128,128}
    self.font    =    {"sansserif", "r", 10}
    self.disabled    = false
end

function sInput:paint(gc)
    self.gc    =    gc
    local x    =    self.x
    local y =     self.y
    
    gc:setFont(uCol(self.font))
    gc:setColorRGB(uCol(self.bgcolor))
    gc:fillRect(x, y, self.w, self.h)

    gc:setColorRGB(0,0,0)
    gc:drawRect(x, y, self.w, self.h)
    
    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(x-1, y-1, self.w+2, self.h+2)
        gc:setColorRGB(0, 0, 0)
    end
        
    local text    =    self.value
    local    p    =    0
    
    
    gc_clipRect(gc, "subset", x, y, self.w, self.h)
    
    --[[
    while true do
        if p==#self.value then break end
        p    =    p + 1
        text    =    self.value:sub(-p, -p) .. text
        if gc:getStringWidth(text) > (self.w - 8) then
            text    =    text:sub(2,-1)
            break 
        end
    end
    --]]
    
    if self.disabled or self.value == "" then
        gc:setColorRGB(uCol(self.disabledcolor))
    end
    if self.value == ""  then
        text    = self.placeholder or ""
    end
    
    local strwidth = gc:getStringWidth(text)
    
    if strwidth<self.w-4 or not self.hasFocus then
        gc:drawString(text, x+2, y+1, "top")
    else
        gc:drawString(text, x-4+self.w-strwidth, y+1, "top")
    end
    
    if self.hasFocus and self.value ~= "" then
        gc:fillRect(self.x+(text==self.value and strwidth+2 or self.w-4), self.y, 1, self.h)
    end
    
    gc_clipRect(gc, "restore")
end

function sInput:charIn(char)
    if self.disabled or (self.number and not tonumber(self.value .. char)) then --or char~="," then
        return
    end
    --char = (char == ",") and "." or char
    self.value    =    self.value .. char
end

function sInput:clearKey()
    if self:deleteInvalid() then return 0 end
    self.value    =    ""
end

function sInput:backspaceKey()
    if self:deleteInvalid() then return 0 end
    if not self.disabled then
        self.value    =    self.value:usub(1,-2)
    end
end

function sInput:deleteInvalid()
    local isInvalid = string.find(self.value, "Invalid input")
    if isInvalid then
        self.value = self.value:usub(1, -19)
        return true
    end
    return false
end

function sInput:enable()
    self.disabled    = false
end

function sInput:disable()
    self.disabled    = true
end




------------------------------------------------------------------
--                         Label Widget                         --
------------------------------------------------------------------

sLabel    =    class(Widget)

function sLabel:init(text, widget)
    self.widget    =    widget
    self.text    =    text
    self.ww        =    30
    
    self.hh        =    20
    self.lim    =    false
    self.color    =    {0,0,0}
    self.font    =    {"sansserif", "r", 10}
    self.p        =    "top"
    
end

function sLabel:paint(gc)
    gc:setFont(uCol(self.font))
    gc:setColorRGB(uCol(self.color))
    
    local text    =    ""
    local ttext
    if self.lim then
        text, self.dw    = textLim(gc, self.text, self.w)
    else
        text = self.text
    end
    
    gc:drawString(text, self.x, self.y, self.p)
end

function sLabel:getFocus(n)
    if n then
        n    = n < 0 and -1 or (n > 0 and 1 or 0)
    end
    
    if self.widget and not n then
        self.widget:giveFocus()
    elseif n then
        self.parent:switchFocus(n)
    end
end


------------------------------------------------------------------
--                        Button Widget                         --
------------------------------------------------------------------

sButton    =    class(Widget)

function sButton:init(text, action)
    self.text    =    text
    self.action    =    action
    self.pushed = false

    self.dh    =    27
    self.dw    =    48

    self.bordercolor    =    {136,136,136}
    self.font    =    {"sansserif", "r", 10}
end

function sButton:paint(gc)
    gc:setFont(uCol(self.font))
    self.ww    =    gc:getStringWidth(self.text)+8
    self:size()

    if self.pushed and self.forcePushed then
        self.y = self.y + 2
    end

    gc:setColorRGB(248,252,248)
    gc:fillRect(self.x+2, self.y+2, self.w-4, self.h-4)
    gc:setColorRGB(0,0,0)

    gc:drawString(self.text, self.x+4, self.y+4, "top")

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:setPen("medium", "smooth")
    else
        gc:setColorRGB(uCol(self.bordercolor))
        gc:setPen("thin", "smooth")
    end
    gc:fillRect(self.x + 2, self.y, self.w-4, 2)
    gc:fillRect(self.x + 2, self.y+self.h-2, self.w-4, 2)
    gc:fillRect(self.x, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+1, self.y+1, 1, self.h-2)
    gc:fillRect(self.x+self.w-1, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+self.w-2, self.y+1, 1, self.h-2)

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        -- old way of indicating focus :
        --gc:drawRect(self.x-2, self.y-2, self.w+3, self.h+3)
        --gc:drawRect(self.x-3, self.y-3, self.w+5, self.h+5)
    end
end

function sButton:mouseMove(x,y)
    local isIn = (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h))
    self.pushed = self.forcePushed and isIn
    platform.window:invalidate()
end

function sButton:enterKey()
    if self.action then self.action() end
end

function sButton:mouseDown(x,y)
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self.pushed = true
        self.forcePushed = true
    end
    platform.window:invalidate()
end

function sButton:mouseUp(x,y)
    self.pushed = false
    self.forcePushed = false
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self:enterKey()
    end
    platform.window:invalidate()
end


------------------------------------------------------------------
--                      Scrollbar Widget                        --
------------------------------------------------------------------


scrollBar    = class(Widget)

scrollBar.upButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")
scrollBar.downButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")

function scrollBar:init(h, top, visible, total)
    self.color1    = {96, 100, 96}
    self.color2    = {184, 184, 184}
    
    self.hh    = h or 100
    self.ww = 14
    
    self.visible = visible or 10
    self.total   = total   or 15
    self.top     = top     or 4
end

function scrollBar:paint(gc)
    gc:setColorRGB(255,255,255)
    gc:fillRect(self.x+1, self.y+1, self.w-1, self.h-1)
    
    gc:drawImage(self.upButton  , self.x+2, self.y+2)
    gc:drawImage(self.downButton, self.x+2, self.y+self.h-11)
    gc:setColorRGB(uCol(self.color1))
    if self.h > 28 then
        gc:drawRect(self.x + 3, self.y + 14, 8, self.h - 28)
    end
    
    if self.visible<self.total then
        local step    = (self.h-26)/self.total
        gc:fillRect(self.x + 3, self.y + 14  + step*self.top, 9, step*self.visible)
        gc:setColorRGB(uCol(self.color2))
        gc:fillRect(self.x + 2 , self.y + 14 + step*self.top, 1, step*self.visible)
        gc:fillRect(self.x + 12, self.y + 14 + step*self.top, 1, step*self.visible)
    end
end

function scrollBar:update(top, visible, total)
    self.top      = top     or self.top
    self.visible  = visible or self.visible
    self.total    = total   or self.total
end

function scrollBar:action(top) end

function scrollBar:mouseUp(x, y)
    local upX    = self.x+2
    local upY    = self.y+2
    local downX    = self.x+2
    local downY    = self.y+self.h-11
    local butH    = 10
    local butW    = 11
    
    if x>=upX and x<upX+butW and y>=upY and y<upY+butH and self.top>0 then
        self.top    = self.top-1
        self:action(self.top)
    elseif x>=downX and x<downX+butW and y>=downY and y<downY+butH and self.top<self.total-self.visible then
        self.top    = self.top+1
        self:action(self.top)
    end
end

function scrollBar:getFocus(n)
    if n==-1 or n==1 then
        self.parent:switchFocus(n)
    end
end


------------------------------------------------------------------
--                         List Widget                          --
------------------------------------------------------------------

sList    = class(WWidget)

function sList:init()
    Widget.init(self)
    self.dw    = 150
    self.dh    = 153

    self.ih    = 18

    self.top    = 0
    self.sel    = 1
    
    self.font    = {"sansserif", "r", 10}
    self.colors    = {50,150,190}
    self.items    = {}
end

function sList:appended()
    self.scrollBar    = scrollBar("100", self.top, #self.items,#self.items)
    self:appendWidget(self.scrollBar, -1, 0)
    
    function self.scrollBar:action(top)
        self.parent.top    = top
    end
end


function sList:paint(gc)
    local x    = self.x
    local y    = self.y
    local w    = self.w
    local h    = self.h
    
    
    local ih    = self.ih   
    local top    = self.top        
    local sel    = self.sel        
              
    local items    = self.items            
    local visible_items    = math.floor(h/ih)    
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(x, y, w, h)
    gc:setColorRGB(0, 0, 0)
    gc:drawRect(x, y, w, h)
    gc_clipRect(gc, "set", x, y, w, h)
    gc:setFont(unpack(self.font))

    
    
    local label, item
    for i=1, math.min(#items-top, visible_items+1) do
        item    = items[i+top]
        label    = textLim(gc, item, w-(5 + 12 + 2 + 1))
        
        if i+top == sel then
            gc:setColorRGB(unpack(self.colors))
            gc:fillRect(x+1, y + i*ih-ih + 1, w-(12 + 2 + 2), ih)
            
            gc:setColorRGB(255, 255, 255)
        end
        
        gc:drawString(label, x+5, y + i*ih-ih , "top")
        gc:setColorRGB(0, 0, 0)
    end
    
    self.scrollBar:update(top, visible_items, #items)
    
    gc_clipRect(gc, "reset")
end

function sList:arrowKey(arrow)    
    
    if arrow=="up" then
        if self.sel>1 then
            self.sel    = self.sel - 1
            if self.top>=self.sel then
                self.top    = self.top - 1
            end
        else
            self.top = self.h/self.ih < #self.items and math.ceil(#self.items - self.h/self.ih) or 0
            self.sel = #self.items
        end
        self:change(self.sel, self.items[self.sel])
    end

    if arrow=="down" then
        if self.sel<#self.items then
            self.sel    = self.sel + 1
            if self.sel>(self.h/self.ih)+self.top then
                self.top    = self.top + 1
            end
        else
            self.top = 0
            self.sel = 1
        end
        self:change(self.sel, self.items[self.sel])
    end
end


function sList:mouseUp(x, y)
    if x>=self.x and x<self.x+self.w-16 and y>=self.y and y<self.y+self.h then
        
        local sel    = math.floor((y-self.y)/self.ih) + 1 + self.top
        if sel==self.sel then
            self:enterKey()
            return
        end
        if self.items[sel] then
            self.sel=sel
            self:change(self.sel, self.items[self.sel])
        else
            return
        end
        
        if self.sel>(self.h/self.ih)+self.top then
            self.top    = self.top + 1
        end
        if self.top>=self.sel then
            self.top    = self.top - 1
        end
                        
    end 
    self.scrollBar:mouseUp(x, y)
end


function sList:enterKey()
    if self.items[self.sel] then
        self:action(self.sel, self.items[self.sel])
    end
end


function sList:change() end
function sList:action() end

function sList:reset()
    self.sel    = 1
    self.top    = 0
end

------------------------------------------------------------------
--                        Screen Widget                         --
------------------------------------------------------------------

sScreen    = class(WWidget)

function sScreen:init(w, h)
    Widget.init(self)
    self.ww    = w
    self.hh    = h
    self.oy    = 0
    self.ox    = 0
    self.noloop    = true
end

function sScreen:appended()
    self.oy    = 0
    self.ox    = 0
end

function sScreen:paint(gc)
    gc_clipRect(gc, "set", self.x, self.y, self.w, self.h)
    self.x    = self.x + self.ox
    self.y    = self.y + self.oy
end

function sScreen:postPaint(gc)
    gc_clipRect(gc, "reset")
end

function sScreen:setY(y)
    self.oy    = y or self.oy
end
                        
function sScreen:setX(x)
    self.ox    = x or self.ox
end

function sScreen:showWidget()
    local w    = self:getWidget()
    if not w then print("bye") return end
    local y    = self.y - self.oy
    local wy = w.y - self.oy
    
    if w.y-2 < y then
        print("Moving up")
        self:setY(-(wy-y)+4)
    elseif w.y+w.h > y+self.h then
        print("moving down")
        self:setY(-(wy-(y+self.h)+w.h+2))
    end
    
    if self.focus == 1 then
        self:setY(0)
    end
end

function sScreen:getFocus(n)
    if n==-1 or n==1 then
        self:stealFocus()
        self:switchFocus(n, true)
    end
end

function sScreen:loop(n)
    self.parent:switchFocus(n)
    self:showWidget()
end

function sScreen:focusChange()
    self:showWidget()
end

function sScreen:loseFocus(n)
    if n and ((n >= 1 and self.focus+n<=#self.widgets) or (n <= -1 and self.focus+n>=1)) then
        self:switchFocus(n)
        return -1
    else
        self:stealFocus()
    end
    
end


-------------------------------------------------------------------------------
--                                    sDropdown                                 --
-------------------------------------------------------------------------------

sDropdown    =    class(Widget)


function sDropdown:init(items)
    self.dh    = 21
    self.dw    = 75
    self.screen    = WScreen()
    self.sList    = sList()
    self.sList.items    = items or {}
    self.screen:appendWidget(self.sList,0,0)
    self.sList.action    = self.listAction
    self.sList.loseFocus    = self.screenEscape
    self.sList.change    = self.listChange
    self.screen.escapeKey    = self.screenEscape
    self.lak    = self.sList.arrowKey    
    self.sList.arrowKey    = self.listArrowKey
    self.value    = items[1] or ""
    self.valuen    = #items>0 and 1 or 0
    self.rvalue    = items[1] or ""
    self.rvaluen=self.valuen
    
    self.sList.parentWidget = self
    self.screen.parentWidget = self
    --self.screen.focus=1
end

function sDropdown:screenpaint(gc)
    gc:setColorRGB(255,255,255)
    gc:fillRect(self.x, self.y, self.h, self.w)
    gc:setColorRGB(0,0,0)
    gc:drawRect(self.x, self.y, self.h, self.w)
end

function sDropdown:mouseDown()
    self:open()
end


sDropdown.img = image.new("\14\0\0\0\7\0\0\0\0\0\0\0\28\0\0\0\16\0\1\000{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239al{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239alalal{\239{\239\255\255\255\255\255\255\255\255\255\255\255\255{\239{\239alalalalal{\239{\239\255\255\255\255\255\255\255\255{\239{\239alalalalalalal{\239{\239\255\255\255\255{\239{\239alalalalalalalalal{\239{\239{\239{\239alalalalalalalalalalal{\239{\239alalalalalal")

function sDropdown:arrowKey(arrow)    
    if arrow=="up" then
        self.parent:switchFocus(self.focusUp or -1)
    elseif arrow=="down" then
        self.parent:switchFocus(self.focusDown or 1)
    elseif arrow=="left" then 
        self.parent:switchFocus(self.focusLeft or -1)
    elseif arrow == "right" then
        self:open()
    end
end

function sDropdown:listArrowKey(arrow)
    if arrow == "left" then
        self:loseFocus()
    else
        self.parentWidget.lak(self, arrow)
    end
end

function sDropdown:listChange(a, b)
    self.parentWidget.value  = b
    self.parentWidget.valuen = a
end

function sDropdown:open()
    self.screen.yy    = self.y+self.h
    self.screen.xx    = self.x-1
    self.screen.ww    = self.w + 13
    local h = 2+(18*#self.sList.items)
    
    local py    = self.parent.oy and self.parent.y-self.parent.oy or self.parent.y
    local ph    = self.parent.h
    
    self.screen.hh    = self.y+self.h+h>ph+py-10 and ph-py-self.y-self.h-10 or h
    if self.y+self.h+h>ph+py-10  and self.screen.hh<40 then
        self.screen.hh = h < self.y and h or self.y-5
        self.screen.yy = self.y-self.screen.hh
    end
    
    self.sList.ww = self.w + 13
    self.sList.hh = self.screen.hh-2
    self.sList.yy =self.sList.yy+1
    self.sList:giveFocus()
    
    self.screen:size()
    push_screen_direct(self.screen)
end

function sDropdown:listAction(a,b)
    self.parentWidget.value  = b
    self.parentWidget.valuen = a
    self.parentWidget.rvalue  = b
    self.parentWidget.rvaluen = a
    self.parentWidget:change(a, b)
    remove_screen()
end

function sDropdown:change() end

function sDropdown:screenEscape()
    self.parentWidget.sList.sel = self.parentWidget.rvaluen
    self.parentWidget.value    = self.parentWidget.rvalue
    if current_screen() == self.parentWidget.screen then
        remove_screen()
    end
end

function sDropdown:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w-1, self.h-1)
    
    gc:setColorRGB(0,0,0)
    gc:drawRect(self.x, self.y, self.w-1, self.h-1)
    
    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(self.x-1, self.y-1, self.w+1, self.h+1)
        gc:setColorRGB(0, 0, 0)
    end
    
    gc:setColorRGB(192, 192, 192)
    gc:fillRect(self.x+self.w-21, self.y+1, 20, 19)
    gc:setColorRGB(224, 224, 224)
    gc:fillRect(self.x+self.w-22, self.y+1, 1, 19)
    
    gc:drawImage(self.img, self.x+self.w-18, self.y+9)
    
    gc:setColorRGB(0,0,0)
    local text = self.value
    if self.unitmode then
        text=text:gsub("([^%d]+)(%d)", numberToSub)
    end
    
    gc:drawString(textLim(gc, text, self.w-5-22), self.x+5, self.y, "top")
end

