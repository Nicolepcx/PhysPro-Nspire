--[[

0-------------------0
|                   |
|    PhysPro v1.0   |
|  (Nov. 7th 2012)  |
|   LGLP 3 License  |
|     Mr. Kitty     |
|                   |
0-------------------0

Orignal code:
(Oct. 29th 2012)
FormulaPro v1.4a    LGLP 3 License
Jim Bauwens         Adrien Bertrand
TI-Planet.org       Inspired-Lua.org
]]--

pInfo={name="PhysPro", by="Mr. Kitty", ver="v0.8a", web="", license="LGPL3 License" }
infoStr = pInfo["name"].." "..pInfo["ver"].."\nBy "..pInfo["by"].."\n"..pInfo["license" ]
print("\n.."..infoStr.."\n")
function utf8(n)
	return string.uchar(n)
end

SubNumbers={185, 178, 179, 8308, 8309, 8310, 8311, 8312, 8313}

function numberToSub(w,n)
	return w..utf8(SubNumbers[tonumber(n)])
end

Constants = {}
Constants["g"] = {info="Acceleration due to gravity", value="9.81", unit="m*s^-2"}
Constants["G"] = {info="Gravitational constant", value="6.67 * 10^-11", unit="Nm^2/kg^-2"}
Constants["N"] = {info="Avogadro's constant", value="6.022 * 10^23", unit="mol^-1"}
Constants["R"] = {info="Gas constant", value="8.314", unit="J/((mol^-1)*(K^-1))"}
Constants["k"]	= {info="Boltzmann's constant", value="1.38 * 10^-23", unit="J/K^-1"}
--Constants["k"]	= {info="Stefan-Boltzmann constant", value="5.67 * 10^-8", unit="W*m^-2*K^-1"}
--Constants["k"] = {info="Coulomb constant", value="8.99 * 10^9", unit="N*m^2*C^-2"}
Constants[utf8(949).."0"] = {info="Permittivity of a vacuum", value="8.854 * 10^-12", unit="F/m^-1"}
Constants[utf8(956).."0"] = {info="Permeability of a vacuum", value="4*pi * 10^-7", unit="N/A^-2"}
Constants["C"] = {info="Speed of light in vacuum", value="2.9979 * 10^8", unit="m/s"}
Constants["h"] = {info="Planck constant", value="6.626 * 10^-34", unit="J/s"}
Constants["q"] = {info="Elementary charge", value="1.60218 * 10^-19", unit="C"}
Constants["me"] = {info="Electron rest mass", value="9.109 * 10^-31", unit="kg"}
Constants["mp"] = {info="Proton rest mass", value="1.6726 * 10^-27", unit="kg"}
Constants["mn"]	= {info="Neutron rest mass", value="1.675 * 10^-27", unit="kg"}
Constants["mu"] = {info="Atomic mass unit", value="1.66 * 10^-27", unit="kg"}
Constants["pi"] = {info="PI", value="pi", unit=nil}
Constants[utf8(960)] = Constants["pi"]

--------------------------------------------------------
--                      Database                      --
--------------------------------------------------------

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

Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
    if not checkIfExists(Categories, name) then
        return table.insert(Categories, id, {id=id, name=name, info=info, sub={}, varlink={}})
    else
        return -1
    end
end

function addCatVar(cid, var, info, unit)
    Categories[cid].varlink[var] = {unit=unit, info=info }
end

function addSubCat(cid, id, name, info)
    if not checkIfExists(Categories[cid].sub, name) then
        return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}})
    else
        return -1
    end
end

function aF(cid, sid, formula, variables) --add Formula
	local fr	=	{category=cid, sub=sid, formula=formula, variables=variables}
	-- In times like this we are happy that inserting tables just inserts a reference

    if not checkIfFormulaExists(Formulas, fr.formula) then
        table.insert(Formulas, fr)
    end
    if not checkIfFormulaExists(Categories[cid].sub[sid].formulas, fr.formula) then
        table.insert(Categories[cid].sub[sid].formulas, fr)
    end
	
	-- This function might need to be merged with U(...)
	for variable,_ in pairs(variables) do
		Categories[cid].sub[sid].variables[variable]	= true
	end
end

function U(...)
	local out	= {}
	for i, p in ipairs({...}) do
		out[p]	= true
	end
	return out
end

----------------------------------------------
-- Categories && Sub-Categories && Formulas --
----------------------------------------------

c_th = utf8(952)
c_om = utf8(969)
c_la = utf8(955)
c_ep = utf8(949)
c_de = utf8(916)
c_ph = utf8(966)
c_pi = utf8(960)

addCat(1, "Motion", "Performs calculations of motion-related stuff")

addCatVar(1,    "u",        "Intial velocity",              "m/s"       )
addCatVar(1,    "v",        "Final velocity",               "m/s"       )
addCatVar(1,    "dv",       "Change in velocity",           "m/s"       )
addCatVar(1,    "s",        "Displacement",                 "m"         )
addCatVar(1,    "t",        "Time",                         "s"         )
addCatVar(1,    "a",        "Accleration",                  "m/s2"      )
addCatVar(1,    "F",        "Force",                        "N"         )
addCatVar(1,    "m",        "Mass",                         "kg"        )
addCatVar(1,    "W",        "Work",                         "J"         )
addCatVar(1,    "P",        "Power",                        "W"         )
addCatVar(1,    "g",        "Gravity Acc.",                 "m/s2"      )
addCatVar(1,    "h",        "Height",                       "m"         )
addCatVar(1,    "Imp",      "Impulse",                      "N*s"       )
addCatVar(1,    "p",        "Momentum",                     "N*s"       )
addCatVar(1,    "Ep",       "Gravity PE",                   "J"         )
addCatVar(1,    "Ek",       "Kinetic energy",               "J"         )
addCatVar(1,    "E",        "Total energy",                 "J"         )
addCatVar(1,    c_th,       "Angle (Degrees)",              utf8(176)   )
addCatVar(1,    "Tp",       "Period",                       "s"         )
addCatVar(1,    "c",        "Circumference",                "m"         )
addCatVar(1,    "r",        "Radius",                       "m"         )


addSubCat(1, 1, "Kinematics", "Solves for: u, v, s, t, a")
aF(1, 1,    "s=((u+v)/2)*t",        U("s", "u", "v", "t")   )
aF(1, 1,    "s=u*t+(1/2)*a*t^(2)",  U("s", "u", "t", "a")   )
aF(1, 1,    "v^(2)=u^(2)+2*a*s",    U("v", "u", "a", "s")   )
aF(1, 1,    "v=u+a*t",              U("v", "u", "a", "t")   )

addSubCat(1, 2, "Force", "")
aF(1, 2,    "F=m*a",    U("F", "m", "a")  )

addSubCat(1, 3, "Impulse", "Solves for: p, Imp, F, t, dv, m, v, u")
aF(1, 3,    "Imp=F*t",          U("Imp", "F", "t")          )
aF(1, 3,    "Imp=m*t",          U("Imp", "m", "t")          )
aF(1, 3,    "p=m*v",            U("p", "m", "v")            )
aF(1, 3,    "F=m*(dv/t)",       U("F", "m", "dv", "t")      )
aF(1, 3,    "F*t=m*dv",         U("F", "t", "m", "dv")      )
aF(1, 3,    "dv=v-u",           U("dv", "v", "u")           )
aF(1, 3,    "F*t=m*v-m*u",      U("F", "t", "m", "v", "u")  )
aF(1, 3,    "p=m*v-m*u",        U("p", "m", "v", "u")       )

addSubCat(1, 4, "Work", "Solves for: W, F, s, m, a, "..c_th)
aF(1, 4,    "W=F*s*cos("..c_th..")",        U("W", "F", c_th, "s")      )
aF(1, 4,    "W=(m*a)*cos("..c_th..")*s",    U("W", "m", "a", c_th, "s") )
aF(1, 4,    "F=m*a",                        U("F", "m", "a")            )
aF(1, 4,    "W=(1/2)*m*(v^(2)-u^(2))",      U("W", "m", "v", "u")       )

addSubCat(1, 5, "Power", "Solves for: P, W, t, F, m, a, s, "..c_th)
aF(1, 5,    "P=W/t",                        U("P", "W", "t")            )
aF(1, 5,    "P=F*v*cos("..c_th..")",        U("P", "F", "v", c_th)      )
aF(1, 5,    "P=F*cos("..c_th..")*(s/t)",    U("P", "F", c_th, "s", "t") )
aF(1, 5,    "W=F*s*cos("..c_th..")",        U("W", "F", "s", c_th)      )
aF(1, 5,    "F=m*a",                        U("F", "m", "a")            )

addSubCat(1, 6, "Energy", "Solves for: Ek, Ep, E, m, v, h, g")
aF(1, 6,    "Ek=(1/2)*m*v^(2)",     U("Ek", "m", "v")           )
aF(1, 6,    "Ek=p^(2)/(2*m)",       U("Ek", "p", "m")           )
aF(1, 6,    "Ep=m*abs(g)*h",        U("Ep", "m", "g", "h")      )
aF(1, 6,    "E=Ek+Ep",              U("E", "Ek", "Ep")          )

addSubCat(1, 7, "Centripital", "Solves for F, a, v, r, Tp (period), m, c" )
aF(1, 7,    "F=(m*v^2)/r",              U( "F", "m", "v", "r" )     )
aF(1, 7,    "a=(4*pi^2*r)/Tp^2",        U( "a", "r", "Tp" )         )
aF(1, 7,    "a=v^2/r^2",                U( "a", "v", "r" )          )
aF(1, 7,    "c=2*π*r",                  U( "c", "r" )               )

addCat(2, "Thermal", "Performs thermal related physics calculations")

addCatVar(2, "P", "Pressure", "Pa")
addCatVar(2, "V", "Volume", "m3")
addCatVar(2, "T", "Tempturature", "K")
addCatVar(2, "n", "Amount", "mol")
addCatVar(2, "m", "Atomic Mass", "kg")
addCatVar(2, "M", "Mass", "kg")
--addCatVar(2, "F", "", "")
--addCatVar(2, "A", "", "")
--addCatVar(2, "Q", "", "")
--addCatVar(2, "c", "", "")
--addCatVar(2, "W", "", "")
--addCatVar(2, "U", "", "")

addSubCat(2, 1, "Thermo", "Solves for P, V, T, n, m, M")
aF(2, 1, "P*V=n*"..Constants["R"].value.."*T", U( "P", "V", "n", "T" ) )
aF(2, 1, "n=m/M", U( "n", "m", "M" ) )

addCat(3, "Oscillations and Waves", "Performs calculations related to oscillations and waves")

--addCatVar(2,    c_om, "", "")
--addCatVar(2,    "T", "", "")
--addCatVar(2,    "x", "", "")
--addCatVar(2,    "v", "", "")
--addCatVar(2,    "u", "", "")
--addCatVar(2,    "t", "", "")
--addCatVar(2,    "Ek", "Kinetic energy", "")
--addCatVar(2,    "Ekm", "Kinetic energy (max)", "")
--addCatVar(2,    "ET", "Thermal energy", "")
--addCatVar(2,    "f", "", "")
--addCatVar(2,    "m", "", "")
--addCatVar(2,    "n", "", "")
--addCatVar(2,    c_la, "", "")
--addCatVar(2,    c_th, "Angle (Degrees)", utf8(176))

addCat(4, "Electric Currents", "Performs electrical related physics calculations")

--addCatVar(2,    "Ve", "", "")
--addCatVar(2,    "m", "", "")
--addCatVar(2,    "v", "", "")
--addCatVar(2,    "I", "", "")
--addCatVar(2,    "q", "", "")
--addCatVar(2,    "t", "", "")
--addCatVar(2,    "R", "", "")
--addCatVar(2,    "P", "", "")
--addCatVar(2,    c_ep, "", "")
--addCatVar(2,    "r", "", "")

addCat(5, "Quantum & Nuclear", "Performs calculations relating to nuclear physics")

