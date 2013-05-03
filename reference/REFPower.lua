--@@  REFPower.lua
--@@  LGLP 3 License
--@@  alex3yoyo

RefPower = Screen()

RefPower.data = {
    { "Base",           "watt",         "W"     },
    { "0.001 W",        "milliwatt",    "mW"    },
    { "1000 W",         "kilowatt",     "kW"    },
    { "1000000 W",      "megawatt",     "MW"    },
    { "1000000000 W",   "gigawatt",     "GW"    },
    { "745.7 W",        "horsepower",   "hp"    },
    { "0.9983 W",       "air watt",     "airW"  }
}

RefPower.tmpScroll = 1
RefPower.dual = false

function RefPower:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefPower.tmpScroll = RefPower.tmpScroll - test(RefPower.tmpScroll > 1)
        end
        if arrw == "down" then
            RefPower.tmpScroll = RefPower.tmpScroll + test(RefPower.tmpScroll < (table.getn(RefPower.data) - 7))
        end
        screenRefresh()
    end
end

function RefPower:enterKey()
    RefPower.dual = not RefPower.dual
    RefPower:invalidate()
end

function RefPower:escapeKey()
    only_screen_back(Ref)
end

function RefPower:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Power Units : "
    gc:setFont("sansserif", "b", 12)
    if RefPower.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefPower.tmpScroll < table.getn(RefPower.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 9)
    drawXCenteredString(gc, "Press enter for description/conversion ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefPower.tmpScroll, table.getn(RefPower.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefPower.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefPower.data[k][1 + test(RefPower.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
    end
end

