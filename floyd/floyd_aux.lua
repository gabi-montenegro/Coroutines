local BLANK_LINE = false

local printLines = coroutine.create(function()
    while true do
        local line = coroutine.yield()

        if not line then break end

        print(line)
    end
end)

local wrapText = coroutine.create(function()
    local buffer = ""
    while true do
        local word = coroutine.yield()

        if not word then
            break
        end

        if #buffer + #word + (buffer ~= "" and 1 or 0) > 30 then
            coroutine.resume(printLines, buffer)
            buffer = word
        else
            buffer = buffer .. (buffer ~= "" and " " or "") .. word
        end
    end

    if #buffer > 0 then 
        coroutine.resume(printLines, buffer) 
    end
    coroutine.resume(printLines, nil)

end)

local normalizeWordsLines = coroutine.create(function()
    while true do
        local line = coroutine.yield()
        if not line then
            coroutine.resume(wrapText, nil)
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

            -- linha em branco
            if line:match("^%s*$") then 
                BLANK_LINE = true 
                break
            end

            coroutine.resume(normalizeWordsLines, line)
            previous = string.sub(previous, lineEnd + 1)
        end
    end

    if not BLANK_LINE and #previous > 0 then
        coroutine.resume(normalizeWordsLines, previous)
    end
    coroutine.resume(normalizeWordsLines, nil)
end)

-- Leitura de arquivo em chunks
function readFile(fileName, chunkSize)
    local file = io.open(fileName, "rb")

    while not BLANK_LINE do
        local chunk = file:read(chunkSize)

        if not chunk then break end

        coroutine.resume(splitLines, chunk)
        
    end
    file:close()

    coroutine.resume(splitLines, nil)

    
    coroutine.close(normalizeWordsLines)
    coroutine.close(wrapText)
    coroutine.close(printLines)
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
