-- Corrotina final que imprime a linha diretamente
local printLines = coroutine.create(function ()
    while true do
        local line = coroutine.yield()
        print(line)
    end
end)

-- Corrotina que numera as linhas e envia para printLines
local numberLines = coroutine.create(function ()
    local lineNo = 1
    while true do
        local line = coroutine.yield()
        coroutine.resume(printLines, string.format("%d: %s", lineNo, line))
        lineNo = lineNo + 1
    end
end)

-- Corrotina que quebra os chunks em linhas
local splitLines = coroutine.create(function ()
    local previous = ""
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

-- Leitura de arquivo em chunks
function readFile(fileName, chunkSize)
    local file = io.open(fileName, "rb")
    while true do
        local chunk = file:read(chunkSize)
        if not chunk then break end
        coroutine.resume(splitLines, chunk)
    end
    file:close()

    -- Processa o último pedaço pendente despertado no #previous > 0 do splitLines
    coroutine.resume(splitLines, nil) -- Indica o fim da leitura

    -- Fecha todas as corrotinas (Lua 5.4+)
    coroutine.close(splitLines)
    coroutine.close(numberLines)
    coroutine.close(printLines)
end

function activateCoroutines()
    coroutine.resume(splitLines)
    coroutine.resume(numberLines)
    coroutine.resume(printLines)
end

-- Executa
local fileName = arg[1]
activateCoroutines()
readFile(fileName, 16)
