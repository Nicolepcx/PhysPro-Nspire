
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


RefConstants = Screen()

RefConstants.data = refCon()

RefConstants.tmpScroll = 1
RefConstants.leftRight = 1

function RefConstants:arrowKey(arrw)
    if arrw == "up" then
        RefConstants.tmpScroll = RefConstants.tmpScroll - test(RefConstants.tmpScroll>1)
    end
    if arrw == "down" then
        RefConstants.tmpScroll = RefConstants.tmpScroll + test(RefConstants.tmpScroll<(table.getn(RefConstants.data)-7))
    end
    if arrw == "left" then
        RefConstants.leftRight = RefConstants.leftRight - 5*test(RefConstants.leftRight>1)
    end
    if arrw == "right" then
        RefConstants.leftRight = RefConstants.leftRight + 5*test(RefConstants.leftRight<150)
    end
    screenRefresh()
end

function RefConstants:paint(gc)
    gc:setColorRGB(255,255,255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0,0,0)
    
        msg = "Physical Constants: "
        gc:setFont("sansserif","b",12)
        if RefConstants.leftRight > 1 then
            gc:drawString(utf8(9664),4,0,"top")
        end
        if RefConstants.leftRight < 160 then
            gc:drawString(utf8(9654),pww()-gc:getStringWidth(utf8(9660))-2,0,"top")
        end
        if RefConstants.tmpScroll > 1 then
            gc:drawString(utf8(9650),gc:getStringWidth(utf8(9664))+7,0,"top")
        end
        if RefConstants.tmpScroll < table.getn(RefConstants.data)-7 then
            gc:drawString(utf8(9660),pww()-4*gc:getStringWidth(utf8(9654))-2,0,"top")
        end
        drawXCenteredString(gc,msg,4)
        gc:setFont("sansserif","r",12)
        
           local tmp = 0
           for k=RefConstants.tmpScroll,table.getn(RefConstants.data) do
            tmp = tmp + 1
               gc:setFont("sansserif","b",12)
            gc:drawString(RefConstants.data[k][1], 5-RefConstants.leftRight, 5+22*tmp, "top")
            gc:setFont("sansserif","r",12)
            gc:drawString("  (" .. RefConstants.data[k][2] .. "): " .. RefConstants.data[k][3], gc:getStringWidth(RefConstants.data[k][1])+15-RefConstants.leftRight, 5+22*tmp, "top")
        end
end

function RefConstants:escapeKey()
    only_screen_back(Ref)
end


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


Greek = Screen()
 
Greek.font = "serif"
  
Greek.alphabet1 = {
    {utf8(913), utf8(945), "Alpha"},
    {utf8(914), utf8(946), "Beta"},
    {utf8(915), utf8(947), "Gamma"},
    {utf8(916), utf8(948), "Delta"},
    {utf8(917), utf8(949), "Epsilon"},
    {utf8(918), utf8(950), "Zeta"},
    {utf8(919), utf8(951), "Eta"},
    {utf8(920), utf8(952), "Theta"}
}
Greek.alphabet2 = {
    {utf8(921), utf8(953), "Iota"},
    {utf8(922), utf8(954), "Kappa"},
    {utf8(923), utf8(955), "Lambda"},
    {utf8(924), utf8(956), "Mu"},
    {utf8(925), utf8(957), "Nu"},
    {utf8(926), utf8(958), "Xi"},
    {utf8(927), utf8(959), "Omicron"},
    {utf8(928), utf8(960), "Pi"}
}
Greek.alphabet3 = {
    {utf8(929), utf8(961), "Rho"},
    {utf8(931), utf8(963), "Sigma"},
    {utf8(932), utf8(964), "Tau"},
    {utf8(933), utf8(965), "Upsilon"},
    {utf8(934), utf8(966), "Phi"},
    {utf8(935), utf8(967), "Chi"},
    {utf8(936), utf8(968), "Psi"},
    {utf8(937), utf8(969), "Omega"}
}
 
function Greek:paint(gc)
    gc:setColorRGB(255,255,255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0,0,0)
    
        local msg = "Greek Alphabet"
        gc:setFont("sansserif","b",12)
        drawXCenteredString(gc,msg,5)
        gc:setFont(Greek.font,"r",12)
        for k,v in ipairs(Greek.alphabet1) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5, 10+22*k, "top")
        end
        for k,v in ipairs(Greek.alphabet2) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.34*pww(), 10+22*k, "top")
        end
        for k,v in ipairs(Greek.alphabet3) do
                gc:drawString(v[3] .. " : " .. v[1] .. " " .. v[2], 5+.67*pww(), 10+22*k, "top")
        end
