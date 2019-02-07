---
layout: post
categories: articles
title:  "리모트 저장소에 푸시한 커밋은 리베이스하지 말 것"
excerpt: "\"Pro Git\"에서 배우는 리베이스 주의사항"
tags: [git]
date: 2018-01-25 17:20:00
last_modified_at: 2019-02-07 10:38:08
---

리베이스(`rebase`)는 상황에 따라 유용한 머지 전략 중 하나이지만, 어떻게 작동하는지 잘 이해하지 않은 상태에서 사용하면 예상치 못한 결과로 혼란을 초래하기도 합니다.
제게 그런 일이 일어났었죠.

![wrong rebase](/images/20180125_wrong_rebase/1.png "rebase 했는데, 뭔가 이상하다")

`feature/v.2.0` 브랜치에서 새로운 feature 브랜치를 만들어, `feature/#462-uno-xxx-helper`를 진행합니다. 이 브랜치에서 `feature/v.2.0` 개발 내용의 일부를 독립적으로 작업한 뒤 다시 `feature/v.2.0`에 하나로 합칠 목적입니다. 작업을 진행했고, 그 사이 동료 프로그래머도 `feature/v.2.0` 개발에 진척이 있었습니다. `feature/v.2.0`는 `feature/#462-uno-xxx-helper`의 모체이므로, `feature/v.2.0`의 최신 변경사항을 가져오기 위해 `rebase`를 선택한다면 브랜치 히스토리가 복잡해지는 것을 막을 수 있을 것 같은 기분이 듭니다.

그리하여 실행하고, 그 결과가 위와 같이 되었습니다.

어딘가.. 기분이 좀 쎄하죠.


## 원격(공용) 저장소에 이미 푸시했던 작업물(commits)을 리베이스(rebase)하지 마세요

![wrong rebase explanation](/images/20180125_wrong_rebase/2.png "같은 commit 내용이 이동하지 않고 복제되어 중복이 발생해 버렸다")

자세히 살펴보니, 중복 커밋이 만들어지고 말았습니다.

`rebase`의 내부 메커니즘은 겉보기와 달리 단순한 "이동" 이 아니라, 노드 변경점의 역추적을 통한 "복제" 입니다. 복제된 커밋은 내용은 같지만 새로운 노드이므로, 기존 노드와 SHA-1 해시값이 다릅니다. 그 결과 저장소에는 해시 값만 다를 뿐, 변경점과 커밋 메시지까지 똑같은 커밋 노드들 두 줄이 공존하게 되지요. 이것은 프로그래머가 `rebase`를 하면서 가장 의도하지 않은 장면일 겁니다. 이 때문에 원격 저장소에 작업물을 내보낸 사이 `rebase` 대상 브랜치에 변경점이 있었다면, `rebase`를 해서는 안됩니다. `merge`보다 훨씬 더 복잡하고 의도하지 않은 히스토리를 남기게 되거든요.

위와 같은 부작용은 내 작업물 브랜치가 원격 저장소에 아직 푸시되지 않았거나, 원격 저장소에 작업 브랜치가 나간 상태라도 모체가 되는 `rebase` 대상 브랜치에 변경점이 없다면 일어나지 않습니다. 문제는 이미 원격 저장소에 존재하는 기존 노드들과, 로컬에서 `rebase` 작업을 통해 새롭게 발생한 복제 노드들이 공존할 때 발생합니다.

그럼 기억합시다. `rebase`는 원격 저장소의 커밋 히스토리를 어지럽히지 않고, 로컬 작업물을 원격 저장소의 최신 변경 사항으로 업데이트하려 할 때 바람직한 머지(`merge`) 전략입니다. 자신의 작업물이 이미 원격 저장소에도 나가 있다면, `rebase` 하려는 대상 원격 작업물에 변경 사항이 있었는지 신중히 확인해 주세요. `rebase` 대상 브랜치에 변경점이 있었을 경우에는 `merge`를 이용하는 것이 좋습니다.


## Reference

* [https://git-scm.com/book/ko/v1/Git-브랜치-Rebase하기#Rebase의-위험성](https://git-scm.com/book/ko/v1/Git-브랜치-Rebase하기#Rebase의-위험성)
* [https://git-scm.com/book/no-nb/v1/Git-Branching-Rebasing#The-Perils-of-Rebasing](https://git-scm.com/book/no-nb/v1/Git-Branching-Rebasing#The-Perils-of-Rebasing)
* [https://stackoverflow.com/questions/9264314/git-commits-are-duplicated-in-the-same-branch-after-doing-a-rebase](https://stackoverflow.com/questions/9264314/git-commits-are-duplicated-in-the-same-branch-after-doing-a-rebase)
