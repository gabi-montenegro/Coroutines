function numbers1to3()
    return coroutine.wrap(function()
        coroutine.yield(1)
        coroutine.yield(2)
        coroutine.yield(3)
    end)
end

function numbers4to6()
    return coroutine.wrap(function()
        coroutine.yield(4)
        coroutine.yield(5)
        coroutine.yield(6)
    end)
end

function composableIterator()
    return coroutine.wrap(function()
        for n in numbers1to3() do
            coroutine.yield(n)
        end
        for n in numbers4to6() do
            coroutine.yield(n)
        end
    end)
end

local resultado = {}
for valor in composableIterator() do
    table.insert(resultado, valor)
end

for i, v in ipairs(resultado) do
    print(v)
end
