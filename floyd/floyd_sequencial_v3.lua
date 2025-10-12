local BLANK_LINE = false

-- Imprime as linhas formatadas
local function printLines(line)
    print(line)
end

-- Agrupa palavras em linhas de até 30 caracteres
-- Recebe o buffer atual e retorna o buffer atualizado
local function wrapText(words, buffer, flush)
    for _, word in ipairs(words) do
        if #buffer + #word + (#buffer > 0 and 1 or 0) > 30 then
            printLines(buffer)
            buffer = word
        else
            buffer = buffer .. (#buffer > 0 and " " or "") .. word
        end
    end

    -- Quando flush é true, imprime o restante
    if flush and #buffer > 0 then
        printLines(buffer)
        buffer = ""
    end

    return buffer
end

-- Divide linha em palavras
local function normalizeWordsLines(line)
    local words = {}
    for word in string.gmatch(line, "[^%s]+") do
        table.insert(words, word)
    end
    return words
end

-- Separa blocos de texto em linhas
local function splitLines(chunk, previous)
    previous = (previous or "") .. chunk
    local allLines = {}

    while true do
        local lineEnd = string.find(previous, "\n", 1, true)
        if not lineEnd then break end

        local line = string.sub(previous, 1, lineEnd - 1)

        if line:match("^%s*$") then
            BLANK_LINE = true
            break
        end

        table.insert(allLines, line)
        previous = string.sub(previous, lineEnd + 1)
    end

    return allLines, previous
end

-- Lê o arquivo em blocos e processa o texto
local function readFile(fileName, chunkSize)
    local file = io.open(fileName, "rb")
    local previous = ""
    local buffer = ""  -- agora o buffer é local

    while not BLANK_LINE do
        local chunk = file:read(chunkSize)
        if not chunk then break end

        local lines
        lines, previous = splitLines(chunk, previous)
        
        for _, line in ipairs(lines) do
            local words = normalizeWordsLines(line)
            buffer = wrapText(words, buffer) -- buffer faz parte do paragrafo
        end
    end

    -- Processa o conteúdo restante quando a linha em branco nao foi detectada
    if not BLANK_LINE and #previous > 0 then
        local words = normalizeWordsLines(previous)
        buffer = wrapText(words, buffer)
    end
    wrapText({}, buffer, true) -- o buffer final nunca vai passar de 30 caracteres
    print("=====Previous:", previous)
    print("=====Buffer:", buffer)
    -- Imprimir o restante do buffer

    file:close()
end

-- Execução principal
local fileName = arg[1]
readFile(fileName, 16)
