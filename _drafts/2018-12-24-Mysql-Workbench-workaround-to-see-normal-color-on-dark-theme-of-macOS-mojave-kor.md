---
layout: post
categories: articles
title:  "MacOS 모하비 다크 테마에서 MySQL Workbench 색깔이 정상적으로 나오게 하는 법"
excerpt: "다크 테마를 쓰지 않으면 됩니다"
tags: [mac,macos,mojave,dark,theme,darktheme,mysql,workbench,color,workaround,맥,맥os,모하비,다크,테마,다크테마,워크벤치,색상,우회,해법]
date: 2018-12-24 16:25:28
modified: 2018-12-24 16:25:28
image: 
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

```
defaults write com.oracle.workbench.MySQLWorkbench NSRequiresAquaSystemAppearance -bool yes
```

## Reference

* [https://bugs.mysql.com/bug.php?id=92902](https://bugs.mysql.com/bug.php?id=92902)
* [https://www.tekrevue.com/tip/exclude-app-dark-mode-macos-mojave/](https://www.tekrevue.com/tip/exclude-app-dark-mode-macos-mojave/)
