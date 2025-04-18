function transformSequence(a)
    print("Created")
    local b = coroutine.yield(a * 3)
    return b - 1 -- corrotina retomada com c sendo (b+1) -> 23
end

co = coroutine.create(transformSequence(10))

success, c = coroutine.resume(co, 10) -- A corrotina recebe 20 e retorna 22 (20 + 2)
print(success)
print("c:", c)

success, d = coroutine.resume(co, c + 2) -- A corrotina recebe 23 (b + 1) e retorna 46 (23 * 2)
print("d:", d)