--addCatVar(2,    "E", "", "")
--addCatVar(2,    "m", "", "")
--addCatVar(2,    "c", "", "")
--addCatVar(2,    "h", "", "")
--addCatVar(2,    "f", "", "")
--addCatVar(2,    "eV", "", "")
--addCatVar(2,    "n", "", "")
--addCatVar(2,    "x", "", "")
--addCatVar(2,    "p", "", "")
--addCatVar(2,    "A", "", "")
--addCatVar(2,    "N", "", "")
--addCatVar(2,    "t", "", "")
--addCatVar(2,    c_la, "", "")
--addCatVar(2,    "T", "", "")
--addCatVar(2,    "L", "", "")

addCat(6, "Electromagnetism", "Performs calculations relating to electromagnetism")

addCat(7, "Relativity", "Performs calculations relating to relivity")

addCat(8, "Astrophysics", "Performs calculations relating to astrophysics")

addCat(9, "Particle", "Performs calculations relating to particle physics")
--This part is supposed to load external formulas stored in a string from a file in MyLib.
--WIP

function loadExtDB()
    local err
    _, err = pcall(function()
        loadstring(math.eval("formulaproextdb\\categories()"))()
        loadstring(math.eval("formulaproextdb\\variables()"))()
        loadstring(math.eval("formulaproextdb\\subcategories()"))()
        loadstring(math.eval("formulaproextdb\\equations()"))()
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
meaning: n mainunit = n*a+b subunit
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

Ms = {}
Ms.min = 60
Ms.hr = 3600
Ms.day = 86400
Ms.wk = 604800
Ms.fortn = 1209600
Ms.month = 18144000 
Ms.yr = 217728000


--Length
Units["m"] = {}
Units["m"]["nm"] = { Mt.n, 0 }
Units["m"][utf8(956).."m"] = { Mt.u, 0 }
Units["m"]["mm"] = { Mt.m, 0 }
Units["m"]["cm"] = { Mt.c, 0 }
Units["m"]["dm"] = { Mt.d, 0 }
Units["m"]["dam"] = { Mt.da, 0 }
Units["m"]["hm"] = { Mt.h, 0 }
Units["m"]["km"] = { Mt.k, 0 }
Units["m"]["Mm"] = { Mt.M, 0 }
Units["m"]["Gm"] = { Mt.G, 0 }
Units["m"]["in"] = { 0.0254, 0 }
Units["m"]["ft"] = { 0.3048, 0 }
Units["m"]["yd"] = { 0.9144, 0 }
Units["m"]["mi"] = { 1609.34, 0 }
Units["m"]["Nmi"] = { 1852, 0 }
Units["m"]["rod"] = { 4.572, 0 }
Units["m"]["chain"] = { 20.1168, 0 }
Units["m"]["Smoot"] = { 1.70180, 0 }
Units["m"]["ftm"] = { 1.8288, 0 }
Units["m"]["FB-F"] = { 109.7, 0 }
Units["m"]["furlong"] = { 201.168, 0 }
Units["m"]["brds"] = { 0.000000005, 0 }

--Velocity
Units["m/s"] = {}
Units["m/s"]["km/s"] = { Mt.k, 0 }
Units["m/s"]["cm/s"] = { Mt.c, 0 }
Units["m/s"]["mm/s"] = { Mt.m, 0 }
Units["m/s"]["m/hr"] = { Ms.hr, 0 }
Units["m/s"]["km/hr"] = { 3.6, 0 }
Units["m/s"]["knot"] = { 0.514444, 0 }
Units["m/s"]["mi/hr"] = { 0.44704, 0 }
Units["m/s"]["km/min"] = { 16.6667, 0 }
Units["m/s"]["ft/min"] = { 0.00508, 0 }
Units["m/s"]["ft/s"] = { 0.3048, 0 }
Units["m/s"]["mi/min"] = { 26.8224, 0 }
Units["m/s"]["brds/sec"] = { 0.000000005, 0 }

--Acceleration
Units["m/s2"] = {}
Units["m/s2"]["km/s2"] = { Mt.k, 0 }
Units["m/s2"]["cm/s2"] = { Mt.c, 0 }
Units["m/s2"]["mm/s2"] = { Mt.m, 0 }
Units["m/s2"]["m/hr2"] = { Ms.hr, 0 }
Units["m/s2"]["km/hr2"] = { 3.6, 0 }
Units["m/s2"]["knot2"] = { 0.514444, 0 }
Units["m/s2"]["mi/hr2"] = { 0.44704, 0 }
Units["m/s2"]["km/min2"] = { 16.6667, 0 }
Units["m/s2"]["ft/min2"] = { 0.00508, 0 }
Units["m/s2"]["ft/s2"] = { 0.3048, 0 }
Units["m/s2"]["mi/min2"] = { 26.8224, 0 }

--Time
Units["s"] = {}
Units["s"]["min"] = { Ms.min, 0 }
Units["s"]["hr"] = { Ms.hr, 0 }
Units["s"]["day"] = { Ms.day, 0 }
Units["s"]["wk"] = { Ms.wk, 0 }
Units["s"]["fortn"] = { Ms.fortn, 0 }
Units["s"]["month"] = { Mt.month, 0 }
Units["s"]["yr"] = { Mt.yr, 0 }
Units["s"]["mCent"] = { 34, 0 }
Units["s"]["Frieds"] = { 108864000, 0 }

--Force
Units["N"] = {}
Units["N"]["kN"] = { Mt.k, 0 }
Units["N"]["mN"] = { Mt.m, 0 }
Units["N"]["MN"] = { Mt.M, 0 }
Units["N"]["GN"] = { Mt.G, 0 }
Units["N"]["dyn"] = { 100000, 0 }
Units["N"]["lbf"] = { 0.224809, 0 }
Units["N"]["kgf"] = { 0.101972, 0 }
Units["N"]["tonf"] = { 0.000112404, 0 }

--Newton*sec (Impulse/Momentum)
Units["N*s"] = {}

--Mass
Units["kg"] = {}
Units["kg"]["g"] = { Mt.m, 0 }
Units["kg"]["mg"] = { Mt.u, 0 }
Units["kg"]["lb"] = { 0.453592, 0 }
Units["kg"]["oz"] = { 0.0283495, 0 }
Units["kg"]["ton"] = { 907.185, 0 }
Units["kg"]["slug"] = { 14.5939, 0 }

--Energy
Units["J"] = {}
Units["J"]["GJ"] = { Mt.G, 0 }
Units["J"]["MJ"] = { Mt.M, 0 }
Units["J"]["kJ"] = { Mt.k, 0 }
Units["J"]["mJ"] = { Mt.m, 0 }
Units["J"]["kWh"] = { 3600000, 0 }
Units["J"]["ftlb"] = { 1.35582, 0 }
Units["J"]["Btu"] = { 1055.06, 0 }

--Power
Units["W"] = {}
Units["W"]["GW"] = { Mt.G, 0 }
Units["W"]["MW"] = { Mt.M, 0 }
Units["W"]["kW"] = { Mt.k, 0 }
Units["W"]["mW"] = { Mt.m, 0 }
Units["W"]["hp"] = { 745.7, 0 }
Units["W"]["airW"] = { 0.9983, 0 }
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

--Temperature
Units["K"] = {}
--Units["K"][utf8(176).."C"] = { 1, 273.15}
--Units["K"][utf8(176).."F"] = { 255.92777777778, 0}
--Units["K"]["R"] = { 0.55555555555556, 0}

--Moles
Units["mol"] = {}

--Degrees (Angle)
Units[utf8(176)] = {}
Units[utf8(176)]["rad"] = { (180/mathpi), 0 }

------------------------------------------------------------------
--                  Overall Global Variables                    --
------------------------------------------------------------------
--
-- Uses BetterLuaAPI : https://github.com/adriweb/BetterLuaAPI-for-TI-Nspire
--

a_acute = string.uchar(225)
a_circ  = string.uchar(226)
a_tilde = string.uchar(227)
a_diaer = string.uchar(228)
a_ring  = string.uchar(229)
e_acute = string.uchar(233)
e_grave = string.uchar(232)
o_acute = string.uchar(243) 
o_circ  = string.uchar(244)
l_alpha = string.uchar(945)
l_beta = string.uchar(946)
l_omega = string.uchar(2126)
sup_plus = string.uchar(8314)
sup_minus = string.uchar(8315)
right_arrow = string.uchar(8594)


Color = {
	["black"] = {0, 0, 0},
	["red"] = {255, 0, 0},
	["green"] = {0, 255, 0},
	["blue "] = {0, 0, 255},
	["white"] = {255, 255, 255},
	["brown"] = {165,42,42},
	["cyan"] = {0,255,255},
	["darkblue"] = {0,0,139},
	["darkred"] = {139,0,0},
	["fuchsia"] = {255,0,255},
	["gold"] = {255,215,0},
	["gray"] = {127,127,127},
	["grey"] = {127,127,127},
	["lightblue"] = {173,216,230},
	["lightgreen"] = {144,238,144},
	["magenta"] = {255,0,255},
	["maroon"] = {128,0,0},
	["navyblue"] = {159,175,223},
	["orange"] = {255,165,0},
	["palegreen"] = {152,251,152},
	["pink"] = {255,192,203},
	["purple"] = {128,0,128},
	["royalblue"] = {65,105,225},
	["salmon"] = {250,128,114},
	["seagreen"] = {46,139,87},
	["silver"] = {192,192,192},
	["turquoise"] = {64,224,208},
	["violet"] = {238,130,238},
	["yellow"] = {255,255,0}
}
Color.mt = {__index = function () return {0,0,0} end}
setmetatable(Color,Color.mt)

function copyTable(t)
  local t2 = {}
  for k,v in pairs(t) do
    t2[k] = v
  end
  return t2
end

function deepcopy(t) -- This function recursively copies a table's contents, and ensures that metatables are preserved. That is, it will correctly clone a pure Lua object.
	if type(t) ~= 'table' then return t end
	local mt = getmetatable(t)
	local res = {}
	for k,v in pairs(t) do
		if type(v) == 'table' then
		v = deepcopy(v)
		end
	res[k] = v
	end
	setmetatable(res,mt)
	return res
end -- from http://snippets.luacode.org/snippets/Deep_copy_of_a_Lua_Table_2

function utf8(nbr)
	return string.uchar(nbr)
end

function test(arg)
	return arg and 1 or 0
end

function screenRefresh()
	return platform.window:invalidate()
end

function pww()
	return platform.window:width()
end

function pwh()
	return platform.window:height()
end

function drawPoint(gc, x, y)
	gc:fillRect(x, y, 1, 1)
end

function drawCircle(gc, x, y, diameter)
	gc:drawArc(x - diameter/2, y - diameter/2, diameter,diameter,0,360)
end

function drawCenteredString(gc, str)
	gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), .5*pwh(), "middle")
end

function drawXCenteredString(gc, str, y)
	gc:drawString(str, .5*(pww() - gc:getStringWidth(str)), y, "top")
end

function setColor(gc,theColor)
	if type(theColor) == "string" then
		theColor = string.lower(theColor)
		if type(Color[theColor]) == "table" then gc:setColorRGB(unpack(Color[theColor])) end
	elseif type(theColor) == "table" then
		gc:setColorRGB(unpack(theColor))
	end
end

function verticalBar(gc,x)
	gc:fillRect(gc,x,0,1,pwh())
end

function horizontalBar(gc,y)
	gc:fillRect(gc,0,y,pww(),1)
end

function nativeBar(gc, screen, y)
	gc:setColorRGB(128,128,128)
	gc:fillRect(screen.x+5, screen.y+y, screen.w-10, 2)
end

function drawSquare(gc,x,y,l)
	gc:drawPolyLine(gc,{(x-l/2),(y-l/2), (x+l/2),(y-l/2), (x+l/2),(y+l/2), (x-l/2),(y+l/2), (x-l/2),(y-l/2)})
end

