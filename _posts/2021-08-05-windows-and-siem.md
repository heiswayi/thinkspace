---
layout: post
title: "Windows and SIEM, the beginning.."
description: "Windows and SIEM, what is this?"
comments: true
keywords: "windows, siem, splunk, logs, events"
---


Welcome reader, in this post you will find my adventures with Windows, what are logs, how Windows operates and saves logs, how they are sent and what is sent to the SIEM.

## Prologue

Before I begin my journey I must say **do not try this at home** or it will be more appropriate to say **do not try this in production**. If you are a noob like me, do not try this in any kind of production and do not follow it as a tutorial. The environment in which I will test my dangerous pursuit is a Windows Server 2019 with some dummy users in it, the SIEM is running on the latest Ubuntu available at this point of writing the "post".

<div style="text-align: center"><img src="/assets/images/1.png" width="216" height="290"></div>


## Windows

Let's start with what is Windows and what are the logs. What is windows, basically this is a operating system used in most of the modern environments to help operate and manage the daily tasks of the users (employees). There different variations of windows, based on my quick research I've stumbled upon the following [wikipedia page](https://en.wikipedia.org/wiki/Microsoft_Windows) there are shown and written the versions which start from a simple end-user orientated windows like, windows 8.1, windows 10 and the older version windows xp, windows vita and so on. Okay, but what does that all mean? What is the connection between Windows 10 and logs, and many users in a big environment? Every person and in this case a user has all kinds of intentions while using the corporate laptop or a computer, and now the role of the system administrator comes in place. The system administrator is responsible for the availability of every system either a PC, laptop, router and/or a printer. How would the system administrator will manage hundrets or thousands of users? Now it comes the key role of the Active Directory. Think for the Active directory as a huge building and every person that steps in that building has a dedicated floor or a room in which he has the access (keys) for.

![SCREENSHOT](https://i.imgur.com/D6P2qz0.png)

And now the core issue, how would a system administrator now what the users are doing on their workstations? The logs. I know, no one expected that. Basically, the purpose of the logs are to show the state of the system and/or to show the generated incidents or events by the user on XYZ workstation on ABC floor/room. But, but... there might be thousand of lines in the logs. True, you are completely right in this case, that's why the SIEM comes in places. Before we transition to the SIEM, let's dive a bit more about the windows logs and/or events.
**Event logging** (named by Microsoft) is used to track and be aware of the errors/actions in any kind of application in the system. Quoting.. "*Event logging provides a standard, centralized way for applications (and the operating system) to record important software and hardware events. The event logging service records events from various sources and stores them in a single collection called an event log. The Event Viewer enables you to view logs; the programming interface also enables you to examine logs.*" But you will state, what if they are 100 workstations and more than 1000 events are coming from those workstations to the system administrator, or to be technically correct, to the Active directory machine. And now is the time to transition to the SIEM part of the post.

![SCREENSHOT](https://i.imgur.com/1Idzt94.png)

## SIEM

What is SIEM, and why I'm using the abbreviation - quick answer it's easy to remember SIEM, rather ***S**ecurity **I**nformation and **E**vent **M**anagement*. Right? I hope so. It is basically a monitoring system, think of it as pacman, it consumes a lot of data by a lot I mean huge chunks of data. But how does that help us, but windows stores the logs locally, why do we need another system to spend time and time to find the correct log or the pattern of an logged incident? The SIEM has the capability to "ask questions" or "demand" information based on a words that are meaningful for you. For example, you are hosting a website and you want to see every requests that is mark as "Error" or technically said as 404. You will create a query searching only for requests that are 404 and with this query you will remove the logs or requests that were other than 404 such as 200, 302 and etc. The technical term that I will use is structured languaged search. Every SIEM has a different query language, for instance on QRadar (IBM) is called *ariel query languange* (AQL) and for Splunk is *search processing languange* (SPL). And at this point I will stop about the SIEM, I know that you are bored, if you managed to get so far in the post. In the future posts I hope that I will include more and more interesting information about the monster SIEM.

![SCREENSHOT](https://i.imgur.com/8UWMVCV.png)

## Lab adventure

The time has come!! I'm going to show you how Windows Events and SIEM go hand to hand. Will it be easy? I honestly have no idea. The environment that I'm going to use is going to be a Windows Server 2019, Ubuntu on which my SIEM is running in this case is Splunk and Kali Linux which I'm going to use as an attack machine and will try to break into the Windows Server. The topology is shown below.

![SCREENSHOT](https://i.imgur.com/16P2IFJ.png)

Obviously, the machines are seeing each other, the ports open on the Windows machine are the default ones (out of the box). There is no router or DMZ between them. For a simplicity in showing the ports open on the windows machine, I will scan it using nmap. (What is nmap - https://en.wikipedia.org/wiki/Nmap). And after approx. one minute we get the results from nmap. As you can see there are many ports open, but in this post I will be focusing on the SMB ports (What is SMB - [https://en.wikipedia.org/wiki/Server\_Message\_Block](https://en.wikipedia.org/wiki/Server_Message_Block))

![SCREENSHOT](https://i.imgur.com/mfKQNKs.png)
I'll be using the famous EternalBlue exploit. A little information what vulnerability is exploiting EternalBlue. "*The EternalBlue exploit works by taking advantage of SMBv1 vulnerabilities present in older versions of Microsoft operating systems. SMBv1 was first developed in early 1983 as a network communication protocol to enable shared access to files, printers, and ports. It was essentially a way for Windows machines to talk to one another and other devices for remote services.*" \- Avast (https://www.avast.com/c-eternalblue). Do you think that our version of Windows Server is vulnerable to this exploit, I will leave that for your own research.

![SCREENSHOT](https://i.imgur.com/TTdwDAX.png)

As you can see if we do not structure our search, we will get many events, most of them are not relevant for our test. The purpose of this test (exercise) is to see if an event is being triggered from this exploit on the Windows Server and if yes, is the event stored in the logs.

Seeing the output of the error, it appears that the machine at this point with this configuration is not vulnerable to this exploit.

![SCREENSHOT](https://i.imgur.com/8ZNt5nh.png)

Awesome, we are not that vulnerable. Now the question is did that exploit generate any kind of logs, and can we find them? If you have done your research you will know that the exploit is trying to log in "anonymously". Let's adjust our search query and see if there are any logs. The exploit, succeed to log in anonymously in the SMB, but failes to escalate it's privileges which results in the exploit to fail. The good thing is that Windows has created an event (log) and stores it, also for our enjoyment the log was sent and stored in the SIEM as well.

![SCREENSHOT](https://i.imgur.com/y9vUswA.png)

The purpose of this exercise was to show how easily windows can be exploited, if you are not updating or configuring your system in a way that becomes more and more vulnerable. Of course and event can be generated upon an alleged attack, but remember the attacks become more and more sophisticated and zero days become more noticable and impactful in our day-to-day life using any kind of an operating system. The SIEM is a powerful tool in the hands of a skilled person, and most of the attacks could be catch in no time and mitigated.
