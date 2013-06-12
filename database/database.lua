--@@  database.lua
--@@  LGLP 3 License
--@@  alex3yoyo

-- Almost all formulas are from the IB Physics HL Data Booklet, which contains the fundamental equations needed throughout the course. It does not contain every physics equation know to man, nor is every Data Booklet equation included in this database.


--addCat(ct.t1, "Physics and physical measurement", "IB Topic 1. ￼Note: All equations relate to the magnitude of the quantities only. Vector notation has not been used.")


addCat(ct.mo, "Mechanics", "IB topic 2. Perform motion-related calculations")

addCatVar(ct.mo, "u",   "Intial velocity", "m/s")
addCatVar(ct.mo, "v",   "Final velocity", "m/s")
addCatVar(ct.mo, s.dv,  "Change in velocity", "m/s")
addCatVar(ct.mo, "s",   "Displacement", "m")
addCatVar(ct.mo, "t",   "Final time", "s")
addCatVar(ct.mo, "t0",  "Initial time", "s")
addCatVar(ct.mo, s.dt,  "Change in time", "s")
addCatVar(ct.mo, "a",   "Accleration", s.ms2)
addCatVar(ct.mo, "F",   "Force", "N")
addCatVar(ct.mo, "m",   "Mass", "kg")
addCatVar(ct.mo, "W",   "Work", "J")
addCatVar(ct.mo, "P",   "Power", "W")
addCatVar(ct.mo, s.dh,  "Change in height", "m")
addCatVar(ct.mo, "imp", "Impulse", s.ns)
addCatVar(ct.mo, "pm",  "Final momentum", s.ns)
addCatVar(ct.mo, "pm0", "Initial momentum", s.ns)
addCatVar(ct.mo, s.dpm, "Change in momentum", s.ns)
addCatVar(ct.mo, "Epg", "gravitational potential energy", "J")
addCatVar(ct.mo, "Ek",  "Kinetic energy (translational)", "J")
addCatVar(ct.mo, "TME", "Total mechanical energy", "J")
addCatVar(ct.mo, g.th[2],  "Angle", s.dg)
addCatVar(ct.mo, "Tp",  "Period", "s")
addCatVar(ct.mo, "c",   "Circumference", "m")
addCatVar(ct.mo, "r",   "Radius", "m")
addCatVar(ct.mo, "ca",  "Centripital acceleration", "m/s"..s.sp2)
addCatVar(ct.mo, "cF",  "Centripital force", "N")
addCatVar(ct.mo, "cv",  "Centripital velocity", "m/s")

addSubCat(ct.mo, 1, "Kinematics", "")
aF(ct.mo, 1, "s=((u+v)/2)*"..s.dt, U("s", "u", "v", s.dt) )
aF(ct.mo, 1, "s=u*"..s.dt.."+(1/2)*a*"..s.dt.."^(2)", U("s", "u", s.dt, "a") )
aF(ct.mo, 1, "v^(2)=u^(2)+2*a*s", U("v", "u", "a", "s") )
aF(ct.mo, 1, "v=u+a*"..s.dt, U("v", "u", "a", s.dt) )
aF(ct.mo, 1, s.dt.."=t-t0", U(s.dt, "t", "t0") )
aF(ct.mo, 1, s.dv.."=v-u", U(s.dv, "v", "u") )

addSubCat(ct.mo, 2, "Force", "")
aF(ct.mo, 2, "F=m*a", U("F", "m", "a") )

addSubCat(ct.mo, 3, "Impulse (WIP)", "") -- Very confusing
aF(ct.mo, 3, "F*t=m*"..s.dv, U("F", "t", "m", s.dv) ) -- impulse-momentum change equation
aF(ct.mo, 3, s.dv.."=v-u", U(s.dv, "v", "u") ) -- change in velocity
aF(ct.mo, 3, "pm0=m*u", U("pm0", "m", "u") ) -- initial momentum
aF(ct.mo, 3, "pm=m*v", U("pm", "m", "v") ) -- final momentum
aF(ct.mo, 3, "imp=pm-pm0", U("imp", "pm", "pm0") ) -- change in momentum
aF(ct.mo, 3, "imp=F*t", U("imp", "F", "t") ) -- impulse
aF(ct.mo, 3, "imp=m*"..s.dv, U("imp", "m", s.dv) ) -- delta-momentum
aF(ct.mo, 3, "F=m*a", U("F", "m", "a") ) -- force
--aF(ct.mo, 3, "pm=m*v-m*u", U("pm", "m", "v", "u") )

