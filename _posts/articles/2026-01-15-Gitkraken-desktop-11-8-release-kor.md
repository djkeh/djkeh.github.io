---
layout: post
categories: articles
title:  "Gitkraken Desktop 11.8 업데이트"
excerpt: "Gitkraken Desktop 11.8 새로운 기능 정리: ARM Build, Shallow Clone"
tags: [git]
date: 2026-01-15 12:01:32
last_modified_at: 2026-01-15 12:01:32
sitemap: true
---

2026년 새해가 되고 깃크라켄의 첫 업데이트네요. 1월 14일에 깃크라켄이 `11.8` 버전으로 업데이트 되었습니다. 어떤 변경이 있었는지 빠르게 살펴볼텐데요, 이번 업데이트의 주요 키워드는 **ARM 빌드**와 **Shallow Clone** 입니다.


## ARM 빌드 지원 (Linux 및 Windows)

이제 Linux와 Windows 환경에서도 ARM 프로세서를 사용하는 사용자들이 깃크라켄을 보다 쾌적하게 사용할 수 있습니다. [공식 다운로드 페이지](https://www.gitkraken.com/download)에서 사용 중이신 칩 아키텍처에 맞는 빌드를 선택하여 설치할 수 있고, 즉각적인 성능 향상을 경험할 수 있다고 하네요. 다만 이 업데이트를 보고 궁금해져서 찾아봤는데, pc 시장에서 최근 cpu 점유율이 인텔 7~80%, AMD 20% 정도로 나옵니다. ARM칩의 시장 점유율은 10% 내외인 듯 하니 아직 데스크탑에서 그리 많은 비중을 차지하고 있진 않은 것 같네요.


## Shallow Clone 직접 생성 기능

이제 깃크라켄에서 저장소를 클론(`clone`)으로 가져올 때, 직접 `shallow clone`을 할 수 있습니다. 히스토리가 방대한 프로젝트에서 필요한 부분만 빠르게 받아오고 싶은 경우 유용합니다. 그런데 여러분, shallow clone 해본 적 있으세요? 이게 뭘까요?

### Shallow Clone 이란?

Shallow clone은 깃 저장소의 커밋 기록을 일부분만 clone 받는 기능입니다. 예를 들어 [스프링 부트 오픈소스](https://github.com/spring-projects/spring-boot)에 참여한다고 해보죠. 당연히 커밋 히스토리가 어마어마하겠죠?

![스프링 부트 프로젝트의 어마어마한 커밋 기록](/images/20260118_gitkraken_11_8_release/shallow-clone-1.gif)

이 커밋 기록을 보통 다 보고 싶지는 않을 것 같습니다. 이럴 때 shallow clone을 하면:

![Shallow Clone](/images/20260118_gitkraken_11_8_release/shallow-clone-2.gif)

이렇게 짧은 최신 커밋 기록 일부만 받아볼 수 있습니다. 요약하면 **git 저장소에서 최신 커밋만 가져오는 기법** 되겠습니다.

개인 사용자라면 평소 실용성을 크게 체감하지는 못하실 지도 모르겠습니다. 전체 히스토리를 갖고 있는 평범한 개인 프로젝트가 엄청 버벅이거나 큰 문제를 일으키지는 않는 편이니까요. 그러나 git 저장소를 기업 인프라에서 운영할 때, 매우 큰 저장소를 운영할 때, 매우 오랫동안 운영되어 히스토리가 많은 저장소를 운영할 때 이 기능은 빛을 발할 수 있습니다. 기본적으로 최신 커밋과 거기 딸려오는 브랜치, 태그 등만 가져오기 때문에 다운로드 속도와 사이즈가 줄어들기 때문입니다. 평소 운영하던 [CI 프로세스](https://ko.wikipedia.org/wiki/지속적_통합) 도중 `git clone` 부분에서 부하가 관찰되었다면, 이 방법으로 최적화를 한 번 시도해볼 수 있겠죠! 나름 중요한 고급 기능이라 할 수 있겠습니다.


## 그 밖에

이번 버전부터 커스텀 테마 기능이 한동안 빠집니다. 현재 UI 개편 작업이 진행 중이거든요. 기본 다크 테마가 충분히 쓸만해서 크게 신경 쓸 사람은 없을 것 같긴 합니다. 커스텀 테마 기능은 UI 개편이 끝난 뒤에 부활할 예정이라고 하네요.

이 블로그 포스팅을 하는 와중에 깃크라켄 버전이 `11.9`까지 올라갔네요. `11.9`는 큰 변경이 없어서 여기서만 간단히 언급드리고 따로 포스팅을 하진 않을 것 같습니다. `11.8` 기능이 좀 더 다듬어졌고, 파일 뷰어 화면에서 `줄바꿈(Word Wrap)` 토글 버튼이 새로 생긴 정도가 있네요. 줄바꿈은 껐다 켰다 하면서 보면 나름 편리한 기능이 될 것 같습니다.

최신 깃크라켄 써보시고, shallow clone 기능도 한 번 구경해 보세요. 깃크라켄은 무료로 사용할 수 있습니다. 바로 구입하지 않고도 사용해볼 수 있으니, 아직 깃크라켄 계정이 없으신 분은 [제 추천 링크](https://gitkraken.cello.so/rcr7uWnNUdm)로 가입하시고 깃크라켄을 다운로드 받아 사용해 보세요. 나중에 유료 구독을 원하실 때 큰 폭으로 할인을 받으실 수 있습니다.


## Reference

* [https://www.youtube.com/watch?v=Q9CpplgRhEE](https://www.youtube.com/watch?v=Q9CpplgRhEE)
* [https://gitkraken.cello.so/rcr7uWnNUdm](https://gitkraken.cello.so/rcr7uWnNUdm)
