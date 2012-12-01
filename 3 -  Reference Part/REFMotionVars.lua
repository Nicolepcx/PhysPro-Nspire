
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

