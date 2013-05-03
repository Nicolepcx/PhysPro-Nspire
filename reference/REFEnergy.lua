--@@  REFEnergy.lua
--@@  LGLP 3 License
--@@  alex3yoyo

RefEnergy = Screen()

RefEnergy.data = {
    { "Base",               "joules",                   "J"         },
    { "0.001 J",            "millijoules",              "mJ"        },
    { "1000 J",             "kilojoules",               "kJ"        },
    { "1000000 J",          "megajoules",               "MJ"        },
    { "1000000000 J",       "gigajoules",               "GJ"        },
    { "3600000 J",          "kilowatt-hour",            "kWh"       },
    { "1.35582 J",          "foot-pound",               "ftlb"      },
    { "1055.06 J",          "British thermal unit",     "Btu"       }
}

RefEnergy.tmpScroll = 1
RefEnergy.dual = false

function RefEnergy:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefEnergy.tmpScroll = RefEnergy.tmpScroll - test(RefEnergy.tmpScroll > 1)
        end
        if arrw == "down" then
            RefEnergy.tmpScroll = RefEnergy.tmpScroll + test(RefEnergy.tmpScroll < (table.getn(RefEnergy.data) - 7))
        end
        screenRefresh()
    end
end

function RefEnergy:enterKey()
    RefEnergy.dual = not RefEnergy.dual
    RefEnergy:invalidate()
end

function RefEnergy:escapeKey()
    only_screen_back(Ref)
end

function RefEnergy:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Energy Units : "
    gc:setFont("sansserif", "b", 12)
    if RefEnergy.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefEnergy.tmpScroll < table.getn(RefEnergy.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 9)
    drawXCenteredString(gc, "Press enter for description/conversion ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefEnergy.tmpScroll, table.getn(RefEnergy.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefEnergy.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefEnergy.data[k][1 + test(RefEnergy.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
    end
end

