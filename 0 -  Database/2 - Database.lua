Categories	=	{}
Formulas	=	{}

function addCat(id,name,info)
	return table.insert(Categories, id, {id=id, name=name, info=info, sub={}, varlink={}})
end

function addCatVar(cid, var, info, unit)
	Categories[cid].varlink[var] = {unit=unit, info=info}
end

function addSubCat(cid, id, name, info)
	return table.insert(Categories[cid].sub, id, {category=cid, id=id, name=name, info=info, formulas={}, variables={}})
end

function aF(cid, sid, formula, variables) --add Formula
	local fr	=	{category=cid, sub=sid, formula=formula, variables=variables}
	-- In times like this we are happy that inserting tables just inserts a reference
	table.insert(Formulas, fr)
	table.insert(Categories[cid].sub[sid].formulas, fr)
	
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

c_O  = utf8(963)
c_P  = utf8(961)
c_e  = utf8(949)
c_Pi = utf8(960)
c_u  = utf8(956)
c_t  = utf8(964)
c_Ohm = utf8(937)

addCat(1, "Resistive Circuits", "Performs routine calculations of resistive circuits")

addCatVar(1, "A", "Area", "m2")
addCatVar(1, "G", "Conductance", "S")
addCatVar(1, "I", "Current", "A")
addCatVar(1, "Il", "Load current", "A")
addCatVar(1, "Is", "Current source", "A")
addCatVar(1, "len", "Length", "m")
addCatVar(1, "P", "Power", "W")
addCatVar(1, "Pmax", "Maximum power in load", "W")
addCatVar(1, "R", "Resistance", utf8(937))
addCatVar(1, "Rl", "Load resistance", utf8(937))
addCatVar(1, "Rlm", "Match load resistance", utf8(937))
addCatVar(1, "RR1", "Resistance, T1", utf8(937))
addCatVar(1, "RR2", "Resistance, T2", utf8(937))
addCatVar(1, "Rs", "Source resistance", utf8(937))
addCatVar(1, "T1", "Temperature 1", "K")
addCatVar(1, "T2", "Temperature 2", "K")
addCatVar(1, "U", "Voltage", "V")
addCatVar(1, "Vl", "Load voltage", "V")
addCatVar(1, "Vs", "Source voltage", "V")
addCatVar(1, utf8(945), "Temperature coefficient", "1/"..utf8(176).."K")
addCatVar(1, utf8(961), "Resistivity", utf8(937).."*m")
addCatVar(1, utf8(963), "Conductivity", "S/m")


addSubCat(1, 1, "Resistance Formulas", "")
aF(1, 1, "R=(" ..c_P .."*len)/A",           U("R",c_P,"len","A") )
aF(1, 1, "G=(" ..c_O .."*A)/len",           U("G",c_O,"len","A") )
aF(1, 1, "G=1/R",                             U("G","R")           )
aF(1, 1, c_O .."=1/" ..c_P,                 U(c_O,c_P)           )

addSubCat(1, 2, "Ohm\'s Law and Power", "")
aF(1, 2, "U=I*R",                 U("R","U","I") )
aF(1, 2, "P=I*U",                 U("P","U","I") )
aF(1, 2, "P=(U*U)/R",             U("P","U","R") )
aF(1, 2, "P=U*U*G",               U("P","U","G") )
aF(1, 2, "R=1/G",                 U("R","G")    )

addSubCat(1, 3, "Temperature Effect", "")
aF(1, 3, "RR2=RR1*(1+"..utf8(945).."*(T2-T1))", U("RR2","RR1","T1", "T2", utf8(945)) )

addSubCat(1, 4, "Maximum DC Power Transfer", "")
aF(1, 4, "Vl=(Vs*Rl)/(Rs+Rl)",    U("Vl","Vs","Rl","Rs") )
aF(1, 4, "Il=Vs/(Rs+Rl)",         U("Il","Rs","Rs","Rl") )
aF(1, 4, "P=Il*Vl",               U("P","Il", "Vl")      )
aF(1, 3, "Pmax=(Vs*Vs)/(4*Rs)",   U("Pmax","Vs","Rs")    )
aF(1, 3, "Rlm=Rs",                U("Rlm","Rs")          )

addSubCat(1, 5, "V, I Source", "")
aF(1, 5, "Is=Vs/Rs",              U("Is","Vs","Rs") )
aF(1, 5, "Vs=Is*Rs",              U("Vs","Is","Rs") )

addCat(2, "Capacitors, E-Fields", "Compute electric field properties and capacitance of various types\nof structures")

addCatVar(2, "A", "Area", "m2")
addCatVar(2, "C", "Capacitance", "F")
addCatVar(2, "cl", "Capacitance per unit length", "F/m")
addCatVar(2, "d", "Separation", "m")
addCatVar(2, "E", "Electric field", "V/m")
addCatVar(2, "Er", "Radial electric field", "V/m")
addCatVar(2, "Ez", "Electric field along z axis", "V/m")
addCatVar(2, "F", "Force on plate", "N")
addCatVar(2, "Q", "Charge", "C")
addCatVar(2, "r", "Radial distance", "m")
addCatVar(2, "ra", "Inner radius, wire radius", "m")
addCatVar(2, "rb", "Outer radius", "m")
addCatVar(2, "V", "Potential", "V")
addCatVar(2, "Vz", "Potential along z axis", "V")
addCatVar(2, "W", "Energy stored", "J")
addCatVar(2, "z", "z axis distance from disk", "m")
addCatVar(2, utf8(949).."r", "Relative permittivity", "unitless")
addCatVar(2, utf8(961).."l", "Line charge", "C/m")
addCatVar(2, utf8(961).."s", "Charge density", "C/m2")

addSubCat(2, 1, "Point Charge", "")
aF(2, 1, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r*r)",  U("Er","Q",c_Pi,c_e.."0",c_e.."r") )
aF(2, 1, "V=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r)",     U("V","Q",c_Pi,c_e.."0",c_e.."r")  )

addSubCat(2, 2, "Long Charged Line", "")
aF(2, 2, "Er="..c_P.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)",     U("Er",c_P.."l",c_Pi,c_e.."0",c_e.."r")  )

addSubCat(2, 3, "Charged Disk", "")
aF(2, 3, "Ez=("..c_P.."s/(2*"..c_e.."0*"..c_e.."r))*(1-abs(z)/sqrt(ra*ra+z*z))",     U("Ez",c_P.."s",c_e.."0",c_e.."r","z","ra")  )
aF(2, 3, "Vz=("..c_P.."s/(2*"..c_e.."0*"..c_e.."r))*(sqrt(ra*ra+z*z)-abs(z))",       U("Vz",c_P.."s",c_e.."0",c_e.."r","z","ra")  )

