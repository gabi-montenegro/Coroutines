

local queue = {} -- Fila de mensagens (armazenamento temporário)

-- Função para enviar mensagens à fila
local function sendMessage(msg, producer_id)
    table.insert(queue, {msg = msg, producer = producer_id})
    print(string.format("[PRODUTOR %d] - Mensagem enviada: %s", producer_id, msg))
end

-- Função para processar mensagens da fila
local function processMessages(consumer_id)
    while true do
        if #queue > 0 then
            local message = table.remove(queue, 1)
            print(string.format("[CONSUMIDOR %d] - Processando: '%s' (de Produtor %d)", 
                  consumer_id, message.msg, message.producer))
            coroutine.yield() -- Simula tempo de processamento
        else
            print(string.format("[CONSUMIDOR %d] - Fila vazia - aguardando...", consumer_id))
            coroutine.yield() -- Evita consumo de CPU enquanto espera
        end
    end
end

-- Criação dos consumidores (como corrotinas)
local consumers = {
    coroutine.create(function() processMessages(1) end),
    coroutine.create(function() processMessages(2) end)
}

-- Criação dos produtores (como corrotinas)
local producers = {
    coroutine.create(function()
        sendMessage("Pedido #1001 processado", 1)
        coroutine.yield()
        sendMessage("Erro no pedido #1002", 1)
    end),
    
    coroutine.create(function()
        sendMessage("Log: Usuário autenticado", 2)
        coroutine.yield()
        sendMessage("Log: Sistema reiniciado", 2)
        coroutine.yield()
        sendMessage("Alerta: CPU acima de 90%", 2)
    end)
}

-- Loop principal de execução
local cycle = 1
while true do
    print("\n=== CICLO " .. cycle .. " ===")
    
    -- Executa todos os produtores
    for prod_id, prod in ipairs(producers) do
        if coroutine.status(prod) ~= "dead" then
            coroutine.resume(prod)
        else
            print(string.format("[PRODUTOR %d] - Finalizado", prod_id))
        end
    end

    -- Executa todos os consumidores
    for cons_id, cons in ipairs(consumers) do
        if coroutine.status(cons) ~= "dead" then
            coroutine.resume(cons)
        end
    end

    -- Controle de execução
    cycle = cycle + 1
    if cycle > 10 then  -- Limita a 10 ciclos para demonstração
        print("\n=== SIMULAÇÃO CONCLUÍDA ===")
        break
    end
    
    os.execute("sleep 0.5")  
end