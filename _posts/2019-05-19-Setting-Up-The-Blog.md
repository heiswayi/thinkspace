---
layout: post
title: "Setting up the blog"
description: "Setting up a jekyll blog on github pages"
comments: true
keywords: "dummy content, lorem ipsum"
---

Nowadays, If I want to set up a blog, I have an immense number of options, all of which have different trade-offs in terms of `cost`, `ease of use`, etc. In the following post, I'll try
to explain my choice of platform, and help you in making an informed decision about which platform is the best for you.

### What I needed
I needed a platform where i caould play around with each and every component of the blog, while not burdening myself with the hassles of hosting, domain registration etc.
Also, I wanted to be able to put up, remove and edit posts quickly.

### The options
From my initial google searches, the major contenders were [Wordpress](https://wordpress.org/), [Medium](https://medium.com/), [Blogger](https://www.blogger.com/), [Wix](https://www.wix.com/) and finally [Jekyll](https://jekyllrb.com/).
Almost all of those are free, apart from the [.com version](https://wordpress.com/) of wordpress, which allows you to focus on the content, while they do the rest of the work for you, similar to wix, which 
allows you to set up your blog in a `WYSIWYG` (What you see is what you get) environment, which is pretty cool for beginners. They have ads in the free version, which can be removed 
by upgrading your account.

### Why Github Pages?
Github Pages provides free hosting for your github projects. It's very easy to set up if you know your way around the git environment. It also provides a free github subdomain, 
which is another expense saved. If you already have a domain name, you can easily link that too.

### Why Jekyll?
Jekyll is a static site generator which allows you to generate and set up a website around your content _very_ easily. I used Jekyll Themes, which has pre built themes for you to
use, which makes your work even easier. A post update is just a `git push` away.

### Putting it online
Assuming you have a github account, fork the Theme repo to your account, and change the branch from master to gh-pages. Create a branch if it does not already exist. Thats it. Your 
blog/website will be up and running. Use a git client to update any changes you make, and those will be updated on your site in a few seconds. I found a step by step [video](https://www.youtube.com/watch?v=U0idtvxVo9I) that shows you the whole process.

######Cheers!