addSubCat(2, 4, "Parallel Plates", "")
aF(2, 4, "E=V/d",                 U("E","V","d")           )
aF(2, 4, "C=("..c_e.."0*"..c_e.."r*A)/d",         U("C",c_e.."0",c_e.."r","A","d") )
aF(2, 4, "Q=C*V",                 U("Q","C","V")           )
aF(2, 4, "F=-0.5*(V*V*C)/d",      U("F","V","C","d")       )
aF(2, 4, "W=0.5*V*V*C",           U("W","V","C")           )

addSubCat(2, 5, "Parallel Wires", "")
aF(2, 5, "scl="..c_Pi.."*"..c_e.."0*"..c_e.."r/arccosh(d/(2*ra))", U("cl",c_Pi,c_e.."0",c_e.."r","d","ra")     )

addSubCat(2, 6, "Coaxial Cable", "")
aF(2, 6, "V=("..c_P.."l/(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*ln(rb/ra)",  U("V",c_P.."l",c_Pi,c_e.."0",c_e.."r","ra")     )
aF(2, 6, "Er=V/(r*ln(rb/ra))",            U("Er","V","r","rb","ra")          )
aF(2, 6, "cl=(2*"..c_Pi.."*"..c_e.."0*"..c_e.."r)/ln(rb/ra)",      U("cl",c_Pi,c_e.."0",c_e.."r","rb","ra")    )

addSubCat(2, 7, "Sphere", "")
aF(2, 7, "V=(Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r))*(1/ra-1/rb)", U("V","Q",c_Pi,c_e.."0",c_e.."r","ra","rb") )
aF(2, 7, "Er=Q/(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*r*r)",          U("Er","Q","r",c_Pi,c_e.."0",c_e.."r")      )
aF(2, 7, "cl=(4*"..c_Pi.."*"..c_e.."0*"..c_e.."r*ra*rb)/(rb-ra)",  U("cl",c_Pi,c_e.."0",c_e.."r","rb","ra")    )

addCat(3, "Inductors and Magnetism", "Calculate electrical and magnetic properties of physical elements")

addCatVar(3, utf8(952), "Angle", "radian")
addCatVar(3, utf8(956).."r", "Relative permeability", "unitless")
addCatVar(3, "a", "Loop radius or side of a rectangular loop", "m")
addCatVar(3, "B", "Magnetic field", "T")
addCatVar(3, "bl", "Width of rectangular loop", "m")
addCatVar(3, "Bx", "Magnetic field, x axis", "T")
addCatVar(3, "By", "Magnetic field, y axis", "T")
addCatVar(3, "D", "Center-center wire spacing", "m")
addCatVar(3, "d", "Strip width", "m")
addCatVar(3, "f", "Frequency", "Hz")
addCatVar(3, "Fw", "Force between wires/unit length", "N/m")
addCatVar(3, "I", "Current", "A")
addCatVar(3, "I1", "Current in line 1", "A")
addCatVar(3, "I2", "Current in line 2", "A")
addCatVar(3, "Is", "Current in strip", "A/m")
addCatVar(3, "L", "Inductance per unit length", "H/m")
addCatVar(3, "L12", "Mutual inductance", "H")
addCatVar(3, "Ls", "Loop self-inductance", "H")
addCatVar(3, "r", "Radial distance", "m")
addCatVar(3, "ra", "Radius of inner conductor", "m")
addCatVar(3, "rb", "Radius of outer conductor", "m")
addCatVar(3, "Reff", "Effective resistance", utf8(937))
addCatVar(3, "rr0", "Wire radius", "m")
addCatVar(3, "T12", "Torque", "N*m")
addCatVar(3, "x", "x axis distance", "m")
addCatVar(3, "y", "y axis distance", "m")
addCatVar(3, "z", "Distance to loop z axis", "m")
addCatVar(3, utf8(948), "Skin depth", "m")
addCatVar(3, utf8(961), "Resistivity", utf8(937).."*m")

addSubCat(3, 1, "Long Line", "")
aF(3, 1, "B=("..c_u.."0*I)/(2*"..c_Pi.."*r)", U("B",c_u.."0","I","r",c_Pi) )

addSubCat(3, 2, "Long Strip", "")

aF(3, 2, "Bx=((-"..c_u.."0*Is)/(2*"..c_Pi.."))*(atan((x+d/2)/y)-atan((x-d/2)/y))", U("Bx",c_u.."0","Is",c_Pi,"x","d","y") )
aF(3, 2, "By=(("..c_u.."0*Is)/(4*"..c_Pi.."))*ln((y*y-(x+d/2))/(y*y-(x-d/2)))",    U("By",c_u.."0","Is",c_Pi,"x","d","y") )

addSubCat(3, 3, "Parallel Wires", "")
aF(3, 3, "Fw=("..c_u.."0*I1*I2)/2*"..c_Pi.."*D",               U("Fw",c_u.."0","I1","I2",c_Pi,"D")       )
aF(3, 3, "Bx=("..c_u.."0/(2*"..c_Pi.."))*(I1/x-I2/(D-x))",     U("Bx",c_u.."0","I1","I2",c_Pi,"D","x" )  )
aF(3, 3, "L=("..c_u.."0/(4*"..c_Pi.."))+("..c_u.."0/("..c_Pi.."))*acos(D/2*a)", U("L",c_u.."0","a",c_Pi,"D" )             )

addSubCat(3, 4, "Loop", "")
addSubCat(3, 5, "Coaxial Cable", "")
addSubCat(3, 6, "Skin Effect", "")

addCat(4, "Electron Motion", "Investigate the trajectories of electrons under the influence \nof electric and magnetic fields")

addCatVar(4, "A0", "Richardson"..utf8(8217).."s constant", "A/(m2*K2)")
addCatVar(4, "B", "Magnetic field", "T")
addCatVar(4, "d", "Deflection tube diameter, plate spacing", "m")
addCatVar(4, "f", "Frequency", "Hz")
addCatVar(4, "f0", "Critical frequency", "Hz")
addCatVar(4, "I", "Thermionic current", "A")
addCatVar(4, "L", "Deflecting plate length", "m")
addCatVar(4, "Ls", "Beam length to destination", "m")
addCatVar(4, "r", "Radius of circular path", "m")
addCatVar(4, "S", "Surface area", "m2")
addCatVar(4, "T", "Temperature", "K")
addCatVar(4, "v", "Vertical velocity", "m/s")
addCatVar(4, "Va", "Accelerating voltage", "V")
addCatVar(4, "Vd", "Deflecting voltage", "V")
addCatVar(4, "y", "Vertical deflection", "m")
addCatVar(4, "yd", "Beam deflection on screen", "m")
addCatVar(4, "z", "Distance along beam axis", "m")
addCatVar(4, utf8(966), "Work function", "V")

