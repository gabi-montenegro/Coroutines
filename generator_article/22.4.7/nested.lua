function callee()
    while true do
        print("callee: " .. coroutine.yield())
    end
end

function caller()
    local co_callee = coroutine.create(callee)
    coroutine.resume(co_callee)  -- inicia callee e pausa no primeiro yield

    while true do
        local input = coroutine.yield()
        coroutine.resume(co_callee, input)
    end
end

-- Cria a corrotina chamadora
local co_caller = coroutine.create(caller)

-- Inicia a execução de caller
coroutine.resume(co_caller)       -- avança até o yield da caller

-- Agora sim, envia valores:
coroutine.resume(co_caller, 'a')  --> imprime "callee: a"
coroutine.resume(co_caller, 'b')  --> imprime "callee: b"
