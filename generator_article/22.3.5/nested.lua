function gen()
    local function sub()
        coroutine.yield(1) 
    end

    sub()
    coroutine.yield(2) -- 
end

local co = coroutine.create(gen)

print(coroutine.resume(co)) -- true   1
print(coroutine.resume(co)) -- true   2
