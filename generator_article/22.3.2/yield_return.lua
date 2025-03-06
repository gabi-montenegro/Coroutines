function gen(x)
    while true do
        print("Before yield:", x)
        local input = coroutine.yield(x) --suspende e retorna x. Captura o valor recebido ao retomar
        x = x + (input or 0)
        print("After yield:", x)
    end
end

co = coroutine.create(gen)

local v, s = coroutine.resume(co, 10)
print(v) --retorno do x pelo yield
-- print(s) --status da corrotina


local v, s = coroutine.resume(co, 30)

print(v) --retorno do x pelo yield
-- print(s)--status da corrotina

