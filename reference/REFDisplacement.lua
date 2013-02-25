
RefDisplacement = Screen()

RefDisplacement.data = {
    { "0.0000000001 m",     "nanometer",                "nm"                },
    { "0.000001 m",         "micrometer",               utf8(956).."m"      },
    { "0.001 m",            "millimeter",               "mm"                },
    { "0.01 m",             "centimeter",               "cm"                },
    { "0.1",                "decimeter",                "dm"                },
    { "Base",               "meter",                    "m"                 },
    { "10 m",               "",                         "dam"               },
    { "100 m",              "hectometer",               "hm"                },
    { "1000 m",             "kilometer",                "km"                },
    { "1000000",            "megameter",                "Mm"                },
    { "1000000000 m",       "gigameter",                "Gm"                },
    { "0.0254 m",           "inch",                     "in"                },
    { "0.3048 m",           "feet",                     "ft"                },
    { "0.9144 m",           "yard",                     "yd"                },
    { "1609.34 m",          "mile",                     "mi"                },
    { "1852 m",             "knautical mile",           "Nmi"               },
    { "4.572 m",            "rod",                      "rod"               },
    { "20.1168 m",          "millimeters",              "chain"             },
    { "201.168 m",          "furlong",                  "fur"               },
    { "1.8288 m",           "fathom",                   "ftm"               },
    { "1.70180 m",          "Smoot",                    "smoot"             },
    { "109.7 m",            "football fields",          "FB-F"              },
    { "0.000000005 m",      "Beard-seconds",            "brds"              }
}

RefDisplacement.tmpScroll = 1
RefDisplacement.dual = false

function RefDisplacement:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefDisplacement.tmpScroll = RefDisplacement.tmpScroll - test(RefDisplacement.tmpScroll > 1)
        end
        if arrw == "down" then
            RefDisplacement.tmpScroll = RefDisplacement.tmpScroll + test(RefDisplacement.tmpScroll < (table.getn(RefDisplacement.data) - 7))
        end
        screenRefresh()
    end
end

function RefDisplacement:enterKey()
    RefDisplacement.dual = not RefDisplacement.dual
    RefDisplacement:invalidate()
end

function RefDisplacement:escapeKey()
    only_screen_back(Ref)
end

function RefDisplacement:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Displacement Units : "
    gc:setFont("sansserif", "b", 12)
    if RefDisplacement.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefDisplacement.tmpScroll < table.getn(RefDisplacement.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 9)
    drawXCenteredString(gc, "Press enter for description/conversion ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefDisplacement.tmpScroll, table.getn(RefDisplacement.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefDisplacement.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefDisplacement.data[k][1 + test(RefDisplacement.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
    end
end

