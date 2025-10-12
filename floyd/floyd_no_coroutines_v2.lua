-- Implementação tradicional sem corrotinas do "problema de Floyd"
-- Mostra como o controle de fluxo precisa ser manual e mais acoplado entre as etapas.

-- local STOP = "__STOP__"

-- === Etapa 1: Leitura e divisão em linhas ===
local function splitLines(fileName, chunkSize)
    local file = io.open(fileName, "rb")
    local lines = {}
    local buffer = ""

    while true do
        local chunk = file:read(chunkSize)
        if not chunk then break end
        buffer = buffer .. chunk

        while true do
            local lineEnd = string.find(buffer, "\n", 1, true)
            if not lineEnd then break end

            local line = string.sub(buffer, 1, lineEnd - 1)
            table.insert(lines, line)
            buffer = string.sub(buffer, lineEnd + 1)
        end
    end

    if #buffer > 0 then
        table.insert(lines, buffer)
    end

    file:close()
    return lines
end

-- === Etapa 2: Normalização (remove espaços redundantes) ===
local function normalizeLines(lines)
    local normalized = {}
    for _, line in ipairs(lines) do
        -- se encontrar linha vazia, interrompe completamente o processamento
        if line:match("^%s*$") then
            break
        end

        local words = {}
        for word in string.gmatch(line, "[^%s]+") do
            table.insert(words, word)
        end

        -- transforma a lista de palavras de volta em string normalizada
        local normalizedLine = table.concat(words, " ")
        table.insert(normalized, normalizedLine)
    end
    return normalized
end

-- === Etapa 3: Quebra em linhas de 30 caracteres sem quebrar palavras ===
local function wrapText(lines)
    local wrapped = {}
    local buffer = ""

    for _, line in ipairs(lines) do
        for word in string.gmatch(line, "[^%s]+") do
            if #buffer + #word + (buffer ~= "" and 1 or 0) > 30 then
                table.insert(wrapped, buffer)
                buffer = word
            else
                buffer = buffer .. (buffer ~= "" and " " or "") .. word
            end
        end
    end

    if #buffer > 0 then
        table.insert(wrapped, buffer)
    end

    return wrapped
end

-- === Etapa 4: Impressão do resultado ===
local function printLines(lines)
    for _, line in ipairs(lines) do
        print(line)
    end
end

-- === Função principal ===
local function processFile(fileName)
    local rawLines = splitLines(fileName, 16)
    local normalized = normalizeLines(rawLines)
    local wrapped = wrapText(normalized)
    printLines(wrapped)
end

-- Execução
local fileName = arg[1]
processFile(fileName)