function drawRoundRect(gc,x,y,wd,ht,rd)  -- wd = width, ht = height, rd = radius of the rounded corner
	x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same for y coord
	if rd > ht/2 then rd = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max rd)
	gc:drawLine(x + rd, y, x + wd - (rd), y);
	gc:drawArc(x + wd - (rd*2), y + ht - (rd*2), rd*2, rd*2, 270, 90);
	gc:drawLine(x + wd, y + rd, x + wd, y + ht - (rd));
	gc:drawArc(x + wd - (rd*2), y, rd*2, rd*2,0,90);
	gc:drawLine(x + wd - (rd), y + ht, x + rd, y + ht);
	gc:drawArc(x, y, rd*2, rd*2, 90, 90);
	gc:drawLine(x, y + ht - (rd), x, y + rd);
	gc:drawArc(x, y + ht - (rd*2), rd*2, rd*2, 180, 90);
end

function fillRoundRect(gc,x,y,wd,ht,radius)  -- wd = width and ht = height -- renders badly when transparency (alpha) is not at maximum >< will re-code later
	if radius > ht/2 then radius = ht/2 end -- avoid drawing cool but unexpected shapes. This will draw a circle (max radius)
    gc:fillPolygon({(x-wd/2),(y-ht/2+radius), (x+wd/2),(y-ht/2+radius), (x+wd/2),(y+ht/2-radius), (x-wd/2),(y+ht/2-radius), (x-wd/2),(y-ht/2+radius)})
    gc:fillPolygon({(x-wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y-ht/2), (x+wd/2-radius+1),(y+ht/2), (x-wd/2+radius),(y+ht/2), (x-wd/2+radius),(y-ht/2)})
    x = x-wd/2  -- let the center of the square be the origin (x coord)
	y = y-ht/2 -- same
	gc:fillArc(x + wd - (radius*2), y + ht - (radius*2), radius*2, radius*2, 1, -91);
    gc:fillArc(x + wd - (radius*2), y, radius*2, radius*2,-2,91);
    gc:fillArc(x, y, radius*2, radius*2, 85, 95);
    gc:fillArc(x, y + ht - (radius*2), radius*2, radius*2, 180, 95);
end


-- Fullscreen 'Library'

doNotDisplayIcon = true

icon=image.new("\020\0\0\0\020\0\0\0\0\0\0\0\040\0\0\0\016\0\001\000wwwwwwwwwwwwww\223\251\222\251\189\251\188\251\188\251\221\255\221\255\254\255wwwwwwwwwwwwwwwwwwww\156\243\024\227\215\218\214\218\247\222\025\227Z\235\156\243wwwwwwwwwwwwwwwwwwwwww\024\227S\202s\206\181\214\214\218\248\2229\2279\231Z\235Z\235wwwwwwwwwwwwwwwwwwZ\235\207\185\016\194R\202s\206\148\210\214\218\214\218\214\2229\231Z\235:\231wwwwwwwwwwwwww\190\251\239\189\239\189\148\210\148\210\156\247\148\214\214\218\147\210\181\218{\239\025\227Z\235|\239wwwwwwwwwwww\149\214\239\189\239\189\239\189\206\185{\239\206\185R\202R\202\148\214{\239\247\2229\227Z\231wwwwwwwwww\189\255\016\194\239\189\239\189\239\189\206\185{\239\173\181\016\194\016\194s\210Z\235\214\218\247\222\025\227\189\247wwwwwwww8\243\016\194\239\189\239\189\240\189\206\189{\239\206\185\016\194\207\185s\2109\235\148\210\214\218\024\223{\239wwwwww\254\255\244\238\239\189\206\185\207\185\206\185\140\177z\239\008\161\008\161\198\152\016\194\214\218\173\181\017\194t\206:\231wwwwww\188\2556\247\016\194\206\185k\173)\165\231\156{\239\132\144\133\144c\140\239\193\148\210\008\161l\173\239\1899\231wwwwwwx\255\154\255\240\189\231\156\132\144C\136B\136k\173\0\128B\136!\132\165\148\231\156B\136\165\148K\173\156\243wwwwww6\255\154\255\024\227\198\152c\140\206\185\206\185\173\181\207\185k\173)\165\206\185\239\189J\169c\140\173\181\222\251wwwwww6\255x\255ww\140\177\0\128\148\210\016\194\173\181R\202\173\181\206\185R\202\239\189\231\156\164\152\213\218wwwwwwwwx\2556\255ww\222\251J\169\008\161c\140c\140c\140c\140c\140c\140\008\169O\230o\234\178\242z\251wwwwww\221\255\209\250wwwwww\239\189\132\144d\140B\136d\140\132\144B\136\202\213\012\234\012\230\012\230-\234\189\251wwwwww\242\2506\255wwwwww\156\243\149\210\016\194\240\1892\202\247\222\236\221\147\222r\2220\214\146\222\245\238wwwwww\188\255\141\250\243\250wwwwwwwwwwwwww\021\251\168\221\136\217\169\213\236\213O\222Y\243wwwwwwww\188\255\142\250m\250\244\250X\255y\2557\255\177\250)\246(\246K\242\168\229\134\229\134\229\178\238wwwwwwwwwwwwwwW\255\175\250k\250J\250K\250\141\250\242\250y\255ww\188\2557\251z\251wwwwwwwwwwwwwwwwwwww\222\255\222\255\222\255wwwwwwwwwwwwwwwwwwwwww")

local pw	= getmetatable(platform.window)
function pw:invalidateAll()
	if self.setFocus then
		self:setFocus(false)
		self:setFocus(true)
	end
end

function on.draw(gc)
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(18, 5, 20, 20)
	gc:drawImage(icon, 18, 5)
end

if not platform.withGC then
    function platform.withGC(func, ...)
        local gc = platform.gc()
        gc:begin()
        func(..., gc)
        gc:finish()
    end
end


----------

local tstart = timer.start
function timer.start(ms)
    if not timer.isRunning then
        tstart(ms)
    end
    timer.isRunning = true
end

local tstop = timer.stop
function timer.stop()
    timer.isRunning = false
    tstop()
end


if platform.hw then
    timer.multiplier = platform.hw() < 4 and 3.2 or 1
else
    timer.multiplier = platform.isDeviceModeRendering() and 3.2 or 1
end

function on.timer()
    --current_screen():timer()
    local j = 1
    while j <= #timer.tasks do -- for each task
        if timer.tasks[j][2]() then -- delete it if has ended
            table.remove(timer.tasks, j)
            sj = j - 1
        end
        j = j + 1
    end
    if #timer.tasks > 0 then
        platform.window:invalidate()
    else
        --for _,screen in pairs(Screens) do
        --	screen:size()
        --end
        timer.stop()
    end
end

timer.tasks = {}

timer.addTask = function(object, task) timer.start(0.01) table.insert(timer.tasks, { object, task }) end

function timer.purgeTasks(object)
    local j = 1
    while j <= #timer.tasks do
        if timer.tasks[j][1] == object then
            table.remove(timer.tasks, j)
            j = j - 1
        end
        j = j + 1
    end
end


---------- Animable Object class
Object = class()
function Object:init(x, y, w, h, r)
    self.tasks = {}
    self.x = x
    self.y = y
    self.w = w
    self.h = h
    self.r = r
    self.visible = true
end

function Object:PushTask(task, t, ms, callback)
    table.insert(self.tasks, { task, t, ms, callback })
    timer.start(0.01)
    if #self.tasks == 1 then
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:PopTask()
    table.remove(self.tasks, 1)
    if #self.tasks > 0 then
        local task, t, ms, callback = unpack(self.tasks[1])
        local ok = task(self, t, ms, callback)
        if not ok then table.remove(self.tasks, 1) end
    end
end

function Object:purgeTasks()
    for i = 1, #self.tasks do
        self.tasks[i] = nil
    end
    collectgarbage()
    timer.purgeTasks(self)
    self.tasks = {}
    return self
end

function Object:paint(gc)
    -- to override
end

speed = 1