addSubCat(ct.mo, 4, "Work", "")
aF(ct.mo, 4, "W=F*s*cos("..g.th[2]..")", U("W", "F", g.th[2], "s") )
aF(ct.mo, 4, "W=(1/2)*m*(v^(2)-u^(2))", U("W", "m", "v", "u") )
aF(ct.mo, 4, "F=m*a", U("F", "m", "a") )
aF(ct.mo, 4, s.dv.."=v-u", U(s.dv, "v", "u") )

addSubCat(ct.mo, 5, "Energy", "")
aF(ct.mo, 5, "Ek=(1/2)*m*v^2", U("Ek", "m", "v") ) -- kinetic energy
aF(ct.mo, 5, "Ek=pm^2/(2*m)", U("Ek", "pm", "m") ) -- kinetic energy
aF(ct.mo, 5, "Epg=m*"..s.dh.."*("..con("g")..")", U("Epg", "m", s.dh) ) -- gravity potential energy
aF(ct.mo, 5, "TME=Ek+Epg", U("TME", "Ek", "Epg") ) -- total mechanical energy

addSubCat(ct.mo, 6, "Power", "")
aF(ct.mo, 6, "P=W/"..s.dt, U("P", "W", s.dt) ) -- power (work/time)
aF(ct.mo, 6, "P=F*(s/"..s.dt, U("P", "F", "s", s.dt) ) -- power (force*(displacement/time))
aF(ct.mo, 6, "W=F*v", U("W", "F", "v") ) -- work
aF(ct.mo, 6, "F=m*a", U("F", "m", "a") ) -- force
aF(ct.mo, 6, s.dv.."=s/"..s.dt, U(s.dv, "s", s.dt) )

addSubCat(ct.mo, 7, "Centripital", "" )
aF(ct.mo, 7, "cF=(m*cv^2)/r", U("cF", "m", "cv", "r") )
aF(ct.mo, 7, "ca=(4*pi^2*r)/Tp^2", U("ca", "r", "Tp") )
aF(ct.mo, 7, "ca=cv^2/r^2", U("ca", "cv", "r") )
aF(ct.mo, 7, "c=2*pi*r", U("c", "r") )


addCat(ct.th, "Thermal physics", "IB topic 3 & 10. Perform thermal related physics calculations.")

addCatVar(ct.th, "P",   "Pressure", "Pa")
addCatVar(ct.th, "V",   "Volume", "m"..s.sp3)
addCatVar(ct.th, "T",   "Tempturature", "K")
addCatVar(ct.th, "n",   "Amount", "mol")
addCatVar(ct.th, "m",   "Mass", "kg")
addCatVar(ct.th, "amu", "Molecular mass", "amu")
addCatVar(ct.th, "F",   "Force", "N")
addCatVar(ct.th, "A",   "Area", "m"..s.sp2)
addCatVar(ct.th, "Ek",  "Kinetic energy (translational)", "J")
addCatVar(ct.th, "Q",   "Heat", "J")
addCatVar(ct.th, "c",   "Specific heat capacity", "J/kg"..s.bul.."K")
addCatVar(ct.th, "L",   "Latent heat", "nounit")
addCatVar(ct.th, "tK",  "Kelvin", "nounit")
addCatVar(ct.th, "tC",  "Celcius", "nounit")
addCatVar(ct.th, "tF",  "Farhenhiet", "nounit")

