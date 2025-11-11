local promise = require("promise")

local function readFileInChunks(filename, chunkSize)
  return promise.async(function()
    local file = io.open(filename, "rb")
    if not file then
      return nil, "Erro ao abrir o arquivo"
    end

    local content = {}
    while true do
      local chunk = file:read(chunkSize)
      if not chunk then break end
      table.insert(content, chunk)
    end
    file:close()

    return table.concat(content)
  end)
end

-- Uso:
local result = readFileInChunks("input.txt", 1024)
result:next(function(content)
  print("Conteúdo do arquivo:", content)
end):catch(function(err)
  print("Erro:", err)
end)
