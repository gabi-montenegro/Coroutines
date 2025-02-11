function gen()
    print("Before yield")
    coroutine.yield()
    print("After yield")
end


co = coroutine.create(gen)
coroutine.resume(co)
coroutine.resume(co)