addSubCat(ct.th, 1, "Tempurature", "")
aF(ct.th, 1, "tF=(9/5)*tC+32", U("tC", "tF") )
aF(ct.th, 1, "tK=tC+273.15", U("tK", "tC") )

addSubCat(ct.th, 2, "Thermal", "")
aF(ct.th, 2, "P*V=n*("..con("R")..")*T", U("P", "V", "n", "T") )
aF(ct.th, 2, "n=m/amu", U("n", "m", "amu") )
aF(ct.th, 2, "P=F/A", U("P", "F", "A") )
aF(ct.th, 2, "Ek=(3/2)*("..con("k1")..")*T", U("Ek", "T") )

addSubCat(ct.th, 3, "Heat Capacity", "")
aF(ct.th, 3, "Q=c*m*T", U("Q", "c", "m", "T") )
aF(ct.th, 3, "Q=m*L", U("Q", "m", "L") )


addCat(ct.wa, "Oscillations and Waves", "IB Topic 4. Perform wave-related calculations")

addCatVar(ct.wa, "F",       "Force", "N")
addCatVar(ct.wa, "K",       "Spring constant", "N/m")
addCatVar(ct.wa, "x",       "Displacement", "m")
addCatVar(ct.wa, "m",       "Mass", "kg")
addCatVar(ct.wa, "a",       "Acceleration", "m/s"..s.sp2)
addCatVar(ct.wa, "Ep",      "Elastic potential energy", "J")
addCatVar(ct.wa, "T",       "Period", "s")
addCatVar(ct.wa, "fq",      "Frequency", "Hz")
addCatVar(ct.wa, "v",       "Velocity", "m/s")
addCatVar(ct.wa, "v0",      "Velocity", "m/s")
addCatVar(ct.wa, "n",       "Refraction index", "nounit")
addCatVar(ct.wa, "n0",      "Refraction index", "nounit")
addCatVar(ct.wa, g.th[2],   "Angle", s.dg)
addCatVar(ct.wa, s.th0,     "Angle", s.dg)
addCatVar(ct.wa, g.la[2],   "Wavelength", "m")
addCatVar(ct.wa, s.la0,     "Wavelength", "m")

addSubCat(ct.wa, 1, "Waves", "")
aF(ct.wa, 1, "F=m*a", U("F", "m", "a") ) -- force
aF(ct.wa, 1, "F=-K*x", U("F", "K", "x") ) -- force (spring_constant * displacement)
aF(ct.wa, 1, "Ep=0.5*K*(x)^2", U("Ep", "K") )
aF(ct.wa, 1, "a=(-K/m)*x", U("a", "K", "m", "x") )
aF(ct.wa, 1, "T=2*pi*sqrt(m/K)", U("T", "m", "K") )
aF(ct.wa, 1, "v="..g.la[2].."/T", U("v", g.la[2], "T") )
aF(ct.wa, 1, "v=fq*"..g.la[2], U("v", "fq", g.la[2]) )

addSubCat(ct.wa, 2, "Reflections & Refractions", "")
aF(ct.wa, 2, "n/n0=sin("..s.th0..")/sin("..g.th[2]..")=v0/v", U("n", "n0", s.th0, g.th[2], "v0", "v") )
aF(ct.wa, 2, "n=("..con("C")..")/v", U("n", "v") )
aF(ct.wa, 2, "n0=("..con("C")..")/v0", U("n0", "v0") )
aF(ct.wa, 2, "v=fq*"..g.la[2], U("v", "fq", g.la[2] ) )
aF(ct.wa, 2, "v0=fq*"..s.la0, U("v0", "fq", s.la0 ) )
--aF(ct.wa, 2, "v/"..g.la[2].."=v0/"..s.la0, U("v", "v0", g.la[2], s.la0) )

-- addSubCat(ct.wa, 3, "Wave phenomena", "")

-- addSubCat(ct.wa, 4, "Sight and wave phenomena", "")


addCat(ct.ec, "Electric Curents", "IB Topic 5 & 12.")

