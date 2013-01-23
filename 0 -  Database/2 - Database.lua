--------------------------------------------------------
--                      Database                      --
--------------------------------------------------------

-- Set the position of each section
ct = {}
ct.mo = 1 -- Mechanics
ct.th = 2 -- Thermal physics
ct.wa = 3 -- Oscillations & Waves
ct.ch = 4 -- Chemistry
ct.ex = 5 -- External Database

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

addCatVar(ct.mo, "u", "Intial velocity", "m/s")
addCatVar(ct.mo, "v", "Final velocity", "m/s")
addCatVar(ct.mo, "dv", "Change in velocity", "m/s")
addCatVar(ct.mo, "s", "Displacement", "m")
addCatVar(ct.mo, "t", "Time", "s")
addCatVar(ct.mo, "a", "Accleration", "m/s2")
addCatVar(ct.mo, "F", "Force", "N")
addCatVar(ct.mo, "m", "Mass", "kg")
addCatVar(ct.mo, "W", "Work", "J")
addCatVar(ct.mo, "P", "Power", "W")
addCatVar(ct.mo, "h", "Height", "m")
addCatVar(ct.mo, "Imp", "Impulse", "N*s")
addCatVar(ct.mo, "pm", "Momentum", "N*s")
addCatVar(ct.mo, "Ep", "Gravity PE", "J")
addCatVar(ct.mo, "Ek", "Kinetic energy", "J")
addCatVar(ct.mo, "E", "Total energy", "J")
addCatVar(ct.mo, s.th, "Angle (Degrees)", s.dg)
addCatVar(ct.mo, "Tp", "Period", "s")
addCatVar(ct.mo, "c", "Circumference", "m")
addCatVar(ct.mo, "r", "Radius", "m")
addCatVar(ct.mo, "ca", "Centripital acceleration", "m/s2")
addCatVar(ct.mo, "cF", "Centripital force", "N")
addCatVar(ct.mo, "cv", "Centripital velocity", "m/s")
addCatVar(ct.mo, "gF", "Gravitational Force", "N")

addSubCat(ct.mo, 1, "Kinematics", "Solve for: u, v, s, t, a")
aF(ct.mo, 1, "s=((u+v)/2)*t", U("s", "u", "v", "t") )
aF(ct.mo, 1, "s=u*t+(1/2)*a*t^(2)", U("s", "u", "t", "a") )
aF(ct.mo, 1, "v^(2)=u^(2)+2*a*s", U("v", "u", "a", "s") )
aF(ct.mo, 1, "v=u+a*t", U("v", "u", "a", "t") )

addSubCat(ct.mo, 2, "Force", "Solve for F, gF, m, a")
aF(ct.mo, 2, "F=m*a", U("F", "m", "a")  )
aF(ct.mo, 2, "gF=m*("..con("g")..")", U("gF", "m") )

addSubCat(ct.mo, 3, "Impulse", "Solve for: pm, imp, F, t, m, v, u, ")
aF(ct.mo, 3, "imp=F*t", U("imp", "F", "t") )
aF(ct.mo, 3, "imp=m*t", U("imp", "m", "t") )
aF(ct.mo, 3, "pm=m*v", U("pm", "m", "v") )
aF(ct.mo, 3, "F=pm/t", U("F", "pm", "t") )
aF(ct.mo, 3, "F*t=m*"..s.dv, U("F", "t", "m", s.dv) )
aF(ct.mo, 3, s.dv.."=v-u", U(s.dv, "v", "u") )
aF(ct.mo, 3, "F*t=m*v-m*u", U("F", "t", "m", "v", "u") )
aF(ct.mo, 3, "pm=m*v-m*u", U("pm", "m", "v", "u") )

addSubCat(ct.mo, 4, "Work", "Solve for: W, F, s, m, a, "..s.th)
aF(ct.mo, 4, "W=F*s*cos("..s.th..")", U("W", "F", s.th, "s") )
aF(ct.mo, 4, "W=(m*a)*cos("..s.th..")*s", U("W", "m", "a", s.th, "s") )
aF(ct.mo, 4, "F=m*a", U("F", "m", "a") )
aF(ct.mo, 4, "W=(1/2)*m*(v^(2)-u^(2))", U("W", "m", "v", "u") )

addSubCat(ct.mo, 5, "Power", "Solve for: P, W, t, F, m, a, s, "..s.th)
aF(ct.mo, 5, "P=W/t", U("P", "W", "t") )
aF(ct.mo, 5, "P=F*v*cos("..s.th..")", U("P", "F", "v", s.th) )
aF(ct.mo, 5, "P=F*cos("..s.th..")*(s/t)", U("P", "F", s.th, "s", "t") )
aF(ct.mo, 5, "W=F*s*cos("..s.th..")", U("W", "F", "s", s.th) )
aF(ct.mo, 5, "F=m*a", U("F", "m", "a") )