end
 
function Greek:enterKey()
    Greek.font = Greek.font == "serif" and "sansserif" or "serif"
    Greek:invalidate()
end

function Greek:escapeKey()
    only_screen_back(Ref)
end


MotionVars = Screen()

MotionVars.data = {
    { "u",          "m/s",          "Initial velocity"                      },
    { "v",          "m/s",          "Final velocity"                        },
    { "dv",         "m/s",          "Change in velocity"                    },
    { "a",          "m/s2",         "Average acceleration"                  },
    { "s",          "m",            "Displacement"                          },
    { "h",          "m",            "Height"                                },
    { "t",          "s",            "Time"                                  },
    { "F",          "N",            "Force"                                 },
    { "m",          "kg",           "Mass"                                  },
    { "W",          "J",            "Work"                                  },
    { "P",          "W",            "Power"                                 },
    { "Ek",         "J",            "Kinetic energy"                        },
    { "Ep",         "J",            "Gravitaty potential energy"            },
    { "E",          "J",            "Total energy"                          },
    { "p",          "N*s",          "Momentum"                              },
    { "imp",        "N*s",          "Impulse"                               },
    { "Tp",         "s",            "Period"                                },
    { "r",          "m",            "Radius"                                },
    { "c",          "m",            "Circumference"                         }
}

MotionVars.tmpScroll = 1

function MotionVars:arrowKey(arrw)
    if arrw == "up" then
        MotionVars.tmpScroll = MotionVars.tmpScroll - test(MotionVars.tmpScroll>1)
    end
    if arrw == "down" then
        MotionVars.tmpScroll = MotionVars.tmpScroll + test(MotionVars.tmpScroll<(table.getn(MotionVars.data)-7))
    end
    screenRefresh()
end

function MotionVars:paint(gc)
    gc:setColorRGB(255,255,255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0,0,0)
    
        msg = "Motion Variables : "
        gc:setFont("sansserif","b",12)
        if MotionVars.tmpScroll > 1 then
            gc:drawString(utf8(9650),gc:getStringWidth(utf8(9664))+7,0,"top")
        end
        if MotionVars.tmpScroll < table.getn(MotionVars.data)-7 then
            gc:drawString(utf8(9660),pww()-4*gc:getStringWidth(utf8(9654))-2,0,"top")
        end
        drawXCenteredString(gc,msg,4)
        gc:setFont("sansserif","r",12)
        
           local tmp = 0
           for k=MotionVars.tmpScroll,table.getn(MotionVars.data) do
               tmp = tmp + 1
               gc:setFont("sansserif","b",12)
            gc:drawString(MotionVars.data[k][1], 5, 5+22*tmp, "top")
            gc:setFont("sansserif","r",12)
            gc:drawString(MotionVars.data[k][2], 40+30*test(pww()>330)+15, 5+22*tmp, "top")
            gc:drawString(MotionVars.data[k][3], 134+50*test(pww()>330)+15, 5+22*tmp, "top")
        end
end

function MotionVars:escapeKey()
    only_screen_back(Ref)
end


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


SIPrefixes = Screen()

SIPrefixes.prefixes1 = {
	{ "Y", "Yotta", "24" },
	{ "Z", "Zetta", "21" },
	{ "E", "Exa", "18" },
	{ "P", "Peta", "15" },
	{ "T", "Tera", "12" },
	{ "G", "Giga", "9" },
	{ "M", "Mega", "6" },
	{ "k", "Kilo", "3" },
	{ "h", "Hecto", "2" },
	{ "da", "Deka", "1" }
}

SIPrefixes.prefixes2 = {
	{ "d", "Deci", "-1" },
	{ "c","Centi", "-2" },
	{ "m", "Milli", "-3" },
	{ utf8(956), "Micro", "-6" },
	{ "n", "Nano", "-9" },
	{ "p", "Pico", "-12" },
	{ "f", "Femto", "-15" },
	{ "a", "Atto", "-18" },
	{ "z", "Zepto", "-21" },
	{ "y", "Yocto", "-24" }
}

