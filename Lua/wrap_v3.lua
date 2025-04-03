function producer()
    coroutine.yield("data1")
    coroutine.yield("data3")
end


co1 = coroutine.wrap(producer)

for data in co1 do
    print(data)
end