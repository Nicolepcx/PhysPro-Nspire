--------------------------------------------------------
--                       Constants                    --
--------------------------------------------------------

function utf8(n)
    return string.uchar(n)
end

SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}

function numberToSub(w,n)
    return w..utf8(SubNumbers[tonumber(n)])
end

-- The Greeks
g = {} -- Upper  ,   Lower  ,  Name
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

s = {} -- Symbols
s.dg = utf8(176) -- degree symbol
s.th = g.th[2] -- theta
s.th0 = g.th[2].."0" -- theta0
s.la = g.la[2] -- lambda
s.la0 = g.la[2].."0" -- lambda0
s.dv = g.de[1].."v" -- Change in velocity (delta v)
s.dpm = g.de[1].."pm" -- Change in momentum
s.dt = g.de[1].."t" -- Change in time
s.dh = g.de[1].."h" -- change in height
s.om = g.om[1] -- Resistance
s.omm = g.om[1].."*m" -- Resistivity unit (ohms * meter)
s.rh = g.rh[2] -- Resistivity

function refCon() -- Makes the constants reference page
    local t2 = {}
    for k,v in ipairs(Constants) do
        t2[k] = {v.info,v.key,v.val.." "..v.unit}
    end
    return t2
end

Constants = {
{key="g", info="Acceleration due to gravity", val="-9.81", unit="m/s^2"},
{key="G", info="Gravitational constant", val="6.67*10^(-11)", unit="Nm^2/kg^-2"},
{key="N", info="Avogadro's constant", val="6.022*10^(23)", unit="mol^-1"},
{key="R", info="Gas constant", val="8.314", unit="J/((mol^-1)*(K^-1))"},
{key="k1", info="Boltzmann's constant", val="1.38*10^(-23)", unit="J/K^-1"},
{key="k2", info="Stefan-Boltzmann constant", val="5.67 * 10^-8", unit="W*m^-2*K^-1"},
{key="k3", info="Coulomb constant", val="8.99 * 10^9", unit="N*m^2*C^-2"},
{key="C", info="Speed of light in vacuum", val="2.9979*10^(8)", unit="m/s"},
{key="h", info="Planck constant", val="6.626*10^(-34)", unit="J/s"},
{key="q", info="Elementary charge", val="1.60218*10^(-19)", unit="C"},
{key="me", info="Electron rest mass", val="9.109*10^(-31)", unit="kg"},
{key="mp", info="Proton rest mass", val="1.6726*10^(-27)", unit="kg"},
{key="mn", info="Neutron rest mass", val="1.675*10^(-27)", unit="kg"},
{key="mu", info="Atomic mass unit", val="1.66*10^(-27)", unit="kg"},
--{key=utf8(949).."0", info="Permittivity of a vacuum", val="8.854*10^(-12)", unit="F/m^-1"},
--{key=utf8(956).."0", info="Permeability of a vacuum", val="4*pi*10^(-7)", unit="N/A^-2"}
}

function con(i) -- Shortcut for using constants in the database part
    for k,v in ipairs(Constants) do
        if Constants[k].key == i then
            return Constants[k].val
        end
    end
    return "undef"
end


