---
layout: post
categories: articles
title:  "GitKraken 6.0.0 릴리즈 소식"
excerpt: "더욱 쓸만해진 대세 git 클라이언트"
tags: [git,utility]
date: 2019-06-25 15:17:20
last_modified_at: 2019-06-25 15:17:20
---

## 깃크라켄 v6.0 릴리즈 소식

지난 2019년 6월 17일, 깃크라켄([GitKraken](https://www.gitkraken.com/))이 v6.0으로 업데이트 되었습니다. 깃크라켄을 사용하시던 분들은 자동으로 업데이트 알림을 받으셨겠지만, 혹시 미뤄두셨던 분들은 얼른 업데이트를 받고 더 강력해진 기능들을 체험해 보세요.

{% include youtubePlayer.html id=RxqxEyuqOEY %}

### 빨라졌다

정말 빨라졌습니다. 클라이언트 실행(2.3배), 저장소 열기(1.4배), 최근 저장소 다시 열기(3.2배), 저장소 간 이동(4.3배) 등 다양한 시나리오에서 월등한 성능 향상이 있습니다.

### 탭 추가

오래 전 소스트리가 v2.0 릴리즈에서 탭 기능을 소개했는데요, 이는 여러 저장소를 탭으로 관리하고 빠르게 저장소 사이를 이동할 수 있는 기능이었습니다. 깃크라켄은 이 기능이 자신의 UX에는 불필요한 디자인이라고 판단했고 과감히 탭을 삭제한 심플한 UX를 보여주었는데요, 그럼에도 불구하고 탭이 없어서 아쉬워하는 유저들의 피드백이 많았습니다. 버전 6.0 부터 이제 탭을 사용할 수 있습니다. 여러 저장소들을 탭으로 열고 관리하여 탭 클릭으로 빠르게 저장소 사이를 이동할 수 있습니다. 탭 단축키도 물론 지원합니다. (탭 열기: `cmd/ctrl + t`, 탭 닫기: `cmd/ctrl + w`)

### GitHub Pull Request 작성 전에 머지 충돌(Merge Conflict) 확인

깃크라켄은 완벽한 깃헙 풀 리퀘스트 통합 기능을 이미 제공하고 있었는데요, 이 기능이 좀 더 강화됐습니다. 이제 풀 리퀘스트를 작성하기 직전에 머지 충돌을 미리 확인할 수 있습니다.

### 그 외

* 깃크라켄 응용프로그램 사이즈가 맥 기준 100MB 가량 줄어들었습니다.
* 알림 상자 뜨는 위치가 우상단에서 좌하단으로 이동하였습니다.
* 많은 주요 버그 픽스가 있었습니다.


## 근데 깃크라켄이 뭔데?

깃크라켄([GitKraken](https://www.gitkraken.com/))은 [Axosoft](https://www.axosoft.com/)에서 개발한 Git GUI Client 입니다. 경쟁 제품은 유명한 [Sourcetree](https://www.sourcetreeapp.com/)가 있습니다. 기본적으로 무료로 이용 가능하고, 월 3천원 수준의 Pro 구독을 하면 전용 머지 충돌 에디터와 몇 가지 좀 더 고급 기능들을 이용할 수 있습니다. 무엇보다도 빠른 성능, 강력한 편의 기능, 각종 깃 호스팅 서비스와의 깔끔한 통합과 세련된 UI로 소스트리 유저들의 풀리지 않는 갈증을 해소해 주면서 큰 주목을 받았습니다. 아직 써보지 않으신 분들은 Axosoft에서 직접 위트 있게 작성한 [GitKraken vs SourceTree](https://blog.axosoft.com/gitkraken-vs-sourcetree/)(~~왜 깃크라켄을 써야 하는가~~) 포스팅을 통해 깃크라켄이 어떤 특장점을 가지고 있는지 한 번 살펴보세요.


## Reference

* [https://support.gitkraken.com/release-notes/current/](https://support.gitkraken.com/release-notes/current/)
* [https://blog.axosoft.com/gitkraken-vs-sourcetree/](https://blog.axosoft.com/gitkraken-vs-sourcetree/)
