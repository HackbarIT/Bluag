local lf = require("luafcgid")

function main(env, con)
  params = lf.parse(env.QUERY_STRING)
  page = params['p']
 
  if not page then 
    home(env, con)
  elseif page == "html" then
    html(env, con) 
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
    for line in file:lines() do con:puts(line .. '<br />') end
    file:close()
  else
    con:puts("fail")
  end
end

html = function (env, con)
	template_succ, template_file = pcall(assert, io.open("template/index.html"))
	if template_succ == true then
		for line in template_file:lines() do 
			local content = string.find(line, "BluagContent")
			if content then
				con:puts(getContent)
			else
				con:puts(line .. '\n') 
			end
		end
		template_file:close()
	else
		con:puts("fail2")
	end
end

function getContent()

	local content = ""

	content_succ, content_file = pcall(assert, io.open("data/test.txt"))
	if content_succ == true then
		for content_line in content_file:lines() do
			if not string.find(content_line, '#.*') then
				content = content .. '<p>' .. content_line .. '</p>'
			end
		end
		content_file:close()
	else
		con:puts("fail")
	end
	return content
end
