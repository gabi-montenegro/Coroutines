co = coroutine.wrap(function(a)
    local b = coroutine.yield(a + 2)
    return b * 2 --corrotina retormada com c sendo (b+1) -> 23 
end)

c = co(20) -- A corrotina recebe 20 e retorna 22 (20 + 2)
print("b:", b)

d = co(b + 1) -- A corrotina recebe 23 (b + 1) e retorna 46 (23 * 2)
print("d:", d)

-- co(b+1) <---> coroutine.yield(a+2) 
