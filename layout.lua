-- Imports
import "android.widget.LinearLayout"
import "android.widget.TextView"
import "android.widget.ArrayAdapter"
import "android.widget.ListView"
import "android.widget.Button"
import "android.widget.EditText"

-- Declare layout
local layout = LinearLayout(activity)
layout.setOrientation(LinearLayout.VERTICAL)

-- Title text
local title = TextView(activity)
 title.setText("URL-Info")
layout.addView(title)

-- Edit text for enter URL
local edit_text = EditText(activity)
 edit_text.setId("enterURLEditText")
 edit_text.setHint("Enter URL")
layout.addView(edit_text)

-- Button for GET info
 connectToURL = Button(activity)
 connectToURL.setText("connectToURL")
layout.addView(connectToURL)

-- connect to server button
connectToServer = Button(activity)
connectToServer.setText("connectToServer")
layout.addView(connectToServer)

-- List for info
 contentList = ListView(activity)
layout.addView(contentList)

-- return complete layout
return layout
