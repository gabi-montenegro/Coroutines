-- Corrotina final que imprime a linha diretamente
local printLines = coroutine.wrap(function()
    while true do
        local line = coroutine.yield()
        if line == nil then 
            print("DONE")
            break 
        end
        print(line)
    end
end)

-- Corrotina que numera as linhas e envia para printLines
local numberLines = coroutine.wrap(function()
    local lineNo = 1

    while true do
        local line = coroutine.yield()
        if line == nil then 
            printLines(nil) 
            break 
        end
        printLines(string.format("Linha %d: %s", lineNo, line))
        lineNo = lineNo + 1
    end
end)

-- Corrotina que quebra os chunks em linhas
local splitLines = coroutine.wrap(function()
    local previous = ""

    while true do
        local chunk = coroutine.yield()
        if chunk == nil then break end

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
    if not file then error("Could not open file: " .. fileName) end

    while true do
        local chunk = file:read(chunkSize)
        if not chunk then break end
        splitLines(chunk)
    end

    file:close()
    splitLines(nil)
end

-- Inicializa as corrotinas (sem enviar dados)
splitLines()
numberLines()
printLines()

-- Executa (note que não há ativação inicial)
local fileName = "input.txt"
readFile(fileName, 16)