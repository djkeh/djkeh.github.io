---
layout: post
categories: articles
title:  "Gitkraken에서 AI로 더 똑똑하게 형상관리하기"
excerpt: "Gitkraken AI를 활용한 자동 커밋 메시지, PR 작성, 머지 충돌 해결과 커밋 정리"
tags: [git]
date: 2025-12-24 17:57:27
last_modified_at: 2025-12-24 17:57:27
sitemap: true
---

여러분은 평소에 Git Client를 사용하면서 얼마나 AI 기술을 활용하고 계신가요? 프로그램 코드를 작성할 때 뿐만 아니라, 코드를 관리하는 형상관리 영역에서도 AI의 영향력이 점점 커지고 있습니다. Git 저장소에서 당연히 직접 해야 한다고 생각했던 부분들이 AI로 빠르고 정교하게 커버될 수 있다면, 꽤 신기하겠죠?

오늘은 그 중심에 있는 강력한 Git GUI Client, [GitKraken](https://www.gitkraken.com/)의 AI 기능들을 살펴보려고 합니다. 깃크라켄은 전세계에서 가장 인기있는 Git GUI 클라이언트 중 하나입니다. 물론 북미에 비하면 깃크라켄 데스크탑 제품의 국내 시장 점유율이 자바 진영의 인텔리제이처럼 압도적이라고 말씀드리기는 어려울 수도 있는데요, 만약 여러분이 [vscode](https://code.visualstudio.com/)를 쓰고 계시고 이 안에서 깃 저장소를 다룬다면 어떤 확장프로그램(extension)을 쓰시겠어요? 아마 [GitLens](https://www.gitkraken.com/gitlens)가 아닐까 싶습니다. 2016년에 출시됐던 깃렌즈는 vscode의 명실공히 필수 git 확장프로그램이 되었는데요, 이게 깃크라켄의 제품 중 하나입니다. [2021년 깃렌즈가 깃크라켄 산하로 들어왔고](https://www.gitkraken.com/blog/gitkraken-acquires-gitlens-for-visual-studio-code), 이 프로그램의 개발자였던 에릭 아모디오(Eric Amodio)는 깃크라켄의 CTO가 되어 깃크라켄을 이끌고 있죠.

어느덧 출시 11년차가 된 깃크라켄은 최근부터 AI 기능을 적극적으로 도입하며 단순한 깃 클라이언트를 넘어 '지능형 협업 도구'로 진화하고 있습니다. 깃크라켄이 어떤 부분을 AI로 자동화할 수 있는지 보시면, 아마 깜짝 놀라실 겁니다.


## 1. 커밋 & 브랜치 설명

개인적으로 꼽은 가장 매력적인 기능부터 소개해 드리고 싶은데요, 복잡하게 얽힌 커밋 히스토리나 이름만 봐서는 의도를 파악하기 힘든 브랜치를 마주했을 때, `Explain commit` 버튼을 이용해 보세요. 하나의 커밋 노드, 또는 브랜치를 대상으로 이 버튼을 클릭해서 변경 내용의 요약을 받아볼 수 있습니다. 실제로 스프링 부트 프로젝트의 내용을 한 번 분석해 보겠습니다.

![스프링 부트 프로젝트의 단일 커밋을 분석한 결과](/images/20251224_gitkraken_ai/explain-changes-1.gif)

결과가 괜찮죠? 한글로 요약이 나오게 만드는 방법은 아래에서 따로 소개해 드리겠습니다. 빠른 파악이나 의사결정을 해야할 때 이 기능이 얼마나 많은 시간을 세이브해줄 수 있을 지 상상이 되시나요? 깃크라켄에서는 이 기능을 여러 개의 커밋을 대상으로도 할 수 있습니다.

![스프링 부트 프로젝트의 여러 개의 커밋을 한 번에 분석한 결과](/images/20251224_gitkraken_ai/explain-changes-2.gif)

이 블로그를 쓰는 시점에서 깃크라켄 최신 버전이 `11.7.0`인데요, 깃크라켄은 `11.0`에 처음 AI 기능을 보여주기 시작했습니다. 이 요약 기능은 아래에 소개해드릴 커밋 메시지 자동 생성 기능과 더불어 깃크라켄에서 소개하는 첫 번째 AI 기능입니다. 모든 협업 환경에서, 특히 프로젝트 규모가 크면 클 수록 이 기능은 빛을 발합니다. 회사 프로젝트를 분석하고 신규 피쳐를 기획할 때, 오픈소스에 새로 참여할 때, 회사에서 사용 중인 오픈소스가 회사 개발 상황이랑 안 맞을 경우 문제 원인을 찾을 때 빠르게 기존 내용을 분석하고 고치고 싶은 부분으로 찾아 들어갈 수 있겠죠.

다만 이 기능은 분석할 소스코드를 AI 서버에 보내야 하기 때문에, 최초로 사용하실 때 이를 허락 받는 알림창을 보실 수 있습니다. 확인을 클릭해 주시면 진행되고, 다시 묻지 않습니다. 보안에 보수적인 기업 환경에서는 사용해도 되는 지를 한 번 확인해봐야 하겠네요.


## 2. 커밋 메시지 & 풀 리퀘스트 작성

잘 써야 하는게 기본이지만, 한 편으로 가장 귀찮고 평가도 모호한 일 중 하나가 바로 커밋 메시지나 풀 리퀘스트(Pull Request, PR)를 작성하는 일일 것입니다. 깃크라켄은 현재 스테이징된 변경 사항을 분석하여 적절한 커밋 메시지를 자동으로 써줍니다.

![커밋 메시지 자동 작성 예시](/images/20251224_gitkraken_ai/commit-message-generation.gif)

이 기능은 일반 커밋 뿐만 아니라 스태시(stash)에서도 똑같이 사용할 수 있습니다. 스태시 메시지를 자동으로 생성해주는 기능은 `11.1`에서 업데이트 되었습니다. 커밋 메시지는 협업 요소이기 때문에 아무래도 결국은 사람이 검수를 하기 마련이겠지만, 스태시는 혼자서만 본다는 점에서 이 자동화가 더욱 실용적으로 다가올 수 있죠. '대략 빨리 쓰되 핵심을 담아 잘쓴다'는 취지에 딱이니까요.

한 편, 깃크라켄은 출시 초기부터 다른 깃 클라이언트와 차별화되는 장점이 있었죠. 그것은 다른 형상관리 플랫폼과 매끄러운 통합이었습니다. 깃크라켄은 깃헙(GitHub), 깃랩(GitLab), 비트버킷(Bitbucket), 지라(Jira), 애져(Azure DevOps) 등 웬만한 주요 협업 도구들의 연동을 아주 매끄럽게 지원하는데요,

![깃크라켄 도구 연동 지원 목록](/images/20251224_gitkraken_ai/gitkraken-integrations.gif)

그래서 깃크라켄 화면 안에서 깃헙의 이슈나 PR을 작성하는 것도 이미 다 가능한 상태였죠. 여기에도 AI 기능을 쓸 수 있게 된 겁니다. 변경점을 분석해서 PR 본문을 자동으로 작성할 수 있는 것이죠. 다만 이 기능은 국내에서는 다른 깃크라켄 AI 기능과 비교했을 때 상대적으로 아주 널리 퍼지진 못할 것 같습니다.


## 3. 머지 충돌 해결

회사와 같은 협업 환경에서 프로젝트를 관리하면서 가장 자연스럽게 만나는 순간이 바로 머지 충돌(merge conflict)입니다. 프로젝트가 클 수록, 참여 인원이 많을 수록 머지 충돌 문제는 피할 수 없습니다. 깃크라켄은 자체 Merge Conflict Tool을 제공하여 훌륭한 사용자 경험을 기존에 제공하고 있었는데요, 여기서 한 발 더 나아가 충돌이 발생한 코드의 전후 맥락을 파악하고 스스로 최적의 머지 방안을 제안합니다.

![Auto-resolve with AI 버튼 클릭 결과](/images/20251224_gitkraken_ai/auto-conflict-resolve.jpg)

머지 충돌을 해결한 결과와 함께 왜 그렇게 작업했는지 설명을 보여주는데요, 여기서 각 충돌을 해결한 부분마다 `confidence` 수치를 확인할 수 있습니다. 이 충돌 해결이 상황에 맞을 것이라는 확신을 일정한 수치로 평가하여 보여주는 점이 재미있습니다. 굉장히 똑똑한 기능이긴 한데, 어쨌든 사람의 검수를 아예 생략할 수는 없겠죠. 이 기능은 `11.2` 버전에서 추가되었습니다.


## 4. Commit Composer - 커밋 자동 정리

이게 또 한 가지 생소한 기능일 수 있겠습니다. 깃크라켄 AI는 커밋 메시지만 써주는게 아니라, 커밋 그래프 자체를 다시 정리정돈해줄 수도 있습니다. 이 기능은 `11.3`에서 처음 소개되었는데요, 이해를 돕기 위해 자료를 먼저 보시죠.

![Commit Composer - 전](/images/20251224_gitkraken_ai/commit-composer-1.jpg)

![Commit Composer - 후](/images/20251224_gitkraken_ai/commit-composer-2.jpg)

뭔가 대충대충 만든 커밋들과 메시지들이 자동으로 예쁘게 정돈되어 다시 만들어졌습니다. 데모도 같이 보시죠.

![Commit Composer 데모 1](/images/20251224_gitkraken_ai/commit-composer-3.gif)

![Commit Composer 데모 2](/images/20251224_gitkraken_ai/commit-composer-4.gif)

보신 것처럼 기능 하나를 만들던 브랜치에서 조금 편하게 커밋들을 만들더라도, commit composer 기능을 이용해서 기존의 커밋들을 다시(recompose) 정돈할 수 있습니다. 메시지 자동 생성 기능과 연동해서, 기존의 다듬어지지 않았던 커밋 메시지들도 정돈된 형식으로 다시 구성해주고, 합칠 수 있는 커밋들은 합쳐서 커밋 그래프를 다시 쓸 수 있는 거죠. 원격 저장소(remote repository)에 아직 푸시되지 않은 로컬 브랜치를 정리할 때 유용할 것 같고요, 이미 푸시한 뒤에라도 깃을 능숙하게 다룰 줄 아신다면 필요에 따라 브랜치 트리를 정리할 때 도움을 받을 수 있겠습니다.


## 5. AI 모델 선택과 지시어 커스터마이징

그런데 Gitkraken이 UTF-8을 지원하고 한글 사용에 문제가 거의 없다고 하더라도, 일단은 북미를 기준으로 맞춰진 프로그램이다보니 전체적인 UI는 영어로 구성되어 있거든요? AI 생성 결과도 기본적으로 영어에 맞춰져 있습니다. 이것을 어떻게 하면 한글로 바꿀 수 있을까요? 그것은 설정에서 커스텀 지시어(custom instructions)를 작성해주면 가능합니다. 여기서 커밋 메시지 작성이나 변경점 요약 등 AI가 들어가는 모든 부분에 지시어를 넣어서 출력물의 결과를 제어할 수 있습니다. 또한 사용할 AI 모델을 ChatGPT로 할지, Gemini로 할지도 여기서 고를 수 있죠. 제 설정 일부를 보여드리면 아래와 같은데요, 이 부분은 사용자마다 니즈가 워낙 다양하기 때문에 내용 전체를 텍스트로 공개하지는 않아도 될 것 같네요. 대략적인 참고만 해주시면 좋을 것 같습니다.

![GitKraken AI 설정 화면](/images/20251224_gitkraken_ai/gitkraken-ai-settings.jpg)


## 6. 깃크라켄 MCP 서버

[MCP(Model Context Protocol)](https://modelcontextprotocol.io/) 서버 연결도 깃크라켄이 제공하는 AI 기능 중 하나입니다. 현재는 GitLens를 통해서 사용할 수 있고요, vscode 뿐만 아니라 [Cursor](https://cursor.com/), [Windsurf](https://windsurf.com/) 등 다양한 에디터 환경에서 설치할 수 있습니다. 이를 통해 외부 AI 모델이나 도구들이 깃크라켄을 통해 현재 깃 저장소와 상호작용하도록 만들 수 있습니다. 깃 저장소의 상태뿐만 아니라, 깃크라켄은 깃헙 등과도 연동되어 있으니 내게 할당된 이슈나 PR을 파악하는 것도 가능하죠. 설치 방법도 쉬워요. 아래는 vscode를 통해 깃크라켄 MCP를 설치하고 설정하는 과정을 간략하게 보여줍니다.

![GitKraken MCP 데모](/images/20251224_gitkraken_ai/gitkraken-mcp.gif)


## 아쉬운 점: 유료 구독의 벽

이토록 강력한 GitKraken AI 기능들이지만, 한 가지 아쉬운 점이 있습니다. 깃크라켄 AI 기능은 유료 구독 회원(Pro 이상)에게만 제공된다는 점이에요. 아무래도 AI 토큰 사용료가 공짜가 아니다보니 어쩔 수가 없는 부분이죠. 현재 상용 서비스 대부분의 AI 연동 기능이 유료로 제공된다는 점을 생각하면 납득은 됩니다.

그래도 좀 더 저렴하게 사용해볼 수 있는 기회는 있습니다. 저는 오랫동안 깃크라켄 앰배서더로 활동하고 있어서 저를 통한 할인 링크를 이용하실 수도 있거든요. 할인을 받으시면 한 달에 3천원 가격이니 상당히 가볍습니다. 관심이 가셨던 분이라면 [이 쪽 링크](https://gitkraken.cello.so/rcr7uWnNUdm)를 통해 시도해 보시길 바랍니다. 또한 유료 구독을 하지 않아도, 깃헙 퍼블릭 저장소를 다룰 때는 깃크라켄의 거의 대부분의 기능을 사용할 수 있으니 우선 무료(community) 버전으로 시작하시는 것도 좋습니다.


## AI 경쟁: 주요 Git Client 비교

깃크라켄의 AI 기능을 쭉 둘러보았는데요, 다른 깃 클라이언트들은 AI 기능을 얼마나 제공하고 있을까요? 꽤 많은 깃 클라이언트가 있지만 오늘은 대표적으로 소스트리와 인텔리제이 VCS를 살펴보겠습니다.

### Sourcetree

Atlassian의 [Sourcetree](https://www.sourcetreeapp.com/)는 대표적인 무료 깃 GUI 클라이언트입니다. 오랜 시간 많은 개발자들에게 사랑을 받아왔고, 무료라는 강력한 접근성 덕에 지금도 널리 사용되고 있죠. 하지만 AI를 활용한 기능은 아직 없습니다. 제가 찾아볼 때 소스트리 지라에서 `ai` 키워드로 검색되는 AI 관련 논의는 아래 것들이 전부이고, 모두 해결이 되지 않았네요.

* [https://jira.atlassian.com/browse/SRCTREE-8028](https://jira.atlassian.com/browse/SRCTREE-8028)
* [https://jira.atlassian.com/browse/SRCTREE-8193](https://jira.atlassian.com/browse/SRCTREE-8193)

### IntelliJ VCS

그에 비해 자바 진영에서 국내 시장을 장악하고 있는 JetBrains의 [IntelliJ](https://www.jetbrains.com/idea/) 안에 내장되어있는 [VCS(Version Control System)](https://www.jetbrains.com/help/idea/enabling-version-control.html) 기능은 IDE와의 완벽한 통합을 바탕으로 깃크라켄의 가장 강력한 경쟁자로 꼽힙니다. 깃크라켄이 제공하는 것과 거의 비슷한 수준의 기능들을 갖추고 있고, 개발 환경 내에서 모든 것을 처리할 수 있다는 장점이 있습니다. 대략 아래와 같은 기능들을 지원하고요,

* 커밋 메시지 작성
* AI 셀프 리뷰
* 커밋 요약
* 깃헙 pr 작성
* 머지 충돌 해결
* 깃헙 pr 요약

자세한 내용은 아래의 공식 매뉴얼을 살펴보시기 바랍니다.

* [https://www.jetbrains.com/help/ai-assistant/ai-in-vcs-integration.html](https://www.jetbrains.com/help/ai-assistant/ai-in-vcs-integration.html)

하지만 깃크라켄에는 인텔리제이 VCS에 없는 독자적인 편의 기능들이 있기 때문에, 쉽게 비교하기는 어렵겠네요.

## 마치며

깃크라켄은 AI를 통해 형상관리의 패러다임을 바꾸고 있습니다. 단순한 기록 장치를 넘어, 개발자의 의도를 이해하고 도와주는 든든한 조력자로 거듭나고 있습니다. 여러분도 GitKraken AI와 함께 더 똑똑하고 효율적인 Git 워크플로우를 경험해 보시길 바랍니다.


## Reference

* [https://www.gitkraken.com/features/git-ai](https://www.gitkraken.com/features/git-ai)
* [https://www.gitkraken.com/mcp](https://www.gitkraken.com/mcp)
* [https://gitkraken.cello.so/rcr7uWnNUdm](https://gitkraken.cello.so/rcr7uWnNUdm)
