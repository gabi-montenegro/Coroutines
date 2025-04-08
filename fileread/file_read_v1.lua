splitChunkInLines = coroutine.create(function()
    local previous = ""
    local blankLine = false

    while true do
        local chunk = coroutine.yield()
        if not chunk then break end

        previous = previous .. chunk
        while true do
            local lineEnd = string.find(previous, "\n", 1, true)
            if not lineEnd then break end

            local line = string.sub(previous, 1, lineEnd - 1)
            previous = string.sub(previous, lineEnd + 1)

            coroutine.resume(numberLines, line)
        end
    end

    if #previous > 0 then
        coroutine.resume(numberLines, previous)
    end
end)

numberLines = coroutine.create(function()
    local lineNo = 1

    while true do
        local line = coroutine.yield()

        print(string.format("Linha %d: %s", lineNo, line))
        lineNo = lineNo + 1
    end
end)

printLines = coroutine.create(function()
    while true do
        local line = coroutine.yield()
        print(line)
    end
end)


function readFileInChunks(fileName, chunkSize)
    local file = io.open(fileName, "rb") -- Abre em modo binário
    if not file then error("Could not open file: " .. fileName) end

    while true do
        local chunk = file:read(chunkSize) -- Lê um bloco do arquivo
        if not chunk then break end
        coroutine.resume(splitChunkInLines, chunk) -- Envia o chunk para a corrotina (definida em outro lugar)
    end

    file:close()
    coroutine.resume(splitChunkInLines, nil) -- Indica o fim da leitura
end

--inicializa todas as corrotinas para que as corrotinas estejam preparadas para receber os dados do yield
activateCoroutines = function()
    coroutine.resume(splitChunkInLines)
    coroutine.resume(numberLines)
    coroutine.resume(printLines)
end


-- Executa a leitura do arquivo enviando as linhas diretamente para printText
local fileName = "input.txt"
activateCoroutines()
readFileInChunks(fileName, 16) -- leitura de arquivo em blocos de 1024 bytes