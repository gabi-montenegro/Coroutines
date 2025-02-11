function objectEntries(jane)
    return coroutine.wrap(function()
        for key, value in pairs(jane) do
            coroutine.yield(key, value)
        end
    end)
end

local jane = { first = "Jane", last = "Doe" }
-- local co = objectEntries(jane)
-- print(co())
-- print(co())

-- com for in - simula as chamadas acima
for key, value in objectEntries(jane) do
    print(key, value)
end