function SIPrefixes:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.w, self.h)
	gc:setColorRGB(0,0,0)

    local msg = "SI Prefixes  "
    gc:setFont("sansserif","b",12)
    drawXCenteredString(gc,msg,0)
    gc:setFont("sansserif","r",12)
    for k,v in ipairs(SIPrefixes.prefixes1) do
            gc:drawString("10", 5+.03*self.w, 3+19*k, "top")
            gc:drawString(v[3], 23+.03*self.w, 19*k-3, "top")
            gc:drawString(" : " .. v[2], 45+.03*self.w, 3+19*k, "top")
            gc:drawString("  (" .. v[1] .. ")", 98+.03*self.w, 3+19*k, "top")
    end
    for k,v in ipairs(SIPrefixes.prefixes2) do
            gc:drawString("10", 5+.52*self.w, 3+19*k, "top")
            gc:drawString(v[3], 23+.52*self.w, 19*k-3, "top")
            gc:drawString("  : " .. v[2], 45+.52*self.w, 3+19*k, "top")
            gc:drawString("  (" .. v[1] .. ")", 100+.52*self.w, 3+19*k, "top")
    end
end

function SIPrefixes:escapeKey()
	only_screen_back(Ref)
end


RefTime = Screen()

RefTime.data = {
    { "Base",           "second",       "s"             },
    { "60 s",           "minute",       "min"           },
    { "3600 s",         "hour",         "hr"            },
    { "86400 s",        "day",          "day"           },
    { "604800 s",       "week",         "wk"            },
    { "1209600 s",      "fortnight",    "fortn"         },
    { "18144000 s",     "month",        "month"         },
    { "217728000 s",    "year",         "yr"            },
    { "52 minutes",     "microcentury", utf8(956).."Ce" },
    { "6 months",       "Friend",           "Friends"   }
}

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


RefVelocity = Screen()

RefVelocity.data = {
    { "Base",               "meters/second",        "m/s"       },
    { "1000 m/s",           "kilometers/sec",       "km/s"      },
    { "0.01 m/s",           "centimeters/sec",      "cm/s"      },
    { "0.001 m/s",          "millimeters/sec",      "mm/s"      },
    { "0.000277778 m/s",    "meters/hour",          "m/hr"      },
    { "0.277778 m/s",       "kilometers/hour",      "km/hr"     },
    { "16.6667",            "kilometers/min",       "km/min"    },
    { "0.3048 m/s",         "feet/second",          "ft/s"      },
    { "0.00508 m/s",        "feet/minute",          "ft/min"    },
    { "26.8224 m/s",        "miles/minute",         "mi/min"    },
    { "0.44704 m/s",        "miles/hour",           "mi/hr"     },
    { "0.514444 m/s",       "knatical mile/hour",   "knot"      },
    { "0.000000005 m/s",    "bears-sec/second",     "brds/sec"  },
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


References = {
    { title="SI Prefixes", info="", screen=SIPrefixes },
    { title="Greek Alphabet", info="", screen=Greek },
    { title="Constants", info="", screen=RefConstants },
    { title="Motion Variables", info="", screen=MotionVars },
    { title="Displacement Units", info="", screen=RefDisplacement },
    { title="Velocity Units", info="", screen=RefVelocity },
    { title="Acceleration Units", info="", screen=RefAcceleration },
    { title="Time Units", info="", screen=RefTime },
    { title="Force Units", info="", screen=RefForce },
    { title="Energy Units", info="", screen=RefEnergy },
    { title="Power Units", info="", screen=RefPower }
}

Ref = WScreen()

RefList = sList()
RefList:setSize(-8, -32)

Ref:appendWidget(RefList, 4, Ref.y+28)

function Ref.addRefs()
    for n, ref in ipairs(References) do
        if ref.screen then
            table.insert(RefList.items, ref.title)
        else
            table.insert(RefList.items, ref.title .. " (Not yet done)")
        end
    end
end

function RefList:action(ref)
    if References[ref].screen then
        push_screen(References[ref].screen)
    end
end

function Ref:pushed()
    RefList:giveFocus()
end

function Ref:paint(gc)
    gc:setFont("sansserif", "b", 16)
    gc:drawString("Reference", self.x+6, -2, "top")
    gc:setFont("serif", "r", 12)
end

function Ref:tabKey()
    push_screen(CategorySel)
end

Ref.escapeKey = Ref.tabKey

Ref.addRefs()

