---
layout: post
categories: articles
title:  "리모트 저장소에 푸시한 커밋은 리베이스하지 말 것"
excerpt: "\"Pro Git\"에서 배우는 리베이스 주의사항"
tags: [git, rebase, merge, pro, progit, caution, technique, versioncontrol, 깃, 프로, 프로깃, 리베이스, 머지, 형상관리, 요령]
date: 2018-01-25 17:20:00
modified: 2018-01-25 17:20:00
image: 
  feature: 
  credit: 
  creditlink: 
share: true
sitemap: true
---

리베이스(rebase)는 상황에 따라 유용한 머지 전략 중 하나이지만, 어떻게 작동하는지 잘 이해하지 않은 상태에서 사용하면 큰 불편을 초래하기도 합니다.
제게 그런 일이 일어났었죠.

![wrong rebase](/images/20180125_wrong_rebase/1.png "rebase 했는데, 뭔가 이상하다")

`feature/v.2.0` 브랜치에서 새로운 feature 브랜치를 만들어, `feature/#462-uno-xxx-helper`를 진행합니다. 이 개발 내용은 `feature/v.2.0` 개발 내용의 일부를 독립적으로 작업한 뒤 다시 `feature/v.2.0`에 하나로 합칠 목적입니다. 작업을 진행했고, 그 사이 동료 프로그래머도 `feature/v.2.0` 개발에 진척이 있었습니다. `feature/v.2.0`는 `feature/#462-uno-xxx-helper`의 모체이므로, `feature/v.2.0`의 변경사항을 가져오기 위해 `rebase`를 선택한다면 브랜치 정리가 보다 깔끔히 될 것 같은 기분이 듭니다.

그리하여 실행하고, 그 결과가 위와 같이 되었습니다.

어딘가.. 기분이 좀 쎄하죠.


# 공용 저장소에 이미 푸시했던 작업물(commits)을 리베이스(rebase)하지 마세요!

![wrong rebase explanation](/images/20180125_wrong_rebase/2.png "같은 commit 내용이 이동하지 않고 복제되어 중복이 발생해 버렸다")

자세히 살펴보니, 중복 커밋이 만들어지고 말았습니다. 이미 원격(공용) 저장소에 만들어진 브랜치를 `rebase` 하려 한다면, 새로운 커밋 히스토리를 작성하기 위해 `push --force`와 같은 동작을 하는 것이 되는데요, 이는 예상과 같은 "이동"이 아니라 "복제"를 의미합니다. 이 때 `rebase` 명령은 새롭게 복제하는 브랜치 노드가 새 것처럼 보이게 하기 위해 SHA-1 해시값을 바꿉니다. 그 결과 로컬과 원격 저장소에는 해시 값만 다르고 변경점과 커밋 메시지까지 똑같은 커밋 노드 두 개가 공존하게 되지요. 이것은 프로그래머가 `rebase`를 하면서 가장 의도하지 않은 장면일 겁니다.

`rebase`는 아직 업로드하지 않은 로컬 작업물을 원격 저장소에 붙이기 직전, 원격 브랜치의 커밋 히스토리를 어지럽히지 않은 채 원격 브랜치의 최신 변경 사항으로 업데이트할 때 바람직한 머지(`merge`) 전략입니다. `rebase`를 하기 전에는 자신의 작업물이 이미 원격 저장소에 나가지 않았는지 잘 살펴보시고, 이미 나간 경우에는 `merge`를 이용해 주세요!


# Reference

* https://git-scm.com/book/no-nb/v1/Git-Branching-Rebasing#The-Perils-of-Rebasing
* https://stackoverflow.com/questions/9264314/git-commits-are-duplicated-in-the-same-branch-after-doing-a-rebase
