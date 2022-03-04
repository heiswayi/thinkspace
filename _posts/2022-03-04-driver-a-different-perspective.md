---
layout: post
title: "Driver a different perspective"
description: "Indicators of compromise, what is this?"
comments: true
keywords: "driver, htb, thor-lite, ioc"
---


Welcome reader! In this post, you will find my different perspective on Driver an easy based windows machine on [HackTheBox](https://hackthebox.com). 


<div style="text-align: center"><img src="/assets/images/post2_driver_machine.png"></div>

## Prologue

Before I begin the explanation and the "different perspective" consists of going through the IOC (Indicator[s] of compromise), I must add that this is done in a controlled virtualized environment, the machine is retired which means that everyone that has an VIP or VIP+ subscription can go through it. The instrument(s) that I will be using will mostly be metasploit and Thor Lite, more information about Thore Lite could be found in the next few lines. 

## Driver

An introduction for the machine, the machine is based on Windows and simulates a weak password policy, that gains access to a printer firmware update center where every person can upload a file or files. Those file(s) are automatically executed by the system which leads into hash leaking and results in password cracking of the user on the machine. The computer has a local privilege escalation vulnerability based on the Ricoh printer drivers software version, more about the vulnerability could be found in the following [blogpost](https://www.pentagrid.ch/en/blog/local-privilege-escalation-in-ricoh-printer-drivers-for-windows-cve-2019-19363/). I'm not going to go through the explotation process/steps of the machine as they are many good blogs out there on the machine and I strongly recommend you to read them, in order to understand the different approaches of exploiting the machine and thought processes of the writers.

## The IOC adventure

What is IOC you might ask. IOC is the abbreviature of Indicators of Compromise, and the next question that you may arise what is an indicator of compromise, an IOC is a piece of data, found in a system file or log entries that could classify as malicious activity on a system or a network. If we can monitor for such kind of indicators we can build up a picture of a potential breach which can result in finding the methodologies, tools and exploits used for either lateral movement, privilege escalation or any other activity classified as malicious. 

<div style="text-align: center"><img src="/assets/images/post2_puzzle.png"></div>

The tool that I'm going to use to scan for any potential IOCs that I intentionally left on the target system is [Thor Lite](https://www.nextron-systems.com/thor-lite/i). Thor Lite is a scanner for simple indicators of compromise. It uses YARA based rules. More information about YARA can be found in here - https://github.com/plusvic/yara

Output of the scan can be in a text format or in a HTML one. Of course as I'm engineer and I like to see colors will be using the HTML version of the IOC Thor-Lite scan.

<div style="text-align: center"><img src="/assets/images/post2_IOC.png"></div>

Result wise it only found logs related to winPEAS that is part of the [PEASS-ng - Privilege Escalation Awesome Scripts SUITE](https://github.com/carlospolop/PEASS-ng). And it didn't find the msfvenom payload that I dropped while I was logged in as the user tony, also the .scf file wasn't been found. But, let's focus on the logs related to winPEAS as it's still somewhat of an information and indicator that could be related to gathering more information about the system used by the malicious actor.

<div style="text-align: center"><img src="/assets/images/post2_thor-1.png"></div>
<div style="text-align: center"><img src="/assets/images/post2_thor-2.png"></div>
<div style="text-align: center"><img src="/assets/images/post2_thor-3.png"></div>

Based on the warning shown in the screenshot, we can take a note that it was owned by tony and uploaded by the actor using that user account. As per the screenshot the instrument has identified the owner of the file, the hashes, signatures and so on. It has been assigned a score of 80 with type UNKNOWN. Which I don't quite understand, maybe I need to dig more into the documentation for the instrument. Winpeas has been referenced by filename and github page. A different view of another warning caused by winPEAS can be found below. Again it marks it as a "possibly dangerous file", provides the path to us, the ownership of the file and more information on how it got detected and it was based on the YARA rule(s) as it matches on some of the bytes.

<div style="text-align: center"><img src="/assets/images/post2_files.png"></div>

## Conclusion

It is a good instrument, but the files and methodologies that I dropped were not found by it, which were a msfvenom payload, a stable metasploit reverse shell in which a privilege escalation tool (payload) was used to identify a possible privilege escalation vector/software/driver.
