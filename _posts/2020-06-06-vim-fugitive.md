---
layout: post
title: "vim-fugitive"
description: "How to work with git without leaving VIM"
comments: true
keywords: "vim"
---

### Introduction
This is my workflow before I find out the best way to work with git right inside VIM:

- Edit a file, save it
- Make a new `tmux` pane by: `<C-b>-`
- `git diff` and whatever 

After watching this video [https://www.youtube.com/watch?v=PO6DxfGPQvw&t=375s](https://www.youtube.com/watch?v=PO6DxfGPQvw&t=375s), I found out that there is a simpler way to interact with git without leaving the vim

### Installation

```bash
Plug 'tpope/vim-fugitive'

nmap <leader>gh :diffget //3<cr>
nmap <leader>gu :diffget //2<cr>
nmap <leader>gs :G<cr>
```

Source the vim configuration file and then

```bash
:PlugInstall
```

Alright, you're ready to work with `vim-fugitive`

### Scenarios
There are some scenarios occur in my everyday workflow

#### git status

```bash
<leader>gs
```

#### Add files to staged

Navigate to file name inside `<leader>gs` popup, and then press `a`

#### Unstage a file

Navigate again to the file name which was staged by previous step, and then press `u`

### Commit

After update files and stage all the file you need, you can make a commit by:
```bash
:Gcommit
```
and then, `vim-fugitive` will turn on a popup for you to fill in the commit message, after that you can use `:wq` to save the commit message as a normal file
