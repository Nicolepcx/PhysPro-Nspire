
RefTime = Screen()

RefTime.data = {
    { "Base",               "second",               "s"             },
    { "60 s",               "minute",               "min"           },
    { "3600 s",             "hour",                 "hr"            },
    { "86400 s",            "day",                  "day"           },
    { "604800 s",           "week",                 "wk"            },
    { "1209600 s",          "fortnight",            "fortn"         },
    { "18144000 s",         "month",                "month"         },
    { "217728000 s",        "year",                 "yr"            },
    { "52 minutes",         "micro-century",        "mCent"         },
    { "6 months",           "Friend",               "Friends"       }
}

--[[
{ "", "", "" },
]]--

RefTime.tmpScroll = 1
RefTime.dual = false

function RefTime:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefTime.tmpScroll = RefTime.tmpScroll - test(RefTime.tmpScroll > 1)
        end
        if arrw == "down" then
            RefTime.tmpScroll = RefTime.tmpScroll + test(RefTime.tmpScroll < (table.getn(RefTime.data) - 7))
        end
        screenRefresh()
    end
end

function RefTime:enterKey()
    RefTime.dual = not RefTime.dual
    RefTime:invalidate()
end

function RefTime:escapeKey()
    only_screen_back(Ref)
end

function RefTime:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Time Units : "
    gc:setFont("sansserif", "b", 12)
    if RefTime.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefTime.tmpScroll < table.getn(RefTime.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 9)
    drawXCenteredString(gc, "Press enter for description/conversion ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefTime.tmpScroll, table.getn(RefTime.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefTime.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefTime.data[k][1 + test(RefTime.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
    end
end

