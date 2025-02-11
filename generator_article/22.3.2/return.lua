function gen()
    coroutine.yield(1) -- Correto: sem "coroutine." antes de yield
    coroutine.yield(2)
    return 3
end

function gen2()
    coroutine.yield(1)
    coroutine.yield(2)
end

local co = coroutine.create(gen)

print(coroutine.resume(co)) -- true   1
print(coroutine.resume(co)) -- true   2
print(coroutine.resume(co)) -- true   3

print("=======gen2========")

local co2 = coroutine.create(gen2)

print(coroutine.resume(co2)) -- true   1
print(coroutine.resume(co2)) -- true   2
print(coroutine.resume(co2)) -- true   nil
