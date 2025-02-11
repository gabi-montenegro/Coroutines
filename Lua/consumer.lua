function producer()
    coroutine.yield(1)
    coroutine.yield(2)
    coroutine.yield(3)
end

function consumer(producer_coroutine)
    while true do

        local status, data = coroutine.resume(producer_coroutine)

        if not status then
            break  -- Se o produtor não tiver mais dados para fornecer, encerra
        end

        print("Processed:", data)
        coroutine.yield()  -- Controle explícito de cada passo
    end
end

producer = coroutine.create(producer)

cons = coroutine.create(function()
    consumer(producer)
end)


coroutine.resume(cons)
coroutine.resume(cons)
coroutine.resume(cons)
