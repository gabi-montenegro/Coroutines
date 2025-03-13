printText = coroutine.create(function()
    while true do
        local line = coroutine.yield()
        if not line then break end
        print(line)
    end
    print("DONE")
end)


-- Corrotina que formata o texto em linhas de no máximo 30 caracteres
wrapText = coroutine.create(function()
    local buffer = ""
    while true do
        local word = coroutine.yield()
        if not word then break end
        

        if #buffer + #word + (buffer ~= "" and 1 or 0) > 30 then
            coroutine.resume(printText, buffer) -- Envia a linha formatada
            buffer = word
        else
            buffer = buffer .. (buffer ~= "" and " " or "") .. word
        end
    end
end)

splitter = coroutine.create(function()
    while true do
        local line = coroutine.yield()

        if line:match("^%s*(.-)%s*$") == '' then break end --linha vazia

        -- local words = line:match("^%s*(.-)%s*$"):gsub("%s+", " ").split(" ") -- Divide a linha em palavras normalizando espaços

        --divide a linha em palavras, sem espaços irredundantes
        local words = {}
        for word in string.gmatch(line, "[^%s]+") do
            table.insert(words, word)
        end

        -- Envia cada palavra para a corrotina de impressão
        for _, word in ipairs(words) do
            coroutine.resume(wrapText, word)
        end

    end

end)

function readFile(fileName)
    local file = io.open(fileName, "r")
    if not file then error("Could not open file: " .. fileName) end

    -- Garante que a corrotina esteja pronta para começar
    coroutine.resume(splitter)  -- Inicia a corrotina explicitamente, sem essa inicializacao a primeira linha do arquivo nao eh exibida

    for line in file:lines() do
        coroutine.resume(splitter, line) -- Envia cada linha para a corrotina de impressão
    end

    file:close()
    coroutine.resume(splitter, nil) -- Indica o fim da leitura
end




-- Executa a leitura do arquivo enviando as linhas diretamente para printText
local fileName = "input.txt"
readFile(fileName)