addSubCat(4, 1, "Beam Deflection", "")
addSubCat(4, 2, "Thermionic Emission", "")
addSubCat(4, 3, "Photoemission", "")

addCat(5, "Meters and Bridge Circuits", "This category covers a variety of topics on meters, commonly used\nbridge and attenuator circuits")

addCatVar(5, "a", "Resistance multiplier", "unitless")
addCatVar(5, "b", "Resistance Multiplier", "unitless")
addCatVar(5, "c", "Resistance Multiplier", "unitless")
addCatVar(5, "CC3", "Capacitance, arm 3", "F")
addCatVar(5, "CC4", "Capacitance, arm 4", "F")
addCatVar(5, "Cs", "Series capacitor", "F")
addCatVar(5, "Cx", "Unknown capacitor", "F")
addCatVar(5, "DB", "Attenuator loss", "unitless")
addCatVar(5, "f", "Frequency", "Hz")
addCatVar(5, "Ig", "Galvanometer current", "A")
addCatVar(5, "Imax", "Maximum current", "A")
addCatVar(5, "Isen", "Current sensitivity", "A")
addCatVar(5, "Lx", "Unknown inductance", "unitless")
addCatVar(5, "Q", "Quality Factor", "unitless")
addCatVar(5, "Radj", "Adjustable resistor", utf8(937))
addCatVar(5, "Rg", "Galvanometer resistance", utf8(937))
addCatVar(5, "Rj", "Resistance in L pad", utf8(937))
addCatVar(5, "Rk", "Resistance in L pad", utf8(937))
addCatVar(5, "Rl", "Resistance from left", utf8(937))
addCatVar(5, "Rm", "Meter resistance", utf8(937))
addCatVar(5, "Rr", "Resistance from right", utf8(937))
addCatVar(5, "RR1", "Resistance, arm 1", utf8(937))
addCatVar(5, "RR2", "Resistance, arm 2", utf8(937))
addCatVar(5, "RR3", "Resistance, arm 3", utf8(937))
addCatVar(5, "RR4", "Resistance, arm 4", utf8(937))
addCatVar(5, "Rs", "Series resistance", utf8(937))
addCatVar(5, "Rse", "Series resistance", utf8(937))
addCatVar(5, "Rsh", "Shunt resistance", "A")
addCatVar(5, "Rx", "Unknown resistance", utf8(937))
addCatVar(5, "Vm", "Voltage across meter", "V")
addCatVar(5, "Vmax", "Maximum voltage", "V")
addCatVar(5, "Vs", "Source voltage", "V")
addCatVar(5, "Vsen", "Voltage sensitivity", "V")
addCatVar(5, utf8(969), "Radian frequency", "rad/s")

addSubCat(5, 1, "A, V, W Meters", "")
addSubCat(5, 2, "Wheatstone Bridge", "")
addSubCat(5, 3, "Wien Bridge", "")
addSubCat(5, 4, "Maxwell Bridge", "")
addSubCat(5, 5, "Attenuators - Symmetric R", "")
addSubCat(5, 6, "Attenuators - Unsym R", "")

addCat(6, "RL and RC Circuits", "Compute the natural and transient properties of simple RL\nand RC circuits")

addCatVar(6, "C", "Capacitor", "F")
addCatVar(6, "Cs", "Series capacitance", "F")
addCatVar(6, "Cp", "Parallel capacitance", "F")
addCatVar(6, "f", "Frequency", "Hz")
addCatVar(6, "iC", "Capacitor current", "A")
addCatVar(6, "iL", "Inductor current", "A")
addCatVar(6, "I0", "Initial inductor current", "A")
addCatVar(6, "L", "Inductance", "H")
addCatVar(6, "Lp", "Parallel inductance", "H")
addCatVar(6, "Ls", "Series inductance", "H")
addCatVar(6, "Qp", "Q, parallel circuit", "unitless")
addCatVar(6, "Qs", "Q, series circuit", "unitless")
addCatVar(6, "R", "Resistance", utf8(937))
addCatVar(6, "Rp", "Parallel resistance", utf8(937))
addCatVar(6, "Rs", "Series resistance", utf8(937))
addCatVar(6, utf8(964), "Time constant", "s")
addCatVar(6, "t", "Time", "s")
addCatVar(6, "vC", "Capacitor voltage", "V")
addCatVar(6, "vL", "Inductor voltage", "V")
addCatVar(6, "V0", "Initial capacitor voltage", "V")
addCatVar(6, "Vs", "Voltage stimulus", "V")
addCatVar(6, utf8(969), "Radian frequency", "rad/s")
addCatVar(6, "W", "Energy dissipated", "J")

addSubCat(6, 1, "RL Natural Response", "")
aF(6, 1, c_t.."=L/R",                           U(c_t,"L","R")                )
aF(6, 1, "vL=I0*R*exp(-t/"..c_t..")",               U("vL","I0","R","t",c_t)      )
aF(6, 1, "iL=I0*exp(-t/"..c_t..")",                 U("iL","I0","t",c_t)          )
aF(6, 1, "W=1/2*L*I0*I0*(1-exp(-2*t/"..c_t.."))",   U("W","L","I0","t",c_t)       )

addSubCat(6, 2, "RC Natural Response", "")
aF(6, 2, c_t.."=R*C",                           U(c_t,"R","C")                )
aF(6, 2, "vC=V0*exp(-t/"..c_t..")",                 U("vC","V0","t",c_t)          )
aF(6, 2, "iC=V0/R*exp(-t/"..c_t..")",               U("iC","V0","R","t",c_t)      )
aF(6, 2, "W=1/2*C*V0*V0*(1-exp(-2*t/"..c_t.."))",   U("W","C","V0","t",c_t)       )

addSubCat(6, 3, "RL Step response", "")
aF(6, 3, c_t.."=L/R",                           U(c_t,"L","R")                )
aF(6, 3, "vL=(Vs-I0*R)*exp(-t/"..c_t..")",          U("vL","I0","R","t",c_t)      )
aF(6, 3, "iL=Vs/R+(I0-Vs/R)*exp(-t/"..c_t..")",     U("iL","Vs","R","I0","t",c_t) )

addSubCat(6, 4, "RC Step Response", "")
aF(6, 4, c_t.."=R*C",                           U(c_t,"R","C")                )
aF(6, 4, "vC=Vs+(V0-Vs)*exp(-t/"..c_t..")",         U("vC","Vs","V0","t",c_t)     )
aF(6, 4, "iC=(Vs-V0)/R*exp(-t/"..c_t..")",          U("iC","Vs","V0","R","t",c_t) )

addSubCat(6, 5, "RL Series to Parallel", "")
-- 11 formulas here :o --

