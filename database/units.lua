
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

Mt    = {}
Mt.G  = 1 / 1000000000
Mt.M  = 1 / 1000000
Mt.k  = 1 / 1000
Mt.h  = 1 / 100
Mt.da = 1 / 10
Mt.d  = 10
Mt.c  = 100
Mt.m  = 1000
Mt.u  = 1000000
Mt.n  = 1000000000
Mt.p  = 1000000000000

Ms       = {}
Ms.min   = 60
Ms.hr    = 3600
Ms.day   = 86400
Ms.wk    = 604800
Ms.month = 18144000
Ms.yr    = 217728000

--Time
Units["s"]           = {}
Units["s"]["min"]    = { Ms.min, 0}
Units["s"]["hr"]     = { Ms.hr, 0}
Units["s"]["day"]    = { Ms.day, 0}
Units["s"]["wk"]     = { Ms.wk, 0}
Units["s"]["fortn"]  = { 1209600, 0}
Units["s"]["month"]  = { Mt.month, 0}
Units["s"]["yr"]     = { Mt.yr, 0}

--Length
Units["m"]            = {}
Units["m"]["pm"]      = { Mt.p, 0}
Units["m"]["nm"]      = { Mt.n, 0}
Units["m"][s.mu.."m"] = { Mt.u, 0}
Units["m"]["mm"]      = { Mt.m, 0}
Units["m"]["cm"]      = { Mt.c, 0}
Units["m"]["dm"]      = { Mt.d, 0}
Units["m"]["hm"]      = { Mt.h, 0}
Units["m"]["km"]      = { Mt.k, 0}
Units["m"]["in"]      = { 0.0254, 0}
Units["m"]["ft"]      = { 0.3048, 0}
Units["m"]["yd"]      = { 0.9144, 0}
Units["m"]["mi"]      = { 1609.34, 0}
Units["m"]["Nmi"]     = { 1852, 0}
Units["m"]["ftm"]     = { 1.8288, 0}
Units["m"]["FB-F"]    = { 109.7, 0}

--Area
Units["m"..s.p2]                  = {}
Units["m"..s.p2]["nm"..s.p2]      = { Mt.n, 0}
Units["m"..s.p2][s.mu.."m"..s.p2] = { Mt.u, 0}
Units["m"..s.p2]["mm"..s.p2]      = { Mt.m2, 0}
Units["m"..s.p2]["cm"..s.p2]      = { Mt.c, 0}
Units["m"..s.p2]["dm"..s.p2]      = { Mt.d, 0}
Units["m"..s.p2]["hm"..s.p2]      = { Mt.h, 0}
Units["m"..s.p2]["km"..s.p2]      = { Mt.k, 0}
Units["m"..s.p2]["in"..s.p2]      = { 0.0254, 0}
Units["m"..s.p2]["ft"..s.p2]      = { 0.3048, 0}
Units["m"..s.p2]["yd"..s.p2]      = { 0.9144, 0}
Units["m"..s.p2]["mi"..s.p2]      = { 1609.34, 0}
Units["m"..s.p2]["Nmi"..s.p2]     = { 1852, 0}
Units["m"..s.p2]["ftm"..s.p2]     = { 1.8288, 0}
Units["m"..s.p2]["FB-F"..s.p2]    = { 109.7, 0}

--Volume
Units["m"..s.p2]              = {}
Units["m"..s.p2]["mm"..s.p3]  = { Mt.m, 0}
Units["m"..s.p2]["cm3"..s.p3] = { Mt.c, 0}
Units["m"..s.p2]["km"..s.p3]  = { Mt.k, 0}
Units["m"..s.p2]["ml"]        = { 0.000001, 0}
Units["m"..s.p2]["l"]         = { 0.001, 0}
Units["m"..s.p2]["in"..s.p3] = { .000016387064, 0}
Units["m"..s.p2]["ft"..s.p3]  = { 0.028316846592, 0}
Units["m"..s.p2]["yd"..s.p3]  = { 0.764554857984, 0}
Units["m"..s.p2]["tsp"]       = { 0.00000492892159375, 0}
Units["m"..s.p2]["tbsp"]      = { 0.00001478676478125, 0}
Units["m"..s.p2]["floz"]      = { 0.0000295735295625, 0}
Units["m"..s.p2]["cup"]       = { 0.0002365882365, 0}
Units["m"..s.p2]["pt"]        = { 0.000473176473, 0}
Units["m"..s.p2]["qt"]        = { 0.000946352946, 0}
Units["m"..s.p2]["gal"]       = { 0.003785411784, 0}
Units["m"..s.p2]["flozUK"]    = { 0.000028413075, 0}
Units["m"..s.p2]["galUK"]     = { 0.004546092, 0}

--Velocity
Units["m/s"]             = {}
Units["m/s"]["km/s"]     = { Mt.k, 0}
Units["m/s"]["cm/s"]     = { Mt.c, 0}
Units["m/s"]["mm/s"]     = { Mt.m, 0}
Units["m/s"]["m/hr"]     = { Ms.hr, 0}
Units["m/s"]["km/hr"]    = { 3.6, 0}
Units["m/s"]["knot"]     = { 0.514444, 0}
Units["m/s"]["mi/hr"]    = { 0.44704, 0}
Units["m/s"]["km/min"]   = { 16.6667, 0}
Units["m/s"]["ft/min"]   = { 0.00508, 0}
Units["m/s"]["ft/s"]     = { 0.3048, 0}
Units["m/s"]["mi/min"]   = { 26.8224, 0}

