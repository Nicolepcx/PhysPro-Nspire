
RefVelocity = Screen()

RefVelocity.data = {
    {"Base",            "meters/second",        "m/s" },
    {"1000 m/s",        "kilometers/sec",       "km/s" },
    {"0.01 m/s",        "centimeters/sec",      "cm/s" },
    {"0.001 m/s",       "millimeters/sec",      "mm/s" },
    {"0.000277778 m/s", "meters/hour",          "m/hr" },
    {"0.277778 m/s",    "kilometers/hour",      "km/hr" },
    {"16.6667",         "kilometers/min",       "km/min" },
    {"0.3048 m/s",      "feet/second",          "ft/s" },
    {"0.00508 m/s",     "feet/minute",          "ft/min" },
    {"26.8224 m/s",     "miles/minute",         "mi/min" },
    {"0.44704 m/s",     "miles/hour",           "mi/hr" },
    {"0.514444 m/s",    "knatical mile/hour",   "knot" },
    {"0.000000005 m/s", "bears-sec/second",     "brds/sec" },
}

RefVelocity.tmpScroll = 1
RefVelocity.dual = false

function RefVelocity:arrowKey(arrw)
    if pww() < 330 then
        if arrw == "up" then
            RefVelocity.tmpScroll = RefVelocity.tmpScroll - test(RefVelocity.tmpScroll > 1)
        end
        if arrw == "down" then
            RefVelocity.tmpScroll = RefVelocity.tmpScroll + test(RefVelocity.tmpScroll < (table.getn(RefVelocity.data) - 7))
        end
        screenRefresh()
    end
end

function RefVelocity:enterKey()
    RefVelocity.dual = not RefVelocity.dual
    RefVelocity:invalidate()
end

function RefVelocity:escapeKey()
    only_screen_back(Ref)
end

function RefVelocity:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)

    msg = "Velocity Units : "
    gc:setFont("sansserif", "b", 12)
    if RefVelocity.tmpScroll > 1 and pww() < 330 then
        gc:drawString(utf8(9650), gc:getStringWidth(utf8(9664)) + 7, 0, "top")
    end
    if RefVelocity.tmpScroll < table.getn(RefVelocity.data) - 7 and pww() < 330 then
        gc:drawString(utf8(9660), pww() - 4 * gc:getStringWidth(utf8(9654)) - 2, 0, "top")
    end
    drawXCenteredString(gc, msg, 0)
    gc:setFont("sansserif", "i", 9)
    drawXCenteredString(gc, "Press enter for description/conversion ", 15)
    gc:setFont("sansserif", "r", 12)

    local tmp = 0
    for k = RefVelocity.tmpScroll, table.getn(RefVelocity.data) do
        tmp = tmp + 1
        gc:setFont("sansserif", "b", 12)
        gc:drawString(RefVelocity.data[k][3], 3, 10 + 22 * tmp, "top")
        gc:setFont("sansserif", "r", 12)
        gc:drawString(RefVelocity.data[k][1 + test(RefVelocity.dual)], 125 - 32 * test(k == 11) * test(pww() < 330) + 30 * test(pww() > 330) + 12, 10 + 22 * tmp, "top")
    end
end

