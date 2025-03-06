function callee()
    while true do
        local input = coroutine.yield()
        print('callee ' .. input)

        if input == 'stop' then
            return "Final Value"
        end
    end
end

function caller()
    local callee = coroutine.create(callee)

    coroutine.resume(callee) -- inicia a corrotina, para no primeiro yield

    while true do
        local input = coroutine.yield()
        local success, result = coroutine.resume(callee, input) -- recebe valor externo

        if not success then
            print("callee terminou: " .. tostring(result))  -- captura o retorno
            break
        end
    end
end

local caller = coroutine.create(caller)

coroutine.resume(caller)

coroutine.resume(caller, 'a')   -- Continua normalmente
coroutine.resume(caller, 'b')   -- Continua normalmente
local success, finalValue = coroutine.resume(caller, 'stop') -- Encerra e captura o retorno
print(finalValue)
