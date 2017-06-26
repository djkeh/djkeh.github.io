---
layout: post
categories: articles
title:  "Atlassian SourceTree for Windows 2.0 업데이트"
excerpt: "업데이트 개선 사항 정리"
tags: [atlassian, sourcetree, windows, 2.0, update, performance, gvfs, lookandfeel, tab, 아틀라시안, 소스트리, 윈도우, 업데이트, 정리, 성능]
date: 2017-06-26 18:09:49
modified: 2017-06-26 18:09:49
image:
  feature:
share: true
---

# Atlassian SourceTree for Windows 2.0 업데이트

지난 2017년 4월 27일, [소스트리 공식 블로그](https://blog.sourcetreeapp.com/)를 통해 소스트리의 윈도우용 2.0 첫 릴리즈 소식이 들려왔습니다. [소스트리](https://www.sourcetreeapp.com/)는 많은 개발자들에게 사랑받고 있는 [Git](https://git-scm.com/) 클라이언트입니다. 원래는 맥 전용으로만 쓰이던 도구였는데, 공식 블로그에 의하면 이제는 오늘날 반 이상의 유저가 윈도우를 사용한다고 하는군요. 그런 만큼 소스트리도 윈도우 유저를 아주 중요하게 생각할텐데요, 윈도우용 2.0 버젼의 개발이 한창 진행되더니 며칠 전부터는 1.x 버젼대의 소스트리를 구동만 하면 자동 업데이트로 2.0 버젼을 추천받아 다운로드 받을 수 있게 되었습니다.

그렇다면 소스트리가 1에서 2로 버젼 업 하면서 어떤 메이져 업데이트가 있었을까요? 함께 정리해 보겠습니다.


# Look & Feel이 바뀌었습니다

2.0의 가장 첫번째 눈에 띄는 변화는 역시 외관입니다.

![소스트리 윈도우 2.0의 외관](/images/20170626_sourcetree2/1.png)

마치 모던 웹 브라우저처럼 바뀌었습니다. 시원한 상단 메뉴와 탭은 그중에서도 딱 윈도우 엣지를 연상시킵니다. 소스트리는 기존 저장소(repository)를 브라우징하는 UX를 개선하기 위해 탭 중심의 디자인을 적용했다고 밝혔습니다.

과거와 비교해 볼까요?

![v1.10 vs. v2.0 UI 비교](/images/20170626_sourcetree2/2.png)

특히 소스코드 변경점을 확인하는 우측 하단 영역의 비중이 더 높아져서, 커지고 보기 좋아졌으며, 더 좋아질 예정입니다. 이번엔 UI의 '토폴로지 맵'을 살펴보시죠.

![v1.10 vs. v2.0 토폴로지 맵](/images/20170626_sourcetree2/3.png)

보시는 것처럼 이전엔 좀 어수선했는데, 이런 부분이 잘 정리되었습니다. 이제 코드 리뷰를 하기 더 좋은 모양으로 바뀌어가고 있습니다.

또 하나 큰 특징은 왼쪽 사이드 메뉴에 저장소 목록이 사라졌다는 것인데요, 호불호는 있었겠지만 저도 주변에서 저장소 목록을 옵션으로 끄고 사용하는 유저들을 자주 봐왔습니다. 그러한 유저 피드백을 반영한 결과가 아닐까 하는 추측이 드네요. 이제 저장소를 탐색하려면 사이드바에서 하는게 아니라, 새 탭을 만들어야 합니다. 탭 메뉴 오른쪽 끝에 있는 `+` 버튼을 누르면,

![저장소 화면](/images/20170626_sourcetree2/4.png)

이런 화면을 보실 수 있는데요, 여기서 저장소 관리 기능 전반을 모두 사용할 수 있습니다. 사용하는 모습을 간단한 데모로 감상해 보시죠.

![저장소 UX](/images/20170626_sourcetree2/5.gif)


# 퍼포먼스가 향상되었습니다

긴말할 것 없이 소스트리가 제공한 벤치마크 그래프를 보시죠.

![v1.10 vs. v2.0 벤치마크 결과](/images/20170626_sourcetree2/6.png)

특히 스태시 기록을 읽는 속도가 비약적으로 향상되었습니다(가장 중요한 기능은 아닐지도 모르지만...). 업그레이드를 해야 할 가장 중요한 이유가 되겠네요!


# Git Virtual File System을 지원합니다

Git 이용자들이 보편적으로 아쉬워하는 것 중에 하나가 바로 고용량 저장소의 처리인 것 같은데요,  [Git Large File Storage(LFS)](https://www.atlassian.com/git/tutorials/git-lfs?_ga=2.35165153.1555218264.1498180335-1110344662.1497924048)가 이 문제를 완화해줄 수 있었지만 저장소에 많은 파일이나 컨텐츠가 담겼을 땐 여전히 문제가 있었죠. 이에 마이크로소프트가 [Git Virtual File System(GVFS)](https://blogs.msdn.microsoft.com/visualstudioalm/2017/02/03/announcing-gvfs-git-virtual-file-system/)을 올해 발표했습니다. 이것의 주요 아이디어는 '파일 시스템을 가상화해서 마치 모든 파일이 저장소 안에 있는 것처럼 보이지만, 실제로는 파일을 첫번째로 열 때만 다운로드한다' 입니다. 이것으로 거대한 저장소를 가지고 일하지만 보통 때는 코드의 작은 부분에만 접근하는 개발자들은, GVFS를 사용해서 저장소 전체가 아니라 필요한 부분만 다운로드받을 수 있게 되었습니다. 이것으로 체감 성능이 많이 개선되었다고 해요.

소스트리 2.0은 GVFS를 지원합니다. GVFS 기능을 활성화해둔 저장소를 이용하면, 이 기능을 활용할 수 있습니다.


# 이러한 기능이 앞으로 추가될 예정입니다

소스트리 2.0은 현재 이러한 모습으로 나아가고 있습니다.

![소스트리 윈도우 2.0의 향후 업데이트 모습](/images/20170626_sourcetree2/7.png)

- 이상한 푸터(footer)의 탭들도 조만간 맥 버젼처럼 사이드 바로 묶여서 들어갑니다.
- 커미터(committer) 정보 패널이 사라집니다.
- View 옵션이 View 메뉴로 이동합니다.
- Density View 옵션이 추가됩니다.
- Diff 화면이 더 보기 좋아집니다.


# 그 외에 뭔가 없나요?

세세한 내용은 릴리즈 노트에 있겠지만, 이렇게 생겼습니다.

![칙쇼... 이런게 눈에 안 들어오는 걸 보면 난 아직 진정한 개발자가 아닌 듯](/images/20170626_sourcetree2/8.png)

그래서 읽는 것은 관두고 저도 어제부터 업데이트를 받아서 그냥 써보고 있는데요, 옵션에서 소소한 부분이 바뀐 것 같습니다. 이전에는 `도구 > 옵션 > 인증`  부분이 이렇게 생겼었는데요,

![v1.x 시절 사용자 인증 정보 관리 화면](/images/20170626_sourcetree2/9.png)

이것이 2.0부터 이렇게 바뀌었습니다.

![v2.x 새로운 사용자 인증 정보 관리 화면](/images/20170626_sourcetree2/10.png)

한층 썰렁한데, 계정과 비밀번호의 `편집`, `삭제` 버튼이 사라졌습니다. 이제 어떻게 넣죠!?

![뭐야뭐야!](/images/20170626_sourcetree2/11.gif)

그런데, 괜찮습니다. 그냥 맨처음으로 새로운 저장소나 깃헙에 접근할 때 물어보고는 자동으로 저장해서 여기에 표시하거든요. 사용자 경험을 생각해 생략한 모양입니다.

다른 소소한 건, 눈치채셨겠지만 옵션에 `Updates` 항목이 추가되었습니다. 모양은...

![Update 항목](/images/20170626_sourcetree2/12.png)

이렇게 생겼습니다.


# 다른 문제는 없나요?

아직 Git 관련 기능에서 심각한 버그를 체감하진 못했지만, 윈도우 기능에 문제가 좀 있습니다. 우측 상단에 있는 최소화 버튼, 최대화 버튼을 클릭할 때 때때로 이렇게 되면서 한 번에 클릭되지 않습니다.

![뭐야 이거...](/images/20170626_sourcetree2/13.png)

`v2.1.2.5`에서 확인되는 문제입니다. 윈도우 UI를 크게 고치면서 생긴 버그 아닐까 추측해봅니다. 뭐... 금방 고쳐지겠죠?


# 지금, 업데이트 받으세요!

시원하게 바뀐 UI, 빨라진 성능! 새로운 소스트리를 경험해 보세요~


# Reference

* [https://blog.sourcetreeapp.com/2017/04/27/sourcetree-for-windows-2-0-new-ui-faster-performance-and-microsoft-git-virtual-file-system-support/](https://blog.sourcetreeapp.com/2017/04/27/sourcetree-for-windows-2-0-new-ui-faster-performance-and-microsoft-git-virtual-file-system-support/)
* [https://blog.sourcetreeapp.com/2017/05/18/windows-2-0-gets-a-fresh-look/](https://blog.sourcetreeapp.com/2017/05/18/windows-2-0-gets-a-fresh-look/)
