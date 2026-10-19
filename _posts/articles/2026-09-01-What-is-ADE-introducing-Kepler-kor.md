---
layout: post
categories: articles
title: "ADE? 새로운 개발도구 Kepler를 소개합니다"
excerpt: "GitKraken을 만든 Axosoft의 새로운 도전, 성공할지는 글쎄?"
tags: [git, ai]
date: 2026-09-01 10:00:00 +09:00
last_modified_at: 2026-09-01 10:00:00 +09:00
sitemap: true
---

깃크라켄(GitKraken) 이야기를 이 블로그에서 꽤 여러 번 했었죠. [12.0 업데이트](/articles/Gitkraken-desktop-12-0-0-release-kor/)에서 에이전트 세션 뷰가 들어오고, [12.4 업데이트](/articles/Gitkraken-desktop-12-4-0-release-kor/)에서는 이슈에서 바로 에이전트를 띄우고 권한 요청을 한 화면에서 승인하는 기능까지 붙으면서, 깃크라켄 데스크탑은 꾸준히 '에이전트와 함께 쓰는 Git 클라이언트'로 진화해 왔습니다.

그런데 깃크라켄을 만드는 회사 Axosoft(지금은 회사 이름도 GitKraken입니다)가 올해 여름, 깃크라켄 데스크탑과는 완전히 별개의 신제품을 하나 들고 나왔습니다. 이름은 **케플러(Kepler)**. 스스로를 IDE가 아니라 **ADE(Agentic Development Environment)**라고 부르는 물건인데요. 2026년 6월에 첫 공개된 뒤 아직도 0.x 버전의 퍼블릭 프리뷰 상태라 국내에서는 거의 소개된 적이 없는 것 같습니다. 그래서 오늘은 이 생소한 도구를 "왜 만들었는가"를 중심으로 소개해 보려고 합니다. 먼저 공식 튜토리얼 1편 "What is Kepler?"부터 한 번 보고 시작하시죠.

{% include youtubePlayer.html id="U0w18ZXrZ5M" %}

## 터미널 열다섯 개를 저글링하던 한 엔지니어

케플러의 출발점은 거창한 전략 회의가 아니라, 한 엔지니어의 짜증이었습니다. 깃크라켄의 엔지니어링 디렉터인 **지오(Gyo, Giordano Piazza)**는 AI 코딩 에이전트를 본격적으로 쓰기 시작하면서 업무 방식이 이렇게 바뀌었다고 합니다.

1. 지라(Jira)에서 이슈를 찾아 URL을 복사한다.
2. 터미널이나 Claude Code 데스크탑에 붙여넣고 에이전트에게 시작하라고 시킨다.
3. 다음 이슈, 다음 에이전트, 다음 탭에서 같은 일을 반복한다.
4. 깃허브로 넘어가서 PR 상태를 확인하고, 다시 터미널로 돌아온다.
5. 어느 터미널이 어떤 작업을 돌리고 있었는지 기억이 안 난다.

본인 표현을 빌리자면 **"나는 저글러가 아니다(I'm not a juggler)"**. 일 자체는 돌아갔지만 너무 수동적이었고, 무엇보다 각 에이전트가 어떤 이슈를 맡고 있는지 연결 고리가 자꾸 끊어졌다는 거죠. 12.4 소개 글에서 제가 "에이전트에게 일을 맡겼는데 정작 내가 에이전트들의 비서가 되어버린 느낌"이라고 썼던 바로 그 상황입니다.

여기서 재미있는 건 지오가 선택하지 않은 길입니다. 에이전트에게 티켓 상태까지 알아서 바꾸게 하고 사람은 손을 떼는 '완전 자동화' 쪽으로 갈 수도 있었을 텐데, 그는 에이전트를 감독 없이 믿고 싶지 않았다고 합니다. 작업 중에는 방향을 잡아주고, 결과물은 공개되기 전에 직접 검토하는 **사람이 루프 안에 있는(human-in-the-loop)** 구조를 원했던 거죠. 그래서 자기 불편을 해결하려고 혼자 거친 프로토타입을 만들어 두었는데, 동료 아담이 "에이전트를 탭 하나씩 돌보는 대신 여러 에이전트를 지휘(orchestrate)할 아이디어가 없느냐"고 물어본 것이 계기가 되어 그 프로토타입이 제품이 되었다고 합니다. 이것이 케플러입니다.

## 그래서 ADE가 뭔데?

깃크라켄은 ADE를 IDE에 빗대어 이렇게 설명합니다.

