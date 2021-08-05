---
layout: post
title: "Windows and SIEM, the beginning.."
description: "Windows and SIEM, what is this?"
comments: true
keywords: "windows, siem, splunk, logs, events"
---

# Windows and SIEM, the beginning

Welcome reader, in this post you will find my adventures with Windows, what are logs, how Windows operates and saves logs, how they are sent and what is sent to the SIEM.

## Prologue

Before I begin my journey I must say **do not try this at home** or it will be more appropriate to say **do not try this in production**. If you are a noob like me, do not try this in any kind of production and do not follow it as a tutorial. The environment in which I will test my dangerous pursuit is a Windows Server 2019 with some dummy users in it, the SIEM is running on the latest Ubuntu available at this point of writing the "post".

<div style="text-align:center"><img src=":/811f603e20674db99b38aba4c7183443" alt="7d9172fa04a5ef632671f2b3d56f459e.png" width="216" height="290"></div>

## Windows

Let's start with what is Windows and what are the logs. What is windows, basically this is a operating system used in most of the modern environments to help operate and manage the daily tasks of the users (employees). There different variations of windows, based on my quick research I've stumbled upon the following wikipedia page (https://en.wikipedia.org/wiki/Microsoft_Windows) there are shown and written the versions which start from a simple end-user orientated windows like, windows 8.1, windows 10 and the older version windows xp, windows vita and so on. Okay, but what does that all mean? What is the joint between Windows 10 and logs, and many users in a big environment? 