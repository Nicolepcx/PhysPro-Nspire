--@@  exdb.lua
--@@  LGLP 3 License
--@@  alex3yoyo

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
