function profundidade()
    print("Antes de pausar")
    coroutine.yield()
    print("Depois de retomar")
end

function corrotina()
    profundidade()
end

co = coroutine.create(corrotina)
coroutine.resume(co)
coroutine.resume(co)