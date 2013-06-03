--@@  RefMain.lua
--@@  LGLP 3 License
--@@  alex3yoyo

--include "REFSIPrefixes.lua"
--include "REFGreekAlphabet.lua"
--include "REFConstants.lua"
--include "REFBoolAlg.lua"
--include "REFBoolExpr.lua"
-- do not include "REFDisplacement.lua"
-- do not include "REFVelocity.lua"
-- do not include "REFAcceleration.lua"
-- do not include "REFTime.lua"
-- do not include "REFForce.lua"
-- do not include "REFEnergy.lua"
-- do not include "REFPower.lua"
-- do not include "REFMotionVars.lua"

References = {
    {title="SI Prefixes",           info="",    screen=SIPrefixes},
    {title="Greek Alphabet",        info="",    screen=Greek},
    {title="Constants",             info="",    screen=RefConstants},
    {title="BoolAlg",               info="",    screen=RefBoolAlg},
    {title="BoolExpr",              info="",    screen=RefBoolExpr},
    -- {title="Displacement Units",    info="",    screen=RefDisplacement},
    -- {title="Velocity Units",        info="",    screen=RefVelocity},
    -- {title="Acceleration Units",    info="",    screen=RefAcceleration},
    -- {title="Time Units",            info="",    screen=RefTime},
    -- {title="Force Units",           info="",    screen=RefForce},
    -- {title="Energy Units",          info="",    screen=RefEnergy},
    -- {title="Power Units",           info="",    screen=RefPower},
    -- {title="Motion Variables",      info="",    screen=MotionVars}
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
            table.insert(RefList.items, ref.title .. " (WIP)")
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