addSubCat(ct.mo, 6, "Energy", "Solve for: Ek, Ep, E, m, v, h, g")
aF(ct.mo, 6, "Ek=(1/2)*m*v^(2)", U("Ek", "m", "v") )
aF(ct.mo, 6, "Ek=p^(2)/(2*m)", U("Ek", "p", "m") )
aF(ct.mo, 6, "Ep=m*h*("..con("g")..")", U("Ep", "m", "h") )
aF(ct.mo, 6, "E=Ek+Ep", U("E", "Ek", "Ep") )

addSubCat(ct.mo, 7, "Centripital", "Solve for F, a, v, r, Tp (period), m, c" )
aF(ct.mo, 7, "cF=(m*cv^2)/r", U("cF", "m", "cv", "r") )
aF(ct.mo, 7, "ca=(4*pi^2*r)/Tp^2", U("ca", "r", "Tp") )
aF(ct.mo, 7, "ca=cv^2/r^2", U("ca", "cv", "r") )
aF(ct.mo, 7, "c=2*pi*r", U("c", "r") )

addCat(ct.th, "Thermal physics", "IB topic 3 & 10. Perform thermal related physics calculations")

addCatVar(ct.th, "P", "Pressure", "Pa")
addCatVar(ct.th, "V", "Volume", "m3")
addCatVar(ct.th, "T", "Tempturature", "K")
addCatVar(ct.th, "n", "Amount", "mol")
addCatVar(ct.th, "m", "Mass", "kg")
addCatVar(ct.th, "amu", "Molecular mass", "amu")
addCatVar(ct.th, "tK", "Kelvin", "nounit")
addCatVar(ct.th, "tC", "Celcius", "nounit")
addCatVar(ct.th, "tF", "Farhenhiet", "nounit")
addCatVar(ct.th, "F", "Force", "N")
addCatVar(ct.th, "A", "Area", "m2")
addCatVar(ct.th, "Ek", "Kinetic energy", "J")
addCatVar(ct.th, "Q", "Heat", "J")
addCatVar(ct.th, "c", "Specific heat capacity", "J/kg*K")
addCatVar(ct.th, "L", "Latent heat", "nounit")
--addCatVar(ct.th, "Ep", "Potential energy", "J")

addSubCat(ct.th, 1, "Tempurature", "Convert between the different tempurature scales")
aF(ct.th, 1, "tF=(9/5)*tC+32", U("tC", "tF") )
aF(ct.th, 1, "tK=tC+273.15", U("tK", "tC") )

addSubCat(ct.th, 2, "Thermal", "Solve for P, V, T, n, m, amu")
aF(ct.th, 2, "P*V=n*("..con("R")..")*T", U("P", "V", "n", "T") )
aF(ct.th, 2, "n=m/amu", U("n", "m", "amu") )
aF(ct.th, 2, "P=F/A", U("P", "F", "A") )

addSubCat(ct.th, 3, "Energy", "Solve for Ek, Ep T, m, h")
aF(ct.th, 3, "Ek=(3/2)*("..con("k1")..")*T", U("Ek", "T") )
--aF(ct.th, 3, "Ep=m*h*("..con("g")..")", U("Ep", "m", "h") )

addSubCat(ct.th, 4, "Capacity", "Solve for Q, T, m, c, L")
aF(ct.th, 4, "Q=c*m*T", U("Q", "c", "m", "T") )
aF(ct.th, 4, "Q=m*L", U("Q", "m", "L") )

addCat(ct.wa, "Oscillations & Waves", "IB Topic 4. Waves related things") --[[ W.I.P. ]]--

addCatVar(ct.wa, "F", "Force", "N")
addCatVar(ct.wa, "K", "Spring constant", "N/m")
addCatVar(ct.wa, "x", "Displacement", "m")
addCatVar(ct.wa, "m", "Mass", "kg")
addCatVar(ct.wa, "a", "Acceleration", "m/s2")
addCatVar(ct.wa, "Ep", "Elastic potential energy", "J")
addCatVar(ct.wa, "T", "Period", "s")
addCatVar(ct.wa, "fq", "Frequency", "Hz")
addCatVar(ct.wa, "v", "Velocity", "m/s")
addCatVar(ct.wa, "v0", "Velocity", "m/s")
--addCatVar(ct.wa, "v1", "Velocity", "m/s")
addCatVar(ct.wa, "n", "Refraction index", "nounit")
addCatVar(ct.wa, "n0", "Refraction index", "nounit")
--addCatVar(ct.wa, "n1", "Refraction index", "nounit")
addCatVar(ct.wa, s.th, "Angle", s.dg)
addCatVar(ct.wa, s.th0, "Angle", s.dg)
--addCatVar(ct.wa, s.th.."1", "Angle", s.dg)
addCatVar(ct.wa, s.la, "Wavelength", "m")
addCatVar(ct.wa, s.la0, "Wavelength", "m")
--addCatVar(ct.wa, s.la.."1", "Wavelength", "nm")

