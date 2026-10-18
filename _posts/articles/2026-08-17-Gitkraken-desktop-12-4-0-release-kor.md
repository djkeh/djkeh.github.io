---
layout: post
categories: articles
title: "Gitkraken Desktop 12.4 업데이트"
excerpt: "이슈에서 바로 에이전트 시작, 클로드 권한 요청 바로 승인하기"
tags: [git, ai]
date: 2026-08-17 10:00:00 +09:00
last_modified_at: 2026-08-17 10:00:00 +09:00
sitemap: true
---

[지난 12.0 업데이트 소개 글](/articles/Gitkraken-desktop-12-0-0-release-kor/)에서 깃크라켄이 **에이전트 세션 뷰(Agent Sessions View)**를 들고 나오면서, 여러 개의 워크트리(worktree) 위에서 AI 코딩 에이전트들을 동시에 굴리는 '멀티 에이전트 시대'에 본격적으로 올라탔다는 이야기를 했었는데요. 그 뒤로 몇 번의 마이너 업데이트를 거치면서, 깃크라켄은 이 방향을 꾸준히 다듬어 오고 있습니다.

그런데 막상 에이전트 여러 개를 띄워놓고 일해 보면, 의외로 사람의 손이 자주 갑니다. 이슈 내용을 복사해서 에이전트에게 붙여넣어 주고, 브랜치 이름 정해주고, 에이전트가 "이 명령어 실행해도 될까요?" 하고 물어보면 해당 워크트리 터미널로 쫓아가서 `y`를 눌러주고... 에이전트가 늘어날수록 이런 잔심부름도 함께 늘어나죠. 에이전트에게 일을 맡겼는데 정작 내가 에이전트들의 비서가 되어버린 느낌, 다들 한 번쯤 겪어보셨을 겁니다.

2026년 8월 5일 릴리즈된 **깃크라켄(GitKraken) Desktop 12.4** 버전은 바로 이 부분을 정조준했습니다. 릴리즈 노트의 한 줄 슬로건부터 "어떤 에이전트의 행동이든 카운터스펠(counterspell)하라"인데요, 공식 소개 영상의 제목도 **"Human in Control"**, 즉 사람이 주도권을 쥐는 에이전트 워크플로우입니다. 어떤 기능들이 추가되었는지 함께 살펴보겠습니다.

![GitKraken Desktop 12.4 체인지로그 공식 썸네일. HUMAN IN CONTROL 문구 옆에서 고민 중인 개발자, 아마 에이전트 권한 승인 버튼을 누를지 고민 중](/images/20260817_gitkraken_12_4_release/01-release-hero.png)

## 1. 이슈 하나로 에이전트 출동! 이슈에서 에이전트 세션 시작하기

이번 업데이트의 첫 번째 주인공은 **이슈(issue)에서 바로 에이전트 세션을 시작하는 기능**입니다. 런치패드(Launchpad)나 왼쪽 패널(Left Panel)의 이슈 목록에서 클릭 몇 번이면, 깃크라켄이 다음 작업을 한 번에 처리해 줍니다.

1. 해당 이슈를 위한 새 브랜치를 생성하고,
2. 그 브랜치를 새 워크트리로 열고,
3. 미리 선택한 코딩 에이전트를 **이슈의 내용(context)을 담아서** 기동합니다.

![왼쪽 패널 GitHub 이슈 목록에서 이슈를 우클릭해 Start an Agent Session 메뉴를 고르는 화면. 폰트 바꾸는 법 같은 이슈도 이제 에이전트에게 토스 가능](/images/20260817_gitkraken_12_4_release/02-start-agent-session-from-issue.png)

진입 경로는 두 가지입니다.

* **런치패드(Launchpad)**: 아직 연결된 브랜치가 없는 이슈의 `ACTION` 컬럼에서 "Start an Agent Session"을 선택합니다.
* **왼쪽 패널(Left Panel)**: 이슈를 우클릭하고 "Start an Agent Session"을 선택합니다. 이 메뉴 역시 연결된 브랜치가 아직 없는 이슈에서만 나타납니다.

