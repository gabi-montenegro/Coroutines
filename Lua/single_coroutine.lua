co = coroutine.create(function() 
    print("Hello, Coroutine!") 
end)

coroutine.resume(co)