--Acceleration
Units["m/s"..s.p2]                 = {}
Units["m/s"..s.p2]["km/s"..s.p2]   = { Mt.k, 0}
Units["m/s"..s.p2]["cm/s"..s.p2]   = { Mt.c, 0}
Units["m/s"..s.p2]["mm/s"..s.p2]   = { Mt.m, 0}
Units["m/s"..s.p2]["m/hr"..s.p2]   = { Ms.hr, 0}
Units["m/s"..s.p2]["km/hr"..s.p2]  = { 3.6, 0}
Units["m/s"..s.p2]["knot"..s.p2]   = { 0.514444, 0}
Units["m/s"..s.p2]["mi/hr"..s.p2]  = { 0.44704, 0}
Units["m/s"..s.p2]["km/min"..s.p2] = { 16.6667, 0}
Units["m/s"..s.p2]["ft/min"..s.p2] = { 0.00508, 0}
Units["m/s"..s.p2]["ft/s"..s.p2]   = { 0.3048, 0}
Units["m/s"..s.p2]["mi/min"..s.p2] = { 26.8224, 0}

--Mass
Units["kg"]         = {}
Units["kg"]["g"]    = { Mt.m, 0}
Units["kg"]["mg"]   = { Mt.u, 0}
Units["kg"]["lb"]   = { 0.453592, 0}
Units["kg"]["oz"]   = { 0.0283495, 0}
Units["kg"]["ton"]  = { 907.185, 0}
Units["kg"]["slug"] = { 14.5939, 0}

--Force
Units["N"]         = {}
Units["N"]["kN"]   = { Mt.k, 0}
Units["N"]["mN"]   = { Mt.m, 0}
Units["N"]["dyn"]  = { 100000, 0}
Units["N"]["lbf"]  = { 0.224809, 0}
Units["N"]["kgf"]  = { 0.101972, 0}
Units["N"]["tonf"] = { 0.000112404, 0}

--Newton*sec (Impulse/Momentum)
Units["N*s"] = {}

--Energy
Units["J"]         = {}
Units["J"]["GJ"]   = { Mt.G, 0}
Units["J"]["MJ"]   = { Mt.M, 0}
Units["J"]["kJ"]   = { Mt.k, 0}
Units["J"]["mJ"]   = { Mt.m, 0}
Units["J"]["kWh"]  = { 3600000, 0}
Units["J"]["ftlb"] = { 1.35582, 0}
Units["J"]["Btu"]  = { 1055.06, 0}

--Power
Units["W"]            = {}
Units["W"]["GW"]      = { Mt.G, 0}
Units["W"]["MW"]      = { Mt.M, 0}
Units["W"]["kW"]      = { Mt.k, 0}
Units["W"]["mW"]      = { Mt.m, 0}
Units["W"]["hp"]      = { 745.7, 0}
Units["W"]["airW"]    = { 0.9983, 0}
Units["W"]["Btu/min"] = { 17.5842638, 0}

--Pressure
Units["Pa"]                = {}
Units["Pa"]["mPA"]         = { Mt.m, 0}
Units["Pa"]["kPa"]         = { Mt.k, 0}
Units["Pa"]["MPa"]         = { Mt.M, 0}
Units["Pa"]["N/m"..s.p2]   = { 1, 0}
Units["Pa"]["mmH20"]       = { 9.80665, 0}
Units["Pa"]["inH2O"]       = { 249.08891, 0}
Units["Pa"]["mmHg"]        = { 133.32236842105, 0}
Units["Pa"]["inHg"]        = { 3338.6388157895, 0}
Units["Pa"]["mbar"]        = { 100, 0}
Units["Pa"]["lb/ft"..s.p2] = { 47.880258980336, 0}
Units["Pa"]["psi"]         = { 6894.7572931684, 0}
Units["Pa"]["torr"]        = { 0133.32236842105, 0}
Units["Pa"]["atm"]         = { 101325, 0}

--Temperature
Units["K"]            = {}
Units["K"][s.dg.."C"] = { 1, 273.15}
--Units["K"][s.dg.."F"] = { 0, 0}
--Units["K"]["R"]       = { 0, 0}

--Moles
Units["mol"] = {}

--Molecular mass
Units["amu"]       = {}
Units["amu"]["kg"] = {0.000000000000000000000000001660538782, 0}
Units["amu"]["g"]  = {0.000000000000000000000001660538782, 0}
Units["amu"]["mg"] = {0.000000000000000000001660538782, 0}

--Heat Capacity
Units["J/kg*K"]           = {}
Units["J/kg*K"]["J/kg*C"] = { 1, 0}
--Units["J/kg*K"]["Cal/kg*K"] = {}

--Mole Energy
Units["kJ/mol"] = {}

--Density
Units["kg/m"..s.p3] = {}

--Spring Constant
Units["N/m"] = {}

--Frequency
Units["Hz"]        = {}
Units["Hz"]["kHz"] = {Mt.k, 0}
Units["Hz"]["MHz"] = {Mt.M, 0}
Units["Hz"]["GHz"] = {Mt.G, 0}
Units["Hz"]["mHz"] = {Mt.m, 0}
Units["Hz"]["nHz"] = {Mt.n, 0}

--Degrees (Angle)
Units[s.dg]        = {}
Units[s.dg]["rad"] = { (180/mathpi), 0}

--Charge
Units["C"] = {}

--Voltage
Units["V"] = {}

--Current
Units["A"] = {}

--Rssistence
Units[s.om] = {}

--Resistivity
Units[s.omm] = {}

--Boltzmann
--Units["J/K"] = {}

--Gas C
--Units["J/mol*K"] = {}

--Thermal conductivity
--Units["W/mK"] = {}

--Electrical conductivity
--Units["MS/m"] = {}