addSubCat(6, 6, "RC Series to Parallel", "")
-- 11 formulas here :o --


addCat(7, "RLC Circuits", "Compute the impedance, admittance, natural response and\ntransient behavior of RLC circuits")

addCatVar(7, utf8(945), "Neper"..utf8(8217).."s frequency", "rad/s")
addCatVar(7, "A1", "Constant", "V")
addCatVar(7, "A2", "Constant", "V")
addCatVar(7, "B", "Susceptance", "S")
addCatVar(7, "B1", "Constant", "V")
addCatVar(7, "B2", "Constant", "V")
addCatVar(7, "BC", "Capacitive susceptance", "S")
addCatVar(7, "BL", "Inductive susceptance", "S")
addCatVar(7, "C", "Capacitance", "F")
addCatVar(7, "D1", "Constant", "V/s")
addCatVar(7, "D2", "Constant", "V")
addCatVar(7, "f", "Frequency", "Hz")
addCatVar(7, "G", "Conductance", "S")
addCatVar(7, "I0", "Initial inductor current", "A")
addCatVar(7, "L", "Inductance", "H")
addCatVar(7, utf8(952), "Phase angle", "rad")
addCatVar(7, "R", "Resistance", utf8(937))
addCatVar(7, "s1", "Characteristic frequency", "rad/s")
addCatVar(7, "s2", "Characteristic frequency", "rad/s")
addCatVar(7, "s1i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s1r", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "s2i", "Characteristic frequency (imaginary)", "rad/s")
addCatVar(7, "s2i", "Characteristic frequency (real)", "rad/s")
addCatVar(7, "t", "Time", "s")
addCatVar(7, "v", "Capacitor voltage", "V")
addCatVar(7, "V0", "Initial capacitor voltage", "V")
addCatVar(7, utf8(969), "Radian Frequency", "rad/s")
addCatVar(7, utf8(969).."d", "Damped radian frequency", "rad/s")
addCatVar(7, utf8(969).."0", "Classical radian frequency", "rad/s")
addCatVar(7, "X", "Reactance", utf8(937))
addCatVar(7, "XXC", "Capacitive reactance", utf8(937))
addCatVar(7, "XL", "Inductive reactance", utf8(937))
addCatVar(7, "Ym", "Admittance "..utf8(8211).." magnitude", "S")
addCatVar(7, "Zm", "Impedance "..utf8(8211).." magnitude", "S")

addSubCat(7, 1, "Series Impedance", "")
addSubCat(7, 2, "Parallel Admittance", "")
addSubCat(7, 3, "RLC Natural Response", "")
addSubCat(7, 4, "Under-damped case", "")
addSubCat(7, 5, "Critical Damping", "")
addSubCat(7, 6, "Over-damped Case", "")

addCat(8, "AC Circuits", "Calculate properties of AC circuits")

addCatVar(8, "C", "Capacitance", "F")
addCatVar(8, "f", "Frequency", "Hz")
addCatVar(8, "I", "Instantaneous current", "A")
addCatVar(8, "Im", "Current amplitude", "A")
addCatVar(8, "L", "Inductance", "H")
addCatVar(8, utf8(952), "Impedance phase angle", "rad")
addCatVar(8, utf8(952).."1", "Phase angle 1", "rad")
addCatVar(8, utf8(952).."2", "Phase angle 2", "rad")
addCatVar(8, "R", "Resistance", utf8(937))
addCatVar(8, "RR1", "Resistance 1", utf8(937))
addCatVar(8, "RR2", "Resistance 2", utf8(937))
addCatVar(8, "t", "Time", "s")
addCatVar(8, "V", "Total voltage", "V")
addCatVar(8, "VC", "Voltage across capacitor", "V")
addCatVar(8, "VL", "Voltage across inductor", "V")
addCatVar(8, "Vm", "Maximum voltage", "V")
addCatVar(8, "VR", "Voltage across resistor", "V")
addCatVar(8, utf8(969), "Radian frequency", "rad/s")
addCatVar(8, "X", "Reactance", utf8(937))
addCatVar(8, "XX1", "Reactance 1", utf8(937))
addCatVar(8, "XX2", "Reactance 2", utf8(937))
addCatVar(8, "Y"..utf8(95), "Admittance", "S")
addCatVar(8, "Z1m", "Impedance 1 magnitude", utf8(937))
addCatVar(8, "Z2m", "Impedance 2 magnitude", utf8(937))
addCatVar(8, "Z"..utf8(95), "Complex impedance", utf8(937))
addCatVar(8, "Zm", "Impedance magnitude", utf8(937))

addSubCat(8, 1, "RL Series Impedance", "")
addSubCat(8, 2, "RC Series Impedance", "")
addSubCat(8, 3, "Impedance - Admittance", "")
addSubCat(8, 4, "2 Z's in Series", "")
addSubCat(8, 5, "2 Z's in Parallel", "")

addCat(9, "Polyphase Circuits", "")

addCatVar(9, "IL", "Line current", "A")
addCatVar(9, "Ip", "Phase current", "A")
addCatVar(9, "P", "Power per phase", "W")
addCatVar(9, "PT", "Total power", "W")
addCatVar(9, utf8(952), "Impedance angle", "rad")
addCatVar(9, "VL", "Line voltage", "V")
addCatVar(9, "Vp", "Phase voltage", "V")
addCatVar(9, "W1", "Wattmeter 1", "W")
addCatVar(9, "W2", "Wattmeter 2", "W")

addSubCat(9, 1, "Balanced D Network", "")
addSubCat(9, 2, "Balance Wye Network", "")
addSubCat(9, 3, "Power Measurements", "")

addCat(10, "Electrical Resonance", "")

addCatVar(10, utf8(945), "Damping coefficient", "rad/s")
addCatVar(10, utf8(946), "Bandwidth", "rad/s")
addCatVar(10, "C", "Capacitance", "F")
addCatVar(10, "Im", "Current", "A")
addCatVar(10, "L", "Inductance", "H")
addCatVar(10, utf8(952), "Phase angle", "rad")
addCatVar(10, "Q", "Quality factor", "unitless")
addCatVar(10, "R", "Resistance", utf8(937))
addCatVar(10, "Rg", "Generator resistance", utf8(937))
addCatVar(10, "Vm", "Maximum voltage", "V")
addCatVar(10, utf8(969), "Radian frequency", "rad/s")
addCatVar(10, utf8(969).."0", "Resonant frequency", "rad/s")
addCatVar(10, utf8(969).."1", "Lower cutoff frequency", "rad/s")
addCatVar(10, utf8(969).."2", "Upper cutoff frequency", "rad/s")
addCatVar(10, utf8(969).."d", "Damped resonant frequency", "rad/s")
addCatVar(10, utf8(969).."m", "Frequency for maximum amplitude", "rad/s")
addCatVar(10, "Yres", "Admittance at resonance", "S")
addCatVar(10, "Z", "Impedance", utf8(937))
addCatVar(10, "Zres", "Impedance at resonance", utf8(937))

