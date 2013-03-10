--@@  dbmain.lua
--@@  LGLP 3 License
--@@  alex3yoyo

--include "symbols.lua"
--include "constants.lua"
--include "chem.lua"

ct    = {} -- Set position of each section
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
Formulas   = {}

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

--include "database.lua"
--include "exdb.lua"
--include "units.lua"
