function corrotina()
    print("Início da corrotina")
    coroutine.yield()
    print("Retomando a corrotina")
end


co = coroutine.wrap(corrotina)

print(co())
-- print(coroutine.status(co)) --error, coroutine.satus expects a coroutine reference (thread) not a single function
print(co()) 