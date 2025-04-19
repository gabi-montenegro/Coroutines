-- Corrotina final que imprime a linha diretamente
local printLines = coroutine.wrap(function()
    while true do
        local line = coroutine.yield()
        if not line then break end
        print(line)
    end
end)

local wrapText = coroutine.wrap(function()
    local buffer = ""
    while true do
        local word = coroutine.yield()
        if not word then break end -- controle do nil é importante para parar a corrotina
        if #buffer + #word + (buffer ~= "" and 1 or 0) > 30 then
            printLines(buffer)
            buffer = word
        else
            buffer = buffer .. (buffer ~= "" and " " or "") .. word
        end
    end
    if #buffer > 0 then printLines(buffer) end
    printLines(nil)
end)

local normalizeWordsLines = coroutine.wrap(function()
    while true do
        local line = coroutine.yield()
        if not line then break end
        if line:match("^%s*(.-)%s*$") == '' then break end --linha vazia

        -- local words = line:match("^%s*(.-)%s*$"):gsub("%s+", " ").split(" ") -- Divide a linha em palavras normalizando espaços

        --divide a linha em palavras, sem espaços irredundantes
        local words = {}
        for word in string.gmatch(line, "[^%s]+") do
            table.insert(words, word)
        end

        -- Envia cada palavra para a corrotina de impressão
        for _, word in ipairs(words) do
            wrapText(word)
        end

    end

    wrapText(nil)

end)

-- Corrotina que quebra os chunks em linhas
local splitLines = coroutine.wrap(function()
    local previous = ""
    local blankLine = false
    while true do
        local chunk = coroutine.yield()
        if not chunk then break end -- nil indica o fim da leitura
        previous = previous .. chunk
        while true do
            local lineEnd = string.find(previous, "\n", 1, true)

            if not lineEnd then break end
            local line = string.sub(previous, 1, lineEnd - 1)
            if line:match("^%s*(.-)%s*$") == '' then 
                blankLine = true
                break 
            end --linha vazia
            
            normalizeWordsLines(line)

            previous = string.sub(previous, lineEnd + 1)
        end
    end

    if not blankLine and #previous > 0 then
        normalizeWordsLines(previous)
    end
    normalizeWordsLines(nil)
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
    normalizeWordsLines()
    wrapText()
    printLines()
end

activateCoroutines()
readFile("input.txt", 16)