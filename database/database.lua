--@@  database.lua
--@@  LGLP 3 License
--@@  alex3yoyo

-- Almost all formulas are from the IB Physics HL Data Booklet, which contains the fundamental equations needed throughout the course. It does not contain every physics equation know to man, nor is every Data Booklet equation included in this database.

addCat(ct.mo, "Mechanics", "IB topic 2. Perform motion-related calculations")

addCatVar(ct.mo, "u",   "Intial velocity", "m/s")
addCatVar(ct.mo, "v",   "Final velocity", "m/s")
addCatVar(ct.mo, s.dv,  "Change in velocity", "m/s")
addCatVar(ct.mo, "s",   "Displacement", "m")
addCatVar(ct.mo, "t",   "Final time", "s")
addCatVar(ct.mo, "t0",  "Initial time", "s")
addCatVar(ct.mo, s.dt,  "Change in time", "s")
addCatVar(ct.mo, "a",   "Accleration", "m/s"..s.s2)
addCatVar(ct.mo, "F",   "Force", "N")
addCatVar(ct.mo, "m",   "Mass", "kg")
addCatVar(ct.mo, "W",   "Work", "J")
addCatVar(ct.mo, "P",   "Power", "W")
addCatVar(ct.mo, s.dh,  "Change in height", "m")
addCatVar(ct.mo, "imp", "Impulse", "N"..s.bul.."s")
addCatVar(ct.mo, "pm",  "Final momentum", "N"..s.bul.."s")
addCatVar(ct.mo, "pm0", "Initial momentum", "N"..s.bul.."s")
addCatVar(ct.mo, s.dpm, "Change in momentum", "N"..s.bul.."s")
addCatVar(ct.mo, "Epg", "gravitational potential energy", "J")
addCatVar(ct.mo, "Ek",  "Kinetic energy (translational)", "J")
addCatVar(ct.mo, "TME", "Total mechanical energy", "J")
addCatVar(ct.mo, s.th,  "Angle", s.dg)
addCatVar(ct.mo, "Tp",  "Period", "s")
addCatVar(ct.mo, "c",   "Circumference", "m")
addCatVar(ct.mo, "r",   "Radius", "m")
addCatVar(ct.mo, "ca",  "Centripital acceleration", "m/s"..s.s2)
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

addCat(ct.th, "Thermal physics", "IB topic 3 & 10. Perform thermal related physics calculations.")

addCatVar(ct.th, "P",   "Pressure", "Pa")
addCatVar(ct.th, "V",   "Volume", "m"..s.s3)
addCatVar(ct.th, "T",   "Tempturature", "K")
addCatVar(ct.th, "n",   "Amount", "mol")
addCatVar(ct.th, "m",   "Mass", "kg")
addCatVar(ct.th, "amu", "Molecular mass", "amu")
addCatVar(ct.th, "F",   "Force", "N")
addCatVar(ct.th, "A",   "Area", "m"..s.s2)
addCatVar(ct.th, "Ek",  "Kinetic energy (translational)", "J")
addCatVar(ct.th, "Q",   "Heat", "J")
addCatVar(ct.th, "c",   "Specific heat capacity", "J/kg"..s.bul.."K")
addCatVar(ct.th, "L",   "Latent heat", "nounit")
addCatVar(ct.th, "tK",  "Kelvin", "nounit")
addCatVar(ct.th, "tC",  "Celcius", "nounit")
addCatVar(ct.th, "tF",  "Farhenhiet", "nounit")

addSubCat(ct.th, 1, "Tempurature", "Convert between the different tempurature scales")
aF(ct.th, 1, "tF=(9/5)*tC+32", U("tC", "tF") )
aF(ct.th, 1, "tK=tC+273.15", U("tK", "tC") )

addSubCat(ct.th, 2, "Thermal", "Solve for P, V, T, n, m, amu")
aF(ct.th, 2, "P*V=n*("..con("R")..")*T", U("P", "V", "n", "T") )
aF(ct.th, 2, "n=m/amu", U("n", "m", "amu") )
aF(ct.th, 2, "P=F/A", U("P", "F", "A") )
aF(ct.th, 2, "Ek=(3/2)*("..con("k1")..")*T", U("Ek", "T") )

addSubCat(ct.th, 3, "Heat Capacity", "Solve for Q, T, m, c, L")
aF(ct.th, 3, "Q=c*m*T", U("Q", "c", "m", "T") )
aF(ct.th, 3, "Q=m*L", U("Q", "m", "L") )

addCat(ct.wa, "Oscillations & Waves", "IB Topic 4. Perform wave-related calculations")

addCatVar(ct.wa, "F",   "Force", "N")
addCatVar(ct.wa, "K",   "Spring constant", "N/m")
addCatVar(ct.wa, "x",   "Displacement", "m")
addCatVar(ct.wa, "m",   "Mass", "kg")
addCatVar(ct.wa, "a",   "Acceleration", "m/s"..s.s2)
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
aF(ct.wa, 1, "F=-K*x", U("F", "K", "x") ) -- force (spring_constant * displacement)
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

addCat(ct.ec, "Electric Curents", "IB Topic 5 & 12.")

addCatVar(ct.ec, "q",   "Charge", "C")
addCatVar(ct.ec, "t",   "Time", "s")
addCatVar(ct.ec, "I",   "Current", "A")
addCatVar(ct.ec, "R",   "Resistence", s.om)
addCatVar(ct.ec, "V",   "Voltage", "V")
addCatVar(ct.ec, "P",   "Power", "W")
addCatVar(ct.ec, s.rh,  "Resistivity", s.omm)
addCatVar(ct.ec, "A",   "Cross-sectional area", "m"..s.s2)
addCatVar(ct.ec, "L",   "Length", "m")
--addCatVar(ct.ec, "Ve",  "Energy", "J")
--addCatVar(ct.ec, "m",   "Mass", "kg")
--addCatVar(ct.ec, "v",   "Velocity", "m/s")

