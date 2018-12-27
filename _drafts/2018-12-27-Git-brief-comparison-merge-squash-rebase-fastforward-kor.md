---
layout: post
categories: articles
title:  "Git 머지 전략 간략 정리 - Merge, Squash, Rebase, Fast-Forward"
excerpt: "정확한 차이를 이해하여 더 멋진 브랜치 정리를 해봅시다"
tags: [git,github,merge,squash,rebase,fastforward,technique,technic,vcs,versioncontrol,branch,깃,깃허브,깃헙,머지,스쿼시,리베이스,패스트포워드,테크닉,버전컨트롤,버전,관리,브랜치]
date: 2018-12-27 16:31:05
modified: 2018-12-27 16:31:05
image: 
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

## Merge

두 브랜치 노드를 합치는 새로운 commit(노드) 생성

## Squash and Merge

여러 노드 체인을 하나로 합친 새로운 노드를 만든 후, 두 브랜치 노드를 합치는 새로운 노드 생성

## Fast-Forward Merge

노드 생성 없이 브랜치 포인터를 단순히 이동

## Rebase

현재 브랜치의 변경점을 모두 대상 브랜치로 복사

## Reference

* [https://git-scm.com/book/ko/v2/Git-브랜치-브랜치와-Merge-의-기초](https://git-scm.com/book/ko/v2/Git-브랜치-브랜치와-Merge-의-기초)
* [https://docs.gitlab.com/ee/user/project/merge_requests/fast_forward_merge.html](https://docs.gitlab.com/ee/user/project/merge_requests/fast_forward_merge.html)
* [ttps://git-scm.com/book/ko/v2/Git-브랜치-Rebase-하기](ttps://git-scm.com/book/ko/v2/Git-브랜치-Rebase-하기)
* [https://git-scm.com/book/ko/v2/Git-브랜치-브랜치-관리](https://git-scm.com/book/ko/v2/Git-브랜치-브랜치-관리)
