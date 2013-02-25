--[[

0-------------------0
|                   |
|   PhysPro v1.1.1  |
|  (Jan 27th 2013)  |
|   LGLP 3 License  |
|     alex3yoyo     |
|                   |
0-------------------0

Orignal code:
(Jan 18th 2013)
FormulaPro v1.4b    LGLP 3 License
Jim Bauwens         Adrien Bertrand
TI-Planet.org       Inspired-Lua.org
]]--

pInfo={name="PhysPro-Nspire", by="Mr. Kitty", ver="v1.1.1", web="http://github.com/alex3yoyo/physpro-nspire", license="LGPL3 License"}
infoStr = pInfo.name.." "..pInfo.ver.."\nBy "..pInfo.by.."\n"..pInfo.license.."\n"..pInfo.web
print("\n"..infoStr.."\n") -- Prints info to console
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

-- Symbols
----------

-- The Greeks
g = {} -- Big    , Little   , Name
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
s.dg    = utf8(176)     -- degree symbol
s.th    = g.th[2]       -- theta
s.th0   = g.th[2].."0"  -- theta0
s.la    = g.la[2]       -- lambda
s.la0   = g.la[2].."0"  -- lambda0
s.dv    = g.de[1].."v"  -- Change in velocity (delta v)
s.dpm   = g.de[1].."pm" -- Change in momentum
s.dt    = g.de[1].."t"  -- Change in time
s.dh    = g.de[1].."h"  -- change in height
s.om    = g.om[1]       -- Resistance
s.omm   = g.om[1].."*m" -- Resistivity unit (ohms * meter)
s.rh    = g.rh[2]       -- Resistivity

function refCon() -- Makes the constants reference page
    local t2 = {}
    for k,v in ipairs(Constants) do
        t2[k] = {v.info,v.key,v.val.." "..v.unit}
    end
    return t2
end

