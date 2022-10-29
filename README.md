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
    <a href="http://docs.flow.linwood.dev"><b>Website</b></a> •
    <a href="http://docs.flow.linwood.dev/downloads"><b>Download</b></a> •
    <a href="https://linwood.dev/matrix"><b>Matrix</b></a> •
    <a href="https://go.linwood.dev/discord"><b>Discord</b></a> •
    <a href="https://twitter.com/LinwoodCloud"><b>Twitter</b></a> •
    <a href="CONTRIBUTING.md"><b>Contribute</b></a>
</p>  

---

Linwood Flow is a free, opensource time and event management software. You can choose where your data is stored and who can access it. Group your events and manage places and people. The app is available for Windows, Linux, Android and Web.

## Introduction

### Your data is decentralized

Everyone can host their own backend. See [here](https://docs.flow.linwood.dev/server/getting-started) and everyone can
add it to the server list in the settings.

### Manage your time everywhere

You don't need a server. Everything can be saved on the local device or in the cloud.

## Getting started

* **Try the app** [in the web](https://flow.linwood.dev). You have nothing to lose!
* **To download the app**, visit the [download page](https://docs.flow.linwood.dev/downloads). Please
  [use the guide](https://docs.flow.linwood.dev/app) if you need help.
* **To setup your own server**, [download the binaries](https://docs.flow.linwood.dev/downloads)
  and [follow the guide](https://docs.flow.linwood.dev/server)
* **To contribute**, visit the [contribution guide](https://github.com/LinwoodCloud/Flow/blob/develop/CONTRIBUTING.md)
* **To communicate with us**, visit [the discord server](https://discord.linwood.dev)