addCatVar(ct.ec, "q",       "Charge",       "C")
addCatVar(ct.ec, "t",       "Time",         "s")
addCatVar(ct.ec, "I",       "Current",      "A")
addCatVar(ct.ec, "R",       "Resistence",       g.om[1])
addCatVar(ct.ec, "V",       "Voltage",          "V")
addCatVar(ct.ec, "P",       "Power",            "W")
addCatVar(ct.ec, g.rh[2],   "Resistivity",      s.Omm)
addCatVar(ct.ec, "A",       "Cross-sectional area", "m"..s.sp2)
addCatVar(ct.ec, "L",       "Length",           "m")
addCatVar(ct.ec, "Ve",      "Energy",           "J")
addCatVar(ct.ec, "m",       "Mass",             "kg")
addCatVar(ct.ec, "vel",     "Velocity",         "m/s")
addCatVar(ct.ec, "r",       "Radius of wire",   "m")
addCatVar(ct.ec, "d",       "Diameter of wire", "m")
-- addCatVar(ct.ec, g.ph[1], "", "")
-- addCatVar(ct.ec, "B", "", "")
-- addCatVar(ct.ec, g.th[2], "Angle", s.dg)
-- addCatVar(ct.ec, "N", "", "")
-- addCatVar(ct.ec, s.dep, "Change in", "")
-- addCatVar(ct.ec, s.dr, "", "")

addSubCat(ct.ec, 1, "Electrostatic", "")
aF(ct.ec, 1, "Ve=0.5*m*vel^2", U( "Ve", "m", "vel") )

addSubCat(ct.ec, 2, "Electricity", "")
aF(ct.ec, 2, "I=q/t", U("I", "q", "t") )
aF(ct.ec, 2, "R=V/I", U("R", "V", "I") )
aF(ct.ec, 2, "P=V*I", U("P", "V", "I") )
aF(ct.ec, 2, "P=I^2*R", U("P", "I", "R") )
aF(ct.ec, 2, "P=V^2/R", U("P", "V", "R") )
aF(ct.ec, 2, "R=("..g.rh[2].."*L)/A", U("R", g.rh[2], "L", "A") )
aF(ct.ec, 2, "A=pi*r^2", U("A", "r") )
aF(ct.ec, 2, "r=d/2", U("r", "d") )

-- addSubCat(ct.ec, 3, "Electromagnetic Induction", "")
-- aF(ct.ec, 3, g.ph[1].."=B*A*cos("..g.th[2]..")", U(g.ph[1], "B", "A", g.th[2]) )
-- aF(ct.ec, 3, g.ep[2].."=B*vel*l", U(g.ep[2], "B", "vel", "l") )
-- aF(ct.ec, 3, g.ep[2].."-N*("..s.dep.."/"..s.dt..")", U(g.ep[2], "N", s.dep, s.dt) )


addCat(ct.fo, "Forces and Fields", "IB topic 6. Includes electrosatic, gravitational, and magnetic fields")

addCatVar(ct.fo, "F",   "Force", "N")
addCatVar(ct.fo, "m1",  "Mass 1", "kg")
addCatVar(ct.fo, "m2",  "Mass 2", "kg")
addCatVar(ct.fo, "r",   "Distance", "m")
addCatVar(ct.fo, "q",   "Charge", "C")
addCatVar(ct.fo, "q1",  "Charge 1", "C")
addCatVar(ct.fo, "q2",  "Charge 2", "C")
addCatVar(ct.fo, "v",   "Velocity", "m/s")
addCatVar(ct.fo, g.th[2],  "Angle", s.dg)
addCatVar(ct.fo, "B",   "Teslas", "T")
addCatVar(ct.fo, "L",   "Length", "m")
addCatVar(ct.fo, "I",   "Current", "A")
-- addCatVar(ct.fo, "g", "?", "")
-- addCatVar(ct.fo, "E", "?", "")
-- addCatVar(ct.fo, "m", "Mass", "kg")