addSubCat(ct.wa, 1, "Waves", "Solve for F, K, m, a, x, Ep")
aF(ct.wa, 1, "F=m*a", U("F", "m", "a") )
aF(ct.wa, 1, "F=-K*x", U("F", "K", "x") )
aF(ct.wa, 1, "Ep=0.5*K*(x)^2", U("Ep", "K") )
aF(ct.wa, 1, "a=(-K/m)*x", U("a", "K", "m", "x") )
aF(ct.wa, 1, "T=2*pi*sqrt(m/K)", U("T", "m", "K") )
aF(ct.wa, 1, "v="..s.la.."/T", U("v", s.la, "T") )
aF(ct.wa, 1, "v=fq*"..s.la, U("v", "fq", s.la) )

addSubCat(ct.wa, 2, "Reflections & Refractions", "Solve for n, v, n0, v0, fq") -- PROBLEMS!!!!!!
aF(ct.wa, 2, "n/n0=sin("..s.th0..")/sin("..s.th..")=v0/v", U("n", "n0", s.th0, s.th, "v0", "v") )
--aF(ct.wa, 2, "v/"..s.la.."=v0/"..s.la0, U("v", "v0", s.la, s.la0) )
aF(ct.wa, 2, "n=("..con("C")..")/v", U("n", "v") )
aF(ct.wa, 2, "n0=("..con("C")..")/v0", U("n0", "v0") )
aF(ct.wa, 1, "v=fq*"..s.la, U("v", "fq", s.la) )
aF(ct.wa, 1, "v0=fq*"..s.la0, U("v0", "fq", s.la0) )

addCat(ct.ch, "Chemestry", "Chemistry related things that have some connection to physics")

--addCatVar(ct.ch, "name", "Name", "nounit")
--addCatVar(ct.ch, "sym", "Symbol", "nounit")
addCatVar(ct.ch, "atom", "Atomic number", "nounit")
addCatVar(ct.ch, "mass", "Mass", "amu")
--addCatVar(ct.ch, "type", "Type", "nounit")
--addCatVar(ct.ch, "state", "State at 273K", "nounit")
--addCatVar(ct.ch, "group", "Group", "nounit")
--addCatVar(ct.ch, "period", "Period", "nounit")
--addCatVar(ct.ch, "e_conf", "Electron configuration", "nounit")
--addCatVar(ct.ch, "v_elec", "Valence electrons", "nounit")
--addCatVar(ct.ch, "i_eng", "1st ionization energy", "kJ/mol")
--addCatVar(ct.ch, "e_neg", "Electronegativity", "nounit")
--addCatVar(ct.ch, "e_aff", "Electron affinity", "nounit")
--addCatVar(ct.ch, "a_rad", "Atomic radius", "pm")
--addCatVar(ct.ch, "c_rad", "Covalent radius", "pm")
addCatVar(ct.ch, "dens", "Density", "kg/m3")
addCatVar(ct.ch, "c", "Specific heat", "J/kg*K")
addCatVar(ct.ch, "melt", "Melting point", "K")
addCatVar(ct.ch, "boil", "Boiling point", "K")
addCatVar(ct.ch, "h_fus", "Heat of fusion", "kJ/mol")
addCatVar(ct.ch, "h_vap", "Heat of vaporization", "kJ/mol")
--addCatVar(ct.ch, "t_cond", "Thermal conductivity", "W/mK")
--addCatVar(ct.ch, "e_cond", "Electrical conductivity", "MS/m")

addSubCat(ct.ch, 1, "Elements", "Obtain information relating to the periodic elements")
--aF(ct.ch, 1, "name=ch.name[atom]", U( "name", "atom") )
--aF(ct.ch, 1, "sym=ch.sym[atom]", U( "sym", "atom") )
--aF(ct.ch, 1, "atom=ch.atom[atom]", U( "atom") )
aF(ct.ch, 1, "mass=ch.mass[atom]", U( "mass", "atom") )
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
aF(ct.ch, 1, "dens=ch.dens[atom]", U( "dens", "atom") )
aF(ct.ch, 1, "c=ch.c[atom]", U( "c", "atom") )
aF(ct.ch, 1, "melt=ch.melt[atom]", U( "melt", "atom") )
aF(ct.ch, 1, "boil=ch.boil[atom]", U( "boil", "atom") )
aF(ct.ch, 1, "h_fus=ch.h_fus[atom]", U( "h_fus", "atom") )
aF(ct.ch, 1, "h_vap=ch.h_vap[atom]", U( "h_vap", "atom") )
--aF(ct.ch, 1, "t_cond=ch.t_cond[atom]", U( "t_cond", "atom") )
--aF(ct.ch, 1, "e_cond=ch.e_cond[atom]", U( "e_cond", "atom") )
