local STOP = "__STOP__"

local function safe_close(co)
    if coroutine.status(co) ~= "dead" then
        coroutine.close(co)
    end
end

local printLines = coroutine.create(function()
    while true do
        local line = coroutine.yield()

        if not line or line == STOP then break end
        print(line)
    end
end)

local wrapText = coroutine.create(function()
    local buffer = ""
    while true do
        local word = coroutine.yield()

        if not word or word == STOP then
            if #buffer > 0 then 
                coroutine.resume(printLines, buffer) 
            end
            coroutine.resume(printLines, STOP)
            break
        end

        if #buffer + #word + (buffer ~= "" and 1 or 0) > 30 then
            coroutine.resume(printLines, buffer)
            buffer = word
        else
            buffer = buffer .. (buffer ~= "" and " " or "") .. word
        end
    end
end)

local normalizeWordsLines = coroutine.create(function()
    while true do
        local line = coroutine.yield()
        if not line or line == STOP then
            coroutine.resume(wrapText, STOP)
            break
        end

        
        if line:match("^%s*$") then
            coroutine.resume(wrapText, STOP)
            break
        end

        
        for word in string.gmatch(line, "[^%s]+") do
            coroutine.resume(wrapText, word)
        end
    end
end)


local splitLines = coroutine.create(function()
    local previous = ""
    while true do
        local chunk = coroutine.yield()

        if not chunk then break end

        previous = previous .. chunk
        while true do
            local lineEnd = string.find(previous, "\n", 1, true)
            if not lineEnd then break end
            local line = string.sub(previous, 1, lineEnd - 1)

            -- linha em branco sinaliza parada geral
            if line:match("^%s*$") then
                coroutine.resume(normalizeWordsLines, STOP)
                return
            end

            coroutine.resume(normalizeWordsLines, line)
            previous = string.sub(previous, lineEnd + 1)
        end
    end

    if #previous > 0 then
        coroutine.resume(normalizeWordsLines, previous)
    end
    coroutine.resume(normalizeWordsLines, STOP)
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

    coroutine.resume(splitLines, nil)

    -- Fecha todas as corrotinas com segurança (Lua 5.4+)
    safe_close(normalizeWordsLines)
    safe_close(wrapText)
    safe_close(printLines)
end

-- Ativa as corrotinas uma única vez
function activateCoroutines()
    coroutine.resume(splitLines)
    coroutine.resume(normalizeWordsLines)
    coroutine.resume(wrapText)
    coroutine.resume(printLines)
end

-- Execução principal
local fileName = arg[1]
activateCoroutines()
readFile(fileName, 16)
