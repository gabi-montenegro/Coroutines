-- Implementação tradicional do desafio de Floyd sem corrotinas

local function processFile(fileName)
    local file = io.open(fileName, "r")
    if not file then
        error("Erro ao abrir arquivo: " .. fileName)
    end

    local buffer = ""  -- acumula as palavras até 30 caracteres

    while true do
        local line = file:read("*l")  -- lê linha por linha ***Otimizado pois já lê em linhas
        if not line then break end

        -- se linha em branco → encerra o processamento
        if line:match("^%s*$") then
            break
        end

        -- normaliza espaços múltiplos e divide em palavras
        local words = {}
        for word in string.gmatch(line, "[^%s]+") do
            table.insert(words, word)
        end

        -- para cada palavra, controla o limite de 30 caracteres
        for _, word in ipairs(words) do
            local space = (buffer ~= "" and 1 or 0)
            if #buffer + #word + space > 30 then
                print(buffer)
                buffer = word
            else
                buffer = buffer .. (buffer ~= "" and " " or "") .. word
            end
        end
    end

    -- imprime o restante acumulado
    if #buffer > 0 then
        print(buffer)
    end

    file:close()
end

-- Execução principal
local fileName = arg[1]
processFile(fileName)
