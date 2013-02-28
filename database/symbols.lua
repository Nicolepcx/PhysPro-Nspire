--@@  symbols.lua
--@@  LGLP 3 License
--@@  alex3yoyo

function utf8(n)
    return string.uchar(n)
end

SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}

function numberToSub(w,n)
    return w..utf8(SubNumbers[tonumber(n)])
end

-- The Greeks
g    = {} -- Big    , Little   , Name
g.al = {utf8(913), utf8(945), "Alpha"}
g.be = {utf8(914), utf8(946), "Beta"}
g.ga = {utf8(915), utf8(947), "Gamma"}
g.de = {utf8(916), utf8(948), "Delta"}
g.ep = {utf8(917), utf8(949), "Epsilon"}
g.ze = {utf8(918), utf8(950), "Zeta"}
g.et = {utf8(919), utf8(951), "Eta"}
g.th = {utf8(920), utf8(952), "Theta"}
g.io = {utf8(921), utf8(953), "Iota"}
g.ka = {utf8(922), utf8(954), "Kappa"}
g.la = {utf8(923), utf8(955), "Lambda"}
g.mu = {utf8(924), utf8(956), "Mu"}
g.nu = {utf8(925), utf8(957), "Nu"}
g.xi = {utf8(926), utf8(958), "Xi"}
g.om = {utf8(927), utf8(959), "Omicron"}
g.pi = {utf8(928), utf8(960), "Pi"}
g.rh = {utf8(929), utf8(961), "Rho"}
g.si = {utf8(931), utf8(963), "Sigma"}
g.ta = {utf8(932), utf8(964), "Tau"}
g.up = {utf8(933), utf8(965), "Upsilon"}
g.ph = {utf8(934), utf8(966), "Phi"}
g.ch = {utf8(935), utf8(967), "Chi"}
g.ps = {utf8(936), utf8(968), "Psi"}
g.om = {utf8(937), utf8(969), "Omega"}

s     = {} -- Symbols
s.dg  = utf8(176)       -- degree symbol
s.sh  = utf8(8315)      -- superscript "-"
s.s1  = utf8(185)       -- superscript "1"
s.s1h = s.sh..s.s1
s.s2  = utf8(178)       -- superscript "2"
s.s2h = s.sh..s.s2
s.s3  = utf8(179)       -- superscript "3"
s.th  = g.th[2]         -- theta
s.th0 = g.th[2].."0"    -- theta0
s.la  = g.la[2]         -- lambda
s.la0 = g.la[2].."0"    -- lambda0
s.dv  = g.de[1].."v"    -- Change in velocity (delta v)
s.dpm = g.de[1].."pm"   -- Change in momentum
s.dt  = g.de[1].."t"    -- Change in time
s.dh  = g.de[1].."h"    -- change in height
s.om  = g.om[1]         -- Resistance
s.omm = g.om[1].."*m"   -- Resistivity unit (ohms * meter)
s.rh  = g.rh[2]         -- Resistivity
s.mu  = g.mu[2]         -- Mu greek character
