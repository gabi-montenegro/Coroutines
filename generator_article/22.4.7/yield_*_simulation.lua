function callee()
    while true do
        local input = coroutine.yield()
        print('callee ' .. input)
    end
end

function caller()
    local callee = coroutine.create(callee)

    coroutine.resume(callee) -- inicia a corrotina , para no primeiro yield
    while true do
        local input = coroutine.yield()
        coroutine.resume(callee, input) -- recebe valor externo
    end
end

local caller = coroutine.create(caller)

coroutine.resume(caller)

coroutine.resume(caller, 'a')

coroutine.resume(caller, 'b')
