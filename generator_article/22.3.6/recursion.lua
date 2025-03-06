function foo() 
    coroutine.yield('a')
    coroutine.yield('b')
end

function bar()
    coroutine.yield('x')

    local foo_co = coroutine.create(foo)

    local _, v1 = coroutine.resume(foo_co)
    coroutine.yield(v1)

    local _, v2 = coroutine.resume(foo_co)
    coroutine.yield(v2)

    
    coroutine.yield('y')
end

local co = coroutine.create(bar)

print(coroutine.resume(co)) -- true   x
print(coroutine.resume(co)) -- true   a
print(coroutine.resume(co)) -- true   b
print(coroutine.resume(co)) -- true   y 