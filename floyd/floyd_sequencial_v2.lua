local BLANK_LINE = false

-- Imprime as linhas formatadas
local function printLines(line)
    print(line)
end

-- Agrupa palavras em linhas de até 30 caracteres
local function wrapText(words)
    local buffer = ""
    for _, word in ipairs(words) do
        if #buffer + #word + (#buffer > 0 and 1 or 0) > 30 then
            printLines(buffer)
            buffer = word
        else
            buffer = buffer .. (#buffer > 0 and " " or "") .. word
        end
    end
    if #buffer > 0 then
        printLines(buffer)
    end
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
local function splitLines(chunk)
    local previous = ""
    local allLines = {}

    previous = previous .. chunk

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
    local paragraph = ""

    while not BLANK_LINE do
        local chunk = file:read(chunkSize)
        if not chunk then break end

        chunk = previous .. chunk
        local lines, rem = splitLines(chunk)
        previous = rem

        for _, line in ipairs(lines) do
            -- Acumula as linhas em um único parágrafo
            paragraph = paragraph .. (paragraph ~= "" and " " or "") .. line
        end
    end

    -- Processa o parágrafo acumulado
    if #paragraph > 0 then
        local words = normalizeWordsLines(paragraph)
        wrapText(words)
    end

    file:close()
end

-- Execução principal
local fileName = arg[1]
readFile(fileName, 16)
