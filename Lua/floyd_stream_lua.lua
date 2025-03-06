-- Corrotina que imprime a saída
printText = coroutine.wrap(function()
    while true do
        local line = coroutine.yield()
        if not line then break end
        print(line)
    end
    print("DONE")
end)

-- Corrotina que formata o texto em linhas de no máximo 30 caracteres
wrapText = coroutine.wrap(function()
    local buffer = ""
    while true do
        local word = coroutine.yield()
        if not word then break end
        if word == "__STOP__" then break end -- Interrompe imediatamente

        if #buffer + #word + (buffer ~= "" and 1 or 0) > 30 then
            printText(buffer) -- Envia a linha formatada
            buffer = word
        else
            buffer = (buffer ~= "" and buffer .. " " or "") .. word
        end
    end

    -- Se ainda houver texto acumulado, imprimir antes de parar
    if buffer ~= "" then printText(buffer) end
    printText(nil) -- Enviar sinal de fim para printText
end)

-- Corrotina que normaliza espaços e remove linhas vazias
normalizeText = coroutine.wrap(function()
    while true do
        local line = coroutine.yield()
        if not line or line:match("^%s*$") then
            wrapText("__STOP__") -- Envia sinal de interrupção
            return
        end

        for word in line:gmatch("%S+") do
            wrapText(word) -- Envia palavra por palavra
        end
    end
end)

-- Função principal que controla o fluxo das corrotinas
function processText(inputString)
    for line in inputString:gmatch("[^\r\n]+") do
        normalizeText(line)
    end
    normalizeText(nil) -- Envia sinal de fim para as corrotinas
end

-- Entrada como única string
local INPUT = [[
asdfkj asfdlkjasd  flkajsdfzzzzz laksjdf alkj                                        
asd  flajdsf laksjd   lakjdfla skdj                                            
as dlfkjasdl   fkja d  

aaaaaasss
]]

-- Processa a entrada
processText(INPUT)
