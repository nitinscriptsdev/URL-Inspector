-- Imports
import "java.net.URL"
import "android.widget.ArrayAdapter"
import "android.widget.Button"
-- Requires
local layout = require "layout"

activity.setContentView(layout)

local listItems = {}
local listAdapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, listItems)
listView.setAdapter(listAdapter)

-- Click on Button
get_button.setOnClickListener{
onClick = function()
local text = edit_text.getText().toString()

if text ~= "" then
local success, URL = pcall(function()
return URL(text)
end )

if success then
listItems.clear()
 listAdapter.addAll("Path: " .. tostring(URLObject.getPath()), "Default port: " .. tostring(URLObject.getDefaultPort()))
listAdapter.notifyDataSetChanged()
edit_text.setText("")
else
table.insert(listItems, "Getting...")
end

else
table.insert(listItems, "Invalid link")
end
end
}