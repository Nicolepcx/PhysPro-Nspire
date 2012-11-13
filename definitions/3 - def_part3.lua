-----------------------------------------------------------------------------
---------------- FILE #3 -----------------
-----------------------------------------------------------------------------

function search()
	local searchstr	= searchBox.value:lower()
	local keyList	= {}

	if searchstr == "" then
		keyList = dataSorted
	else
		for key, data in pairs(data) do
			if key:lower():find(searchstr) then
				table.insert(keyList, key)
			end
		end
		
		table.sort(keyList)
	end
	
	dataList:reset()
	dataList.items	= keyList
	if #keyList>0 then
		dataList:giveFocus()
	end
end

function keyToList(data)
	local list	= {}
	for key, _ in pairs(data) do
		table.insert(list, key)
	end
	table.sort(list)
	return list
end

main	= WScreen()

searchBox	= sInput()
searchBtn	= sButton("Search", search)
dataList	= sList()

main:appendWidget(searchBox,  5,  8)
	:appendWidget(searchBtn, -5,  5)
	:appendWidget(dataList ,  5, -5)

searchBox:setSize(-80)
function searchBox:enterKey() searchBtn:action() end

function searchBox:charIn(char)
	sInput.charIn(self, char)
	searchBtn:action()
end

function searchBox:backspaceKey()
	sInput.backspaceKey(self)
	searchBtn:action()
end

dataList:setSize(-10, -43)
dataSorted	= keyToList(data)
dataList.items	= dataSorted
dataList:giveFocus()

function dataList:charIn(char)
	sInput.charIn(searchBox, char)
	searchBtn:action()
end

function dataList:backspaceKey()
	sInput.backspaceKey(searchBox)
	searchBtn:action()
end

function dataList:action(key, name)
	if name then
		only_screen(infoviewer, name)
	end
end

push_screen(main)




infoviewer	= WScreen()
infoviewer.key	= ""

backBtn	= sButton("Back", function () only_screen(main) end)
infoviewer:appendWidget(backBtn,  5,  -5)



function infoviewer:paint(gc)
	gc:setFont("sansserif", "b", 11)
	gc:drawString(self.key, 5, 0, "top")
	gc:setFont("sansserif", "r", 9)
	
	local spl	= self.data:split("\n")
	local y	= 20
	local words, ts
	
	for i, s in ipairs(spl) do
		words	= s:split(" ")
		ts	= ""
		for i, word in ipairs(words) do
			if gc:getStringWidth(ts .. word)<self.w-10 then
				ts = ts..word.." "
			else
				gc:drawString(ts, 5, y, "top")
				y=y+14
				ts=word.." "
			end
		end
		gc:drawString(ts, 5, y, "top")
	
		y=y+14
	end
	
end

function infoviewer:pushed(key)
	self.key	= key
	self.data	= data[key]
	backBtn:giveFocus()
end

---[[

help	= Dialog("About",20,20,250,150)

btn1	= sButton("Back", function () remove_screen() end )

lbl1	= sLabel("orig_code: Jim Bauwens", btn1)
lbl2	= sLabel("orig_code: Credits and help"   , btn1)
lbl3	= sLabel("orig_code: Adriweb & TI-Planet", btn1)

help:appendWidget(lbl1, 2, 30)
    :appendWidget(lbl2, 2, 60)
    :appendWidget(lbl3, 2, 80)
    :appendWidget(btn1, -8, -5)
btn1:giveFocus()

function help:postPaint(gc)
	nativeBar(gc, self, self.h-40)
end

function on.help()
	push_screen(help)
end
--]]

----------------------------
-- END FILE #3 --
----------------------------