addSubCat(10, 1, "Parallel Resonance I", "")
addSubCat(10, 2, "Parallel Resonance II", "")
addSubCat(10, 3, "Lossy Inductor", "")
addSubCat(10, 4, "Series Resonance", "")

addCat(11, "Op. Amp Circuits", "")

addCatVar(11, "Acc", "Common Mode current gain", "unitless", "")
addCatVar(11, "Aco", "Common Mode gain from real OpAmp", "unitless")
addCatVar(11, "Ad", "Differential mode gain", "unitless")
addCatVar(11, "Agc", "Transconductance", "S")
addCatVar(11, "Aic", "Current gain", "unitless")
addCatVar(11, "Av", "Voltage gain", "unitless")
addCatVar(11, "CC1", "Input capacitor", "F")
addCatVar(11, "Cf", "Feedback capacitor", "F")
addCatVar(11, "CMRR", "CM rejection ratio", "unitless")
addCatVar(11, "Cp", "Bypass capacitor", "F")
addCatVar(11, "fcp", "3dB bandwidth, circuit", "Hz")
addCatVar(11, "fd", "Characteristic frequency", "Hz")
addCatVar(11, "f0", "Passband, geometric center", "Hz")
addCatVar(11, "fop", "3dB bandwidth, OpAmp", "Hz")
addCatVar(11, "IIf", "Maximum current through Rf", "A")
addCatVar(11, "RR1", "Input resistor", utf8(937))
addCatVar(11, "RR2", "Current stabilizor", utf8(937))
addCatVar(11, "RR3", "Feedback resistor", utf8(937))
addCatVar(11, "RR4", "Resistor", utf8(937))
addCatVar(11, "Rf", "Feedback resistor", utf8(937))
addCatVar(11, "Rin", "Input resistance", utf8(937))
addCatVar(11, "Rl", "Load resistance", utf8(937))
addCatVar(11, "Ro", "Output resistance, OpAmp", utf8(937))
addCatVar(11, "Rout", "Output resistance", utf8(937))
addCatVar(11, "Rp", "Bias current resistor", utf8(937))
addCatVar(11, "Rs", "Voltage divide resistor", utf8(937))
addCatVar(11, "tr", "10-90"..utf8(37).." rise time", "s")
addCatVar(11, utf8(8710).."VH", "Hysteresis", "V")
addCatVar(11, "VL", "Detection threshold, low", "V")
addCatVar(11, "Vomax", "Maximum circuit output", "V")
addCatVar(11, "VR", "Reference voltage", "V")
addCatVar(11, "Vrate", "Maximum voltage rate", "V/s")
addCatVar(11, "VU", "Detection threshold, high", "V")
addCatVar(11, "Vz1", "Zener breakdown 1", "V")
addCatVar(11, "Vz2", "Zener breakdown 2", "V")

addSubCat(11, 1, "Basic Inverter", "")
addSubCat(11, 2, "Non-Inverting Amplifier", "")
addSubCat(11, 3, "Current Amplifier", "")
addSubCat(11, 4, "Transconductance Amplifier", "")
addSubCat(11, 5, "Lvl. Detector Invert", "")
addSubCat(11, 6, "Lvl. Detector Non-Invert", "")
addSubCat(11, 7, "Differentiator", "")
addSubCat(11, 8, "Diff. Amplifier", "")

addCat(12, "Solid State Devices", "")

