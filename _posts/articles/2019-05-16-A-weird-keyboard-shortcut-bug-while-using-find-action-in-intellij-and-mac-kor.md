---
layout: post
categories: articles
title:  "인텔리제이, 맥 - find action 단축키 사용 버그"
excerpt: "어처구니 없는 맥OS 단축키 버그 해결"
tags: [macos, ide]
date: 2019-05-16 18:53:48
last_modified_at: 2019-05-16 18:53:48
---

## `shift-command-a` 버그

오늘 맥OS에서 인텔리제이를 사용하던 도중 어처구니 없는 상황을 만났습니다. 단축키 하나가 생각나지 않아서 평소처럼 `shift-command-a` 단축키로 `find action` 창을 열어 기능을 찾아보려고 하는데,

![Intellij - Find Action](/images/20190516_shortcut_bug/1.png "인텔리제이 - Find Action")

이렇게 잘 되다가 두 번째 `find action` 단축키를 누르자 이런 처음 보는 터미널 창이 열려버립니다.

![WTF](/images/20190516_shortcut_bug/2.png "WTF")

이런 예상치 못한 일이 생기면 어디서부터 문제를 알아내야 하나 난감하기도 하죠. 구글 검색어를 뭐로 할 지 애매한 경우도 왕왕 있고요. 이번 경우에는 다행히 원인을 빨리 찾았습니다.


## 원인

macOS Mojave (모하비) 10.14.4 에서 생긴 변경점으로, `shift-command-a`를 누를 경우 터미널에서 `man` 페이지를 열어 내용을 인덱스 검색하도록 하는 편의 기능이 추가되었습니다.


## 해결 방법

`시스템 환경설정 > 키보드 > 단축키 탭 > 서비스` 항목으로 들어가서, `터미널에서 man 페이지 인덱스 검색` 단축키 기능을 체크박스 해제하거나 다른 단축키로 바꾸면 됩니다.

![Solution - Keyboard shortcut configuration](/images/20190516_shortcut_bug/3.png "해결책 - 키보드 단축키 설정")

하는 김에 `터미널에서 man 페이지 열기`도 그냥 같이 해제해 버렸어요.

기능 넣었다고 말 좀 해주지...  
...아마 해줬을 수도 있겠죠...  
...일일이 잘 보지 않는다고...


## Reference

* ​[https://intellij-support.jetbrains.com/hc/en-us/community/posts/360003367639-2019-1-Find-Action-shortcut-opens-terminal-securityuploadd-](https://intellij-support.jetbrains.com/hc/en-us/community/posts/360003367639-2019-1-Find-Action-shortcut-opens-terminal-securityuploadd-)
* ​[https://youtrack.jetbrains.com/issue/IDEA-209726#focus=streamItem-27-3361953.0-0](https://youtrack.jetbrains.com/issue/IDEA-209726#focus=streamItem-27-3361953.0-0)
