function gen()
    local function callback(x)
        coroutine.yield(x)
    end

    for _, v in ipairs({"a", "b"}) do
        callback(v)
    end
end

local co = coroutine.create(gen)

print(coroutine.resume(co)) -- true   a
print(coroutine.resume(co)) -- true   b
print(coroutine.resume(co)) -- true   nil
