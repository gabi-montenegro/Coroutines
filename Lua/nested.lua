function callee()
    while true do
      local value = coroutine.yield()
      print("callee: " .. tostring(value))
    end
  end
  
  function caller()
    callee() -- chamada direta: a pilha é preservada
  end
  
  local co = coroutine.create(caller)
  coroutine.resume(co)
  coroutine.resume(co, "a")
  coroutine.resume(co, "b")
  -- Saída:
  -- callee: a
  -- callee: b
  