addCatVar(12, utf8(945), "CB current gain", "unitless")
addCatVar(12, "aLGJ", "Linearly graded junction parameter", "1/m4")
addCatVar(12, "A", "Area", "m2")
addCatVar(12, "A1", "EB junction area", "m2")
addCatVar(12, "A2", "CB junction area", "m2")
addCatVar(12, utf8(945).."f", "Forward "..utf8(945), "unitless")
addCatVar(12, "Aj", "Junction area", "m2")
addCatVar(12, utf8(945).."r", "Reverse "..utf8(945), "unitless")
addCatVar(12, utf8(946), "CE current gain", "unitless")
addCatVar(12, "b", "Channel width", "m")
addCatVar(12, utf8(946).."f", "Forward "..utf8(946), "unitless")
addCatVar(12, utf8(946).."r", "Reverse "..utf8(946), "unitless")
addCatVar(12, "Cj", "Junction capacitance", "F")
addCatVar(12, "CL", "Load capacitance", "F")
addCatVar(12, "Cox", "Oxide capacitance per unit area", "F/m2")
addCatVar(12, "D", "Diffusion coefficient", "m2/s")
addCatVar(12, "DB", "Base diffusion coefficient", "m2/s")
addCatVar(12, "DC", "Collector diffusion coefficient", "m2/s")
addCatVar(12, "DE", "Emitter diffusion coefficient", "m2/s")
addCatVar(12, "Dn", "n diffusion coefficient", "m2/s")
addCatVar(12, "Dp", "p diffusion coefficient", "m2/s")
addCatVar(12, utf8(949).."ox", "Oxide permittivity", "unitless")
addCatVar(12, utf8(949).."s", "Silicon Permittivity", "unitless")
addCatVar(12, "Ec", "Conduction band", "J")
addCatVar(12, "EF", "Fermi level", "J")
addCatVar(12, "Ei", "Intrinsic Fermi level", "J")
addCatVar(12, "Ev", "Valence band", "J")
addCatVar(12, "ffmax", "Maximum frequency", "Hz")
addCatVar(12, utf8(947), "Body coefficient", "V5")
addCatVar(12, "gd", "Drain conductance", "S")
addCatVar(12, "gm", "Transconductance", "S")
addCatVar(12, "gmL", "Transconductance, load device", "S")
addCatVar(12, "Go", "Conductance", "S")
addCatVar(12, "I", "Junction current", "A")
addCatVar(12, "I0", "Saturation current", "A")
addCatVar(12, "IB", "Base current", "A")
addCatVar(12, "IC", "Collector current", "A")
addCatVar(12, "ICB0", "CB leakage, E open", "A")
addCatVar(12, "ICE0", "CE leakage, B open", "A")
addCatVar(12, "ICsat", "Collector I at saturation edge", "A")
addCatVar(12, "ID", "Drain current", "A")
addCatVar(12, "IDmod", "Channel modulation drain current", "A")
addCatVar(12, "ID0", "Drain current at zero bias", "A")
addCatVar(12, "IDsat", "Drain saturation current", "A")
addCatVar(12, "IE", "Emitter current", "A")
addCatVar(12, "IIf", "Forward current", "A")
addCatVar(12, "Ir", "Reverse current", "A")
addCatVar(12, "Ir0", "E-M reverse current component", "A")
addCatVar(12, "IRG", "G-R current", "A")
addCatVar(12, "IRG0", "Zero bias G-R current", "A")
addCatVar(12, "Is", "Saturation current", "A")
addCatVar(12, utf8(955), "Modulation parameter", "1/V")
addCatVar(12, "Is", "Saturation current", "A")
addCatVar(12, "kD", "MOS constant, driver", "A/V2")
addCatVar(12, "kL", "MOS constant, load", "A/V2")
addCatVar(12, "kn", "MOS constant", "A/V2")
addCatVar(12, "kn1", "MOS process constant", "A/V2")
addCatVar(12, "kN", "MOS constant, n channel", "A/V2")
addCatVar(12, "kP", "MOS constant, p channel", "A/V2")
addCatVar(12, "KR", "Ratio", "unitless")
addCatVar(12, "L", "Transistor length", "m")
addCatVar(12, "LC", "Diffusion length, collector", "m")
addCatVar(12, "LD", "Drive transistor length", "m")
addCatVar(12, "LE", "Diffusion length, emitter", "m")
addCatVar(12, "LL", "Load transistor length", "m")
addCatVar(12, "LLn", "Diffusion length, n", "m")
addCatVar(12, "lNN", "n-channel length", "m")
addCatVar(12, "Lp", "Diffusion length, p", "m")
addCatVar(12, "lP", "p-channel length", "m")
addCatVar(12, utf8(956).."n", "n (electron) mobility", "m2/(V*s)")
addCatVar(12, utf8(956).."p", "p (positive charge) mobility", "m2/(V*s)")
addCatVar(12, "mn", "n effective mass", "unitless")
addCatVar(12, "mp", "p effective mass", "unitless")
addCatVar(12, "N", "Doping concentration", "1/m3")
addCatVar(12, "Na", "Acceptor density", "1/m3")
addCatVar(12, "nnC", "n density, collector", "1/m3")
addCatVar(12, "Nd", "Donor density", "1/m3")
addCatVar(12, "nE", "n density, emitter", "1/m3")
addCatVar(12, "ni", "Intrinsic density", "1/m3")
addCatVar(12, "N0", "Surface concentration", "1/m3")
addCatVar(12, "npo", "n density in p material", "1/m3")
addCatVar(12, "p", "p density", "1/m3")
addCatVar(12, "pB", "p density, base", "1/m3")
addCatVar(12, utf8(966).."F", "Fermi potential", "V")
addCatVar(12, utf8(966).."GC", "Work function potential", "V")
addCatVar(12, "pno", "p density in n material", "1/m3")
addCatVar(12, "Qtot", "Total surface impurities", "unitless")
addCatVar(12, "Qb", "Bulk charge at bias", "C/m2")
addCatVar(12, "Qb0", "Bulk charge at 0 bias", "C/m2")
addCatVar(12, "Qox", "Oxide charge density", "C/m2")
addCatVar(12, "Qsat", "Base Q, transition edge", "C")
addCatVar(12, utf8(961).."n", "n resistivity", utf8(937).."*m")
addCatVar(12, utf8(961).."p", "p resistivity", utf8(937).."*m")
addCatVar(12, "Rl", "Load resistance", utf8(937))
addCatVar(12, utf8(964).."B", "lifetime in base", "s")
addCatVar(12, utf8(964).."D", "Time constant", "s")
addCatVar(12, utf8(964).."L", "Time constant", "s")
addCatVar(12, utf8(964).."o", "Lifetime", "s")
addCatVar(12, utf8(964).."p", "Minority carrier lifetime", "s")
addCatVar(12, utf8(964).."t", "Base transit time", "s")
addCatVar(12, "t", "Time", "s")
addCatVar(12, "TT", "Temperature", "K")
addCatVar(12, "tch", "Charging time", "s")
addCatVar(12, "tdis", "Discharge time", "s")
addCatVar(12, "tox", "Gate oxide thickness", "m")
addCatVar(12, "tr", "Collector current rise time", "s")
addCatVar(12, "ts", "Charge storage time", "s")
addCatVar(12, "tsd1", "Storage delay, turn off", "s")
addCatVar(12, "tsd2", "Storage delay, turn off", "s")
addCatVar(12, "Ttr", "Transit time", "s")
addCatVar(12, "V1", "Input voltage", "V")
addCatVar(12, "Va", "Applied voltage", "V")
addCatVar(12, "Vbi", "Built-in voltage", "V")
addCatVar(12, "VBE", "BE bias voltage", "V")
addCatVar(12, "VCB", "CB bias voltage", "V")
addCatVar(12, "VCC", "Collector supply voltage", "V")
addCatVar(12, "VCEs", "CE saturation voltage", "V")
addCatVar(12, "VDD", "Drain supply voltage", "V")
addCatVar(12, "VDS", "Drain voltage", "V")
addCatVar(12, "VDsat", "Drain saturation voltage", "V")
addCatVar(12, "VEB", "EB bias voltage", "V")
addCatVar(12, "VG", "Gate voltage", "V")
addCatVar(12, "VGS", "Gate to source voltage", "V")
addCatVar(12, "VIH", "Input high", "V")
addCatVar(12, "Vin", "Input voltage", "V")
addCatVar(12, "VIL", "Input low voltage", "V")
addCatVar(12, "VL", "Load voltage", "V")
addCatVar(12, "VM", "Midpoint voltage", "V")
addCatVar(12, "VOH", "Output high", "V")
addCatVar(12, "VOL", "Output low", "V")
addCatVar(12, "Vo", "Output voltage", "V")
addCatVar(12, "Vp", "Pinchoff voltage", "V")
addCatVar(12, "VSB", "Substrate bias", "V")
addCatVar(12, "VT", "Threshold voltage", "V")
addCatVar(12, "VT0", "Threshold voltage at 0 bias", "V")
addCatVar(12, "VTD", "Depletion transistor threshold", "V")
addCatVar(12, "VTL", "Load transistor threshold", "V")
addCatVar(12, "VTL0", "Load transistor threshold", "V")
addCatVar(12, "VTN", "n channel threshold", "V")
addCatVar(12, "VTP", "p channel threshold", "V")
addCatVar(12, "W", "MOS transistor width", "m")
addCatVar(12, "WB", "Base width", "m")
addCatVar(12, "WD", "Drive transistor width", "m")
addCatVar(12, "WL", "Load transistor width", "m")
addCatVar(12, "WN", "n-channel width", "m")
addCatVar(12, "WP", "p-channel width", "m")
addCatVar(12, "x", "Depth from surface", "m")
addCatVar(12, "xd", "Depletion layer width", "m")
addCatVar(12, "xn", "Depletion width, n side", "m")
addCatVar(12, "xp", "Depletion width, p side", "m")
addCatVar(12, "Z", "JFET width", "m")


