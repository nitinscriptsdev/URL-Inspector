-- Imports
require "import" 
import "java.net.URL"
import "java.lang.Thread"
import "java.lang.Runnable"
 import "java.util.Map"
 import "java.util.Iterator"
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
listAdapter.clear()
listAdapter.add("Connecting...")
listAdapter.notifyDataSetChanged()
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

local maxRedirect = 5
local redirect = 0
local connection

while true do
local connection = URLObj.openConnection()
connection.setConnectTimeout(5000)
connection.setReadTimeout(5000)
connection.connect()

local code = connection.getResponseCode()

if code == 301 or code == 302 or code == 307 then
local newURL = connection.getHeaderField("Location")

if newURL ~= nil and redirect < maxRedirect then
 URLObj = URL(newURL)
redirect = redirect + 1
else
break
end
else
break
end
end


local contents = {
"URL: " .. tostring(connection.getURL()),
 "ReadTimeout: " .. tostring(connection.getReadTimeout()),
 "LastModified: " .. tostring(connection.getLastModified()),
 "IfModifiedSince: " .. tostring(connection.getIfModifiedSince()),
 "ContentType: " .. tostring(connection.getContentType()),
 "UseCaches: " .. tostring(connection.getUseCaches()),
}

pcall(function()
local code = connection.getResponseCode()
local msg = connection.getResponseMessage()
table.insert(contents, 1, "Code: " .. code .. ",  Message: " .. msg)
end)

 local headerFields = connection.getHeaderFields()
local entrySet = headerFields.entrySet()
local iterator = entrySet.iterator()

while iterator.hasNext() do
local entry = iterator.next()

local key = entry.getKey()
local value = entry.getValue()

if key ~= nil and value ~= nil then
local variableStr = ""

for i = 0, value.size() - 1 do
 variableStr = variableStr .. tostring(value.get(i))

if i < value.size() - 1 then
variableStr = variableStr .. ", "
end
end

table.insert(contents, key .. ": " .. tostring(variableStr))

end
end

return contents
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