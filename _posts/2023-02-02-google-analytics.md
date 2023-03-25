---
layout: post
title: "Google Analytics"
description: "What Google Analytics is and how it works"
comments: false
keywords: "google, services, cookies, tracking"
---
# What is it? 

Google Analytics is a tool that shows its customer how visitors use their website. Although it does not cost any money, it is **NOT** free and open-source software. 

Google Analytics may help its customer with:
- measuring their website performance
- marketing
- analyzing demography of visitors
- optimizing website pages

# How does it work?

After signing up and pasting a few lines of JavaScript code into the customer's website, GA is going to start tracking visitors. This code looks for a _ga cookie (more information below) or if there is no _ga cookie, it creates this, Client ID is sent to Google Analytics servers and then Google shares statistics with Google Analytics' customer about theirs website.    

## \_ga cookie

This cookie stores your **Client ID**. It stores unique information about user's browser and device.   

Example:
**GA1.2.12349876.1500644855**

- GA - Google Analytics 
- 1 - version of the cookie format that's being used. It is fixed
- 2 - points a domain where the cookie is set. It represents a number of dots between subdomains and root domains (i.e. example.com = 1, www.example.com = 2)
- 12349876 - randomly generated number used for identifying users 
- 1500644855 - timestamp of when a user first visited a site

# Alternatives 

I mentioned that Google Analytics is not free and open-source. For more information about FOSS alternatives, I recommend [this](https://opensource.com/article/18/1/top-5-open-source-analytics-tools) article. 

# Sources 
- https://www.bounteous.com/insights/2019/12/23/how-google-analytics-uses-cookies-identify-users
- https://www.monsterinsights.com/how-does-google-analytics-work-beginners-guide/
- https://www.youtube.com/watch?v=NaAyrKrA0os
- https://www.digitalthirdcoast.com/blog/how-does-google-analytics-actually-work