Constants = {
{key="g",   info="Acceleration due to gravity", val="-9.81",            unit="m/s^2"},
{key="G",   info="Gravitational constant",      val="6.67*10^(-11)",    unit="Nm^2/kg^-2"},
{key="N",   info="Avogadro's constant",         val="6.022*10^(23)",    unit="mol^-1"},
{key="R",   info="Gas constant",                val="8.314",            unit="J/((mol^-1)*(K^-1))"},
{key="k1",  info="Boltzmann's constant",        val="1.38*10^(-23)",    unit="J/K^-1"},
{key="k2",  info="Stefan-Boltzmann constant",   val="5.67 * 10^-8",     unit="W*m^-2*K^-1"},
{key="k3",  info="Coulomb constant",            val="8.99 * 10^9",      unit="N*m^2*C^-2"},
{key="C",   info="Speed of light in vacuum",    val="2.9979*10^(8)",    unit="m/s"},
{key="h",   info="Planck constant",             val="6.626*10^(-34)",   unit="J/s"},
{key="q",   info="Elementary charge",           val="1.60218*10^(-19)", unit="C"},
{key="me",  info="Electron rest mass",          val="9.109*10^(-31)",   unit="kg"},
{key="mp",  info="Proton rest mass",            val="1.6726*10^(-27)",  unit="kg"},
{key="mn",  info="Neutron rest mass",           val="1.675*10^(-27)",   unit="kg"},
{key="mu",  info="Atomic mass unit",            val="1.66*10^(-27)",    unit="kg"},
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


function initElementValues() -- Stores elements into nspire documents variables
    local elementValues = {
        --["ch.atom"] = [[Define ch.atom = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118 }]],
        --["ch.name"] = [[Define ch.name = { "Hydrogen", "Helium", "Lithium", "Beryllium", "Boron", "Carbon", "Nitrogen", "Oxygen", "Fluorine", "Neon", "Sodium", "Magnesium", "Aluminium", "Silicon", "Phosphorus", "Sulfur", "Chlorine", "Argon", "Potassium", "Calcium", "Scandium", "Titanium", "Vanadium", "Chromium", "Manganese", "Iron", "Cobalt", "Nickel", "Copper", "Zinc", "Gallium", "Germanium", "Arsenic", "Selenium", "Bromine", "Krypton", "Rubidium", "Strontium", "Yttrium", "Zirconium", "Niobium", "Molybdenum", "Technetium", "Ruthenium", "Rhodium", "Palladium", "Silver", "Cadmium", "Indium", "Tin", "Antimony", "Tellurium", "Iodine", "Xenon", "Caesium", "Barium", "Lanthanum", "Cerium", "Praseodymium", "Neodymium", "Promethium", "Samarium", "Europium", "Gadolinium", "Terbium", "Dysprosium", "Holmium", "Erbium", "Thulium", "Ytterbium", "Lutetium", "Hafnium", "Tantalum", "Tungsten", "Rhenium", "Osmium", "Iridium", "Platinum", "Gold", "Mercury", "Thallium", "Lead", "Bismuth", "Polonium", "Astatine", "Radon", "Francium", "Radium", "Actinium", "Thorium", "Protactinium", "Uranium", "Neptunium", "Plutonium", "Americium", "Curium", "Berkelium", "Californium", "Einsteinium", "Fermium", "Mendelevium", "Nobelium", "Lawrencium", "Rutherfordium", "Dubnium", "Seaborgium", "Bohrium", "Hassium", "Meitnerium", "Darmstadtium", "Roentgenium", "Ununbium", "Ununtrium", "Ununquadium", "Ununpentium", "Ununhexium", "Ununseptium", "Ununoctium" }]],
        --["ch.sym"] = [[Define ch.sym = { "H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar", "K", "Ca", "Sc", "Ti", "V", "Cr", "Mn", "Fe", "Co", "Ni", "Cu", "Zn", "Ga", "Ge", "As", "Se", "Br", "Kr", "Rb", "Sr", "Y", "Zr", "Nb", "Mo", "Tc", "Ru", "Rh", "Pd", "Ag", "Cd", "In", "Sn", "Sb", "Te", "I", "Xe", "Cs", "Ba", "La", "Ce", "Pr", "Nd", "Pm", "Sm", "Eu", "Gd", "Tb", "Dy", "Ho", "Er", "Tm", "Yb", "Lu", "Hf", "Ta", "W", "Re", "Os", "Ir", "Pt", "Au", "Hg", "Tl", "Pb", "Bi", "Po", "At", "Rn", "Fr", "Ra", "Ac", "Th", "Pa", "U", "Np", "Pu", "Am", "Cm", "Bk", "Cf", "Es", "Fm", "Md", "No", "Lr", "Rf", "Db", "Sg", "Bh", "Hs", "Mt", "Ds", "Rg", "Uub", "Uut", "Uuq", "Uup", "Uuh", "Uus", "Uuo" }]],
        ["ch.mass"] = [[Define ch.mass = { 1.00794, 4.002602, 6.941, 9.012182, 10.811, 12.0107, 14.00674, 15.9994, 18.9984032, 20.1797, 22.98976928, 24.305, 26.9815386, 28.0855, 30.973762, 32.065, 35.4527, 39.948, 39.0983, 40.078, 44.955912, 47.867, 50.9415, 51.9961, 54.938045, 55.845, 58.933195, 58.6934, 63.546, 65.409, 69.723, 72.64, 74.9216, 78.96, 79.904, 83.798, 85.4678, 87.62, 88.90585, 91.224, 92.90638, 95.96, 98, 101.07, 102.9055, 106.42, 107.8682, 112.411, 114.818, 118.71, 121.76, 127.6, 126.90447, 131.293, 132.9054519, 137.327, 138.90547, 140.116, 140.90765, 144.242, 145, 150.36, 151.964, 157.25, 158.92535, 162.5, 164.93032, 167.259, 168.93421, 173.054, 174.9668, 178.49, 180.94788, 183.84, 186.207, 190.23, 192.217, 195.084, 196.966569, 200.59, 204.3833, 207.2, 208.9804, 209, 210, 222, 223, 226, 227, 232.03806, 231.03588, 238.02891, 237, 244, 243, 247, 247, 251, 252, 257, 258, 259, 262, 261, 262, 266, 264, 277, 268, 271, 272, 285, 284, 289, 288, 293, undef, 294 }]],
        --["ch.type"] = [[Define ch.type = { "Nonmetal", "Noble", "Alkali", "Alkaline", "Metalloid", "Nonmetal", "Nonmetal", "Nonmetal", "Halogen", "Noble", "Alkali", "Alkaline", "Other metals", "Metalloid", "Nonmetal", "Nonmetal", "Halogen", "Noble", "Alkali", "Alkaline", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Other metals", "Metalloid", "Metalloid", "Nonmetal", "Halogen", "Noble", "Alkali", "Alkaline", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Other metals", "Other metals", "Metalloid", "Metalloid", "Halogen", "Noble", "Alkali", "Alkaline", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Lanthanoid", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Other metals", "Other metals", "Other metals", "Metalloid", "Halogen", "Noble", "Alkali", "Alkaline", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Actinoid", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Transition", "Other metals", "Other metals", "Other metals", "Other metals", undef, "Noble" }]],
        --["ch.state"] = [[Define ch.state = { "Gas", "Gas", "Solid", "Solid", "Solid", "Solid", "Gas", "Gas", "Gas", "Gas", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Gas", "Gas", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Liquid", "Gas", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Gas", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Liquid", "Solid", "Solid", "Solid", "Solid", "Solid", "Gas", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Solid", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown", "Unknown" }]],
        --["ch.group"] = [[Define ch.group = { "Group 1 (I A)","Group 2 (II A)","Group 3 (III B)","Group 4 (IV B)","Group 5 (V B)","Group 6 (VI B)","Group 7 (VII B)","Group 8 (VIII B)","Group 9 (VIII B)","Group 10 (VIII B)","Group 11 (I B)","Group 12 (II B)","Group 13 (III A)","Group 14 (IV A)","Group 15 (V A)","Group 16 (VI A)","Group 17 (VII A)","Group 18 (VIII A)","Lanthanides","Actinides"}]],
        --["ch.group"] = [[Define ch.period = {}]],
        --["ch.e_conf"] = [[Define ch.e_conf = { "1s¹","1s²","[He]2s¹","[He]2s²","[He]2s²2p¹","[He]2s²2p²","[He]2s²2p³","[He]2s²2p⁴","[He]2s²2p⁵","[He]2s²2p⁶","[Ne]3s¹","[Ne]3s²","[Ne]3s²3p¹","[Ne]3s²3p²","[Ne]3s²3p³","[Ne]3s²3p⁴","[Ne]3s²3p⁵","[Ne]3s²3p⁶","[Ar]4s¹","[Ar]4s²","[Ar]3d¹4s²","[Ar]3d²4s²","[Ar]3d³4s²","[Ar]3d⁵4s¹","[Ar]3d⁵4s²","[Ar]3d⁶4s²","[Ar]3d⁷4s²","[Ar]3d⁸4s²","[Ar]3d¹⁰4s¹","[Ar]3d¹⁰4s²","[Ar]3d¹⁰4s²4p¹","[Ar]3d¹⁰4s²4p²","[Ar]3d¹⁰4s²4p³","[Ar]3d¹⁰4s²4p⁴","[Ar]3d¹⁰4s²4p⁵","[Ar]3d¹⁰4s²4p⁶","[Kr]5s¹","[Kr]5s²","[Kr]4d¹5s²","[Kr]4d²5s²","[Kr]4d⁴5s¹","[Kr]4d⁵5s¹","[Kr]4d⁵5s²","[Kr]4d⁷5s¹","[Kr]4d⁸5s¹","[Kr]4d¹⁰","[Kr]4d¹⁰5s¹","[Kr]4d¹⁰5s²","[Kr]4d¹⁰5s²5p¹","[Kr]4d¹⁰5s²5p²","[Kr]4d¹⁰5s²5p³","[Kr]4d¹⁰5s²5p⁴","[Kr]4d¹⁰5s²5p⁵","[Kr]4d¹⁰5s²5p⁶","[Xe]6s¹","[Xe]6s²","[Xe]5d¹6s²","[Xe]4f¹5d¹6s²","[Xe]4f³6s²","[Xe]4f⁴6s²","[Xe]4f⁵6s²","[Xe]4f⁶6s²","[Xe]4f⁷6s²","[Xe]4f⁷5d¹6s²","[Xe]4f⁹6s²","[Xe]4f¹⁰6s²","[Xe]4f¹¹6s²","[Xe]4f¹²6s²","[Xe]4f¹³6s²","[Xe]4f¹⁴6s²","[Xe]4f¹⁴5d¹6s²","[Xe]4f¹⁴5d²6s²","[Xe]4f¹⁴5d³6s²","[Xe]4f¹⁴5d⁴6s²","[Xe]4f¹⁴5d⁵6s²","[Xe]4f¹⁴5d⁶6s²","[Xe]4f¹⁴5d⁷6s²","[Xe]4f¹⁴5d⁹6s¹","[Xe]4f¹⁴5d¹⁰6s¹","[Xe]4f¹⁴5d¹⁰6s²","[Xe]4f¹⁴5d¹⁰6s²6p¹","[Xe]4f¹⁴5d¹⁰6s²6p²","[Xe]4f¹⁴5d¹⁰6s²6p³","[Xe]4f¹⁴5d¹⁰6s²6p⁴","[Xe]4f¹⁴5d¹⁰6s²6p⁵","[Xe]4f¹⁴5d¹⁰6s²6p⁶","[Rn]7s¹","[Rn]7s²","[Rn]6d¹7s²","[Rn]6d²7s²","[Rn]5f²6d¹7s²","[Rn]5f³6d¹7s²","[Rn]5f⁴6d¹7s²","[Rn]5f⁶7s²","[Rn]5f⁷7s²","[Rn]5f⁷6d¹7s²","[Rn]5f⁹7s²","[Rn]5f¹⁰7s²","[Rn]5f¹¹7s²","[Rn]5f¹²7s²","[Rn]5f¹³7s²","[Rn]5f¹⁴7s²","[Rn]5f¹⁴6d¹7s²","[Rn]5f¹⁴6d²7s²","[Rn]5f¹⁴6d³7s²","[Rn]5f¹⁴6d⁴7s²","[Rn]5f¹⁴6d⁵7s²","[Rn]5f¹⁴6d⁶7s²","[Rn]5f¹⁴6d⁷7s²","[Rn]5f¹⁴6d⁹7s¹","[Rn]5f¹⁴6d¹⁰7s¹","[Rn]5f¹⁴6d¹⁰7s²","[Rn]5f¹⁴6d¹⁰7s²7p¹","[Rn]5f¹⁴6d¹⁰7s²7p²","[Rn]5f¹⁴6d¹⁰7s²7p³","[Rn]5f¹⁴6d¹⁰7s²7p⁴",undef,"[Rn]5f¹⁴6d¹⁰7s²7p⁶" }]],
        --["ch.v_elec"] = [[Define ch.v_elec = { 1, 0, 1, 2, 3, 4, 3, 2, 1, 0, 1, 2, 3, 4, 5, 6, 5, 0, 1, 2, 3, 4, 5, 6, 4, 3, 4, 4, 2, 2, 3, 4, 5, 6, 7, 4, 1, 2, 3, 4, 5, 6, 7, 6, 6, 4, 4, 2, 3, 4, 5, 6, 7, 6, 3, 2, 3, 4, 4, 3, 3, 3, 3, 3, 4, 3, 3, 3, 3, 3, 3, 4, 5, 6, 7, 7, 6, 6, 7, 2, 3, 4, 5, 6, 7, 6, 3, 2, 3, 4, 5, 6, 6, 6, 4, 4, 4, 4, 4, 3, 3, 3, 3, 4, 5, 6, 7, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, 6 }]],
        --["ch.i_eng"] = [[Define ch.i_eng = { 1312., 2372.3, 520.2, 899.5, 800.6, 1086.5, 1402.3, 1313.9, 1681., 2080.7, 495.8, 737.7, 577.5, 786.5, 1011.8, 999.6, 1251.2, 1520.6, 418.8, 589.8, 633.1, 658.8, 650.9, 652.9, 717.3, 762.5, 760.4, 737.1, 745.5, 906.4, 578.8, 762, 947., 941., 1139.9, 1350.8, 403., 549.5, 600, 640.1, 652.1, 684.3, 702, 710.2, 719.7, 804.4, 731., 867.8, 558.3, 708.6, 834, 869.3, 1008.4, 1170.4, 375.7, 502.9, 538.1, 534.4, 527, 533.1, 540, 544.5, 547.1, 593.4, 565.8, 573., 581., 589.3, 596.7, 603.4, 523.5, 658.5, 761, 770, 760, 840, 880, 870, 890.1, 1007.1, 589.4, 715.6, 703, 812.1, 890, 1037, 380, 509.3, 499, 587, 568, 597.6, 604.5, 584.7, 578, 581, 601, 608, 619, 627, 635, 642, 470, 580, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        --["ch.e_neg"] = [[Define ch.e_neg = { 2.2, undef, 0.98, 1.57, 2.04, 2.55, 3.04, 3.44, 3.98, undef, 0.93, 1.31, 1.61, 1.9, 2.19, 2.58, 3.16, undef, 0.82, 1., 1.36, 1.54, 1.63, 1.66, 1.55, 1.83, 1.88, 1.91, 1.9, 1.65, 1.81, 2.01, 2.18, 2.55, 2.96, 3., 0.82, 0.95, 1.22, 1.33, 1.6, 2.16, 1.9, 2.2, 2.28, 2.2, 1.93, 1.69, 1.78, 1.96, 2.05, 2.1, 2.66, 2.6, 0.79, 0.89, 1.1, 1.12, 1.13, 1.14, undef, 1.17, undef, 1.2, undef, 1.22, 1.23, 1.24, 1.25, undef, 1.27, 1.3, 1.5, 2.36, 1.9, 2.2, 2.2, 2.28, 2.54, 2., 1.62, 2.33, 2.02, 2., 2.2, undef, 0.7, 0.9, 1.1, 1.3, 1.5, 1.38, 1.36, 1.28, 1.3, 1.3, 1.3, 1.3, 1.3, 1.3, 1.3, 1.3, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        --["ch.e_aff"] = [[Define ch.e_aff = { 72.8, 0, 59.6, 0, 26.7, 153.9, 7, 141, 328, 0, 52.8, 0, 42.5, 133.6, 72, 200, 349, 0, 48.4, 2.37, 18.1, 7.6, 50.6, 64.3, 0, 15.7, 63.7, 112, 118.4, 0, 28.9, 119, 78, 195, 324.6, 0, 46.9, 5.03, 29.6, 41.1, 86.1, 71.9, 53, 101.3, 109.7, 53.7, 125.6, 0, 28.9, 107.3, 103.2, 190.2, 295.2, 0, 45.5, 13.95, 48, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 0, 31, 78.6, 14.5, 106.1, 151, 205.3, 222.8, 0, 19.2, 35.1, 91.2, 183.3, 270.1, 0, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        --["ch.a_rad"] = [[Define ch.a_rad = { 25, undef, 145, 105, 85, 70, 65, 60, 50, undef, 180, 150, 125, 110, 100, 100, 100, 71, 220, 180, 160, 140, 135, 140, 140, 140, 135, 135, 135, 135, 130, 125, 115, 115, 115, undef, 235, 200, 180, 155, 145, 145, 135, 130, 135, 140, 160, 155, 155, 145, 145, 140, 140, undef, 260, 215, 195, 185, 185, 185, 185, 185, 185, 180, 175, 175, 175, 175, 175, 175, 175, 155, 145, 135, 135, 130, 135, 135, 135, 150, 190, 180, 160, 190, 0, undef, undef, 215, 195, 180, 180, 175, 175, 175, 175, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        --["ch.c_rad"] = [[Define ch.c_rad = { 37, 32, 134, 90, 82, 77, 75, 73, 71, 69, 154, 130, 118, 111, 106, 102, 99, 97, 196, 174, 144, 136, 125, 127, 139, 125, 126, 121, 138, 131, 126, 122, 119, 116, 114, 110, 211, 192, 162, 148, 137, 145, 156, 126, 135, 131, 153, 148, 144, 141, 138, 135, 133, 130, 225, 198, 169, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, 160, 150, 138, 146, 159, 128, 137, 128, 144, 149, 148, 147, 146, undef, undef, 145, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        ["ch.dens"] = [[Define ch.dens = { 0.0899, 0.1785, 535, 1848, 2460, 2260, 1.251, 1.429, 1.696, 0.9, 968, 1738, 2700, 2330, 1823, 1960, 3.214, 1.784, 856, 1550, 2985, 4507, 6110, 7140, 7470, 7874, 8900, 8908, 8920, 7140, 5904, 5323, 5727, 4819, 3120, 3.75, 1532, 2630, 4472, 6511, 8570, 10280, 11500, 12370, 12450, 12023, 10490, 8650, 7310, 7310, 6697, 6240, 4940, 5.9, 1879, 3510, 6146, 6689, 6640, 7010, 7264, 7353, 5244, 7901, 8219, 8551, 8795, 9066, 9321, 6570, 9841, 13310, 16650, 19250, 21020, 22610, 22650, 21090, 19300, 13534, 11850, 11340, 9780, 9196, undef, 9.73, undef, 5000, 10070, 11724, 15370, 19050, 20450, 19816, undef, 13510, 14780, 15100, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        ["ch.c"] = [[Define ch.c = { 14300, 5193.1, 3570, 1820, 1030, 710, 1040, 919, 824, 1030., 1230, 1020, 904, 710, 769.7, 705, 478.2, 520.33, 757, 631, 567, 520, 489, 448, 479, 449, 421, 445, 384.4, 388, 371, 321.4, 328, 321.2, 947.3, 248.05, 364, 300, 298, 278, 265, 251, 63, 238, 240, 240, 235, 230, 233, 217, 207, 201, 429., 158.32, 242, 205, 195, 192, 193, 190, undef, 196, 182, 240, 182, 167, 165, 168, 160, 154, 154, 144, 140, 132, 137, 130, 131, 133, 129.1, 139.5, 129, 127, 122, undef, undef, 93.65, undef, 92., 120, 118, 99.1, 116, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        ["ch.melt"] = [[Define ch.melt = { 14.01, 0.95, 453.69, 1560, 2348, 3823, 63.05, 54.8, 53.5, 24.56, 370.87, 923, 933.47, 1687, 317.3, 388.36, 171.6, 83.8, 336.53, 1115, 1814, 1941, 2183, 2180, 1519, 1811, 1768, 1728, 1357.77, 692.68, 302.91, 1211.4, 1090, 494, 265.8, 115.79, 312.46, 1050, 1799, 2128, 2750, 2896, 2430, 2607, 2237, 1828.05, 1234.93, 594.22, 429.75, 505.08, 903.78, 722.66, 386.85, 161.3, 301.59, 1000, 1193, 1071, 1204, 1294, 1373, 1345, 1095, 1586, 1629, 1685, 1747, 1770, 1818, 1092, 1936, 2506, 3290, 3695, 3459, 3306, 2739, 2041.4, 1337.33, 234.32, 577, 600.61, 544.4, 527, 575, 202, 300, 973, 1323, 2023, 1845, 1408, 917, 913, 1449, 1618, 1323, 1173, 1133, 1800, 1100, 1100, 1900, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        ["ch.boil"] = [[Define ch.boil = { 20.28, 4.22, 1615, 2743, 4273, 4300, 77.36, 90.2, 85.03, 27.07, 1156, 1363, 2792, 3173, 553.6, 717.87, 239.11, 87.3, 1032, 1757, 3103, 3560, 3680, 2944, 2334, 3134, 3200, 3186, 3200, 1180, 2477, 3093, 887, 958, 332, 119.93, 961, 1655, 3618, 4682, 5017, 4912, 4538, 4423, 3968, 3236, 2435, 1040, 2345, 2875, 1860, 1261, 457.4, 165.1, 944, 2143, 3737, 3633, 3563, 3373, 3273, 2076, 1800, 3523, 3503, 2840, 2973, 3141, 2223, 1469, 3675, 4876, 5731, 5828, 5869, 5285, 4701, 4098, 3129, 629.88, 1746, 2022, 1837, 1235, 610, 211.3, 950, 2010, 3473, 5093, 4273, 4200, 4273, 3503, 2284, 3383, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        ["ch.h_fus"] = [[Define ch.h_fus = { 0.558, 0.02, 3., 7.95, 50, 105, 0.36, 0.222, 0.26, 0.34, 2.6, 8.7, 10.7, 50.2, 0.64, 1.73, 3.2, 1.18, 2.33, 8.54, 16, 18.7, 22.8, 20.5, 13.2, 13.8, 16.2, 17.2, 13.1, 7.35, 5.59, 31.8, 27.7, 5.4, 5.8, 1.64, 2.19, 8, 11.4, 21, 26.8, 36, 23, 25.7, 21.7, 16.7, 11.3, 6.3, 3.26, 7., 19.7, 17.5, 7.76, 2.3, 2.09, 8., 6.2, 5.5, 6.9, 7.1, 7.7, 8.6, 9.2, 10, 10.8, 11.1, 17., 19.9, 16.8, 7.7, 22, 25.5, 36, 35, 33, 31, 26, 20, 12.5, 2.29, 4.2, 4.77, 10.9, 13, 6, 3, 2, 8, 14, 16, 15, 14, 10, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        ["ch.h_vap"] = [[Define ch.h_vap = { 0.452, 0.083, 147, 297, 507, 715, 2.79, 3.41, 3.27, 1.75, 97.7, 128, 293, 359, 12.4, 9.8, 10.2, 6.5, 76.9, 155, 318, 425, 453, 339, 220, 347, 375, 378, 300, 119, 256, 334, 32.4, 26, 14.8, 9.02, 72, 137, 380, 580, 690, 600, 550, 580, 495, 380, 255, 100, 230, 290, 68, 48, 20.9, 12.64, 65, 140, 400, 350, 330, 285, 290, 175, 175, 305, 295, 280, 265, 285, 250, 160, 415, 630, 735, 800, 705, 630, 560, 490, 330, 59.2, 165, 178, 160, 100, 40, 17, 65, 125, 400, 530, 470, 420, 335, 325, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]]
        --["ch.t_cond"] = [[Define ch.t_cond = { 0.1805, 0.1513, 85, 190, 27, 140, 0.02583, 0.02658, 0.0277, 0.0491, 140, 160, 235, 150, 0.236, 0.205, 0.0089, 0.01772, 100, 200, 16, 22, 31, 94, 7.8, 80, 100, 91, 400, 120, 29, 60, 50, 0.52, 0.12, 0.00943, 58, 35, 17, 23, 54, 139, 51, 120, 150, 72, 430, 97, 82, 67, 24, 3, 0.449, 0.00565, 36, 18, 13, 11, 13, 17, 15, 13, 14, 11, 11, 11, 16, 15, 17, 39, 16, 23, 57, 170, 48, 88, 150, 72, 320, 8.3, 46, 35, 8, undef, 2, 0.00361, undef, 19, 12, 54, 47, 27, 6, 6, 10, undef, 10, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]],
        --["ch.e_cond"] = [[Define ch.e_cond = { undef, undef, 11, 25, 0.0000000001, 0.1, undef, undef, undef, undef, 21, 23, 38, 0.001, 10, 1000000000000000000000, 0.00000001, undef, 14, 29, 1.8, 2.5, 5., 7.9, 0.62, 10, 17, 14, 59, 17, 7.1, 0.002, 3.3, undef, 0.0000000000000001, undef, 8.3, 7.7, 1.8, 2.4, 6.7, 20, 5., 14, 23, 10, 62, 14, 12, 9.1, 2.5, 0.01, 0.0000000000001, undef, 5, 2.9, 1.6, 1.4, 1.4, 1.6, 1.3, 1.1, 1.1, 0.77, 0.83, 1.1, 1.1, 1.2, 1.4, 3.6, 1.8, 3.3, 7.7, 20, 5.6, 12, 21, 9.4, 45, 1, 6.7, 4.8, 0.77, 2.3, undef, undef, undef, 1, undef, 6.7, 5.6, 3.6, 0.83, 0.67, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef, undef }]]
    }
    for k,v in pairs(elementValues) do
        math.eval(v) -- stores
        math.eval("Lock "..k) -- Locks the loaded lists
    end
end

--[[
function getChem(k, v)
    if v >= 1 and v <= # ch.atom then
        return ch[k][v]
    else
        return 0
    end
end
]]--
--------------------------------------------------------
--                      Database                      --
--------------------------------------------------------

-- Set the position of each section
ct = {}
ct.mo = 1 -- Mechanics
ct.th = 2 -- Thermal physics
ct.wa = 3 -- Oscillations & Waves
ct.ec = 4 -- Electric cuurents
ct.ch = 5 -- Chemistry
ct.ex = 6 -- External Database

function checkIfExists(table, name)
    for k,v in pairs(table) do
        if (v.name == name) or (v == name) then
            print("Conflict (elements appearing twice) detected when loading Database. Skipping the item.")
            return true
        end
    end
    return false
end

function checkIfFormulaExists(table, formula)
    for k,v in pairs(table) do
        if (v.formula == formula)  then
            print("Conflict (formula appearing twice) detected when loading Database. Skipping the item.")
            return true
        end
    end
    return false
end

Categories = {}
Formulas = {}

function addCat(id,name,info)
    if checkIfExists(Categories, name) then
        print("Warning ! This category appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories, id, {id=id, name=name, info=info, sub={}, varlink={}})
end

function addCatVar(cid, var, info, unit)
    Categories[cid].varlink[var] = {unit=unit, info=info }
end

function addSubCat(cid, id, name, info)
    if checkIfExists(Categories[cid].sub, name) then
        print("Warning ! This subcategory appears to exist already ! Adding anyway....")
    end
    return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}})
end

function aF(cid, sid, formula, variables) --add Formula
    local fr = {category=cid, sub=sid, formula=formula, variables=variables}
    -- In times like this we are happy that inserting tables just inserts a reference

    -- commented out this check because only the subcategory duplicates should be avoided, and not on the whole db.
    --if not checkIfFormulaExists(Formulas, fr.formula) then
        table.insert(Formulas, fr)
    --end
    if not checkIfFormulaExists(Categories[cid].sub[sid].formulas, fr.formula) then
        table.insert(Categories[cid].sub[sid].formulas, fr)
    end

    -- This function might need to be merged with U(...)
    for variable,_ in pairs(variables) do
        Categories[cid].sub[sid].variables[variable] = true
    end
end

function U(...)
    local out = {}
    for i, p in ipairs({...}) do
        out[p] = true
    end
    return out
end

--------------------------------------------
-- Categories, Sub-Categories, & Formulas --
--------------------------------------------

-- Almost all formulas are from the IB Physics HL Data Booklet, which contains the fundamental equations needed throughout the course. It does not contain every physics equation know to man, nor is every Data Booklet equation included in this database.

addCat(ct.mo, "Mechanics", "IB topic 2. Perform motion-related calculations")

addCatVar(ct.mo, "u",   "Intial velocity", "m/s")
addCatVar(ct.mo, "v",   "Final velocity", "m/s")
addCatVar(ct.mo, s.dv,  "Change in velocity", "m/s")
addCatVar(ct.mo, "s",   "Displacement", "m")
addCatVar(ct.mo, "t",   "Final time", "s")
addCatVar(ct.mo, "t0",  "Initial time", "s")
addCatVar(ct.mo, s.dt,  "Change in time", "s")
addCatVar(ct.mo, "a",   "Accleration", "m/s2")
addCatVar(ct.mo, "F",   "Force", "N")
addCatVar(ct.mo, "m",   "Mass", "kg")
addCatVar(ct.mo, "W",   "Work", "J")
addCatVar(ct.mo, "P",   "Power", "W")
addCatVar(ct.mo, s.dh,  "Change in height", "m")
addCatVar(ct.mo, "imp", "Impulse", "N*s")
addCatVar(ct.mo, "pm",  "Final momentum", "N*s")
addCatVar(ct.mo, "pm0", "Initial momentum", "N*s")
addCatVar(ct.mo, s.dpm, "Change in momentum", "N*s")
addCatVar(ct.mo, "Epg", "gravitational potential energy", "J")
addCatVar(ct.mo, "Ek",  "Kinetic energy (translational)", "J")
addCatVar(ct.mo, "TME", "Total mechanical energy", "J")
addCatVar(ct.mo, s.th,  "Angle", s.dg)
addCatVar(ct.mo, "Tp",  "Period", "s")
addCatVar(ct.mo, "c",   "Circumference", "m")
addCatVar(ct.mo, "r",   "Radius", "m")
addCatVar(ct.mo, "ca",  "Centripital acceleration", "m/s2")
addCatVar(ct.mo, "cF",  "Centripital force", "N")
addCatVar(ct.mo, "cv",  "Centripital velocity", "m/s")

addSubCat(ct.mo, 1, "Kinematics", "Solve for: u, v, s, a, "..s.dt)
aF(ct.mo, 1, "s=((u+v)/2)*"..s.dt, U("s", "u", "v", s.dt) )
aF(ct.mo, 1, "s=u*"..s.dt.."+(1/2)*a*"..s.dt.."^(2)", U("s", "u", s.dt, "a") )
aF(ct.mo, 1, "v^(2)=u^(2)+2*a*s", U("v", "u", "a", "s") )
aF(ct.mo, 1, "v=u+a*"..s.dt, U("v", "u", "a", s.dt) )
aF(ct.mo, 1, s.dt.."=t-t0", U(s.dt, "t", "t0") )
aF(ct.mo, 1, s.dv.."=v-u", U(s.dv, "v", "u") )

addSubCat(ct.mo, 2, "Force", "Solve for F, gF, m, a")
aF(ct.mo, 2, "F=m*a", U("F", "m", "a") )

addSubCat(ct.mo, 3, "Impulse", "Solve for: pm, pm0, imp, F, m, a, v, u, "..s.dt..", "..s.dv..", "..s.dpm) -- Very confusing
aF(ct.mo, 3, "F*t=m*"..s.dv, U("F", "t", "m", s.dv) ) -- impulse-momentum change equation
aF(ct.mo, 3, s.dv.."=v-u", U(s.dv, "v", "u") ) -- change in velocity
aF(ct.mo, 3, "pm0=m*u", U("pm0", "m", "u") ) -- initial momentum
aF(ct.mo, 3, "pm=m*v", U("pm", "m", "v") ) -- final momentum
aF(ct.mo, 3, "imp=pm-pm0", U("imp", "pm", "pm0") ) -- change in momentum
aF(ct.mo, 3, "imp=F*t", U("imp", "F", "t") ) -- impulse
aF(ct.mo, 3, "imp=m*"..s.dv, U("imp", "m", s.dv) ) -- delta-momentum
aF(ct.mo, 3, "F=m*a", U("F", "m", "a") ) -- force
--aF(ct.mo, 3, "pm=m*v-m*u", U("pm", "m", "v", "u") )

addSubCat(ct.mo, 4, "Work", "Solve for: W, F, s, m, a, "..s.th)
aF(ct.mo, 4, "W=F*s*cos("..s.th..")", U("W", "F", s.th, "s") )
aF(ct.mo, 4, "W=(1/2)*m*(v^(2)-u^(2))", U("W", "m", "v", "u") )
aF(ct.mo, 4, "F=m*a", U("F", "m", "a") )
aF(ct.mo, 4, s.dv.."=v-u", U(s.dv, "v", "u") )

addSubCat(ct.mo, 5, "Energy", "Solve for: Ek, Epg, TME, m, v, g, "..s.dh)
aF(ct.mo, 5, "Ek=(1/2)*m*v^2", U("Ek", "m", "v") ) -- kinetic energy
aF(ct.mo, 5, "Ek=pm^2/(2*m)", U("Ek", "pm", "m") ) -- kinetic energy
aF(ct.mo, 5, "Epg=m*"..s.dh.."*("..con("g")..")", U("Epg", "m", s.dh) ) -- gravity potential energy
aF(ct.mo, 5, "TME=Ek+Epg", U("TME", "Ek", "Epg") ) -- total mechanical energy

addSubCat(ct.mo, 6, "Power", "Solve for: P, W, F, m, a, s, "..s.th..", "..s.dt)
aF(ct.mo, 6, "P=W/"..s.dt, U("P", "W", s.dt) ) -- power (work/time)
aF(ct.mo, 6, "P=F*(s/"..s.dt, U("P", "F", "s", s.dt) ) -- power (force*(displacement/time))
aF(ct.mo, 6, "W=F*v", U("W", "F", "v") ) -- work
aF(ct.mo, 6, "F=m*a", U("F", "m", "a") ) -- force
aF(ct.mo, 6, s.dv.."=s/"..s.dt, U(s.dv, "s", s.dt) )

addSubCat(ct.mo, 7, "Centripital", "Solve for F, a, v, r, Tp (period), m, c" )
aF(ct.mo, 7, "cF=(m*cv^2)/r", U("cF", "m", "cv", "r") )
aF(ct.mo, 7, "ca=(4*pi^2*r)/Tp^2", U("ca", "r", "Tp") )
aF(ct.mo, 7, "ca=cv^2/r^2", U("ca", "cv", "r") )
aF(ct.mo, 7, "c=2*pi*r", U("c", "r") )

addCat(ct.th, "Thermal physics", "IB topic 3 & 10. Perform thermal related physics calculations")

addCatVar(ct.th, "P",   "Pressure", "Pa")
addCatVar(ct.th, "V",   "Volume", "m3")
addCatVar(ct.th, "T",   "Tempturature", "K")
addCatVar(ct.th, "n",   "Amount", "mol")
addCatVar(ct.th, "m",   "Mass", "kg")
addCatVar(ct.th, "amu", "Molecular mass", "amu")
addCatVar(ct.th, "tK",  "Kelvin", "nounit")
addCatVar(ct.th, "tC",  "Celcius", "nounit")
addCatVar(ct.th, "tF",  "Farhenhiet", "nounit")
addCatVar(ct.th, "F",   "Force", "N")
addCatVar(ct.th, "A",   "Area", "m2")
addCatVar(ct.th, "Ek",  "Kinetic energy (translational)", "J")
addCatVar(ct.th, "Q",   "Heat", "J")
addCatVar(ct.th, "c",   "Specific heat capacity", "J/kg*K")
addCatVar(ct.th, "L",   "Latent heat", "nounit")

addSubCat(ct.th, 1, "Tempurature", "Convert between the different tempurature scales")
aF(ct.th, 1, "tF=(9/5)*tC+32", U("tC", "tF") )
aF(ct.th, 1, "tK=tC+273.15", U("tK", "tC") )

addSubCat(ct.th, 2, "Thermal", "Solve for P, V, T, n, m, amu")
aF(ct.th, 2, "P*V=n*("..con("R")..")*T", U("P", "V", "n", "T") )
aF(ct.th, 2, "n=m/amu", U("n", "m", "amu") )
aF(ct.th, 2, "P=F/A", U("P", "F", "A") )
aF(ct.th, 2, "Ek=(3/2)*("..con("k1")..")*T", U("Ek", "T") )

addSubCat(ct.th, 3, "Capacity", "Solve for Q, T, m, c, L")
aF(ct.th, 3, "Q=c*m*T", U("Q", "c", "m", "T") )
aF(ct.th, 3, "Q=m*L", U("Q", "m", "L") )

addCat(ct.wa, "Oscillations & Waves", "IB Topic 4. Perform wave-related calculations")

addCatVar(ct.wa, "F",   "Force", "N")
addCatVar(ct.wa, "K",   "Spring constant", "N/m")
addCatVar(ct.wa, "x",   "Displacement", "m")
addCatVar(ct.wa, "m",   "Mass", "kg")
addCatVar(ct.wa, "a",   "Acceleration", "m/s2")
addCatVar(ct.wa, "Ep",  "Elastic potential energy", "J")
addCatVar(ct.wa, "T",   "Period", "s")
addCatVar(ct.wa, "fq",  "Frequency", "Hz")
addCatVar(ct.wa, "v",   "Velocity", "m/s")
addCatVar(ct.wa, "v0",  "Velocity", "m/s")
addCatVar(ct.wa, "n",   "Refraction index", "nounit")
addCatVar(ct.wa, "n0",  "Refraction index", "nounit")
addCatVar(ct.wa, s.th,  "Angle", s.dg)
addCatVar(ct.wa, s.th0, "Angle", s.dg)
addCatVar(ct.wa, s.la,  "Wavelength", "m")
addCatVar(ct.wa, s.la0, "Wavelength", "m")

addSubCat(ct.wa, 1, "Waves", "Solve for F, K, m, a, x, Ep")
aF(ct.wa, 1, "F=m*a", U("F", "m", "a") ) -- force
aF(ct.wa, 1, "F=-K*x", U("F", "K", "x") ) -- force (spring_constant*displacement)
aF(ct.wa, 1, "Ep=0.5*K*(x)^2", U("Ep", "K") )
aF(ct.wa, 1, "a=(-K/m)*x", U("a", "K", "m", "x") )
aF(ct.wa, 1, "T=2*pi*sqrt(m/K)", U("T", "m", "K") )
aF(ct.wa, 1, "v="..s.la.."/T", U("v", s.la, "T") )
aF(ct.wa, 1, "v=fq*"..s.la, U("v", "fq", s.la) )

addSubCat(ct.wa, 2, "Reflections & Refractions", "Solve for n, n0, v, v0, fq, "..s.th..", "..s.th0..", "..s.la..", "..s.la0)
aF(ct.wa, 2, "n/n0=sin("..s.th0..")/sin("..s.th..")=v0/v", U("n", "n0", s.th0, s.th, "v0", "v") )
--aF(ct.wa, 2, "v/"..s.la.."=v0/"..s.la0, U("v", "v0", s.la, s.la0) )
aF(ct.wa, 2, "n=("..con("C")..")/v", U("n", "v") )
aF(ct.wa, 2, "n0=("..con("C")..")/v0", U("n0", "v0") )
aF(ct.wa, 2, "v=fq*"..s.la, U("v", "fq", s.la ) )
aF(ct.wa, 2, "v0=fq*"..s.la0, U("v0", "fq", s.la0 ) )

addCat(ct.ec, "Electric Cuurents", "IB Topic 5.")
addCatVar(ct.ec, "Ve",  "Energy", "J")
addCatVar(ct.ec, "I",   "Current", "A")
addCatVar(ct.ec, "q",   "Charge", "C")
addCatVar(ct.ec, "t",   "Time", "s")
addCatVar(ct.ec, "R",   "Resistence", s.oh)
addCatVar(ct.ec, "V",   "Voltage", "V")
addCatVar(ct.ec, "A",   "Cross-sectional area", "m2")
addCatVar(ct.ec, "l",   "Length", "m")
addCatVar(ct.ec, "m",   "Mass", "kg")
addCatVar(ct.ec, "", "", "")

addCat(ct.ch, "Chemestry", "Chemistry related things that have some connection to physics")

addCatVar(ct.ch, "atom",    "Atomic number", "nounit")
addCatVar(ct.ch, "mass",    "Mass", "amu")
addCatVar(ct.ch, "dens",    "Density", "kg/m3")
addCatVar(ct.ch, "c",       "Specific heat", "J/kg*K")
addCatVar(ct.ch, "melt",    "Melting point", "K")
addCatVar(ct.ch, "boil",    "Boiling point", "K")
addCatVar(ct.ch, "h_fus",   "Heat of fusion", "kJ/mol")
addCatVar(ct.ch, "h_vap",   "Heat of vaporization", "kJ/mol")
addCatVar(ct.ch, "name",    "Name", "nounit")
addCatVar(ct.ch, "sym",     "Symbol", "nounit")
addCatVar(ct.ch, "type",    "Type", "nounit")
addCatVar(ct.ch, "state",   "State at 273K", "nounit")
addCatVar(ct.ch, "group",   "Group", "nounit")
addCatVar(ct.ch, "period",  "Period", "nounit")
addCatVar(ct.ch, "e_conf",  "Electron configuration", "nounit")
addCatVar(ct.ch, "v_elec",  "Valence electrons", "nounit")
addCatVar(ct.ch, "i_eng",   "1st ionization energy", "kJ/mol")
addCatVar(ct.ch, "e_neg",   "Electronegativity", "nounit")
addCatVar(ct.ch, "e_aff",   "Electron affinity", "nounit")
addCatVar(ct.ch, "a_rad",   "Atomic radius", "pm")
addCatVar(ct.ch, "c_rad",   "Covalent radius", "pm")
addCatVar(ct.ch, "t_cond",  "Thermal conductivity", "W/mK")
addCatVar(ct.ch, "e_cond",  "Electrical conductivity", "MS/m")

addSubCat(ct.ch, 1, "Elements", "Obtain information relating to the periodic elements")
aF(ct.ch, 1, "mass=ch.mass[atom]", U( "mass", "atom") )
aF(ct.ch, 1, "dens=ch.dens[atom]", U( "dens", "atom") )
aF(ct.ch, 1, "c=ch.c[atom]", U( "c", "atom") )
aF(ct.ch, 1, "melt=ch.melt[atom]", U( "melt", "atom") )
aF(ct.ch, 1, "boil=ch.boil[atom]", U( "boil", "atom") )
aF(ct.ch, 1, "h_fus=ch.h_fus[atom]", U( "h_fus", "atom") )
aF(ct.ch, 1, "h_vap=ch.h_vap[atom]", U( "h_vap", "atom") )
--aF(ct.ch, 1, "name=ch.name[atom]", U( "name", "atom") )
--aF(ct.ch, 1, "sym=ch.sym[atom]", U( "sym", "atom") )
--aF(ct.ch, 1, "atom=ch.atom[atom]", U( "atom") )
--aF(ct.ch, 1, "type=ch.type[atom]", U( "type", "atom") )
--aF(ct.ch, 1, "state=ch.state[atom]", U( "state", "atom") )
--aF(ct.ch, 1, "group=ch.group[atom]", U( "group", "atom") )
--aF(ct.ch, 1, "period=ch.period[atom]", U( "period", "atom") )
--aF(ct.ch, 1, "e_conf=ch.e_conf[atom]", U( "e_conf", "atom") )
--aF(ct.ch, 1, "v_elec=ch.v_elec[atom]", U( "v_elec", "atom") )
--aF(ct.ch, 1, "i_eng=ch.i_eng[atom]", U( "i_eng", "atom") )
--aF(ct.ch, 1, "e_neg=ch.e_neg[atom]", U( "e_neg", "atom") )
--aF(ct.ch, 1, "e_aff=ch.e_aff[atom]", U( "e_aff", "atom") )
--aF(ct.ch, 1, "a_rad=ch.a_rad[atom]", U( "a_rad", "atom") )
--aF(ct.ch, 1, "c_rad=ch.c_rad[atom]", U( "c_rad", "atom") )
--aF(ct.ch, 1, "t_cond=ch.t_cond[atom]", U( "t_cond", "atom") )
--aF(ct.ch, 1, "e_cond=ch.e_cond[atom]", U( "e_cond", "atom") )
--This part is supposed to load external formulas stored in a string from a file in MyLib.
--WIP

function loadExtDB()
    local err
    _, err = pcall(function()
        loadstring(math.eval("physproextdb\\categories()"))()
        loadstring(math.eval("physproextdb\\variables()"))()
        loadstring(math.eval("physproextdb\\subcategories()"))()
        loadstring(math.eval("physproextdb\\equations()"))()
    end)

    if err then
        print("No external DB loaded")
        -- Display something, or it simply means there is nothing to be loaded.
    else
        -- Display something that tells the user the external DB has been successfully loaded.
        print("External DB succesfully loaded")
    end
end
---------------
--   Units   --
---------------

local mathpi = math.pi

Units = {}

function Units.mainToSub(main, sub, n)
    local c = Units[main][sub]
    return n * c[1] + c[2]
end

function Units.subToMain(main, sub, n)
    local c = Units[main][sub]
    return (n - c[2]) / c[1]
end

--[[
Units["mainunit"]	= {}
Units["mainunit"]["subunit"] = {a, b}
meaning:
    n mainunit = n*a+b subunit
  or
    n subunit = (n-b)/a mainunit
--]]

Mt = {}
Mt.G = 1 / 1000000000
Mt.M = 1 / 1000000
Mt.k = 1 / 1000
Mt.h = 1 / 100
Mt.da = 1 / 10
Mt.d = 10
Mt.c = 100
Mt.m = 1000
Mt.u = 1000000
Mt.n = 1000000000
Mt.p = 1000000000000

Ms = {}
Ms.min = 60
Ms.hr = 3600
Ms.day = 86400
Ms.wk = 604800
Ms.fortn = 1209600
Ms.month = 18144000
Ms.yr = 217728000

--Time
Units["s"] = {}
Units["s"]["min"] = { Ms.min, 0}
Units["s"]["hr"] = { Ms.hr, 0}
Units["s"]["day"] = { Ms.day, 0}
Units["s"]["wk"] = { Ms.wk, 0}
Units["s"]["fortn"] = { Ms.fortn, 0}
Units["s"]["month"] = { Mt.month, 0}
Units["s"]["yr"] = { Mt.yr, 0}
Units["s"]["mCent"] = { 34, 0}
Units["s"]["Frieds"] = { 108864000, 0}

--Length
Units["m"] = {}
Units["m"]["pm"] = { Mt.p, 0}
Units["m"]["nm"] = { Mt.n, 0}
Units["m"][utf8(956).."m"] = { Mt.u, 0}
Units["m"]["mm"] = { Mt.m, 0}
Units["m"]["cm"] = { Mt.c, 0}
Units["m"]["dm"] = { Mt.d, 0}
Units["m"]["dam"] = { Mt.da, 0}
Units["m"]["hm"] = { Mt.h, 0}
Units["m"]["km"] = { Mt.k, 0}
Units["m"]["Mm"] = { Mt.M, 0}
Units["m"]["Gm"] = { Mt.G, 0}
Units["m"]["in"] = { 0.0254, 0}
Units["m"]["ft"] = { 0.3048, 0}
Units["m"]["yd"] = { 0.9144, 0}
Units["m"]["mi"] = { 1609.34, 0}
Units["m"]["Nmi"] = { 1852, 0}
Units["m"]["rod"] = { 4.572, 0}
Units["m"]["chain"] = { 20.1168, 0}
Units["m"]["Smoot"] = { 1.70180, 0}
Units["m"]["ftm"] = { 1.8288, 0}
Units["m"]["FB-F"] = { 109.7, 0}
Units["m"]["furlong"] = { 201.168, 0}
Units["m"]["brds"] = { 0.000000005, 0}

--Area
Units["m2"] = {}
Units["m2"]["nm2"] = { Mt.n, 0}
Units["m2"][utf8(956).."m2"] = { Mt.u, 0}
Units["m2"]["mm2"] = { Mt.m2, 0}
Units["m2"]["cm2"] = { Mt.c, 0}
Units["m2"]["dm2"] = { Mt.d, 0}
Units["m2"]["dam2"] = { Mt.da, 0}
Units["m2"]["hm2"] = { Mt.h, 0}
Units["m2"]["km2"] = { Mt.k, 0}
Units["m2"]["Mm2"] = { Mt.M, 0}
Units["m2"]["Gm2"] = { Mt.G, 0}
Units["m2"]["in2"] = { 0.0254, 0}
Units["m2"]["ft2"] = { 0.3048, 0}
Units["m2"]["yd2"] = { 0.9144, 0}
Units["m2"]["mi2"] = { 1609.34, 0}
Units["m2"]["Nmi2"] = { 1852, 0}
Units["m2"]["rod2"] = { 4.572, 0}
Units["m2"]["chain2"] = { 20.1168, 0}
Units["m2"]["Smoot2"] = { 1.70180, 0}
Units["m2"]["ftm2"] = { 1.8288, 0}
Units["m2"]["FB-F2"] = { 109.7, 0}
Units["m2"]["furlong2"] = { 201.168, 0}
Units["m2"]["brds2"] = { 0.000000005, 0}

--Volume
Units["m3"] = {}
Units["m3"]["mm3"] = { Mt.m, 0}
Units["m3"]["cm3"] = { Mt.c, 0}
Units["m3"]["km3"] = { Mt.k, 0}
Units["m3"]["ml"] = { 0.000001, 0}
Units["m3"]["l"] = { 0.001, 0}
Units["m3"]["in3"] = { .000016387064, 0}
Units["m3"]["ft3"] = { 0.028316846592, 0}
Units["m3"]["yd3"] = { 0.764554857984, 0}
Units["m3"]["tsp"] = { 0.00000492892159375, 0}
Units["m3"]["tbsp"] = { 0.00001478676478125, 0}
Units["m3"]["floz"] = { 0.0000295735295625, 0}
Units["m3"]["cup"] = { 0.0002365882365, 0}
Units["m3"]["pt"] = { 0.000473176473, 0}
Units["m3"]["qt"] = { 0.000946352946, 0}
Units["m3"]["gal"] = { 0.003785411784, 0}
Units["m3"]["flozUK"] = { 0.000028413075, 0}
Units["m3"]["galUK"] = { 0.004546092, 0}

--Velocity
Units["m/s"] = {}
Units["m/s"]["km/s"] = { Mt.k, 0}
Units["m/s"]["cm/s"] = { Mt.c, 0}
Units["m/s"]["mm/s"] = { Mt.m, 0}
Units["m/s"]["m/hr"] = { Ms.hr, 0}
Units["m/s"]["km/hr"] = { 3.6, 0}
Units["m/s"]["knot"] = { 0.514444, 0}
Units["m/s"]["mi/hr"] = { 0.44704, 0}
Units["m/s"]["km/min"] = { 16.6667, 0}
Units["m/s"]["ft/min"] = { 0.00508, 0}
Units["m/s"]["ft/s"] = { 0.3048, 0}
Units["m/s"]["mi/min"] = { 26.8224, 0}
Units["m/s"]["brds/sec"] = { 0.000000005, 0}

--Acceleration
Units["m/s2"] = {}
Units["m/s2"]["km/s2"] = { Mt.k, 0}
Units["m/s2"]["cm/s2"] = { Mt.c, 0}
Units["m/s2"]["mm/s2"] = { Mt.m, 0}
Units["m/s2"]["m/hr2"] = { Ms.hr, 0}
Units["m/s2"]["km/hr2"] = { 3.6, 0}
Units["m/s2"]["knot2"] = { 0.514444, 0}
Units["m/s2"]["mi/hr2"] = { 0.44704, 0}
Units["m/s2"]["km/min2"] = { 16.6667, 0}
Units["m/s2"]["ft/min2"] = { 0.00508, 0}
Units["m/s2"]["ft/s2"] = { 0.3048, 0}
Units["m/s2"]["mi/min2"] = { 26.8224, 0}

--Mass
Units["kg"] = {}
Units["kg"]["g"] = { Mt.m, 0}
Units["kg"]["mg"] = { Mt.u, 0}
Units["kg"]["lb"] = { 0.453592, 0}
Units["kg"]["oz"] = { 0.0283495, 0}
Units["kg"]["ton"] = { 907.185, 0}
Units["kg"]["slug"] = { 14.5939, 0}

--Force
Units["N"] = {}
Units["N"]["kN"] = { Mt.k, 0}
Units["N"]["mN"] = { Mt.m, 0}
Units["N"]["MN"] = { Mt.M, 0}
Units["N"]["GN"] = { Mt.G, 0}
Units["N"]["dyn"] = { 100000, 0}
Units["N"]["lbf"] = { 0.224809, 0}
Units["N"]["kgf"] = { 0.101972, 0}
Units["N"]["tonf"] = { 0.000112404, 0}

--Newton*sec (Impulse/Momentum)
Units["N*s"] = {}

--Energy
Units["J"] = {}
Units["J"]["GJ"] = { Mt.G, 0}
Units["J"]["MJ"] = { Mt.M, 0}
Units["J"]["kJ"] = { Mt.k, 0}
Units["J"]["mJ"] = { Mt.m, 0}
Units["J"]["kWh"] = { 3600000, 0}
Units["J"]["ftlb"] = { 1.35582, 0}
Units["J"]["Btu"] = { 1055.06, 0}

--Power
Units["W"] = {}
Units["W"]["GW"] = { Mt.G, 0}
Units["W"]["MW"] = { Mt.M, 0}
Units["W"]["kW"] = { Mt.k, 0}
Units["W"]["mW"] = { Mt.m, 0}
Units["W"]["hp"] = { 745.7, 0}
Units["W"]["airW"] = { 0.9983, 0}
Units["W"]["Btu/min"] = { 17.5842638, 0}

--Pressure
Units["Pa"] = {}
Units["Pa"]["mPA"] = { Mt.m, 0}
Units["Pa"]["kPa"] = { Mt.k, 0}
Units["Pa"]["MPa"] = { Mt.M, 0}
Units["Pa"]["N/m2"] = { 1, 0}
Units["Pa"]["mmH20"] = { 9.80665, 0}
Units["Pa"]["inH2O"] = { 249.08891, 0}
Units["Pa"]["mmHg"] = { 133.32236842105, 0}
Units["Pa"]["inHg"] = { 3338.6388157895, 0}
Units["Pa"]["mbar"] = { 100, 0}
Units["Pa"]["lb/ft2"] = { 47.880258980336, 0}
Units["Pa"]["psi"] = { 6894.7572931684, 0}
Units["Pa"]["torr"] = { 0133.32236842105, 0}
Units["Pa"]["atm"] = { 101325, 0}

--Temperature
Units["K"] = {}
Units["K"][utf8(176).."C"] = { 1, 273.15}
--Units["K"][utf8(176).."F"] = { 0, 0}
--Units["K"]["R"] = { 0, 0}

--Moles
Units["mol"] = {}

--Molecular mass
Units["amu"] = {}
Units["amu"]["kg"] = {0.000000000000000000000000001660538782, 0}
Units["amu"]["g"] = {0.000000000000000000000001660538782, 0}
Units["amu"]["mg"] = {0.000000000000000000001660538782, 0}

--Heat Capacity
Units["J/kg*K"] = {}
Units["J/kg*K"]["J/kg*C"] = { 1, 0}
--Units["J/kg*K"]["Cal/kg*K"] = {}

--Mole Energy
Units["kJ/mol"] = {}

--Density
Units["kg/m3"] = {}

--Spring Constant
Units["N/m"] = {}

--Frequency
Units["Hz"] = {}
Units["Hz"]["kHz"] = {Mt.k, 0}
Units["Hz"]["MHz"] = {Mt.M, 0}
Units["Hz"]["GHz"] = {Mt.G, 0}
Units["Hz"]["mHz"] = {Mt.m, 0}
Units["Hz"]["nHz"] = {Mt.n, 0}

--Planck
--Units["J/s"] = {}

--Charge
--Units["C"] = {}

--Boltzmann
--Units["J/K"] = {}

--Gas C
--Units["J/mol*K"] = {}

--Thermal conductivity
--Units["W/mK"] = {}

--Electrical conductivity
--Units["MS/m"] = {}

--Degrees (Angle)
Units[utf8(176)] = {}
Units[utf8(176)]["rad"] = { (180/mathpi), 0}