addSubCat(12, 1, "Semiconductor Basics", "")
addSubCat(12, 2, "PN Junctions", "")
addSubCat(12, 3, "PN Junction Currents", "")
addSubCat(12, 4, "Transistor Currents", "")
addSubCat(12, 5, "Ebers-Moll Equations", "")
addSubCat(12, 6, "Ideal Currents - pnp", "")
addSubCat(12, 7, "Switching Transients", "")
addSubCat(12, 8, "MOS Transistor I", "")
addSubCat(12, 9, "MOS Transistor II", "")
addSubCat(12, 10, "MOS Inverter R Load", "")
addSubCat(12, 11, "MOS Inverter Sat Load", "")
addSubCat(12, 12, "MOS Inverter Depl. Ld", "")
addSubCat(12, 13, "CMOS Transistor Pair", "")
addSubCat(12, 14, "Junction FET", "")

addCat(13, "Linear Amplifiers", "")

addCatVar(13, utf8(945).."0", "Current gain, CE", "unitless")
addCatVar(13, "Ac", "Common mode gain", "unitless")
addCatVar(13, "Ad", "Differential mode gain", "unitless")
addCatVar(13, "Ai", "Current gain, CB", "unitless")
addCatVar(13, "Aov", "Overall voltage gain", "unitless")
addCatVar(13, "Av", "Voltage gain, CC/CD", "unitless")
addCatVar(13, utf8(946).."0", "Current gain, CB", "unitless")
addCatVar(13, "CMRR", "Common mode reject ratio", "unitless")
addCatVar(13, "gm", "Transconductance", "S")
addCatVar(13, utf8(956), "Amplification factor", "unitless")
addCatVar(13, "rb", "Base resistance", utf8(937))
addCatVar(13, "rrc", "Collector resistance", utf8(937))
addCatVar(13, "rd", "Drain resistance", utf8(937))
addCatVar(13, "re", "Emitter resistance", utf8(937))
addCatVar(13, "RBA", "External base resistance", utf8(937))
addCatVar(13, "RCA", "External collector resistance", utf8(937))
addCatVar(13, "RDA", "External drain resistance", utf8(937))
addCatVar(13, "REA", "External emitter resistance", utf8(937))
addCatVar(13, "RG", "External gate resistance", utf8(937))
addCatVar(13, "Ric", "Common mode input resistance", utf8(937))
addCatVar(13, "Rid", "Differential input resistance", utf8(937))
addCatVar(13, "Rin", "Input resistance", utf8(937))
addCatVar(13, "Rl", "Load resistance", utf8(937))
addCatVar(13, "Ro", "Output resistance", utf8(937))
addCatVar(13, "Rs", "Source resistance", utf8(937))

addSubCat(13, 1, "BJT (CB)", "")
addSubCat(13, 2, "BJT (CE)", "")
addSubCat(13, 3, "BJT (CC)", "")
addSubCat(13, 4, "FET (Common Gate)", "")
addSubCat(13, 5, "FET (Common Source)", "")
addSubCat(13, 6, "FET (Common Drain)", "")
addSubCat(13, 7, "Darlington (CC-CC)", "")
addSubCat(13, 8, "Darlington (CC-CE)", "")
addSubCat(13, 9, "EC Amplifier", "")
addSubCat(13, 10, "Differential Amplifier", "")
addSubCat(13, 11, "Source Coupled JFET", "")

addCat(14, "Class A, B, C Amps", "")

addCatVar(14, "gm", "Transconductance", "S")
addCatVar(14, "hFE", "CE current gain", "unitless")
addCatVar(14, "hOE", "CE output conductance", "S")
addCatVar(14, "I", "Current", "A")
addCatVar(14, "IB", "Base current", "A")
addCatVar(14, "IC", "Collector Current", "A")
addCatVar(14, utf8(8710).."IC", "Current swing from operating pt.", "A")
addCatVar(14, "ICBO", "Collector current EB open", "A")
addCatVar(14, "ICQ", "Current at operating point", "A")
addCatVar(14, "Idc", "DC current", "A")
addCatVar(14, "Imax", "Maximum current", "A")
addCatVar(14, "K", "Constant", "unitless")
addCatVar(14, "m", "Constant", "1/K")
addCatVar(14, utf8(962), "Efficiency", "unitless")
addCatVar(14, "n", "Turns ratio", "unitless")
addCatVar(14, "N1", utf8(35).." turns in primary", "unitless")
addCatVar(14, "N2", utf8(35).." turns in secondary", "unitless")
addCatVar(14, "Pd", "Power dissipated", "W")
addCatVar(14, "Pdc", "DC power input to amp", "W")
addCatVar(14, "Po", "Power output", "W")
addCatVar(14, "PP", "Compliance", "V")
addCatVar(14, "Q", "Quality factor", "unitless")
addCatVar(14, utf8(952).."JA", "Thermal resistance", "W/K")
addCatVar(14, "R", "Equivalent resistance", utf8(937))
addCatVar(14, "Rl", "Load resistance", utf8(937))
addCatVar(14, "RR0", "Internal circuit loss", utf8(937))
addCatVar(14, "RR2", "Load resistance", utf8(937))
addCatVar(14, "RB", "External base resistance", utf8(937))
addCatVar(14, "Rrc", "Coupled load resistance", utf8(937))
addCatVar(14, "Rxt", "External emitter resistance", utf8(937))
addCatVar(14, "S", "Instability factor", "unitless")
addCatVar(14, "TA", "Ambient temperature", "K")
addCatVar(14, "TJ", "Junction temperature", "K")
addCatVar(14, utf8(8710).."Tj", "Change in temperature", "K")
addCatVar(14, "V0", "Voltage across tank circuit", "V")
addCatVar(14, "V1", "Voltage across tuned circuit", "V")
addCatVar(14, "VBE", "Base emitter voltage", "V")
addCatVar(14, "VCC", "Collector supply voltage", "V")
addCatVar(14, utf8(8710).."VCE", "Voltage swing from operating pt.", "V")
addCatVar(14, "VCEmx", "Maximum transistor rating", "V")
addCatVar(14, "VCEmn", "Minimum transistor rating", "V")
addCatVar(14, "Vm", "Maximum amplitude", "V")
addCatVar(14, "VPP", "Peak-peak volts, secondary", "V")
addCatVar(14, "XXC", "Tuned circuit parameter", utf8(937))
addCatVar(14, "XC1", utf8(960).." equivalent circuit parameter", utf8(937))
addCatVar(14, "XC2", utf8(960).." equivalent circuit parameter", utf8(937))
addCatVar(14, "XL", utf8(960).." series reactance", utf8(937))

