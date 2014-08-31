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
	template_succ, template_file = pcall(assert, io.open("template/index.html"))
	local content, meta = getContent()

	if content == nil then
		con:puts("404")
		return
	end

	if template_succ == true then
		for line in template_file:lines() do 
			if string.find(line, "BluagContent")  then
				con:puts(content)
			elseif string.find(line, "BluagMeta") then
				line = string.gsub(line, "BluagMetaAuthor", meta["author"])
				line = string.gsub(line, "BluagMetaDate", meta["date"])
				line = string.gsub(line, "BluagMetaTitle", meta["title"])
				con:puts(line .. '\n') 
			else
				con:puts(line .. '\n')
			end
		end
		template_file:close()
	else
		con:puts("Cannot open Template file")
	end
end

function getContent()

	local content = ""
	local meta = {}

	content_succ, content_file = pcall(assert, io.open("data/" .. page .. ".txt"))
	if content_succ == true then
		for content_line in content_file:lines() do
			if not string.find(content_line, '#.*') then
				content = content .. '<p>' .. content_line .. '</p>'
			else
				local name = string.match(content_line, "(%a+)")
				local var  = string.sub(content_line, string.find(content_line, "=")+1, -1)
				meta[name] = var
			end
		end
		content_file:close()
	else
		return nil	
	end
	return content, meta
end