어느 쪽이든 바로 에이전트가 뛰쳐나가는 게 아니라, 브랜치 이름과 사용할 코딩 에이전트, 기타 설정을 확인하는 셋업 모달(setup modal)을 한 번 거친 뒤에 실행됩니다. 깃크라켄이 원래 잘하던 "이슈 → 브랜치 생성" 흐름에, 12.0에서 추가된 "워크트리 + 에이전트 세션"을 자연스럽게 이어붙인 셈이죠. 이슈 트래커를 열심히 쓰는 팀이라면, 이슈 설명을 잘 써두는 것 자체가 곧 에이전트에게 주는 좋은 프롬프트가 되는 구조라 꽤 매력적입니다.

## 2. 워크트리 이동 없이 Claude 권한 요청 승인하기

두 번째 기능은 제가 개인적으로 이번 릴리즈에서 가장 반가웠던 기능입니다. [클로드 코드(Claude Code)](https://claude.com/claude-code)를 써보신 분들은 아시겠지만, 클로드는 파일을 수정하거나 셸 명령어를 실행하기 전에 사용자에게 권한(permission)을 요청합니다. 안전을 위해선 꼭 필요한 장치인데, 에이전트를 여러 개 돌리고 있으면 "어? 저쪽 워크트리 에이전트가 승인 기다리느라 10분째 놀고 있었네" 같은 일이 생기기 쉽죠.

12.4부터는 **에이전트 세션 패널(Agent Sessions panel)에서 Claude Code의 대기 중인 권한 요청을 바로 확인하고 허용(allow) 또는 거부(deny)**할 수 있습니다. 해당 워크트리로 전환할 필요가 없어요.

![에이전트 세션 패널의 main 워크트리 카드에 Awaiting approval 상태의 Bash 명령어와 허용, 항상 허용, 거부 버튼이 표시된 화면. 결재 서류가 올라오면 바로 도장 쾅](/images/20260817_gitkraken_12_4_release/03-allow-deny-permission.png)

* 워크트리 카드에 `Awaiting approval · Bash`처럼 어떤 도구 사용을 승인 대기 중인지 표시됩니다.
* 허용/거부 버튼 옆의 캐럿(caret)을 클릭하면, 클로드가 실행하려는 **명령어 전체를 미리 확인**할 수 있습니다.
* 공식 스크린샷을 보면 "항상 허용(Always allow)" 옵션도 함께 제공되는 것을 볼 수 있습니다.

명령어를 확인도 안 하고 무작정 허용하는 건 위험하니, 캐럿을 눌러 명령어를 꼭 한 번 읽어보는 습관은 유지하시길 추천드립니다. "Human in Control"의 핵심은 결국 사람이 '보고 나서' 결정하는 거니까요.

## 3. 그 밖의 개선 사항들

### 워크트리 제거 흐름 개선

깃은 다른 워크트리에서 체크아웃 중인 브랜치를 삭제하지 못하게 막습니다. 그런데 기존 깃크라켄에서는 워크트리에 체크아웃된 브랜치를 커밋 그래프에서 우클릭하면 "Delete branch" 메뉴가 그대로 나왔고, 당연히 깃이 이를 수행할 수 없으니 실패하곤 했죠.

12.4에서는 이런 브랜치를 우클릭하면 대신 **워크트리를 제거하는 메뉴**가 나옵니다. 이때 로컬 브랜치만 함께 삭제하거나, 로컬과 원격 브랜치를 모두 함께 삭제하는 옵션도 선택할 수 있어요. 같은 옵션은 에이전트 세션 패널의 워크트리 메뉴에서도 사용할 수 있습니다. 에이전트가 일을 끝낸 워크트리를 깔끔하게 정리하는 데 딱 필요했던 기능이네요.

![에이전트 세션 패널의 워크트리 우클릭 메뉴에서 Remove worktree and delete branch 항목이 강조된 화면. 다 쓴 워크트리는 브랜치까지 한 번에 분리수거](/images/20260817_gitkraken_12_4_release/04-remove-worktree.png)

### 소소하지만 편리한 개선

* **Git 공급자 자동 연결**: 단일 프로필로 로그인하면, [gitkraken.dev](https://gitkraken.dev/) 계정에 연결해 둔 모든 Git 공급자(GitHub, GitLab 등)를 자동으로 연결해 줍니다.
* **새 탭 검색 단축키**: 새 탭(New Tab)에서 검색 입력창으로 바로 포커스를 옮기는 단축키가 추가되었습니다. 윈도우는 `Ctrl + Alt + F`, 맥은 `Cmd + Option + F`입니다.

### 주요 버그 수정

* 로그아웃 상태에서 런치패드의 Pull Requests, Issues 탭이 무한 로딩되던 문제가 수정되어, 이제 로그인 안내가 표시됩니다.
* 하위 폴더의 `.gitattributes`로 추적되는 Git LFS 파일이 WIP에서 LFS 파일로 인식되지 않던 문제가 수정되었습니다.
* 커밋과 작업 디렉토리를 함께 선택했을 때, 스테이징되지 않은 파일 이름 변경(rename)이 삭제 + 추가로 따로 보이던 문제가 수정되었습니다.
* 주석 태그(annotated tag)만 있는 저장소에서 "Hide all tags", "Show all tags" 메뉴가 비활성화되던 문제가 수정되었습니다.
* 지라(Jira) 이슈 트래커가 이슈를 불러오는 동안 워크트리를 새 탭으로 열면 탭 전환이 한참 막히던 문제가 수정되었습니다.
* 활성 워크트리 카드의 ahead/behind 카운트와 변경 사항 표시가 갱신되지 않던 문제, 워크스페이스 전환 시 에이전트 워크플로우 패널의 스크롤 위치가 초기화되던 문제가 수정되었습니다.
* 깃크라켄이 GitLab API를 과도하게 호출하던 문제, Azure DevOps 재로그인 시 조직(organization) 선택 화면이 나타나지 않던 문제 등도 함께 수정되었습니다.

## 에이전트는 일하고, 사람은 결정한다

이번 **GitKraken Desktop 12.4**는 기능의 가짓수로만 보면 12.0만큼 화려한 릴리즈는 아닙니다. 하지만 멀티 에이전트 워크플로우를 실제로 써보면서 느꼈던 마찰 지점들을 정확히 짚어서 다듬었다는 점에서, 오히려 실사용자 입장에서는 체감이 더 큰 업데이트라고 생각해요.

* **시작**은 이슈에서 클릭 한 번으로,
* **진행 중**에는 워크트리를 오가지 않고 권한 요청을 승인하고,
* **마무리**는 워크트리와 브랜치를 한 번에 정리하는 흐름.

에이전트 작업의 시작부터 끝까지를 깃크라켄 한 화면에서 사람이 통제할 수 있게 된 셈이죠. 에이전트에게 더 많은 일을 맡길수록, 사람은 '무엇을 시킬지'와 '무엇을 허락할지'에 집중해야 한다는 메시지가 잘 담긴 릴리즈라고 봅니다. 아직 권한 요청 승인은 Claude Code를 중심으로 지원되고 있어서, 다른 코딩 에이전트들로 지원 범위가 넓어지는 것도 앞으로 기대해 볼 만한 부분입니다.

깃크라켄은 무료로 시작할 수 있지만, AI 및 에이전트 관련 기능은 유료 라이선스를 구매하셔야 사용하실 수 있습니다. 만약 이번에 라이선스 구매를 고려 중이시라면, 좀 더 저렴하게 사용하실 수 있도록 깃크라켄 앰배서더인 저의 referral 링크를 활용해 보세요. 대략 50% 정도 할인을 받으실 수 있으실 겁니다.

[깃크라켄 라이선스 Referral 링크 <-](https://gitkraken.cello.so/rcr7uWnNUdm)

## Reference

* [https://help.gitkraken.com/gitkraken-desktop/current/#version-12-4-0](https://help.gitkraken.com/gitkraken-desktop/current/#version-12-4-0)
* [https://www.gitkraken.com/blog/gitkraken-desktop-12-4-see-every-agent-approve-every-change](https://www.gitkraken.com/blog/gitkraken-desktop-12-4-see-every-agent-approve-every-change)
* [https://www.youtube.com/watch?v=_Nj7FzczoJw](https://www.youtube.com/watch?v=_Nj7FzczoJw)
* [https://djkeh.github.io/articles/Gitkraken-desktop-12-0-0-release-kor/](https://djkeh.github.io/articles/Gitkraken-desktop-12-0-0-release-kor/)
* [https://git-scm.com/docs/git-worktree](https://git-scm.com/docs/git-worktree)
* [https://gitkraken.cello.so/rcr7uWnNUdm](https://gitkraken.cello.so/rcr7uWnNUdm)