function Object:__Animate(t, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    if not t or type(t) ~= "table" then print("Error: Target position is " .. type(t)) return end
    if not t.x then t.x = self.x end
    if not t.y then t.y = self.y end
    if not t.w then t.w = self.w end
    if not t.h then t.h = self.h end
    if not t.r then t.r = self.r else t.r = math.pi * t.r / 180 end
    local xinc = (t.x - self.x) / ms
    local xside = xinc >= 0 and 1 or -1
    local yinc = (t.y - self.y) / ms
    local yside = yinc >= 0 and 1 or -1
    local winc = (t.w - self.w) / ms
    local wside = winc >= 0 and 1 or -1
    local hinc = (t.h - self.h) / ms
    local hside = hinc >= 0 and 1 or -1
    local rinc = (t.r - self.r) / ms
    local rside = rinc >= 0 and 1 or -1
    timer.addTask(self, function()
        local b1, b2, b3, b4, b5 = false, false, false, false, false
        if (self.x + xinc * speed) * xside < t.x * xside then self.x = self.x + xinc * speed else b1 = true end
        if self.y * yside < t.y * yside then self.y = self.y + yinc * speed else b2 = true end
        if self.w * wside < t.w * wside then self.w = self.w + winc * speed else b3 = true end
        if self.h * hside < t.h * hside then self.h = self.h + hinc * speed else b4 = true end
        if self.r * rside < t.r * rside then self.r = self.r + rinc * speed else b5 = true end
        if self.w < 0 then self.w = 0 end
        if self.h < 0 then self.h = 0 end
        if b1 and b2 and b3 and b4 and b5 then
            self.x, self.y, self.w, self.h, self.r = t.x, t.y, t.w, t.h, t.r
            self:PopTask()
            if callback then callback(self) end
            return true
        end
        return false
    end)
    return true
end

function Object:__Delay(_, ms, callback)
    if not ms then ms = 50 end
    if ms < 0 then print("Error: Invalid time divisor (must be >= 0)") return end
    ms = ms / timer.multiplier
    if ms == 0 then ms = 1 end
    local t = 0
    timer.addTask(self, function()
        if t < ms then
            t = t + 1
            return false
        else
            self:PopTask()
            if callback then callback(self) end
            return true
        end
    end)
    return true
end

function Object:__setVisible(t, _, _)
    timer.addTask(self, function()
        self.visible = t
        self:PopTask()
        return true
    end)
    return true
end

function Object:Animate(t, ms, callback)
    self:PushTask(self.__Animate, t, ms, callback)
    return self
end

function Object:Delay(ms, callback)
    self:PushTask(self.__Delay, false, ms, callback)
    return self
end

function Object:setVisible(t)
    self:PushTask(self.__setVisible, t, 1, false)
    return self
end


stdout = print

function pprint(...)
	stdout(...)
	local out	= ""
	for _,v in ipairs({...}) do 
		out	=	out .. (_==1 and "" or "    ") .. tostring(v)
	end
	var.store("print", out)
end


function Pr(n, d, s, ex)
	local nc	= tonumber(n)
	if nc and nc<math.abs(nc) then
		return s-ex-(type(n)== "number" and math.abs(n) or (.01*s*math.abs(nc)))
	else
		return (type(n)=="number" and n or (type(n)=="string" and .01*s*nc or d))
	end
end

-- Apply an extension on a class, and return our new frankenstein 
function addExtension(oldclass, extension)
	local newclass	= class(oldclass)
	for key, data in pairs(extension) do
		newclass[key]	= data
	end
	return newclass
end

clipRectData	= {}

function gc_clipRect(gc, what, x, y, w, h)
	if what == "set" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		
	elseif what == "subset" and clipRectData.current then
		clipRectData.old	= clipRectData.current
		x	= clipRectData.old.x<x and x or clipRectData.old.x
		y	= clipRectData.old.y<y and y or clipRectData.old.y
		h	= clipRectData.old.y+clipRectData.old.h > y+h and h or clipRectData.old.y+clipRectData.old.h-y
		w	= clipRectData.old.x+clipRectData.old.w > x+w and w or clipRectData.old.x+clipRectData.old.w-x
		what = "set"
		
	elseif what == "restore" and clipRectData.old then
		--gc:clipRect("reset")
		what = "set"
		x	= clipRectData.old.x
		y	= clipRectData.old.y
		h	= clipRectData.old.h
		w	= clipRectData.old.w
	elseif what == "restore" then
		what = "reset"
	end
	
	gc:clipRect(what, x, y, w, h)
	if x and y and w and h then clipRectData.current = {x=x,y=y,w=w,h=h} end
end

------------------------------------------------------------------
--                        Screen  Class                         --
------------------------------------------------------------------

Screen	=	class(Object)

Screens	=	{}

function scrollScreen(screen, d, callback)
  --  print("scrollScreen.  number of screens : ", #Screens)
    local dir = d or 1
    screen.x=dir*kXSize
    screen:Animate( {x=0}, 10, callback )
end

function insertScreen(screen, ...)
  --  print("insertScreen")
	screen:size()
    if current_screen() ~= DummyScreen then
        current_screen():screenLoseFocus()
        local coeff = pushFromBack and 1 or -1
	    current_screen():Animate( {x=coeff*kXSize}, 10)
    end
	table.insert(Screens, screen)

	platform.window:invalidate()
	current_screen():pushed(...)
end

function insertScreen_direct(screen, ...)
  --  print("insertScreen_direct")
	screen:size()
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function push_screen(screen, ...)
    --print("push_screen")
    local args = ...
    local theScreen = current_screen()
    pushFromBack = false
    insertScreen(screen, ...)
    scrollScreen(screen, 1, function() remove_screen_previous(theScreen) end)
end

function push_screen_back(screen, ...)
    --print("push_screen_back")
    local theScreen = current_screen()
    pushFromBack = true
    insertScreen(screen, ...)
    scrollScreen(screen, -1, function() remove_screen_previous(theScreen) end)
end

function push_screen_direct(screen, ...)
   -- print("push_screen_direct")
	table.insert(Screens, screen)
	platform.window:invalidate()
	current_screen():pushed(...)
end

function only_screen(screen, ...)
   -- print("only_screen")
    remove_screen(current_screen())
	Screens	=	{}
	push_screen(screen, ...)
	platform.window:invalidate()
end

function only_screen_back(screen, ...)
 --   print("only_screen_back")
    --Screens	=	{}
	push_screen_back(screen, ...)
	platform.window:invalidate()
end

function remove_screen_previous(...)
  --  print("remove_screen_previous")
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens, #Screens-1)
	current_screen():screenGetFocus()
	return res
end

function remove_screen(...)
  --  print("remove_screen")
	platform.window:invalidate()
	current_screen():removed(...)
	res=table.remove(Screens)
	current_screen():screenGetFocus()
	return res
end

function current_screen()
	return Screens[#Screens] or DummyScreen
end

function Screen:init(xx,yy,ww,hh)

	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	
	self:ext()
	self:size(0)
	
	Object.init(self, self.x, self.y, self.w, self.h, 0)
end

function Screen:ext()
end

function Screen:size()
	local screenH	=	platform.window:height()
	local screenW	=	platform.window:width()

	if screenH	== 0 then screenH=212 end
	if screenW	== 0 then screenW=318 end

	self.x	=	math.floor(Pr(self.xx, 0, screenW)+.5)
	self.y	=	math.floor(Pr(self.yy, 0, screenH)+.5)
	self.w	=	math.floor(Pr(self.ww, screenW, screenW, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, screenH, screenH, 0)+.5)
end


function Screen:pushed() end
function Screen:removed() end
function Screen:screenLoseFocus() end
function Screen:screenGetFocus() end

function Screen:draw(gc)
	--self:size()
	self:paint(gc)
end

function Screen:paint(gc) end

function Screen:invalidate()
	platform.window:invalidate(self.x ,self.y , self.w, self.h)
end

function Screen:arrowKey()	end
function Screen:enterKey()	end
function Screen:backspaceKey()	end
function Screen:clearKey() 	end
function Screen:escapeKey()	end
function Screen:tabKey()	end
function Screen:backtabKey()	end
function Screen:charIn(char)	end


function Screen:mouseDown()	end
function Screen:mouseUp()	end
function Screen:mouseMove()	end
function Screen:contextMenu()	end

function Screen:appended() end

function Screen:resize(w,h) end

function Screen:destroy()
	self	= nil
end

------------------------------------------------------------------
--                   WidgetManager Extension                    --
------------------------------------------------------------------

WidgetManager	= {}

function WidgetManager:ext()
	self.widgets	=	{}
	self.focus	=	0
end

function WidgetManager:resize(w,h)
    if self.x then  --already inited
        self:size()
    end
end

function WidgetManager:appendWidget(widget, xx, yy) 
	widget.xx	=	xx
	widget.yy	=	yy
	widget.parent	=	self
	widget:size()
	
	table.insert(self.widgets, widget)
	widget.pid	=	#self.widgets
	
	widget:appended(self)
	return self
end

function WidgetManager:getWidget()
	return self.widgets[self.focus]
end

function WidgetManager:drawWidgets(gc) 
	for _, widget in pairs(self.widgets) do
		widget:size()
		widget:draw(gc)
		
		gc:setColorRGB(0,0,0)
	end
end

function WidgetManager:postPaint(gc) 
end

function WidgetManager:draw(gc)
	--self:size()
	self:paint(gc)
	self:drawWidgets(gc)
	self:postPaint(gc)
end


function WidgetManager:loop(n) end

function WidgetManager:stealFocus(n)
	local oldfocus=self.focus
	if oldfocus~=0 then
		local veto	= self:getWidget():loseFocus(n)
		if veto == -1 then
			return -1, oldfocus
		end
		self:getWidget().hasFocus	=	false
		self.focus	= 0
	end
	return 0, oldfocus
end

function WidgetManager:focusChange() end

function WidgetManager:switchFocus(n, b)
	if n~=0 and #self.widgets>0 then
		local veto, focus	= self:stealFocus(n)
		if veto == -1 then
			return -1
		end
		
		local looped
		self.focus	=	focus + n
		if self.focus>#self.widgets then
			self.focus	=	1
			looped	= true
		elseif self.focus<1 then
			self.focus	=	#self.widgets
			looped	= true
		end	
		if looped and self.noloop and not b then
			self.focus	= focus
			self:loop(n)
		else
			self:getWidget().hasFocus	=	true	
			self:getWidget():getFocus(n)
		end
	end
	self:focusChange()
end


function WidgetManager:arrowKey(arrow)	
	if self.focus~=0 then
		self:getWidget():arrowKey(arrow)
	end
	self:invalidate()
end

function WidgetManager:enterKey()
    if self.focus~=0 then
        self:getWidget():enterKey()
    else
        if self.widgets and self.widgets[1] then   -- ugh, quite a bad hack for the mouseUp at (0,0) when cursor isn't shown (grrr TI) :/
            self.widgets[1]:enterKey()
        end
    end
    self:invalidate()
end

function WidgetManager:clearKey()	
	if self.focus~=0 then
		self:getWidget():clearKey()
	end
	self:invalidate()
end

function WidgetManager:backspaceKey()
	if self.focus~=0 then
		self:getWidget():backspaceKey()
	end
	self:invalidate()
end

function WidgetManager:escapeKey()	
	if self.focus~=0 then
		self:getWidget():escapeKey()
	end
	self:invalidate()
end

function WidgetManager:tabKey()	
	self:switchFocus(1)
	self:invalidate()
end

function WidgetManager:backtabKey()	
	self:switchFocus(-1)
	self:invalidate()
end

function WidgetManager:charIn(char)
	if self.focus~=0 then
		self:getWidget():charIn(char)
	end
	self:invalidate()
end

function WidgetManager:getWidgetIn(x, y)
	for n, widget in pairs(self.widgets) do
		local wox	= widget.ox or 0
		local woy	= widget.oy or 0
		if x>=widget.x-wox and y>=widget.y-wox and x<widget.x+widget.w-wox and y<widget.y+widget.h-woy then
			return n, widget
		end
	end 
end

function WidgetManager:mouseDown(x, y) 
	local n, widget	=	self:getWidgetIn(x, y)
	if n then
		if self.focus~=0 and self.focus~=n then self:getWidget().hasFocus = false self:getWidget():loseFocus()  end
		self.focus	=	n
		
		widget.hasFocus	=	true
		widget:getFocus()

		widget:mouseDown(x, y)
		self:focusChange()
	else
		if self.focus~=0 then self:getWidget().hasFocus = false self:getWidget():loseFocus() end
		self.focus	=	0
	end
end

function WidgetManager:mouseUp(x, y)
    if self.focus~=0 then
        --self:getWidget():mouseUp(x, y)
    end
    for _, widget in pairs(self.widgets) do
        widget:mouseUp(x,y) -- well, mouseUp is a release of a button, so everything previously "clicked" should be released, for every widget, even if the mouse has moved (and thus changed widget)
        -- eventually, a better way for this would be to keep track of the last widget active and do it to this one only...
    end
    self:invalidate()
end

function WidgetManager:mouseMove(x, y)
	if self.focus~=0 then
		self:getWidget():mouseMove(x, y)
	end
end



--------------------------
-- Our new frankenstein --
--------------------------

WScreen	= addExtension(Screen, WidgetManager)

--Dialog screen

Dialog	=	class(WScreen)

function Dialog:init(title,xx,yy,ww,hh)

	self.yy	=	yy
	self.xx	=	xx
	self.hh	=	hh
	self.ww	=	ww
	self.title	=	title
	self:size()
	
	self.widgets	=	{}
	self.focus	=	0
	    
end

function Dialog:paint(gc)
	self.xx	= (pww()-self.w)/2
	self.yy	= (pwh()-self.h)/2
	self.x, self.y	= self.xx, self.yy
	
	gc:setFont("sansserif","r",10)
	gc:setColorRGB(224,224,224)
	gc:fillRect(self.x, self.y, self.w, self.h)

	for i=1, 14,2 do
		gc:setColorRGB(32+i*3, 32+i*4, 32+i*3)
		gc:fillRect(self.x, self.y+i, self.w,2)
	end
	gc:setColorRGB(32+16*3, 32+16*4, 32+16*3)
	gc:fillRect(self.x, self.y+15, self.w, 10)
	
	gc:setColorRGB(128,128,128)
	gc:drawRect(self.x, self.y, self.w, self.h)
	gc:drawRect(self.x-1, self.y-1, self.w+2, self.h+2)
	
	gc:setColorRGB(96,100,96)
	gc:fillRect(self.x+self.w+1, self.y, 1, self.h+2)
	gc:fillRect(self.x, self.y+self.h+2, self.w+3, 1)
	
	gc:setColorRGB(104,108,104)
	gc:fillRect(self.x+self.w+2, self.y+1, 1, self.h+2)
	gc:fillRect(self.x+1, self.y+self.h+3, self.w+3, 1)
	gc:fillRect(self.x+self.w+3, self.y+2, 1, self.h+2)
	gc:fillRect(self.x+2, self.y+self.h+4, self.w+2, 1)
			
	gc:setColorRGB(255,255,255)
	gc:drawString(self.title, self.x + 4, self.y+2, "top")
	
	self:postPaint(gc)
end

function Dialog:postPaint() end



---
-- The dummy screen
---

DummyScreen	= Screen()


------------------------------------------------------------------
--                   Bindings to the on events                  --
------------------------------------------------------------------


function on.paint(gc)	
    allWentWell, generalErrMsg = pcall(onpaint, gc)
    if not allWentWell and errorHandler then
        errorHandler.display = true
        errorHandler.errorMessage = generalErrMsg
    end
    if platform.hw and platform.hw() < 4 and not doNotDisplayIcon then 
    	platform.withGC(on.draw)
    end
end

function onpaint(gc)
	for _, screen in pairs(Screens) do
		screen:draw(gc)	
	end
	if errorHandler.display then
	    errorPopup(gc)
	end
end

function on.resize(w, h)
	-- Global Ratio Constants for On-Calc (shouldn't be used often though...)
	kXRatio = w/320
	kYRatio = h/212
	
	kXSize, kYSize = w, h
	
	for _,screen in pairs(Screens) do
		screen:resize(w,h)
	end
end

function on.arrowKey(arrw)	current_screen():arrowKey(arrw)  end
function on.enterKey()		current_screen():enterKey()		 end
function on.escapeKey()		current_screen():escapeKey()	 end
function on.tabKey()		current_screen():tabKey()		 end
function on.backtabKey()	current_screen():backtabKey()	 end
function on.charIn(ch)		current_screen():charIn(ch)		 end
function on.backspaceKey()	current_screen():backspaceKey()  end
function on.contextMenu()	current_screen():contextMenu()   end
function on.mouseDown(x,y)	current_screen():mouseDown(x,y)	 end
function on.mouseUp(x,y)	if (x == 0 and y == 0) then current_screen():enterKey() else current_screen():mouseUp(x,y) end	 end
function on.mouseMove(x,y)	current_screen():mouseMove(x,y)  end
function on.clearKey()    	current_screen():clearKey()      end

function uCol(col)
	return col[1] or 0, col[2] or 0, col[3] or 0
end

function textLim(gc, text, max)
	local ttext, out = "",""
	local width	= gc:getStringWidth(text)
	if width<max then
		return text, width
	else
		for i=1, #text do
			ttext	= text:usub(1, i)
			if gc:getStringWidth(ttext .. "..")>max then
				break
			end
			out = ttext
		end
		return out .. "..", gc:getStringWidth(out .. "..")
	end
end


------------------------------------------------------------------
--                        Widget  Class                         --
------------------------------------------------------------------

Widget	=	class(Screen)

function Widget:init()
	self.dw	=	10
	self.dh	=	10
	
	self:ext()
end

function Widget:setSize(w, h)
	self.ww	= w or self.ww
	self.hh	= h or self.hh
end

function Widget:setPos(x, y)
	self.xx	= x or self.xx
	self.yy	= y or self.yy
end

function Widget:size(n)
	if n then return end
	self.w	=	math.floor(Pr(self.ww, self.dw, self.parent.w, 0)+.5)
	self.h	=	math.floor(Pr(self.hh, self.dh, self.parent.h, 0)+.5)
	
	self.rx	=	math.floor(Pr(self.xx, 0, self.parent.w, self.w)+.5)
	self.ry	=	math.floor(Pr(self.yy, 0, self.parent.h, self.h)+.5)
	self.x	=	self.parent.x + self.rx
	self.y	=	self.parent.y + self.ry
end

function Widget:giveFocus()
	if self.parent.focus~=0 then
		local veto	= self.parent:stealFocus()
		if veto == -1 then
			return -1
		end		
	end
	
	self.hasFocus	=	true
	self.parent.focus	=	self.pid
	self:getFocus()
end

function Widget:getFocus() end
function Widget:loseFocus() end
function Widget:clearKey() 	end

function Widget:enterKey() 
	self.parent:switchFocus(1)
end
function Widget:arrowKey(arrow)
	if arrow=="up" then 
		self.parent:switchFocus(self.focusUp or -1)
	elseif arrow=="down"  then
		self.parent:switchFocus(self.focusDown or 1)
	elseif arrow=="left" then 
		self.parent:switchFocus(self.focusLeft or -1)
	elseif arrow=="right"  then
		self.parent:switchFocus(self.focusRight or 1)	
	end
end


WWidget	= addExtension(Widget, WidgetManager)


------------------------------------------------------------------
--                        Sample Widget                         --
------------------------------------------------------------------

-- First, create a new class based on Widget
box	=	class(Widget)

-- Init. You should define self.dh and self.dw, in case the user doesn't supply correct width/height values.
-- self.ww and self.hh can be a number or a string. If it's a number, the width will be that amount of pixels.
-- If it's a string, it will be interpreted as % of the parent screen size.
-- These values will be used to calculate self.w and self.h (don't write to this, it will overwritten everytime the widget get's painted)
-- self.xx and self.yy will be set when appending the widget to a screen. This value support the same % method (in a string)
-- They will be used to calculate self.x and self.h 
function box:init(ww,hh,t)
	self.dh	= 10
	self.dw	= 10
	self.ww	= ww
	self.hh	= hh
	self.t	= t
end

-- Paint. Here you can paint your widget stuff
-- Variable you can use:
-- self.x, self.y	: numbers, x and y coordinates of the widget relative to screen. So it's the actual pixel position on the screen.
-- self.w, self.h	: numbers, w and h of widget
-- many others

function box:paint(gc)
	gc:setColorRGB(0,0,0)
	
	-- Do I have focus?
	if self.hasFocus then
		-- Yes, draw a filled black square
		gc:fillRect(self.x, self.y, self.w, self.h)
	else
		-- No, draw only the outline
		gc:drawRect(self.x, self.y, self.w, self.h)
	end
	
	gc:setColorRGB(128,128,128)
	if self.t then
		gc:drawString(self.t,self.x+2,self.y+2,"top")
	end
end


------------------------------------------------------------------
--                         Input Widget                         --
------------------------------------------------------------------


sInput	=	class(Widget)

function sInput:init()
	self.dw	=	100
	self.dh	=	20
	
	self.value	=	""	
	self.bgcolor	=	{255,255,255}
	self.disabledcolor	= {128,128,128}
	self.font	=	{"sansserif", "r", 10}
	self.disabled	= false
end

function sInput:paint(gc)
	self.gc	=	gc
	local x	=	self.x
	local y = 	self.y
	
	gc:setFont(uCol(self.font))
	gc:setColorRGB(uCol(self.bgcolor))
	gc:fillRect(x, y, self.w, self.h)

	gc:setColorRGB(0,0,0)
	gc:drawRect(x, y, self.w, self.h)
	
	if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(x-1, y-1, self.w+2, self.h+2)
        gc:setColorRGB(0, 0, 0)
    end
		
	local text	=	self.value
	local	p	=	0
	
	
	gc_clipRect(gc, "subset", x, y, self.w, self.h)
	
	--[[
	while true do
		if p==#self.value then break end
		p	=	p + 1
		text	=	self.value:sub(-p, -p) .. text
		if gc:getStringWidth(text) > (self.w - 8) then
			text	=	text:sub(2,-1)
			break 
		end
	end
	--]]
	
	if self.disabled or self.value == "" then
		gc:setColorRGB(uCol(self.disabledcolor))
	end
	if self.value == ""  then
		text	= self.placeholder or ""
	end
	
	local strwidth = gc:getStringWidth(text)
	
	if strwidth<self.w-4 or not self.hasFocus then
		gc:drawString(text, x+2, y+1, "top")
	else
		gc:drawString(text, x-4+self.w-strwidth, y+1, "top")
	end
	
	if self.hasFocus and self.value ~= "" then
		gc:fillRect(self.x+(text==self.value and strwidth+2 or self.w-4), self.y, 1, self.h)
	end
	
	gc_clipRect(gc, "restore")
end

function sInput:charIn(char)
	if self.disabled or (self.number and not tonumber(self.value .. char)) then --or char~="," then
		return
	end
	--char = (char == ",") and "." or char
	self.value	=	self.value .. char
end

function sInput:clearKey()
    if self:deleteInvalid() then return 0 end
    self.value	=	""
end

function sInput:backspaceKey()
    if self:deleteInvalid() then return 0 end
	if not self.disabled then
		self.value	=	self.value:usub(1,-2)
	end
end

function sInput:deleteInvalid()
    local isInvalid = string.find(self.value, "Invalid input")
    if isInvalid then
        self.value = self.value:usub(1, -19)
        return true
    end
    return false
end

function sInput:enable()
	self.disabled	= false
end

function sInput:disable()
	self.disabled	= true
end




------------------------------------------------------------------
--                         Label Widget                         --
------------------------------------------------------------------

sLabel	=	class(Widget)

function sLabel:init(text, widget)
	self.widget	=	widget
	self.text	=	text
	self.ww		=	30
	
	self.hh		=	20
	self.lim	=	false
	self.color	=	{0,0,0}
	self.font	=	{"sansserif", "r", 10}
	self.p		=	"top"
	
end

function sLabel:paint(gc)
	gc:setFont(uCol(self.font))
	gc:setColorRGB(uCol(self.color))
	
	local text	=	""
	local ttext
	if self.lim then
		text, self.dw	= textLim(gc, self.text, self.w)
	else
		text = self.text
	end
	
	gc:drawString(text, self.x, self.y, self.p)
end

function sLabel:getFocus(n)
	if n then
		n	= n < 0 and -1 or (n > 0 and 1 or 0)
	end
	
	if self.widget and not n then
		self.widget:giveFocus()
	elseif n then
		self.parent:switchFocus(n)
	end
end


------------------------------------------------------------------
--                        Button Widget                         --
------------------------------------------------------------------

sButton	=	class(Widget)

function sButton:init(text, action)
    self.text	=	text
    self.action	=	action
    self.pushed = false

    self.dh	=	27
    self.dw	=	48

    self.bordercolor	=	{136,136,136}
    self.font	=	{"sansserif", "r", 10}
end

function sButton:paint(gc)
    gc:setFont(uCol(self.font))
    self.ww	=	gc:getStringWidth(self.text)+8
    self:size()

    if self.pushed and self.forcePushed then
        self.y = self.y + 2
    end

    gc:setColorRGB(248,252,248)
    gc:fillRect(self.x+2, self.y+2, self.w-4, self.h-4)
    gc:setColorRGB(0,0,0)

    gc:drawString(self.text, self.x+4, self.y+4, "top")

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:setPen("medium", "smooth")
    else
        gc:setColorRGB(uCol(self.bordercolor))
        gc:setPen("thin", "smooth")
    end
    gc:fillRect(self.x + 2, self.y, self.w-4, 2)
    gc:fillRect(self.x + 2, self.y+self.h-2, self.w-4, 2)
    gc:fillRect(self.x, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+1, self.y+1, 1, self.h-2)
    gc:fillRect(self.x+self.w-1, self.y+2, 1, self.h-4)
    gc:fillRect(self.x+self.w-2, self.y+1, 1, self.h-2)

    if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        -- old way of indicating focus :
        --gc:drawRect(self.x-2, self.y-2, self.w+3, self.h+3)
        --gc:drawRect(self.x-3, self.y-3, self.w+5, self.h+5)
    end
end

function sButton:mouseMove(x,y)
    local isIn = (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h))
    self.pushed = self.forcePushed and isIn
    platform.window:invalidate()
end

function sButton:enterKey()
    if self.action then self.action() end
end

function sButton:mouseDown(x,y)
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self.pushed = true
        self.forcePushed = true
    end
    platform.window:invalidate()
end

function sButton:mouseUp(x,y)
    self.pushed = false
    self.forcePushed = false
    if (x>self.x and x<(self.x+self.w) and y>self.y and y<(self.y+self.h)) then
        self:enterKey()
    end
    platform.window:invalidate()
end


------------------------------------------------------------------
--                      Scrollbar Widget                        --
------------------------------------------------------------------


scrollBar	= class(Widget)

scrollBar.upButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")
scrollBar.downButton=image.new("\011\0\0\0\010\0\0\0\0\0\0\0\022\0\0\0\016\0\001\0001\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198\255\255\222\251\255\255\255\255\255\255\255\255\255\255\222\251\255\2551\1981\198\156\243\132\144\247\222\255\255\255\255\255\255\247\222\132\144\189\2471\1981\198\132\144B\136B\136\247\222\255\255\247\222B\136B\136\132\1441\1981\198\247\222B\136!\132B\136R\202B\136!\132B\136\247\2221\1981\198\255\255\247\222B\136!\132\0\128!\132B\136\247\222\255\2551\1981\198\255\255\255\255\247\222B\136\0\128B\136\247\222\255\255\255\2551\1981\198\255\255\255\255\255\255\214\218\0\128\214\218\255\255\255\255\255\2551\1981\198\255\255\255\255\255\255\255\255\156\243\255\255\255\255\255\255\255\2551\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\1981\198")

function scrollBar:init(h, top, visible, total)
	self.color1	= {96, 100, 96}
	self.color2	= {184, 184, 184}
	
	self.hh	= h or 100
	self.ww = 14
	
	self.visible = visible or 10
	self.total   = total   or 15
	self.top     = top     or 4
end

function scrollBar:paint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x+1, self.y+1, self.w-1, self.h-1)
	
	gc:drawImage(self.upButton  , self.x+2, self.y+2)
	gc:drawImage(self.downButton, self.x+2, self.y+self.h-11)
	gc:setColorRGB(uCol(self.color1))
	if self.h > 28 then
		gc:drawRect(self.x + 3, self.y + 14, 8, self.h - 28)
	end
	
	if self.visible<self.total then
		local step	= (self.h-26)/self.total
		gc:fillRect(self.x + 3, self.y + 14  + step*self.top, 9, step*self.visible)
		gc:setColorRGB(uCol(self.color2))
		gc:fillRect(self.x + 2 , self.y + 14 + step*self.top, 1, step*self.visible)
		gc:fillRect(self.x + 12, self.y + 14 + step*self.top, 1, step*self.visible)
	end
end

function scrollBar:update(top, visible, total)
	self.top      = top     or self.top
	self.visible  = visible or self.visible
	self.total    = total   or self.total
end

function scrollBar:action(top) end

function scrollBar:mouseUp(x, y)
	local upX	= self.x+2
	local upY	= self.y+2
	local downX	= self.x+2
	local downY	= self.y+self.h-11
	local butH	= 10
	local butW	= 11
	
	if x>=upX and x<upX+butW and y>=upY and y<upY+butH and self.top>0 then
		self.top	= self.top-1
		self:action(self.top)
	elseif x>=downX and x<downX+butW and y>=downY and y<downY+butH and self.top<self.total-self.visible then
		self.top	= self.top+1
		self:action(self.top)
	end
end

function scrollBar:getFocus(n)
	if n==-1 or n==1 then
		self.parent:switchFocus(n)
	end
end


------------------------------------------------------------------
--                         List Widget                          --
------------------------------------------------------------------

sList	= class(WWidget)

function sList:init()
	Widget.init(self)
	self.dw	= 150
	self.dh	= 153

	self.ih	= 18

	self.top	= 0
	self.sel	= 1
	
	self.font	= {"sansserif", "r", 10}
	self.colors	= {50,150,190}
	self.items	= {}
end

function sList:appended()
	self.scrollBar	= scrollBar("100", self.top, #self.items,#self.items)
	self:appendWidget(self.scrollBar, -1, 0)
	
	function self.scrollBar:action(top)
		self.parent.top	= top
	end
end


function sList:paint(gc)
	local x	= self.x
	local y	= self.y
	local w	= self.w
	local h	= self.h
	
	
	local ih	= self.ih   
	local top	= self.top		
	local sel	= self.sel		
		      
	local items	= self.items			
	local visible_items	= math.floor(h/ih)	
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(x, y, w, h)
	gc:setColorRGB(0, 0, 0)
	gc:drawRect(x, y, w, h)
	gc_clipRect(gc, "set", x, y, w, h)
	gc:setFont(unpack(self.font))

	
	
	local label, item
	for i=1, math.min(#items-top, visible_items+1) do
		item	= items[i+top]
		label	= textLim(gc, item, w-(5 + 12 + 2 + 1))
		
		if i+top == sel then
			gc:setColorRGB(unpack(self.colors))
			gc:fillRect(x+1, y + i*ih-ih + 1, w-(12 + 2 + 2), ih)
			
			gc:setColorRGB(255, 255, 255)
		end
		
		gc:drawString(label, x+5, y + i*ih-ih , "top")
		gc:setColorRGB(0, 0, 0)
	end
	
	self.scrollBar:update(top, visible_items, #items)
	
	gc_clipRect(gc, "reset")
end

function sList:arrowKey(arrow)	
    
	if arrow=="up" then
	    if self.sel>1 then
            self.sel	= self.sel - 1
            if self.top>=self.sel then
                self.top	= self.top - 1
            end
        else
            self.top = self.h/self.ih < #self.items and math.ceil(#self.items - self.h/self.ih) or 0
            self.sel = #self.items
        end
        self:change(self.sel, self.items[self.sel])
	end

	if arrow=="down" then
	    if self.sel<#self.items then
            self.sel	= self.sel + 1
            if self.sel>(self.h/self.ih)+self.top then
                self.top	= self.top + 1
            end
        else
            self.top = 0
            self.sel = 1
        end
        self:change(self.sel, self.items[self.sel])
	end
end


function sList:mouseUp(x, y)
	if x>=self.x and x<self.x+self.w-16 and y>=self.y and y<self.y+self.h then
		
		local sel	= math.floor((y-self.y)/self.ih) + 1 + self.top
		if sel==self.sel then
			self:enterKey()
			return
		end
		if self.items[sel] then
			self.sel=sel
			self:change(self.sel, self.items[self.sel])
		else
			return
		end
		
		if self.sel>(self.h/self.ih)+self.top then
			self.top	= self.top + 1
		end
		if self.top>=self.sel then
			self.top	= self.top - 1
		end
						
	end 
	self.scrollBar:mouseUp(x, y)
end


function sList:enterKey()
	if self.items[self.sel] then
		self:action(self.sel, self.items[self.sel])
	end
end


function sList:change() end
function sList:action() end

function sList:reset()
	self.sel	= 1
	self.top	= 0
end

------------------------------------------------------------------
--                        Screen Widget                         --
------------------------------------------------------------------

sScreen	= class(WWidget)

function sScreen:init(w, h)
	Widget.init(self)
	self.ww	= w
	self.hh	= h
	self.oy	= 0
	self.ox	= 0
	self.noloop	= true
end

function sScreen:appended()
	self.oy	= 0
	self.ox	= 0
end

function sScreen:paint(gc)
	gc_clipRect(gc, "set", self.x, self.y, self.w, self.h)
	self.x	= self.x + self.ox
	self.y	= self.y + self.oy
end

function sScreen:postPaint(gc)
	gc_clipRect(gc, "reset")
end

function sScreen:setY(y)
	self.oy	= y or self.oy
end
						
function sScreen:setX(x)
	self.ox	= x or self.ox
end

function sScreen:showWidget()
	local w	= self:getWidget()
	if not w then print("bye") return end
	local y	= self.y - self.oy
	local wy = w.y - self.oy
	
	if w.y-2 < y then
		print("Moving up")
		self:setY(-(wy-y)+4)
	elseif w.y+w.h > y+self.h then
		print("moving down")
		self:setY(-(wy-(y+self.h)+w.h+2))
	end
	
	if self.focus == 1 then
		self:setY(0)
	end
end

function sScreen:getFocus(n)
	if n==-1 or n==1 then
		self:stealFocus()
		self:switchFocus(n, true)
	end
end

function sScreen:loop(n)
	self.parent:switchFocus(n)
	self:showWidget()
end

function sScreen:focusChange()
	self:showWidget()
end

function sScreen:loseFocus(n)
	if n and ((n >= 1 and self.focus+n<=#self.widgets) or (n <= -1 and self.focus+n>=1)) then
		self:switchFocus(n)
		return -1
	else
		self:stealFocus()
	end
	
end


-------------------------------------------------------------------------------
--									sDropdown							     --
-------------------------------------------------------------------------------

sDropdown	=	class(Widget)


function sDropdown:init(items)
	self.dh	= 21
	self.dw	= 75
	self.screen	= WScreen()
	self.sList	= sList()
	self.sList.items	= items or {}
	self.screen:appendWidget(self.sList,0,0)
	self.sList.action	= self.listAction
	self.sList.loseFocus	= self.screenEscape
	self.sList.change	= self.listChange
	self.screen.escapeKey	= self.screenEscape
	self.lak	= self.sList.arrowKey	
	self.sList.arrowKey	= self.listArrowKey
	self.value	= items[1] or ""
	self.valuen	= #items>0 and 1 or 0
	self.rvalue	= items[1] or ""
	self.rvaluen=self.valuen
	
	self.sList.parentWidget = self
	self.screen.parentWidget = self
	--self.screen.focus=1
end

function sDropdown:screenpaint(gc)
	gc:setColorRGB(255,255,255)
	gc:fillRect(self.x, self.y, self.h, self.w)
	gc:setColorRGB(0,0,0)
	gc:drawRect(self.x, self.y, self.h, self.w)
end

function sDropdown:mouseDown()
	self:open()
end


sDropdown.img = image.new("\14\0\0\0\7\0\0\0\0\0\0\0\28\0\0\0\16\0\1\000{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239al{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239{\239alalal{\239{\239\255\255\255\255\255\255\255\255\255\255\255\255{\239{\239alalalalal{\239{\239\255\255\255\255\255\255\255\255{\239{\239alalalalalalal{\239{\239\255\255\255\255{\239{\239alalalalalalalalal{\239{\239{\239{\239alalalalalalalalalalal{\239{\239alalalalalal")

function sDropdown:arrowKey(arrow)	
	if arrow=="up" then
		self.parent:switchFocus(self.focusUp or -1)
	elseif arrow=="down" then
		self.parent:switchFocus(self.focusDown or 1)
	elseif arrow=="left" then 
		self.parent:switchFocus(self.focusLeft or -1)
	elseif arrow == "right" then
		self:open()
	end
end

function sDropdown:listArrowKey(arrow)
	if arrow == "left" then
		self:loseFocus()
	else
		self.parentWidget.lak(self, arrow)
	end
end

function sDropdown:listChange(a, b)
	self.parentWidget.value  = b
	self.parentWidget.valuen = a
end

function sDropdown:open()
	self.screen.yy	= self.y+self.h
	self.screen.xx	= self.x-1
	self.screen.ww	= self.w + 13
	local h = 2+(18*#self.sList.items)
	
	local py	= self.parent.oy and self.parent.y-self.parent.oy or self.parent.y
	local ph	= self.parent.h
	
	self.screen.hh	= self.y+self.h+h>ph+py-10 and ph-py-self.y-self.h-10 or h
	if self.y+self.h+h>ph+py-10  and self.screen.hh<40 then
		self.screen.hh = h < self.y and h or self.y-5
		self.screen.yy = self.y-self.screen.hh
	end
	
	self.sList.ww = self.w + 13
	self.sList.hh = self.screen.hh-2
	self.sList.yy =self.sList.yy+1
	self.sList:giveFocus()
	
    self.screen:size()
	push_screen_direct(self.screen)
end

function sDropdown:listAction(a,b)
	self.parentWidget.value  = b
	self.parentWidget.valuen = a
	self.parentWidget.rvalue  = b
	self.parentWidget.rvaluen = a
	self.parentWidget:change(a, b)
	remove_screen()
end

function sDropdown:change() end

function sDropdown:screenEscape()
	self.parentWidget.sList.sel = self.parentWidget.rvaluen
	self.parentWidget.value	= self.parentWidget.rvalue
	if current_screen() == self.parentWidget.screen then
		remove_screen()
	end
end

function sDropdown:paint(gc)
	gc:setColorRGB(255, 255, 255)
	gc:fillRect(self.x, self.y, self.w-1, self.h-1)
	
	gc:setColorRGB(0,0,0)
	gc:drawRect(self.x, self.y, self.w-1, self.h-1)
	
	if self.hasFocus then
        gc:setColorRGB(40, 148, 184)
        gc:drawRect(self.x-1, self.y-1, self.w+1, self.h+1)
        gc:setColorRGB(0, 0, 0)
    end
	
	gc:setColorRGB(192, 192, 192)
	gc:fillRect(self.x+self.w-21, self.y+1, 20, 19)
	gc:setColorRGB(224, 224, 224)
	gc:fillRect(self.x+self.w-22, self.y+1, 1, 19)
	
	gc:drawImage(self.img, self.x+self.w-18, self.y+9)
	
	gc:setColorRGB(0,0,0)
	local text = self.value
	if self.unitmode then
		text=text:gsub("([^%d]+)(%d)", numberToSub)
	end
	
	gc:drawString(textLim(gc, text, self.w-5-22), self.x+5, self.y, "top")
end


function math.solve(formula, tosolve)
    --local eq="max(exp" .. string.uchar(9654) .. "list(solve(" .. formula .. ", " .. tosolve ..")," .. tosolve .."))"
    local eq = "nsolve(" .. formula .. ", " .. tosolve .. ")"
    local res = tostring(math.eval(eq)):gsub(utf8(8722), "-")
    --print("-", eq, math.eval(eq), tostring(math.eval(eq)), tostring(math.eval(eq)):gsub(utf8(8722), "-"))
    return tonumber(res)
end

function round(num, idp)
    if num >= 0.001 or num <= -0.001 then
        local mult = 10 ^ (idp or 0)
        if num >= 0 then
            return math.floor(num * mult + 0.5) / mult
        else
            return math.ceil(num * mult - 0.5) / mult
        end
    else
        return tonumber(string.format("%.0" .. (idp + 1) .. "g", num))
    end
end

math.round = round -- just in case

function find_data(known, cid, sid)
    local done = {}

    for _, var in ipairs(var.list()) do
        math.eval("delvar " .. var)
    end

    for key, value in pairs(known) do
        var.store(key, value)
    end

    local no
    local dirty_exit = true
    local tosolve
    local couldnotsolve = {}

    local loops = 0
    while dirty_exit do
        loops = loops + 1
        if loops == 100 then error("too many loops!") end
        dirty_exit = false

        for i, formula in ipairs(Formulas) do

            local skip = false
            if couldnotsolve[formula] then
                skip = true
                for k, v in pairs(known) do
                    if not couldnotsolve[formula][k] then
                        skip = false
                        couldnotsolve[formula] = nil
                        break
                    end
                end
            end

            if ((not cid) or (cid and formula.category == cid)) and ((not sid) or (formula.category == cid and formula.sub == sid)) and not skip then
                no = 0

                for var in pairs(formula.variables) do
                    if not known[var] then
                        no = no + 1
                        tosolve = var
                        if no == 2 then break end
                    end
                end

                if no == 1 then
                    print("I can solve " .. tosolve .. " for " .. formula.formula)

                    local sol, r = math.solve(formula.formula, tosolve)
                    if sol then
                        sol = round(sol, 4)
                        known[tosolve] = sol
                        done[formula] = true
                        var.store(tosolve, sol)
                        couldnotsolve[formula] = nil
                        print(tosolve .. " = " .. sol)
                    else
                        print("Oops! Something went wrong:", r)
                        -- Need to issue a warning dialog
                        couldnotsolve[formula] = copyTable(known)
                    end
                    dirty_exit = true
                    break

                elseif no == 2 then
                    print("I cannot solve " .. formula.formula .. " because I don't know the value of multiple variables")
                end
            end
        end
    end

    return known
end


CategorySel = WScreen()

CategorySel.iconS = 48
CategorySel.sublist = sList()
CategorySel:appendWidget(CategorySel.sublist, 5, 5 + 24)
CategorySel.sublist:setSize(-10, -70)
CategorySel.sublist.cid = 0

function CategorySel.sublist:action(sid)
    push_screen(SubCatSel, sid)
end

function CategorySel:charIn(ch)
    if ch == "l" then
        loadExtDB()
        self:pushed() -- refresh list
        self:invalidate() -- asks for screen repaint
    end
end

function CategorySel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)

    if not kIsInSubCatScreen then 
        gc:setColorRGB(0, 0, 0)
        gc:setFont("sansserif", "r", 16)
        gc:drawString(pInfo["name"], self.x + 5, 0, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString(pInfo["ver"], self.x + .4 * self.w, 4, "top")

        gc:setFont("sansserif", "r", 12)
        gc:drawString("by "..pInfo["by"], self.x + self.w - gc:getStringWidth("by "..pInfo["by"]) - 5, 4, "top")

        gc:setColorRGB(220, 220, 220)
        gc:setFont("sansserif", "r", 8)
        gc:drawRect(5, self.h - 46 + 10, self.w - 10, 25 + 6)
        gc:setColorRGB(128, 128, 128)
    end

    local splinfo = Categories[self.sublist.sel].info:split("\n")
    for i, str in ipairs(splinfo) do
        gc:drawString(str, self.x + 7, self.h - 56 + 12 + i * 10, "top")
    end
    self.sublist:giveFocus()
end

function CategorySel:pushed()
    local items = {}
    for cid, cat in ipairs(Categories) do
        table.insert(items, cat.name)
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function CategorySel:tabKey()
    push_screen_back(Ref)
end


SubCatSel = WScreen()

SubCatSel.sel = 1
SubCatSel.sublist = sList()
SubCatSel:appendWidget(SubCatSel.sublist, 5, 5 + 24)
SubCatSel.back = sButton(utf8(9664) .. " Back")
SubCatSel:appendWidget(SubCatSel.back, 5, -5)
SubCatSel.sublist:setSize(-10, -66)
SubCatSel.sublist.cid = 0

function SubCatSel.back:action()
    SubCatSel:escapeKey()
end

function SubCatSel.sublist:action(sub)
    local cid = self.parent.cid
    if #Categories[cid].sub[sub].formulas > 0 then
        push_screen(manualSolver, cid, sub)
    end
end

function SubCatSel:paint(gc)
    gc:setColorRGB(255, 255, 255)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(0, 0, 0)
    gc:setFont("sansserif", "r", 16)
    gc:drawString(Categories[self.cid].name, self.x + 5, 0, "top")
end

function SubCatSel:pushed(sel)

    kIsInSubCatScreen = true
    self.cid = sel
    local items = {}
    for sid, subcat in ipairs(Categories[sel].sub) do
        table.insert(items, subcat.name .. (#subcat.formulas == 0 and " (Empty)" or ""))
    end

    if self.sublist.cid ~= sel then
        self.sublist.cid = sel
        self.sublist:reset()
    end

    self.sublist.items = items
    self.sublist:giveFocus()
end

function SubCatSel:escapeKey()
    kIsInSubCatScreen = false
    only_screen_back(CategorySel)
end



-------------------
-- Manual solver --
-------------------

manualSolver = WScreen()
manualSolver.pl = sScreen(-20, -50)
manualSolver:appendWidget(manualSolver.pl, 2, 4)

manualSolver.sb = scrollBar(-50)
manualSolver:appendWidget(manualSolver.sb, -2, 3)

manualSolver.back = sButton(utf8(9664) .. " Back")
manualSolver:appendWidget(manualSolver.back, 5, -5)

manualSolver.usedFormulas = sButton("Formulas")
manualSolver:appendWidget(manualSolver.usedFormulas, -5, -5)

function manualSolver.back:action()
    manualSolver:escapeKey()
end

function manualSolver.usedFormulas:action()
    push_screen_direct(usedFormulas)
end

function manualSolver.sb:action(top)
    self.parent.pl:setY(4 - top * 30)
end

function manualSolver:paint(gc)
    gc:setColorRGB(224, 224, 224)
    gc:fillRect(self.x, self.y, self.w, self.h)
    gc:setColorRGB(128, 128, 128)
    gc:fillRect(self.x + 5, self.y + self.h - 42, self.w - 10, 2)
    self.sb:update(math.floor(-(self.pl.oy - 4) / 30 + .5))

    gc:setFont("sansserif", "r", 10)
    local name = self.sub.name
    local len = gc:getStringWidth(name)
    if len >= .7*self.w then name = string.sub(name, 1, -10) .. ". " end
    local len = gc:getStringWidth(name)
    local x = self.x + (self.w - len) / 2

    --gc:setColorRGB(255,255,255)
    --gc:fillRect(x-3, 10, len+6, 18)

    gc:setColorRGB(0, 0, 0)
    gc:drawString(name, x, self.h - 28, "top")
    --gc:drawRect(x-3, 10, len+6, 18)
end

function manualSolver:postPaint(gc)
    --gc:setColorRGB(128,128,128)
    --gc:drawRect(self.x, self.y, self.w, self.h-46)
end

basicFuncsInited = false

function manualSolver:pushed(cid, sid)

    if not basicFuncsInited then
        initBasicFunctions()
        basicFuncsInited = true
    end

    self.pl.widgets = {}
    self.pl.focus = 0
    self.cid = cid
    self.sid = sid
    self.sub = Categories[cid].sub[sid]
    self.pl.oy = 0
    self.known = {}
    self.inputs = {}
    self.constants = {}

    local inp, lbl
    local i = 0
    local nodropdown, lastdropdown
    for variable, _ in pairs(self.sub.variables) do


        if not Constants[variable] or Categories[cid].varlink[variable] then
            i = i + 1
            inp = sInput()
            inp.value = ""
            --inp.number	= true

            function inp:enterKey()
                if not tonumber(self.value) and #self.value > 0 then
                    if not manualSolver:preSolve(self) then
                        self.value = self.value .. "   " .. utf8(8658) .. " Invalid input"
                    end
                end
                manualSolver:solve()
                self.parent:switchFocus(1)
            end

            self.inputs[variable] = inp
            inp.ww = -145
            inp.focusDown = 4
            inp.focusUp = -2
            lbl = sLabel(variable, inp)

            self.pl:appendWidget(inp, 60, i * 30 - 28)
            self.pl:appendWidget(lbl, 2, i * 30 - 28)
            self.pl:appendWidget(sLabel(":", inp), 50, i * 30 - 28)

            print(variable)
            local variabledata = Categories[cid].varlink[variable]
            inp.placeholder = variabledata.info

            if nodropdown then
                inp.focusUp = -1
            end

            if variabledata then
                if variabledata.unit ~= "unitless" then
                    --unitlbl	= sLabel(variabledata.unit:gsub("([^%d]+)(%d)", numberToSub))
                    local itms = { variabledata.unit }
                    for k, _ in pairs(Units[variabledata.unit]) do
                        table.insert(itms, k)
                    end
                    inp.dropdown = sDropdown(itms)
                    inp.dropdown.unitmode = true
                    inp.dropdown.change = self.update
                    inp.dropdown.focusUp = nodropdown and -5 or -4
                    inp.dropdown.focusDown = 2
                    self.pl:appendWidget(inp.dropdown, -2, i * 30 - 28)
                    nodropdown = false
                    lastdropdown = inp.dropdown
                else
                    self.pl:appendWidget(sLabel("Unitless"), -32, i * 30 - 28)
                end
            else
                nodropdown = true
                inp.focusDown = 1
                if lastdropdown then
                    lastdropdown.focusDown = 1
                    lastdropdown = false
                end
            end

            inp.getFocus = manualSolver.update
        else
            self.constants[variable] = math.eval(Constants[variable].value)
            --var.store(variable, self.known[variable])
        end
    end
    inp.focusDown = 1

    manualSolver.sb:update(0, math.floor(self.pl.h / 30 + .5), i)
    self.pl:giveFocus()

    self.pl.focus = 1
    self.pl:getWidget().hasFocus = true
    self.pl:getWidget():getFocus()
end

function manualSolver.update()
    manualSolver:solve()
end

function manualSolver:preSolve(input)
    local res, err
    res, err = math.eval(input.value)
    res = res and round(res, 4)
    print("Presolve : ", input.value .. " = " .. tostring(res), "(err ? = " .. tostring(err) .. ")")
    input.value = res and tostring(res) or input.value
    return res and 1 or false
end

function manualSolver:solve()
    local inputed = {}
    local disabled = {}

    for variable, input in pairs(self.inputs) do
        local variabledata = Categories[self.cid].varlink[variable]
        if input.disabled then
            inputed[variable] = nil
            input.value = ""
        end

        input:enable()
        if input.value ~= "" then
            local tmpstr = input.value:gsub(utf8(8722), "-")
            inputed[variable] = tonumber(tmpstr)
            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                inputed[variable] = Units.subToMain(variabledata.unit, input.dropdown.rvalue, inputed[variable])
            end
        end
    end

    local invs = copyTable(inputed)
    for k, v in pairs(self.constants) do
        invs[k] = v
    end
    self.known = find_data(invs, self.cid, self.sid)

    for variable, value in pairs(self.known) do
        if (not inputed[variable] and self.inputs[variable]) then
            local variabledata = Categories[self.cid].varlink[variable]
            local result = tostring(value)
            local input = self.inputs[variable]

            if input.dropdown and input.dropdown.rvalue ~= variabledata.unit then
                result = Units.mainToSub(variabledata.unit, input.dropdown.rvalue, result)
            end

            input.value = result
            input:disable()
        end
    end
end

function manualSolver:escapeKey()
    only_screen_back(SubCatSel, self.cid)
end

function manualSolver:contextMenu()
    push_screen_direct(usedFormulas)
end

usedFormulas = Dialog("Used formulas", 10, 10, -20, -20)

usedFormulas.but = sButton("Close")

usedFormulas:appendWidget(usedFormulas.but, -10, -5)

function usedFormulas:postPaint(gc)
    if self.ed then
        self.ed:move(self.x + 5, self.y + 30)
        self.ed:resize(self.w - 9, self.h - 74)
    end

    nativeBar(gc, self, self.h - 40)
end

function usedFormulas:pushed()
    doNotDisplayIcon = true
    self.ed = D2Editor.newRichText()
    self.ed:setReadOnly(true)
    local cont = ""

    local fmls = #manualSolver.sub.formulas
    for k, v in ipairs(manualSolver.sub.formulas) do
        cont = cont .. k .. ": \\0el {" .. v.formula .. "} " .. (k < fmls and "\n" or "")
    end

    if self.ed.setExpression then
        self.ed:setExpression(cont, 1)
        self.ed:registerFilter{ escapeKey = usedFormulas.closeEditor, enterKey = usedFormulas.closeEditor, tabKey = usedFormulas.leaveEditor }
        self.ed:setFocus(true)
    else
        self.ed:setText(cont, 1)
    end

    self.but:giveFocus()
end

function usedFormulas.leaveEditor()
    platform.window:setFocus(true)
    usedFormulas.but:giveFocus()
    return true
end

function usedFormulas.closeEditor()
    platform.window:setFocus(true)
    if current_screen() == usedFormulas then
        remove_screen()
    end
    doNotDisplayIcon = false
    return true
end

function usedFormulas:screenLoseFocus()
    self:removed()
end

function usedFormulas:screenGetFocus()
    self:pushed()
end

function usedFormulas:removed()
    if usedFormulas.ed.setVisible then
        usedFormulas.ed:setVisible(false)
    else
        usedFormulas.ed:setText("")
        usedFormulas.ed:resize(1, 1)
        usedFormulas.ed:move(-10, -10)
    end
    usedFormulas.ed = nil
    doNotDisplayIcon = false
end

function usedFormulas.but.action(self)
    remove_screen()
end	

--------------------------------------------
--                 MAIN                   --
--------------------------------------------

function initBasicFunctions()
    local basicFunctions = {
        ["erf"] = [[Define erf(x)=Func:2/sqrt(pi)*integral(exp(-t*t),t,0,x):EndFunc]],
        ["erfc"] = [[Define erfc(x)=Func:1-erf(x):EndFunc]],
        ["ni"] = [[Define ni(ttt)=Func:7.7835*10^21*ttt^(3/2)*exp((4.73*10^-4*ttt^2/(ttt+636)-1.17)/(1.72143086667*10^-4*ttt)):EndFunc]],
        ["eegalv"] = [[Define eegalv(rrx,rr2,rr3,rr4,rrg,rrs,vs)=Func:Local rra,rrb,rrc,vb,rg34,rx2ab: rg34:=rrg+rr3+rr4:  rra:=((rrg*rr3)/(rg34)): rrb:=((rrg*rr4)/(rg34)): rrc:=((rr3*rr4)/(rg34)): rx2ab:=rrx+rr2+rra+rrb: rra:=((rrg*rr3)/(rg34)): vb:=((((vs*(rrx+rra)*(rr2+rrb))/(rx2ab)))/(rrs+rrc+(((rrx+rra)*(rr2+rrb))/(rx2ab)))): vb*(((rx)/(rrx+rra))-((rr2)/(rr2+rrb))):Return :EndFunc]],
    }
    for var, func in pairs(basicFunctions) do
        math.eval(func .. ":Lock " .. var) -- defines and prevents against delvar.
    end
end

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

--[[
{ "", "", "" },
]]--

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

RefConstants.data = {
    {"Acceleration due to gravity", "", ""}
}

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
            gc:drawString("  (" .. RefConstants.data[k][2] .. ") : " .. RefConstants.data[k][3] .. ". ", gc:getStringWidth(RefConstants.data[k][1])+15-RefConstants.leftRight, 5+22*tmp, "top")
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

--[[
{ "", "", "" },
]]--

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

--[[
{ "", "", "" },
]]--

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

--[[
{ "", "", "" },
]]--

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
    { utf8(913),        utf8(945),      "Alpha"         },
    { utf8(914),        utf8(946),      "Beta"          },
    { utf8(915),        utf8(947),      "Gamma"         },
    { utf8(916),        utf8(948),      "Delta"         },
    { utf8(917),        utf8(949),      "Epsilon"       },
    { utf8(918),        utf8(950),      "Zeta"          },
    { utf8(919),        utf8(951),      "Eta"           },
    { utf8(920),        utf8(952),      "Theta"         }
}
Greek.alphabet2 = {
    { utf8(921),        utf8(953),      "Iota"          },
    { utf8(922),        utf8(954),      "Kappa"         },
    { utf8(923),        utf8(955),      "Lambda"        },
    { utf8(924),        utf8(956),      "Mu"            },
    { utf8(925),        utf8(957),      "Nu"            },
    { utf8(926),        utf8(958),      "Xi"            },
    { utf8(927),        utf8(959),      "Omicron"       },
    { utf8(928),        utf8(960),      "Pi"            }
}
Greek.alphabet3 = {
    { utf8(929),        utf8(961),      "Rho"           },
    { utf8(931),        utf8(963),      "Sigma"         },
    { utf8(932),        utf8(964),      "Tau"           },
    { utf8(933),        utf8(965),      "Upsilon"       },
    { utf8(934),        utf8(966),      "Phi"           },
    { utf8(935),        utf8(967),      "Chi"           },
    { utf8(936),        utf8(968),      "Psi"           },
    { utf8(937),        utf8(969),      "Omega"         }
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
    { "Base",               "watt",                 "W"         },
    { "0.001 W",            "milliwatt",            "mW"        },
    { "1000 W",             "kilowatt",             "kW"        },
    { "1000000 W",          "megawatt",             "MW"        },
    { "1000000000 W",       "gigawatt",             "GW"        },
    { "745.7 W",            "horsepower",           "hp"        },
    { "0.9983 W",           "air watt",             "airW"      }
}

--[[
{ "", "", "" },
]]--

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
	{ "Y",      "Yotta",        "24"    },
	{ "Z",      "Zetta",        "21"    },
	{ "E",      "Exa",          "18"    },
	{ "P",      "Peta",         "15"    },
	{ "T",      "Tera",         "12"    },
	{ "G",      "Giga",         "9"     },
	{ "M",      "Mega",         "6"     },
	{ "k",      "Kilo",         "3"     },
	{ "h",      "Hecto",        "2"     },
	{ "da",     "Deka",         "1"     }
}

SIPrefixes.prefixes2 = {
	{ "d",          "Deci",         "-1"        },
	{ "c",          "Centi",        "-2"        },
	{ "m",          "Milli",        "-3"        },
	{ utf8(956),    "Micro",        "-6"        },
	{ "n",          "Nano",         "-9"        },
	{ "p",          "Pico",         "-12"       },
	{ "f",          "Femto",        "-15"       },
	{ "a",          "Atto",         "-18"       },
	{ "z",          "Zepto",        "-21"       },
	{ "y",          "Yocto",        "-24"       }
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


RefVelocity = Screen()

RefVelocity.data = {
    { "Base",                   "meters/second",                   "m/s"           },
    { "1000 m/s",               "kilometers/sec",               "km/s"          },
    { "0.01 m/s",               "centimeters/sec",              "cm/s"          },
    { "0.001 m/s",              "millimeters/sec",              "mm/s"          },
    { "0.000277778 m/s",        "meters/hour",                  "m/hr"          },
    { "0.277778 m/s",           "kilometers/hour",              "km/hr"         },
    { "16.6667",                "kilometers/min",               "km/min"        },
    { "0.3048 m/s",             "feet/second",                  "ft/s"          },
    { "0.00508 m/s",            "feet/minute",                  "ft/min"        },
    { "26.8224 m/s",            "miles/minute",                 "mi/min"        },
    { "0.44704 m/s",            "miles/hour",                   "mi/hr"         },
    { "0.514444 m/s",           "knatical mile/hour",           "knot"          },
    { "0.000000005 m/s",        "bears-sec/second",             "brds/sec"      },
}

--[[
{ "", "", "" },
]]--

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


References	= {
	{ title="SI Prefixes",              info="",        screen=SIPrefixes       },
	{ title="Greek Alphabet",           info="",        screen=Greek            },
	{ title="Motion Variables",         info="",        screen=MotionVars       },
	{ title="Displacement Units",       info="",        screen=RefDisplacement  },
	{ title="Velocity Units",           info="",        screen=RefVelocity      },
	{ title="Acceleration Units",       info="",        screen=RefAcceleration  },
	{ title="Time Units",               info="",        screen=RefTime          },
	{ title="Force Units",              info="",        screen=RefForce         },
	{ title="Energy Units",             info="",        screen=RefEnergy        },
	{ title="Power Units",              info="",        screen=RefPower         },
	{ title="Constants",                info="",        screen=REFConstants     }
}

Ref	= WScreen()

RefList	= sList()
RefList:setSize(-8, -32)

Ref:appendWidget(RefList, 4, Ref.y+28)

function Ref.addRefs()
	for n, ref in ipairs(References) do
		if ref.screen then
			table.insert(RefList.items, ref.title)
		else
			table.insert(RefList.items, ref.title .. " (not yet done)")
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



aboutWindow	= Dialog("About", 50, 20, 280, 180)

local origInfoStr = "Orig Code:\nFormulaPro v1.4a LGPL3\nJim Bauwens, Adrien \"Adriweb\" Bertrand, Levak\ntiplanet.org - inspired-lua.org"
local aboutstr = infoStr..origInfoStr
local aboutButton	= sButton("OK")

for i, line in ipairs(aboutstr:split("\n")) do
	local aboutlabel	= sLabel(line)
	aboutWindow:appendWidget(aboutlabel, 10, 27 + i*14-12)
end

aboutWindow:appendWidget(aboutButton,-10,-5)

function aboutWindow:postPaint(gc)
	nativeBar(gc, self, self.h-40)
	on.help = function() return 0 end
end

aboutButton:giveFocus()

function aboutButton:action()
	remove_screen(aboutWindow)
	on.help = function() push_screen_direct(aboutWindow) end
end

----------------------------------------

function on.help()
	push_screen_direct(aboutWindow)
end

----------------------------------------

function errorPopup(gc)
    
    errorHandler.display = false
    errorDialog = Dialog("Oops...", 50, 20, "85", "80")

    local textMessage	= [[PhysPro has encountered an error
-----------------------------
Sorry for the inconvenience.
Error at line ]]..errorHandler.errorLine
    local errorOKButton	= sButton("OK")
    
    for i, line in ipairs(textMessage:split("\n")) do
        local errorLabel = sLabel(line)
        errorDialog:appendWidget(errorLabel, 10, 27 + i*14-12)
    end
    
    errorDialog:appendWidget(errorOKButton,-10,-5)
    
    function errorDialog:postPaint(gc)
        nativeBar(gc, self, self.h-40)
    end
    
    errorOKButton:giveFocus()
    
    function errorOKButton:action()
        remove_screen(errorDialog)
        errorHandler.errorMessage = nil
    end
    
    push_screen_direct(errorDialog)
end

---------------------------------------------------------------

function on.create()
	platform.os = "3.1"
end

function on.construction()
	platform.os = "3.2"
end

errorHandler = {}

function handleError(line, errMsg, callStack, locals)
    print("Error handled!", errMsg)
    errorHandler.display = true
    errorHandler.errorMessage = errMsg
    errorHandler.errorLine = line
    errorHandler.callStack = callStack
    errorHandler.locals = locals
    platform.window:invalidate()
    return true --go on....
end

if platform.registerErrorHandler then
    platform.registerErrorHandler( handleError )
end

---------------------------------------------- Launch!

push_screen_direct(CategorySel)
