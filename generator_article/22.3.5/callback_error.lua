co = coroutine.create(function()
    table.sort({3, 2, 1}, function(a, b)
      coroutine.yield(a < b)
      return a < b
    end)
  end)
  
  print(coroutine.resume(co))
  