* **IDE**: 개발자 한 명이 코드를 '쓰기' 위한 도구. 한 번에 파일 하나, 브랜치 하나에 집중한다.
* **ADE**: 개발자 한 명이 여러 에이전트를 '병렬로 지휘'하기 위한 도구. 어떤 변경을 내보내고 어떤 것을 되돌려 보낼지 결정하는 데 집중한다.

즉 코드를 타이핑하는 공간이 아니라, 에이전트들에게 일을 나눠주고 진행 상황을 지켜보고 결과를 검수해서 머지까지 끌고 가는 **관제실** 같은 공간이라는 겁니다. 케플러의 슬로건이 "Any Agent. Any Model. From Idea to Merged."인 이유도 여기에 있습니다.

케플러의 핵심 개념 몇 가지만 짚어보면 이렇습니다.

### 태스크(Task)

케플러에서 모든 작업의 단위는 태스크입니다. 지라나 깃허브 이슈에서 시작할 수도 있고, 리뷰할 PR에서 시작할 수도 있고, 그냥 빈 태스크에 질문 하나 던지면서 시작할 수도 있습니다. 태스크 하나는 **하나 이상의 저장소**에 걸칠 수 있고, 저장소마다 **격리된 Git 워크트리(worktree)**를 가집니다. 에이전트들이 서로의 변경을 덮어쓰지 않도록 하는 장치죠. 워크트리 위에서 에이전트를 돌리는 방식은 깃크라켄 데스크탑 12.0 때부터 밀고 있던 노선이라, 그 연장선으로 이해하시면 됩니다.

### 에이전트와 모델은 골라 쓴다

케플러는 특정 에이전트에 종속되지 않는 **에이전트 불가지론(agent-agnostic)**을 표방합니다. 글을 쓰는 시점 기준으로 Claude Code, Codex, GitHub Copilot, Cursor CLI, OpenCode, Auggie를 연결할 수 있고, 태스크마다 에이전트와 모델, 권한 모드, 추론 강도를 따로 고를 수 있습니다. 같은 이슈에 Claude Code와 Codex를 나란히 붙여서 결과를 비교하는 것도 가능하고요.

### 액션(Actions)

이슈나 PR 옆에는 `Plan`, `Implement`, `Review`, `Address Feedback` 같은 버튼이 붙습니다. 누르면 해당 이슈 내용, diff, 저장소 상태를 컨텍스트로 담아서 미리 정해둔 에이전트와 모델로 세션이 시작됩니다. 프롬프트와 기본 에이전트는 액션별로 수정할 수 있고, 자기만의 액션을 새로 만들거나 에이전트 스킬을 붙일 수도 있습니다. 12.4에서 소개했던 "이슈에서 에이전트 세션 시작하기"를 훨씬 체계화한 버전인 셈입니다.

### 에이전트 그래프(Agent Graph)

제가 케플러에서 가장 흥미롭게 본 기능입니다. 에이전트가 뭘 하고 있는지 알려면 보통 터미널에 폭포수처럼 쏟아지는 로그를 읽어야 하죠. 케플러는 이걸 태스크 → 세션 → 턴 → 도구 호출 → 서브에이전트로 이어지는 **그래프**로 그려줍니다. 어느 노드가 권한 승인을 기다리는지(`NEEDS YOU`), 어디서 에러가 났는지가 색으로 바로 보입니다. 깃크라켄이 10년 넘게 커밋 그래프로 '코드의 역사'를 보여줬다면, 이제 에이전트 그래프로 '에이전트의 현재'를 보여주겠다는 발상이에요.

### 머지까지

각 워크트리의 diff를 보고, 스테이징하고, 커밋하고, PR을 만드는 것까지 케플러 안에서 끝납니다. SSH와 WSL 원격 환경, 모바일에서 액션을 실행하고 모니터링하는 기능, 새 워크트리가 만들어질 때 자동으로 실행되는 셋업 명령어 같은 것들도 붙어 있습니다.

## 그럼 깃크라켄 데스크탑은?

여기서 자연스럽게 드는 의문이 "그럼 깃크라켄 데스크탑에 있는 에이전트 기능들은 뭐가 되는 거지?"일 텐데요. 공식 입장은 명확합니다. **깃크라켄 데스크탑은 저장소 하나를 에이전트와 함께 깊게(deep) 파는 도구, 케플러는 여러 저장소와 여러 에이전트를 넓게(wide) 지휘하는 도구**라는 겁니다. 그래서 케플러에서 에이전트가 작업 중인 워크트리를 깃크라켄 데스크탑으로 바로 열어 라이브 diff를 보는 식으로 서로 연결되어 있습니다.

