# URL Inspector (Lua + AndroLua)

This is a simple project I created while learning how URL and network connection works in Android using Lua (AndroLua / LuaJava).

The main goal of this project is not just to make a tool, but to understand deeply how things like URL parsing and server connection actually work behind the scenes.

---

## 🚀 What this project does

This app takes a URL from user and shows useful information like:

### 🔹 URL Info (Local Parsing)

* Protocol (http / https)
* Host
* Port and Default Port
* Path
* Query
* File
* Authority
* User Info
* Ref

### 🔹 Server Info (Connection)

* Content Type
* Content Length
* Last Modified
* Cache usage
* Basic connection properties

---

## 🧠 What I learned from this project

While building this, I learned:

* How `java.net.URL` works
* Difference between URL parsing and real server connection
* What `openConnection()` actually does
* Basic use of `URLConnection`
* How ListView and ArrayAdapter work in Android Lua
* Common mistakes like adapter not updating or wrong data type

---

## ⚠️ Important Note

Currently, network connection is running on main thread.
So sometimes it can freeze UI.

This is just a learning version.
In next updates I will fix this using threading.

---

## 🛠️ Technologies Used

* Lua (AndroLua / LuaJava)
* Android UI (ListView, Button, EditText)
* Java Networking classes

---

## 📦 Project Structure

* `main.lua` → main logic and event handling
* `layout.lua` → UI layout

---

## 🔮 Future Plans

* Add proper threading (no UI freeze)
* Show HTTP Status Code (200, 404, etc)
* Display full response headers
* Improve UI design
* Convert into reusable Lua module/library

---

## 💡 Why I made this

I like learning by building real things.
Instead of just reading theory, I try to create small tools and understand how they work internally.

This project is part of that journey.

---

## 🙌 Final Note

This is not a perfect project, but it is a strong step in learning.
More improvements coming soon.

If you have suggestions or ideas, feel free to share.

---