addSubCat(14, 1, "Class A Amplifier", "")
addSubCat(14, 2, "Power Transistor", "")
addSubCat(14, 3, "Push-Pull Principle", "")
addSubCat(14, 4, "Class B Amplifier", "")
addSubCat(14, 5, "Class C Amplifier", "")

addCat(15, "Transformers", "")

addCatVar(15, "I1", "Primary current", "A")
addCatVar(15, "I2", "Secondary current", "A")
addCatVar(15, "N1", utf8(35).." primary turns", "unitless")
addCatVar(15, "N2", utf8(35).." secondary turns", "unitless")
addCatVar(15, "RR1", "Primary resistance", utf8(937))
addCatVar(15, "RR2", "Secondary resistance", utf8(937))
addCatVar(15, "Rin", "Equiv. primary resistance", utf8(937))
addCatVar(15, "Rl", "Resistive part of load", utf8(937))
addCatVar(15, "V1", "Primary voltage", "V")
addCatVar(15, "V2", "Secondary voltage", "V")
addCatVar(15, "XX1", "Primary reactance", utf8(937))
addCatVar(15, "XX2", "Secondary reactance", utf8(937))
addCatVar(15, "Xin", "Equivalent primary reactance", utf8(937))
addCatVar(15, "Xl", "Reactive part of load", utf8(937))
addCatVar(15, "Zin", "Primary impedance", utf8(937))
addCatVar(15, "ZL", "Secondary load", utf8(937))

addSubCat(15, 1, "Ideal Transformer", "")
addSubCat(15, 2, "Linear Equiv. Circuit", "")

addCat(16, "Motors, Generators", "")

addCatVar(16, "A", "Area", "m2")
addCatVar(16, "ap", utf8(35).." parallel paths", "unitless")
addCatVar(16, "B", "Magnetic induction", "T")
addCatVar(16, "Ea", "Average emf induced in armature", "V")
addCatVar(16, "Ef", "Field voltage", "V")
addCatVar(16, "Ema", "Phase voltage", "V")
addCatVar(16, "Es", "Induced voltage", "V")
addCatVar(16, "Eta", "Average emf induced per turn", "V")
addCatVar(16, "F", "Magnetic pressure", "Pa")
addCatVar(16, "H", "Magnetic field intensity", "A/m")
addCatVar(16, "Ia", "Armature current", "A")
addCatVar(16, "IIf", "Field current", "A")
addCatVar(16, "IL", "Load current", "A")
addCatVar(16, "Ir", "Rotor current per phase", "A")
addCatVar(16, "Isb", "Backward stator current", "A")
addCatVar(16, "Isf", "Forward stator current", "A")
addCatVar(16, "K", "Machine constant", "unitless")
addCatVar(16, "Kf", "Field coefficient", "A/Wb")
addCatVar(16, "KM", "Induction motor constant", "unitless")
addCatVar(16, "L", "Length of each turn", "m")
addCatVar(16, utf8(952), "Phase delay", "r")
addCatVar(16, "N", "Total "..utf8(35).." armature coils", "unitless")
addCatVar(16, "Ns", utf8(35).." stator coils", "unitless")
addCatVar(16, utf8(961), "Resistivity", utf8(937).."/m")
addCatVar(16, utf8(966), "Flux", "Wb")
addCatVar(16, "p", utf8(35).." poles", "unitless")
addCatVar(16, "P", "Power", "W")
addCatVar(16, "Pa", "Mechanical power", "W")
addCatVar(16, "Pma", "Power in rotor per phase", "W")
addCatVar(16, "Pme", "Mechanical power", "W")
addCatVar(16, "Pr", "Rotor power per phase", "W")
addCatVar(16, "RR1", "Rotor resistance per phase", utf8(937))
addCatVar(16, "Ra", "Armature resistance", utf8(937))
addCatVar(16, "Rd", "Adjustable resistance", utf8(937))
addCatVar(16, "Re", "Ext. shunt resistance", utf8(937))
addCatVar(16, "Rel", "Magnetic reluctance", "A/Wb")
addCatVar(16, "Rf", "Field coil resistance", utf8(937))
addCatVar(16, "Rl", "Load resistance", utf8(937))
addCatVar(16, "Rr", "Equivalent rotor resistance", utf8(937))
addCatVar(16, "Rs", "Series field resistance", utf8(937))
addCatVar(16, "Rst", "Stator resistance", utf8(937))
addCatVar(16, "s", "Slip", "unitless")
addCatVar(16, "sf", "Slip for forward flux", "unitless")
addCatVar(16, "sm", "Maximum slip", "unitless")
addCatVar(16, "T", "Internal torque", "N*m")
addCatVar(16, "Tb", "Backward torque", "N*m")
addCatVar(16, "Tf", "Forward torque", "N*m")
addCatVar(16, "Tgmax", "Breakdown torque", "N*m")
addCatVar(16, "TL", "Load torque", "N*m")
addCatVar(16, "Tloss", "Torque loss", "N*m")
addCatVar(16, "Tmmax", "Maximum positive torque", "N*m")
addCatVar(16, "TTmax", "Pullout torque", "N*m")
addCatVar(16, "Ts", "Shaft torque", "N*m")
addCatVar(16, "Va", "Applied voltage", "V")
addCatVar(16, "Vf", "Field voltage", "V")
addCatVar(16, "Vfs", "Field voltage", "V")
addCatVar(16, "Vt", "Terminal voltage", "V")
addCatVar(16, utf8(969).."m", "Mechanical radian frequency", "rad/s")
addCatVar(16, utf8(969).."me", "Electrical radian frequency", "rad/s")
addCatVar(16, utf8(969).."r", "Electrical rotor speed", "rad/s")
addCatVar(16, utf8(969).."s", "Electrical stator speed", "rad/s")
addCatVar(16, "Wf", "Magnetic energy", "J")
addCatVar(16, "XL", "Inductive reactance", utf8(937))


addSubCat(16, 1, "Energy Conversion", "")
addSubCat(16, 2, "DC Generator", "")
addSubCat(16, 3, "Sep. Excited DC Gen.", "")
addSubCat(16, 4, "DC Shunt Generator", "")
addSubCat(16, 5, "DC Series Generator", "")
addSubCat(16, 6, "Sep Excite DC Motor", "")
addSubCat(16, 7, "DC Shunt Motor", "")
addSubCat(16, 8, "DC Series Motor", "")
addSubCat(16, 9, "Perm Magnet Motor", "")
addSubCat(16, 10, "Induction Motor I", "")
addSubCat(16, 11, "Induction Motor II", "")
addSubCat(16, 12, "1 f Induction Motor", "")
addSubCat(16, 13, "Synchronous Machines", "")