지오 본인도 "IDE는 죽었고 ADE가 대체했다"는 식의 기사에 동의하지 않는다고 못을 박습니다. 에이전트가 이미 있는 함수를 또 만들어 놓는 것 같은 실수를 잡아내려면 **결국 사람이 코드를 읽어야 하고**, 코드를 읽는 데 가장 좋은 도구는 여전히 IDE라는 거죠. "IDE를 새 제품 안에 다시 만들고 있는 거냐?"는 질문에는 "절대 아니다"라고 답합니다. 케플러는 IDE를 대체하는 게 아니라 그 옆자리에 두는 도구라는 점을 분명히 하고 있습니다.

## 솔직히 말해서, 우려되는 점들

여기까지 들으면 꽤 그럴듯한데, 저는 몇 가지 걱정도 함께 들었습니다.

**첫째, ADE라는 범주 자체가 아직 생소합니다.** 깃크라켄은 ADE라는 말을 열심히 밀고 있지만, 이 용어가 업계 표준으로 자리 잡을지는 아직 모릅니다. 비슷한 '에이전트 관제실' 류의 도구는 이미 여럿 등장했고, 각자 다른 이름을 붙이고 있죠. 개발자 입장에서는 "또 새로운 범주의 도구를 배워야 하나"라는 피로감이 먼저 들 수 있습니다.

**둘째, 제품이 아직 0.x입니다.** 2026년 6월 첫 공개 이후 10월 현재 0.13 버전까지 왔는데, 깃크라켄 스스로도 의도적으로 1.0 이전 단계에 머물러 있다고 말합니다. 퍼블릭 프리뷰라 무료 깃크라켄 계정만 있으면 써볼 수 있지만, 정식 출시 이후의 가격 정책은 아직 공개되지 않았습니다. 실제로 써본 분들의 후기 중에는 이슈 트래커 연동은 훌륭하지만 UI가 아직 거칠고, 칸반 카드를 직접 옮기는 것 같은 기본 동작보다 에이전트 그래프 같은 부가 기능에 더 공을 들인 것 같다는 평도 있었습니다.

**셋째, 깃크라켄 데스크탑과의 역할 분담이 사용자에게도 선명할까요?** 회사의 설명은 깔끔하지만, 데스크탑에도 이미 에이전트 세션 뷰와 워크트리 관리가 있다 보니 "둘 중 뭘 써야 하지?"라는 혼란은 당분간 피하기 어려워 보입니다.

**넷째, 멀티 에이전트 병렬 작업 자체가 아직 모든 팀의 현실은 아닙니다.** 에이전트 하나를 잘 쓰는 것도 버거운 팀이 많은데, 열다섯 개를 동시에 돌리는 사람의 고통을 해결하는 도구가 당장 얼마나 넓은 시장을 가질지는 지켜봐야 합니다.

## 그럼에도 관심을 가져볼 이유

그럼에도 저는 케플러를 한 번쯤 눈여겨볼 가치가 있다고 생각합니다. 이유는 간단한데, **지오가 겪은 저 고통은 우리 모두에게 곧 닥칠 일**이기 때문입니다. 올해 초만 해도 "에이전트 하나 띄워서 써본다" 수준이었던 분들이 지금은 워크트리 두세 개에 에이전트를 나눠 돌리고 계시죠. 이 숫자는 줄어들지 않을 거고, 그러면 '어느 터미널이 어느 이슈였더라' 문제는 반드시 찾아옵니다.

그 문제에 대한 깃크라켄의 답이 흥미로운 건, **완전 자동화가 아니라 사람의 통제를 전제로** 설계했다는 점입니다. 에이전트가 알아서 티켓을 닫게 두지 않고, 그래프로 상태를 보여주고, 머지 전에 사람이 diff를 보게 만드는 방향이죠. 12.4의 "Human in Control"이라는 메시지와 정확히 같은 결입니다. 그리고 특정 에이전트 벤더에 묶이지 않는 구조라서, 내일 더 좋은 에이전트가 나와도 워크플로우는 그대로 두고 에이전트만 갈아 끼울 수 있다는 점도 실용적입니다.

