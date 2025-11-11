local BLANK_LINE = false

local function printLines(line)
    print(line)
end

local function wrapText(words, buffer, flush)
    for _, word in ipairs(words) do
        if #buffer + #word + (#buffer > 0 and 1 or 0) > 30 then
            printLines(buffer)
            buffer = word
        else
            buffer = buffer .. (#buffer > 0 and " " or "") .. word
        end
    end

    if flush and #buffer > 0 then
        printLines(buffer)
        buffer = ""
    end

    return buffer
end

local function normalizeWordsLines(line)
    local words = {}
    for word in string.gmatch(line, "[^%s]+") do
        table.insert(words, word)
    end
    return words
end

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

local function readFile(fileName, chunkSize)
    local file = io.open(fileName, "rb")
    local previous = ""
    local buffer = "" 

    while not BLANK_LINE do
        local chunk = file:read(chunkSize)
        if not chunk then break end

        local lines
        lines, previous = splitLines(chunk, previous)
        
        for _, line in ipairs(lines) do
            local words = normalizeWordsLines(line)
            buffer = wrapText(words, buffer)
        end
    end

    if not BLANK_LINE and #previous > 0 then
        local words = normalizeWordsLines(previous)
        buffer = wrapText(words, buffer)
    end
    wrapText({}, buffer, true)

    file:close()
end

local fileName = arg[1]
readFile(fileName, 16)
