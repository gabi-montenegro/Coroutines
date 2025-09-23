function gen()
    print("Before yield")
    coroutine.yield()
    print("After yield")
end

function helper()
    print("Before yield -- helper")
    coroutine.yield()


co = coroutine.create(gen)
coroutine.resume(co)
coroutine.resume(co)