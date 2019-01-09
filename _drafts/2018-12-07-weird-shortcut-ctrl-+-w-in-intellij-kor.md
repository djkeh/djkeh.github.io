---
layout: post
categories: blog
title:  "인텔리제이의 이상한 단축키 - ctrl + w"
excerpt: "소스코드 탭을 닫을 줄 알았는데?!"
tags: [intellij,windows,shortcut]
date: 2018-12-07 01:50:38
modified: 2018-12-07 01:50:38
image: 
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

`ctrl+w`는 요즘 웹 브라우저에서 탭을 닫기 위해 즐겨 사용하는 단축키다. 인텔리제이에서도 당연히 소스코드 탭을 닫을 때 될 줄 알고 써봤는데, 실제로 해보니 동작이 영 이상하다.

알아보니 인텔리제이 기본 동작은 좀 다르게 구성되어 있다. 이 단축키는 기본값으로 `Extend Selection`으로 매핑되어 있다. 이는 커서 주변 텍스트 선택 영역을 단계적으로 확장시키는 기능으로, `선택 영역 확장`이라 부르면 될 듯 하다. 기능이 좋은 텍스트 에디터의 경우 이 기능을 가지고 있는 경우가 있다. 바꾸고 싶다면, `Settings > Keymap > Editor Actions > Extend Selection` 동작 단축키를 다른 것으로 옮기고, `Settings > Keymap > Main menu > Window > Editor Tabs > Close`를 `ctrl + w`로 바꾸면 된다.

안바꿨다.

..고 하려다 바꿨다. `Extend Selection` 단축키를 포기했다.

* [https://intellij-support.jetbrains.com/hc/en-us/community/posts/206411479-Keyboard-shortcut-to-close-active-file-tab-](https://intellij-support.jetbrains.com/hc/en-us/community/posts/206411479-Keyboard-shortcut-to-close-active-file-tab-)