addSubCat(ct.fo, 1, "Gravitational", "Gravitational fields")
aF(ct.fo, 1, "F=("..con("G")..")*((m1*m2)/r^2)", U("F", "m1", "m2", "r") )
-- aF(ct.fo, 1, "g=F/m", U("g", "F", "m") )

addSubCat(ct.fo, 2, "Electrostatic", "Electrostatic fields")
aF(ct.fo, 2, "F=("..con("k2")..")*((q1*q2)/r^2)", U("F", "q1", "q2", "r") )
-- aF(ct.fo, 1, "E=F/q", U("E", "F", "q") )

addSubCat(ct.fo, 3, "Magnetic", "Magnetic fields")
aF(ct.fo, 3, "F=(q1*q2)/(4*pi*"..con(s.ep0).."*r^2)", U("F", "q1", "q2", "r") )
aF(ct.fo, 3, "F=q*v*B*sin("..g.th[2]..")", U("F", "q", "v", "B", g.th[2]) )
aF(ct.fo, 3, "F=B*I*L*sin("..g.th[2]..")", U("F", "B", "I", "L", g.th[2]) )

-- addSubCat(ct.fo, 4, "Motion in fields", "")

addCat(ct.nu, "Topic 7", "Atomic & nuclear physics")

addCatVar(ct.nu, "E",       "Energy", "J")
addCatVar(ct.nu, "m",       "Mass", "kg")
addCatVar(ct.nu, "hl",      "Half-life", "s")
addCatVar(ct.nu, "N",       "Present nuclei", "nuclei")
addCatVar(ct.nu, "N0",      "Inintial nuclei", "nuclei")
addCatVar(ct.nu, s.dn,      "Decayed nuclei", "nuclei")
addCatVar(ct.nu, "A",       "Decay rate", "Bq")
addCatVar(ct.nu, "t",       "Time", "s")
addCatVar(ct.nu, s.dt,      "Change in time", "s")
addCatVar(ct.nu, g.la[2],   "Decay constant", "nounit")
-- addCatVar(ct.nu, "h",       "", "") -- What is h?
-- addCatVar(ct.nu, "f",       "Frequency", "Hz")

addSubCat(ct.nu, 1, "Mass-Energy", "")
aF(ct.nu, 1, "E=m*("..con("C")..")^2", U("E", "m") )

addSubCat(ct.nu, 2, "Nuclear Decay", "")
aF(ct.nu, 2, s.dn.."=(-"..g.la[2]..")*N*"..s.dt, U(s.dn, g.la[2], "N", s.dt) )
aF(ct.nu, 2, "A=abs("..s.dn.."/"..s.dt..")", U("A", s.dn, s.dt) )
aF(ct.nu, 2, "A="..g.la[2].."*N", U("A", g.la[2], "N") )
aF(ct.nu, 2, "N=N0*exp(-("..g.la[2]..")*t)", U("N", "N0", g.la[2], "t") )
aF(ct.nu, 2, "hl=ln(2)/"..g.la[2], U("hl", g.la[2]) )
-- aF(ct.nu, 2, "E=h*f", U("E", "h", "f") )


addCat(ct.en, "Topic 8", "Energy, power, and climate change")

addCatVar(ct.en, "P",       "Power", "J")
addCatVar(ct.en, g.rh[2],   "Density", s.kgm3)
addCatVar(ct.en, "A",       "Area", s.m2)
addCatVar(ct.en, "r",       "Radius", "m")
addCatVar(ct.en, "h",       "Height", "m")
addCatVar(ct.en, "v",       "Velocity", "m/s")
addCatVar(ct.en, "ti",      "Time", "s")
addCatVar(ct.en, g.la[2],   "Wavelength", "m")
addCatVar(ct.en, "f",       "Frequency", "Hz")
addCatVar(ct.en, "T",       "Tempurature", "K")
addCatVar(ct.en, s.dvl,     "Change in volume", s.m3)
addCatVar(ct.en, "V0",      "Initial volume", s.m3)
addCatVar(ct.en, g.be[1],   "/K", "nounit")
addCatVar(ct.en, "Q",       "Heat", "J")
addCatVar(ct.en, "c",       "Specific heat capacity", "J/kg"..s.bul.."K")
addCatVar(ct.en, "L",       "Latent heat", "nounit")
addCatVar(ct.en, "m",       "Mass", "kg")
addCatVar(ct.en, "Pm2",     "Power/meter2", "W") -- For BBR

