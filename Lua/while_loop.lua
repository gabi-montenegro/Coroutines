function gen(x)
    while true do
        print("Before yield:", x)
        coroutine.yield(x) -- Suspende a execução e retorna o valor de x
        x = x + 1 -- Incrementa x para a próxima iteração
        print("After yield:", x)
    end
end



co = coroutine.create(gen)
coroutine.resume(co, 10) --executa ate o primeiro yield

coroutine.resume(co, 10)
-- print(coroutine.resume(co))