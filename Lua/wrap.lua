co = coroutine.wrap(function(a)
    print("Created")
    local c = coroutine.yield(a + 2)
    return c * 2 --corrotina retormada com c sendo (b+1) -> 23 
end)

b = co(20) -- A corrotina recebe 20 e retorna 22 (20 + 2)
print("b:", b)

d = co(b + 1) -- A corrotina recebe 23 (b + 1) e retorna 46 (23 * 2)
print("d:", d)

-- co(b+1) <---> coroutine.yield(a+2) 
