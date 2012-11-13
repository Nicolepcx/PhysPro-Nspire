
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

addCat(1, "Motion Stuff", "Performs calculations of motion-related stuff")

addCatVar(1,    "u",        "Intial velocity",              "m/s"       )
addCatVar(1,    "v",        "Final velocity",               "m/s"       )
addCatVar(1,    "dv",       "Change in velocity",           "m/s"       )
addCatVar(1,    "av",       "Average velocity",             "m/s"       )
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
addCatVar(1,    "GPE",      "Gravity PE",                   "J"         )
addCatVar(1,    "KE",       "Kinetic energy",               "J"         )
addCatVar(1,    "eng",      "Total energy",                 "J"         )
addCatVar(1,    c_th,       "Angle (Degrees)",              utf8(176)   )
addCatVar(1,    "Tp",       "Period",                       "s"         )
addCatVar(1,    "c",        "Circumference",                "m"         )

addSubCat(1, 1, "Kinematics", "Solves for: u, v, s, t, a")
aF(1, 1,    "u=v-a*t",              U("u", "v", "a", "t")   )
aF(1, 1,    "v=sqrt(2*a*s+u^2)",    U("v", "a", "s", "u")   )
aF(1, 1,    "s=(u*t)+(.5*a*t^2)",   U("s", "u", "t", "a")   )
aF(1, 1,    "t=(2*s)/(u+v)",        U("t", "s", "u", "v")   )
aF(1, 1,    "a=(v-u)*t",            U("a", "v", "u", "t")   )

addSubCat(1, 2, "Force", "Solves for: F, m, a")
aF(1, 2,    "F=m*a",    U("F","m","a")  )
aF(1, 2,    "m=F/a",    U("m","F","a")  )
aF(1, 2,    "a=F/m",    U("a","F","m")  )

addSubCat(1, 3, "Impulse", "Solves for: Imp, F, t, dv, m, v, u")
aF(1, 3,    "Imp=F*t",          U("Imp", "F", "t")          ) 
aF(1, 3,    "F=m*(dv/t)",       U("F", "m", "dv", "t")      )
aF(1, 3,    "m=(F*t)/v",        U("m", "F", "t", "v")       )
aF(1, 3,    "dv=v-u",           U("dv", "v", "u")           )
aF(1, 3,    "t=Imp/F",          U("t", "Imp", "F")          )
aF(1, 3,    "u=v-(F*t)/m",      U("u", "v", "F", "t", "m")  )
aF(1, 3,    "v=(F*t)/m+u",      U("v", "F", "t", "m", "u")  )

addSubCat(1, 4, "Work", "Solves for: W, F, s, m, a, "..c_th)
aF(1, 4,    "W=F*s*cos("..c_th..")",    U("W", "F", c_th, "s")  )
aF(1, 4,    c_th,                       U(c_th)                 )
aF(1, 4,    "F=m*a",                    U("F", "m", "a")        )
aF(1, 4,    "s=(W*sec("..c_th.."))/F",  U("s", "W", c_th, "F")  )
aF(1, 4,    "m=F/a",                    U("m", "F", "a")        )
aF(1, 4,    "a=F/m",                    U("a", "F", "m")        )

addSubCat(1, 5, "Power", "Solves for: P, W, t, F, m, a, s, av, "..c_th)
aF(1, 5,    "P=W/t",                        U("P", "W", "t")            )
aF(1, 5,    "W=F*s*cos("..c_th..")",        U("W", "F", "s", c_th)      )
aF(1, 5,    "t=W/P",                        U("t", "W", "P")            )
aF(1, 5,    "F=m*a",                        U("F", "m", "a")            )
aF(1, 5,    "s=(P*t*sec("..c_th.."))/F",    U("s", "P", "t", c_th, "F") )
aF(1, 5,    "m=F/a",                        U("m", "F", "a")            )
aF(1, 5,    "a=F/m",                        U("a", "F", "m")            )
aF(1, 5,    "av=(P*sec("..c_th.."))/F",     U("av", "P", c_th, "F")     )
aF(1, 5,    c_th,                        U(c_th)                     )

addSubCat(1, 6, "Energy", "Solves for: KE, GPE, eng, m, v, h, g")
aF(1, 6,    "KE=(1/2)*m*v^2",       U("KE", "m", "v")           )
aF(1, 6,    "GPE=m*abs(g)*h",       U("GPE", "m", "g", "h")     )
aF(1, 6,    "eng=KE+GPE",           U("eng", "KE", "GPE")       )
aF(1, 6,    "m=GPE/(g*h)",          U("m", "GPE", "g", "h")     )
aF(1, 6,    "g=abs(GPE/(h*m))",     U("g", "GPE", "h", "m")     )
aF(1, 6,    "h=GPE/(abs(g)*m)",     U("h", "GPE", "g", "m")     )
aF(1, 6,    "v=sqrt((2*KE)/m)",     U("v", "KE", "m")           )

addSubCat(1, 7, "Centripital", "Solves for F[c], a[c], v, r, Tp (period), m, c" )
aF(1, 7,    "F=(m*v^2)/r",                  U( "F", "m", "v", "r" )     )
aF(1, 7,    "a=(4*pi^2*r)/Tp^2",            U( "a", "r", "Tp" )         )
aF(1, 7,    "v=sqrt(a*r)",                  U( "v", "a", "r" )          )
aF(1, 7,    "r=(m*v^2)/F",                  U( "r", "m" ,"v", "F" )     )
aF(1, 7,    "m=(F*r)/v^2",                  U( "m", "r", "v" )          )
aF(1, 7,    "Tp=(2*pi*sqrt(r))/sqrt(a)",    U( "Tp", "r", "v" )         )
aF(1, 7,    "c=2*π*r",                      U( "c", "r" )               )