addSubCat(ct.ec, 1, "Electrostatic", "Solve for")
--aF(ct.ec, 1, "Ve=0.5*m*v^2", U( "Ve", "m", "v") )

addSubCat(ct.ec, 2, "Electricity", "Solve for I, q, t, V, R, P, "..s.rh)
aF(ct.ec, 2, "I=q/t", U("I", "q", "t") )
aF(ct.ec, 2, "R=V/I", U("R", "V", "I") )
aF(ct.ec, 2, "R=("..s.rh.."*L)/A", U("R", s.rh, "L", "A") )
aF(ct.ec, 2, "P=V*I", U("P", "V", "I") )
aF(ct.ec, 2, "P=I^2*R", U("P", "I", "R") )
aF(ct.ec, 2, "P=V^2/R", U("P", "V", "R") )

addSubCat(ct.ec, 3, "Electromagnetic Induction", "Solve for I, V, N, R, P, B, A, "..s.th)

addCat(ct.fo, "Forces and Fields", "IB topic 6. Includes electrosatic, gravitational, and magnetic fields")

addCatVar(ct.fo, "F", "Force", "N")
--addCatVar(ct.fo, "m", "Mass", "kg")
addCatVar(ct.fo, "m1", "Mass 1", "kg")
addCatVar(ct.fo, "m2", "Mass 2", "kg")
addCatVar(ct.fo, "r", "Distance", "m")
addCatVar(ct.fo, "q", "Charge", "C")
addCatVar(ct.fo, "q1", "Charge 1", "C")
addCatVar(ct.fo, "q2", "Charge 2", "C")
-- addCatVar(ct.fo, "g", "?", "")
-- addCatVar(ct.fo, "E", "?", "")
addCatVar(ct.fo, "v", "Velocity", "m/s")
addCatVar(ct.fo, s.th, "Angle", s.dg)
addCatVar(ct.fo, "B", "Teslas", "T")
addCatVar(ct.fo, "L", "Length", "m")
addCatVar(ct.fo, "I", "Current", "A")

addSubCat(ct.fo, 1, "Gravitational", "Gravitational fields")
aF(ct.fo, 1, "F=("..con("G")..")*((m1*m2)/r^2)", U("F", "m1", "m2", "r") )
-- aF(ct.fo, 1, "g=F/m", U("g", "F", "m") )

addSubCat(ct.fo, 2, "Electrostatic", "Electrostatic fields")
aF(ct.fo, 2, "F=("..con("k2")..")*((q1*q2)/r^2)", U("F", "q1", "q2", "r") )
-- aF(ct.fo, 1, "E=F/q", U("E", "F", "q") )

addSubCat(ct.fo, 3, "Magnetic", "Magnetic fields")
aF(ct.fo, 3, "F=(q1*q2)/(4*pi*"..con(g.ep[2].."0").."*r^2)", U("F", "q1", "q2", "r") )
aF(ct.fo, 3, "F=q*v*B*sin("..s.th..")", U("F", "q", "v", "B", s.th) )
aF(ct.fo, 3, "F=B*I*L*sin("..s.th..")", U("F", "B", "I", "L", s.th) )

addCat(ct.ch, "Chemestry", "Chemistry related things that have some connection to physics")

addCatVar(ct.ch, "atom",    "Atomic number", "nounit")
addCatVar(ct.ch, "mass",    "Mass", "amu")
addCatVar(ct.ch, "dens",    "Density", "kg/m"..s.s3)
addCatVar(ct.ch, "c",       "Specific heat", "J/kg*K")
addCatVar(ct.ch, "melt",    "Melting point", "K")
addCatVar(ct.ch, "boil",    "Boiling point", "K")
addCatVar(ct.ch, "h_fus",   "Heat of fusion", "kJ/mol")
addCatVar(ct.ch, "h_vap",   "Heat of vaporization", "kJ/mol")
-- addCatVar(ct.ch, "name",    "Name", "nounit")
-- addCatVar(ct.ch, "sym",     "Symbol", "nounit")
-- addCatVar(ct.ch, "type",    "Type", "nounit")
-- addCatVar(ct.ch, "state",   "State at 273K", "nounit")
-- addCatVar(ct.ch, "group",   "Group", "nounit")
-- addCatVar(ct.ch, "period",  "Period", "nounit")
-- addCatVar(ct.ch, "e_conf",  "Electron configuration", "nounit")
-- addCatVar(ct.ch, "v_elec",  "Valence electrons", "nounit")
-- addCatVar(ct.ch, "i_eng",   "1st ionization energy", "kJ/mol")
-- addCatVar(ct.ch, "e_neg",   "Electronegativity", "nounit")
-- addCatVar(ct.ch, "e_aff",   "Electron affinity", "nounit")
-- addCatVar(ct.ch, "a_rad",   "Atomic radius", "pm")
-- addCatVar(ct.ch, "c_rad",   "Covalent radius", "pm")
-- addCatVar(ct.ch, "t_cond",  "Thermal conductivity", "W/mK")
-- addCatVar(ct.ch, "e_cond",  "Electrical conductivity", "MS/m")

addSubCat(ct.ch, 1, "Basic Properties", "Obtain information relating to the periodic elements")
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
