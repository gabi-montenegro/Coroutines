function foo()
    coroutine.yield('a')
    coroutine.yield('b')
    return 'The result' -- Valor final da iteração
end

function bar()
    local foo_co = coroutine.create(foo)

    local _,v1 = coroutine.resume(foo_co)
    coroutine.yield(v1)

    local _,v2 = coroutine.resume(foo_co)
    coroutine.yield(v2)

    local _,v3 = coroutine.resume(foo_co)
    coroutine.yield(v3)
end

local co = coroutine.create(bar)

print(coroutine.resume(co)) -- true   a
print(coroutine.resume(co)) -- true   b
print(coroutine.resume(co)) -- true   The result