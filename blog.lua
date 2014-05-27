home = function () 
  ngx.print("Startseite<br />")
  for filename in io.popen("ls " .. localpath  .. "/data"):lines() do
    local title = filename:gsub('.txt', "")

    ngx.print('<a href="/' .. title .. '">' .. title  .. '</a><br />') 
  end
end

article = function ()
  ngx.print('<a href="/">Startseite</a></br>')
  local req_file = uri:gsub('/', "")

  succ, file = pcall(assert, io.open(localpath .. "/data/" .. req_file .. ".txt"))
  if succ == true then
    for line in file:lines() do ngx.print(line .. '<br />') end
    file:close()
  else
    ngx.print("fail")
  end
end
