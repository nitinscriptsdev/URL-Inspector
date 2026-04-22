-- Imports
require "import" 
import "java.net.URL"
import "java.lang.Thread"
import "java.lang.Runnable"
import "android.widget.ArrayAdapter"
import "android.widget.Button"

-- Requires
local layout = require "layout"

activity.setContentView(layout)

-- Create table for items.
local listItems = {}
local listAdapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, listItems)
 contentList.setAdapter(listAdapter)

-- Click on Button
connectToURL.setOnClickListener{
onClick = function()
local text = edit_text.getText().toString()

if text ~= "" then
local success, url = pcall(function()
return URL(text)
end )

if success then
listAdapter.clear()
content = {
"Path: " .. tostring(url.getPath()),
 "Default port: " .. tostring(url.getDefaultPort()),
 "Ref: " .. tostring(url.getRef()),
 "UserInfo: " .. tostring(url.getUserInfo()),
 "Query: " .. tostring(url.getQuery()),
 "Protocol: " .. tostring(url.getProtocol()),
 "Port: " .. tostring(url.getPort()),
 "Host: " .. tostring(url.getHost()),
 "File: " .. tostring(url.getFile()),
 "Authority: " .. tostring(url.getAuthority())
}
listAdapter.clear()
listAdapter.addAll(content)
listAdapter.notifyDataSetChanged()
edit_text.setText("")
else
listAdapter.clear()
listAdapter.add("Something went wrong")
listAdapter.notifyDataSetChanged()
end

else
listAdapter.clear()
listAdapter.add("Invalid link")
listAdapter.notifyDataSetChanged()
end
end
}

-- connectToServer
connectToServer.setOnClickListener{
onClick = function()
local text = edit_text.getText().toString()

if text == "" then
listAdapter.clear()
listAdapter.add("URL cannot be empty")
listAdapter.notifyDataSetChanged()
return
end

if not text:match("^https?://") then
text = "https://" .. text
end

Thread(Runnable{
run = function()

local success, URLObj = pcall(function()
return URL(text)
end)

if success then
local ok, content = pcall(function()
local connection = URLObj.openConnection()
connection.setConnectTimeout(5000)

return {
"URL: " .. tostring(connection.getURL()),
 "ReadTimeout: " .. tostring(connection.getReadTimeout()),
 "LastModified: " .. tostring(connection.getLastModified()),
 "IfModifiedSince: " .. tostring(connection.getIfModifiedSince()),
 "ContentType: " .. tostring(connection.getContentType()),
 "UseCaches: " .. tostring(connection.getUseCaches()),
 "HeaderFields: " .. tostring(connection.getHeaderFields())
}
end)

if not ok then
activity.runOnUiThread(function()
listAdapter.clear()
listAdapter.add("Something went wrong !")
listAdapter.notifyDataSetChanged()
end)
return
end


activity.runOnUiThread(function()
listAdapter.clear()
listAdapter.addAll(content)
listAdapter.notifyDataSetChanged()
end)

else

activity.runOnUiThread(function()
listAdapter.clear()
listAdapter.add("Invalid URL")
listAdapter.notifyDataSetChanged()
end)
end
end }).start()
end
}