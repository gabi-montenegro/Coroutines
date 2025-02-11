function producer()
    -- A corrotina gera alguns dados
    coroutine.yield("data1")
    coroutine.yield("data2")
    coroutine.yield("data3")
end

function consumer(prod)
    -- A função consumer vai consumir os dados do producer
    for data in prod do -- o for automaticamente faz chamadas repetidas de resume
        print("Processed: " .. data)
    end
end

-- Usando coroutine.wrap para criar a corrotina de forma simples e para receber os valores do yield sem resume
local prod = coroutine.wrap(producer)

-- Passando a corrotina do producer para o consumer
consumer(prod)  -- Isso chama automaticamente o next() da corrotina do producer e imprime os dados
