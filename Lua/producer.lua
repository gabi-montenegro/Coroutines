function gen()
    coroutine.yield("string 1")
    coroutine.yield("string 2")
    coroutine.yield("string 3")
end


co = coroutine.create(gen)

local status, value = coroutine.resume(co)
print(string.format("Status: %s --- Value: %s", status, value))

local status, value = coroutine.resume(co)
print(string.format("Status: %s --- Value: %s", status, value))

local status, value = coroutine.resume(co)
print(string.format("Status: %s --- Value: %s", status, value))

local status, value = coroutine.resume(co)
print(string.format("Status: %s --- Value: %s", status, value))