케플러가 ADE라는 범주를 성공적으로 만들어낼지, 아니면 깃크라켄 데스크탑의 기능으로 흡수될지는 솔직히 모르겠습니다. 다만 "에이전트 여러 개를 어떻게 지휘할 것인가"라는 질문 자체는 2026년 하반기 개발 도구 시장에서 가장 뜨거운 주제 중 하나이고, 케플러는 그 질문에 Git 회사다운 방식으로 답을 내놓은 초기 시도입니다. 글 서두에 붙여둔 공식 튜토리얼 1편(약간의 영어 듣기가 필요합니다)을 보시고, 윈도우·맥·리눅스 어디서든 무료로 설치해 보실 수 있으니 한 번 만져보시길 권합니다.

더 깊이 알고 싶으신 분들을 위해 관련 글도 한 줄씩 정리해 둡니다.

* [공식 제품 페이지](https://gitkraken.com/kepler): 다운로드와 기능 소개, FAQ.
* [Kepler 튜토리얼 영상 모음](https://gitkraken.com/blog/kepler-tutorials-every-video-you-need-to-get-started): 태스크 시작, 작업 공간 투어, 에이전트 그래프, 액션 설정까지 6편의 짧은 영상.
* [Why We Built Kepler](https://gitkraken.com/blog/why-we-built-kepler-one-engineers-frustration-with-fifteen-open-terminals): 이 글의 중심이 된, 터미널 열다섯 개 이야기.
* [Why We Stopped Reading Agent Logs Like a Waterfall](https://gitkraken.com/blog/why-we-stopped-reading-agent-logs-like-a-waterfall): 에이전트 그래프를 만든 이유.
* [Introducing Kepler](https://gitkraken.com/blog/introducing-kepler-the-delivery-engine-for-agent-driven-development): 2026년 6월 15일 첫 공개 발표문.
* [Kepler: GitKraken's ADE](https://gitkraken.com/blog/gitkrakenskepler): ADE 개념과 기능 전체를 정리한 공식 설명.

깃크라켄 데스크탑 쪽 유료 라이선스를 고민 중이시라면, 깃크라켄 앰배서더인 저의 referral 링크로 대략 50% 정도 할인을 받으실 수 있습니다.

[깃크라켄 라이선스 Referral 링크 <-](https://gitkraken.cello.so/rcr7uWnNUdm)

## Reference

* [https://gitkraken.com/kepler](https://gitkraken.com/kepler)
* [https://gitkraken.com/blog/kepler-tutorials-every-video-you-need-to-get-started](https://gitkraken.com/blog/kepler-tutorials-every-video-you-need-to-get-started)
* [https://www.youtube.com/watch?v=U0w18ZXrZ5M](https://www.youtube.com/watch?v=U0w18ZXrZ5M)
* [https://gitkraken.com/blog/why-we-built-kepler-one-engineers-frustration-with-fifteen-open-terminals](https://gitkraken.com/blog/why-we-built-kepler-one-engineers-frustration-with-fifteen-open-terminals)
* [https://gitkraken.com/blog/why-we-stopped-reading-agent-logs-like-a-waterfall](https://gitkraken.com/blog/why-we-stopped-reading-agent-logs-like-a-waterfall)
* [https://gitkraken.com/blog/introducing-kepler-the-delivery-engine-for-agent-driven-development](https://gitkraken.com/blog/introducing-kepler-the-delivery-engine-for-agent-driven-development)
* [https://gitkraken.com/blog/gitkrakenskepler](https://gitkraken.com/blog/gitkrakenskepler)
* [https://gitkraken.com/blog/kepler-is-in-public-preview-one-task-every-repo-every-agent](https://gitkraken.com/blog/kepler-is-in-public-preview-one-task-every-repo-every-agent)
* [https://help.gitkraken.com/kepler/release-notes-current/](https://help.gitkraken.com/kepler/release-notes-current/)
* [https://news.hada.io/topic?id=34783](https://news.hada.io/topic?id=34783)
* [https://djkeh.github.io/articles/Gitkraken-desktop-12-0-0-release-kor/](https://djkeh.github.io/articles/Gitkraken-desktop-12-0-0-release-kor/)
* [https://djkeh.github.io/articles/Gitkraken-desktop-12-4-0-release-kor/](https://djkeh.github.io/articles/Gitkraken-desktop-12-4-0-release-kor/)
* [https://git-scm.com/docs/git-worktree](https://git-scm.com/docs/git-worktree)
* [https://gitkraken.cello.so/rcr7uWnNUdm](https://gitkraken.cello.so/rcr7uWnNUdm)
