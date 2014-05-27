-- path to the blog directory
localpath = ngx.var.root
uri = ngx.var.uri

-- set http header
ngx.header.content_type = 'text/html; charset=UTF-8'

dofile(localpath .. "/blog.lua")

if uri == "/" then home() 
else article() end
