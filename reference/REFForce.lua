--@@  REFForce.lua
--@@  LGLP 3 License
--@@  alex3yoyo

RefForce = Screen()

RefForce.data = {
    { "Base",               "newton",                   "N"         },
    { "0.001 N",            "millinewton",              "mN"        },
    { "1000 N",             "kilonewton",               "kN"        },
    { "1000000 N",          "meganewton",               "MN"        },
    { "1000000000 N",       "giganewton",               "GN"        },
    { "N",                  "dyne",                     "dyn"       },
    { "0.224809 N",         "pound-force",              "lbf"       },
    { "0.101972 N",         "kilogram-force",           "kgf"       },
    { "0.000112404 N",      "ton-force",                "tonf"      }
}

RefForce.tmpScroll = 1
RefForce.dual = false

function RefForce:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefForce.tmpScroll = RefForce.tmpScroll - test(RefForce.tmpScroll > 1)
        end
        if arrw == "down" then
            RefForce.tmpScroll = RefForce.tmpScroll + test(RefForce.tmpScroll < (table.getn(RefForce.data) - 7))
        end
        screenRefresh()
    end
end

function RefForce:enterKey()
    RefForce.dual = not RefForce.dual
    RefForce:invalidate()
end

function RefForce:escapeKey()
    only_screen_back(Ref)
end

function RefForce:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Force Units : "
    gc:setFont("sansserif", "b", 12)
    if RefForce.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefForce.tmpScroll < table.getn(RefForce.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 9)
    drawXCenteredString(gc, "Press enter for description/conversion ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefForce.tmpScroll, table.getn(RefForce.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefForce.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefForce.data[k][1 + test(RefForce.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
    end
end

