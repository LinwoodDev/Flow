<!--suppress HtmlDeprecatedAttribute -->
<div align="center">
  <img alt="Linwood Flow Logo" src="https://raw.githubusercontent.com/LinwoodCloud/Flow/develop/app/images/logo.png" width="350px">

# Linwood Flow

> Free, opensource time and event management software

[![Latest release)](https://img.shields.io/github/v/release/LinwoodCloud/Flow?color=7C4DFF&style=for-the-badge&logo=github&logoColor=7C4DFF)](https://github.com/LinwoodCloud/Flow/releases)
[![GitHub License badge](https://img.shields.io/github/license/LinwoodCloud/dev_doctor?color=7C4DFF&style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiBmaWxsPSIjZWJiNzMzIiB2aWV3Qm94PSIwIDAgMjU2IDI1NiI%2BPHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIGZpbGw9Im5vbmUiPjwvcmVjdD48cmVjdCB4PSIzMiIgeT0iNDgiIHdpZHRoPSIxOTIiIGhlaWdodD0iMTYwIiByeD0iOCIgc3Ryb2tlLXdpZHRoPSIxNiIgc3Ryb2tlPSIjZWJiNzMzIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGZpbGw9Im5vbmUiPjwvcmVjdD48bGluZSB4MT0iNzYiIHkxPSI5NiIgeDI9IjE4MCIgeTI9Ijk2IiBmaWxsPSJub25lIiBzdHJva2U9IiNlYmI3MzMiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIxNiI%2BPC9saW5lPjxsaW5lIHgxPSI3NiIgeTE9IjEyOCIgeDI9IjE4MCIgeTI9IjEyOCIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZWJiNzMzIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iMTYiPjwvbGluZT48bGluZSB4MT0iNzYiIHkxPSIxNjAiIHgyPSIxODAiIHkyPSIxNjAiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI2ViYjczMyIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjE2Ij48L2xpbmU%2BPC9zdmc%2B)](https://github.com/LinwoodCloud/Flow/blob/main/LICENSE)
[![GitHub Repo stars](https://img.shields.io/github/stars/LinwoodCloud/Flow?color=7C4DFF&logo=github&logoColor=7C4DFF&style=for-the-badge)](https://github.com/LinwoodCloud/Flow)
[![Matrix badge](https://img.shields.io/matrix/linwood:matrix.org?style=for-the-badge&color=7C4DFF&logo=matrix&logoColor=7C4DFF&label=Matrix)](https://linwood.dev/matrix)
[![Discord badge](https://img.shields.io/discord/735424757142519848?style=for-the-badge&color=7C4DFF&logo=discord&logoColor=7C4DFF&label=Discord)](https://discord.linwood.dev)
[![Download](https://img.shields.io/github/downloads/LinwoodCloud/Flow/total?color=7C4DFF&style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIxOTIiIGhlaWdodD0iMTkyIiBmaWxsPSIjZWJiNzMzIiB2aWV3Qm94PSIwIDAgMjU2IDI1NiI+PHJlY3Qgd2lkdGg9IjI1NiIgaGVpZ2h0PSIyNTYiIGZpbGw9Im5vbmUiPjwvcmVjdD48cG9seWxpbmUgcG9pbnRzPSI4NiAxMTAuMDExIDEyOCAxNTIgMTcwIDExMC4wMTEiIGZpbGw9Im5vbmUiIHN0cm9rZT0iI2ViYjczMyIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIiBzdHJva2Utd2lkdGg9IjE2Ij48L3BvbHlsaW5lPjxsaW5lIHgxPSIxMjgiIHkxPSI0MCIgeDI9IjEyOCIgeTI9IjE1MS45NzA1NyIgZmlsbD0ibm9uZSIgc3Ryb2tlPSIjZWJiNzMzIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIHN0cm9rZS13aWR0aD0iMTYiPjwvbGluZT48cGF0aCBkPSJNMjE2LDE1MnY1NmE4LDgsMCwwLDEtOCw4SDQ4YTgsOCwwLDAsMS04LThWMTUyIiBmaWxsPSJub25lIiBzdHJva2U9IiNlYmI3MzMiIHN0cm9rZS1saW5lY2FwPSJyb3VuZCIgc3Ryb2tlLWxpbmVqb2luPSJyb3VuZCIgc3Ryb2tlLXdpZHRoPSIxNiI+PC9wYXRoPjwvc3ZnPg==)](https://docs.flow.linwood.dev/downloads)

</div>


<p align="center">
    <a href="https://docs.flow.linwood.dev"><b>Website</b></a> •
    <a href="https://docs.flow.linwood.dev/downloads"><b>Download</b></a> •
    <a href="https://linwood.dev/matrix"><b>Matrix</b></a> •
    <a href="https://go.linwood.dev/discord"><b>Discord</b></a> •
    <a href="https://twitter.com/LinwoodCloud"><b>Twitter</b></a> •
    <a href="CONTRIBUTING.md"><b>Contribute</b></a>
</p>  

---

Linwood Flow is a free, opensource time and event management software. You can choose where your data is stored and who can access it. Group your events and manage places and people. The app is available for Windows, Linux, Android and Web.

## Features

* **⚡ Simple and intuitive:** Every tool is in the right place. Open the app and start managing your time. Invite people to your events and share your calendar with them.
* **📝 Support your favorite formats:** Import and export your old notes and events. Set the app as your default calendar app and use it with your favorite apps.
* **📱 Works on every device:** The app is available for android, windows, linux, and in the web. You can use it on your phone, tablet, or computer.
* **💻 Choose where your data is stored:** You can choose to store your data locally, in your favorite cloud (webdav) or decentralized using S5. You can also export your data to a file and import it again.
* **🌐 Available in many languages:** The app is available in many languages. Help us to translate this app to your language.
* **📚 FOSS:** The app is open source and free. You can contribute to the project and help to make it better.
* **🔋 Use it offline:** You can use the app offline. You can draw, paint, and export your notes without an internet connection.
* **📅 Manage your time:** You can manage your time using a calendar. You can add events to it and share them with your friends.
* **🏠 Manage your places:** You can add places to the app and share them with your friends. Keep track which places are free and which are busy.
* **👥 Manage users:** Add users to the app to keep track of who is available and who is not. You can also share your calendar with them. Add birthdays to the app and get a notification when it is time to celebrate.
* **📜 Manage your tasks:** You can add tasks to the app and share them with your friends. You can also add your favorite tasks to the app. Set a deadline and get notified when it is due.
* **📝 Take notes:** You can add files and notes to your events. Add a backlog to your events to keep track of your progress.
* **📁 Group your events:** Group your events to know which events are related to each other. You can also add tags to your events to find them faster.
* **⏳ Irregular events:** You can add irregular events to the app. Have irregular meetings? Add them to the app and get notified when it is time to meet. Simply copy the event and change the date.

## Getting started

* **Try the app** [in the web](https://flow.linwood.dev). You have nothing to lose!
* **To download the app**, visit the [download page](https://docs.flow.linwood.dev/downloads). Please
  [use the guide](https://docs.flow.linwood.dev/app) if you need help.
* **To setup your own server**, [download the binaries](https://docs.flow.linwood.dev/downloads)
  and [follow the guide](https://docs.flow.linwood.dev/server)
* **To contribute**, visit the [contribution guide](https://github.com/LinwoodCloud/Flow/blob/develop/CONTRIBUTING.md)
* **To communicate with us**, visit [the discord server](https://discord.linwood.dev)
