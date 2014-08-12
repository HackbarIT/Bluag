local lf = require("luafcgid")

function main(env, con) 
  params = lf.parse(env.QUERY_STRING)
  page = params['p']

  if not page then 
    home()
  else 
    article()
  end
end

home = function()
  con:header("X-Powered-By", "Bluag")
  
  con:puts("Startseite<br />")
  for filename in io.popen("ls data"):lines() do
    local title = filename:gsub('.txt', "")

    con:puts('<a href="/' .. title .. '">' .. title  .. '</a><br />') 
  end
end

article = function ()
  con:puts('<a href="/">Startseite</a></br>')
  local req_file = uri:gsub('/', "")

  succ, file = pcall(assert, io.open(localpath .. "/data/" .. req_file .. ".txt"))
  if succ == true then
    for line in file:lines() do ngx.print(line .. '<br />') end
    file:close()
  else
    con:puts("fail")
  end
end
