
RefAcceleration = Screen()

RefAcceleration.data = {
    { "Base",                   "meters/sec/sec",               "m/s2"      },
    { "1000 m/s2",              "kilometers/sec/sec",           "km/s2"     },
    { "0.01 m/s2",              "centimeters/sec/sec",          "cm/s2"     },
    { "0.001 m/s2",             "millimeters/sec/sec",          "mm/s2"     },
    { "0.000277778 m/s2",       "meters/hr/hr",                 "m/hr2"     },
    { "0.277778 m/s2",          "kilometers/hr/hr",             "km/hr2"    },
    { "16.6667 m/s2",           "kilometers/min/min",           "km/min2"   },
    { "0.3048 m/s2",            "feet/sec/sec",                 "ft/s2"     },
    { "0.00508 m/s2",           "feet/min/min",                 "ft/min2"   },
    { "26.8224 m/s2",           "miles/min/min",                "mi/min2"   },
    { "0.44704 m/s2",           "miles/hr/hr",                  "mi/hr2"    },
    { "0.514444 m/s2",          "knatical mile/hr/hr",          "knot2"     }
}

RefAcceleration.tmpScroll = 1
RefAcceleration.dual = false

function RefAcceleration:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefAcceleration.tmpScroll = RefAcceleration.tmpScroll - test(RefAcceleration.tmpScroll > 1)
        end
        if arrw == "down" then
            RefAcceleration.tmpScroll = RefAcceleration.tmpScroll + test(RefAcceleration.tmpScroll < (table.getn(RefAcceleration.data) - 7))
        end
        screenRefresh()
    end
end

function RefAcceleration:enterKey()
    RefAcceleration.dual = not RefAcceleration.dual
    RefAcceleration:invalidate()
end

function RefAcceleration:escapeKey()
    only_screen_back(Ref)
end

function RefAcceleration:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Acceleration Units : "
    gc:setFont("sansserif", "b", 12)
    if RefAcceleration.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefAcceleration.tmpScroll < table.getn(RefAcceleration.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 9)
    drawXCenteredString(gc, "Press enter for description/conversion ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefAcceleration.tmpScroll, table.getn(RefAcceleration.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefAcceleration.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefAcceleration.data[k][1 + test(RefAcceleration.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
    end
end

