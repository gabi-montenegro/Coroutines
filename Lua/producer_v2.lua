function producer()
    coroutine.yield("data1")
    coroutine.yield("data3")
    end

function producer_2()
    coroutine.yield("data2")
end

co1 = coroutine.create(producer)
co2 = coroutine.create(producer_2)

print(coroutine.resume(co1))

-- status, value = coroutine.resume(co1)  -- "data1"
-- print(status, value)  -- true, data1

-- status, value = coroutine.resume(co2)  -- "data2"
-- print(status, value)  -- true, data2

-- status, value = coroutine.resume(co1)  -- "data3"
-- print(status, value)  -- true, data3

