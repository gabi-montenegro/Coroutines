function numbers1to3()
    coroutine.yield(1)
    coroutine.yield(2)
    coroutine.yield(3)
  end
  
  function numbers4to6()
    coroutine.yield(4)
    coroutine.yield(5)
    coroutine.yield(6)
  end
  
  function composableIterator()
    return coroutine.wrap(function()
      numbers1to3()
      numbers4to6()
    end)
  end
  
  for value in composableIterator() do
    print(value)
  end
  