addSubCat(ct.en, 1, "Wind", "")
aF(ct.en, 1, "P=(1/2)*"..g.rh[2].."*A*v^3", U("P", g.rh[2], "A", "v") )
aF(ct.en, 1, "A=pi*r^2", U("A", "r") )

addSubCat(ct.en, 2, "Hydroelectric", "")
aF(ct.en, 2, "P="..g.rh[2].."*"..con("+g").."*h*(v/ti)", U("P", g.rh[2], "h", "v", "ti") )

addSubCat(ct.en, 3, "Tidal", "")
aF(ct.en, 3, "P=(1/2)*"..g.rh[2].."*"..con("+g").."*A^2*v", U("P", g.rh[2], "A", "v") )
aF(ct.en, 3, "v="..g.la[2].."*f", U("v", g.la[2], "f") )

addSubCat(ct.en, 4, "Solar", "")
-- aF(ct.en, 4, "", U("") )

addSubCat(ct.en, 5, "Black-Body Radiation", "") -- "BBR"
aF(ct.en, 5, "Pm2="..con(g.si[2]).."*T^4", U("Pm2", "T") )
aF(ct.en, 5, "P="..con(g.si[2]).."*A*T^4", U("P", "A", "T") )
aF(ct.en, 5, g.la[2].."=(2.90*10^-3)/T", U(g.la[2], "T") )
--aF(ct.en, 5, "P=e*"..con(s.si).."*A*T^4", U("P", "A", "T") )

addSubCat(ct.en, 6, "Volume Expansion", "")
aF(ct.en, 6, s.dvl.."="..g.be[1].."*V0*"..s.dtt, U(s.dvl, g.be[1], "V0", s.dtt) )
aF(ct.en, 6, "Q=c*m*T", U("Q", "c", "m", "T") )
aF(ct.en, 6, "Q=m*L", U("Q", "m", "L") )
--aF(ct.en, 6, "C=(Q)/(A*ti)", U("C", "Q", "A", "ti") )


addCat(ct.ch, "Chemestry", "Chemistry related things that have some connection to physics")

addCatVar(ct.ch, "atom",    "Atomic number",        "nounit")
addCatVar(ct.ch, "mass",    "Mass",                 "amu")
addCatVar(ct.ch, "dens",    "Density",              s.kgm3)
addCatVar(ct.ch, "c",       "Specific heat",        "J/kg*K")
addCatVar(ct.ch, "melt",    "Melting point",        "K")
addCatVar(ct.ch, "boil",    "Boiling point",        "K")
addCatVar(ct.ch, "h_fus",   "Heat of fusion",       "kJ/mol")
addCatVar(ct.ch, "h_vap",   "Heat of vaporization", "kJ/mol")
-- addCatVar(ct.ch, "sym",     "Symbol", "nounit")

addSubCat(ct.ch, 1, "Basic Properties", "")
aF(ct.ch, 1, "mass=ch.mass[atom]",      U( "mass", "atom")  )
aF(ct.ch, 1, "dens=ch.dens[atom]",      U( "dens", "atom")  )
aF(ct.ch, 1, "c=ch.c[atom]",            U( "c", "atom")     )
aF(ct.ch, 1, "melt=ch.melt[atom]",      U( "melt", "atom")  )
aF(ct.ch, 1, "boil=ch.boil[atom]",      U( "boil", "atom")  )
aF(ct.ch, 1, "h_fus=ch.h_fus[atom]",    U( "h_fus", "atom") )
aF(ct.ch, 1, "h_vap=ch.h_vap[atom]",    U( "h_vap", "atom") )
-- aF(ct.ch, 1, "sym=ch.sym[atom]", U( "sym", "atom") )
