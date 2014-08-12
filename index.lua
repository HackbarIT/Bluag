local lf = require("luafcgid")

function main(env, con)
  params = lf.parse(env.QUERY_STRING)
  page = params['p']
 
  if not page then 
    home(env, con)
  else 
    article(env, con)
  end
end

home = function(env, con)
  con:header("X-Powered-By", "Bluag")
  
  con:puts("Startseite<br />")
  for filename in io.popen("ls data"):lines() do
    local title = filename:gsub('.txt', "")

    con:puts('<a href="?p=' .. title .. '">' .. title  .. '</a><br />') 
  end
end

article = function (env, con)
  con:puts('<a href="/">Startseite</a></br>')

  succ, file = pcall(assert, io.open("data/" .. page .. ".txt"))
  if succ == true then
    for line in file:lines() do ngx.print(line .. '<br />') end
    file:close()
  else
    con:puts("fail")
  end
end
