-- Corrotina final que imprime a linha diretamente
local printLines = coroutine.wrap(function()
    while true do
        local line = coroutine.yield()
        if not line then break end
        print(line)
    end
end)

-- Corrotina que numera as linhas e envia para printLines
local numberLines = coroutine.wrap(function()
    local lineNo = 1

    while true do
        local line = coroutine.yield()
        if not line then break end -- controle do nil importante para parar a corrotina quando não temos o coroutine.close
        printLines(string.format("%d: %s", lineNo, line))
        lineNo = lineNo + 1
    end
end)

-- Corrotina que quebra os chunks em linhas
local splitLines = coroutine.wrap(function()
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

            numberLines(line)
        end
    end

    if #previous > 0 then
        numberLines(previous)
    end
    numberLines(nil)
end)



-- Leitura de arquivo em chunks
function readFile(fileName, chunkSize)
    local file = io.open(fileName, "rb")
    while true do
        local chunk = file:read(chunkSize)
        if not chunk then break end
        splitLines(chunk)
    end

    file:close()
    splitLines(nil)
end

-- Inicializa as corrotinas (sem enviar dados)
function activateCoroutines()
    splitLines()
    numberLines()
    printLines()
end 


-- Executa (note que não há ativação inicial)
local fileName = "input.txt"
activateCoroutines()
readFile(fileName, 16)