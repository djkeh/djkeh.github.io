---
layout: post
categories: articles
title:  "Gist 댓글 알림 받기"
excerpt: "Giscus, GistWatch를 통해 Gist 댓글 알림 받는 법"
tags: [git, gist]
date: 2017-08-01 11:44:10
last_modified_at: 2019-02-07 10:35:13
---

## Gist는 편리하다

[Gist](https://gist.github.com/)는 [Github](https://github.com/)에서 제공하는 문서 공유 서비스입니다. 즉석에서 간단한 문서 한 개, 코드 한 토막, 작은 솔루션, 아이디어를 작성하고 공유하기에 최적화된 도구입니다. 검색이 가능한 public 문서와 검색 노출이 제한된 secret 문서, 로그인 없이 바로 작성하는 anonymous 문서를 만들 수 있고, 파일 포맷에 따라 적당한 수준의 syntax highlighting을 지원합니다. 문서에 관한 피드백을 댓글로 주고 받을 수 있고, 댓글 속에서 깃헙의 특정 사용자를 멘션할 수도 있습니다. Gist 에디터는 [CodeMirror](https://codemirror.net/)를 사용하고 있습니다.

재밌는 것은 Gist도 Git 저장소로 만들어져 있다는 점이죠. 따라서 `fork`, `clone`이 가능하고, 문서의 변경 내역(revisions)도 모두 볼 수 있습니다.


## 근데 알림을 못 받는다

Gist는 꽤 오래된 서비스이고, 이와 관련된 이슈도 2013년에 이미 나왔지만, 아직 알림 기능이 없습니다! 내가 만든 Gist 문서에 누군가 댓글을 달아도 직접 들어가서 보기 전에는 댓글이 달렸다는 사실을 알 방법이 없는 상태입니다.

* [https://github.com/isaacs/github/issues/21](https://github.com/isaacs/github/issues/21)

이것 굉장히 난감하군요!


## 방법

있습니다!

### 1. Giscus

* [https://giscus.co/home](https://giscus.co/home)

Giscus는 Gist의 알림을 깃헙 계정의 이메일로 보내주는 간단한 서비스를 제공합니다.

![Giscus 메인 화면](/images/20170801_gist_notification/giscus.png)

무료이고, 사용법도 아주 간단합니다. 그저 OAuth 로그인을 통해 계정 정보 접근을 허용해주면 됩니다.

![접근 허용 화면](/images/20170801_gist_notification/giscus2.png)

별다른 라이선스가 명시되어 있지 않지만, 소스코드도 깃헙에 공개되어 있습니다.

* [https://github.com/tightenco/giscus](https://github.com/tightenco/giscus)

#### 쓸만한가

저도 방금 발견해서, 해두기는 했는데.. 아직 알림을 못 받아봤습니다 ㅎㅎ 받게 되면 문서를 밑에 업데이트 하겠습니다.

#### 사용 후기 업데이트

* 자신이 쓴 댓글의 알림은 안오고 있습니다..

### 2. GistWatch

* [https://gistwatch.com/](https://gistwatch.com/)

GistWatch 또한 Gist의 댓글 알림을 보내주는 심플한 서비스입니다. Giscus와의 차별점이라면, 이메일 뿐만 아니라 추가로 슬랙(Slack)과 트위터(twitter)를 통해 알림을 보내주는 기능이 있습니다. 홈피도 조금 더 예뻐요.

![GIstWatch 메인 화면](/images/20170801_gist_notification/gistwatch.png)

역시 무료이고, Giscus와 비슷하게 사용법도 간단합니다.

#### 쓸만한가

저도 방금 발견했어요 ㅎㅎ 써보는 중입니다. 알림을 받게 되면 문서를 밑에 업데이트 하겠습니다.

#### 사용 후기 업데이트

![알림 모습](/images/20170801_gist_notification/gistwatch-noti.png)

* 알림 모습을 캡쳐하였습니다. 이메일 알림에 댓글 작성자나 내용을 미리 보여주진 않네요. 단순히 댓글이 달린 것만 알 수 있는 것 같습니다.
* 자신이 쓴 댓글의 알림이 오네요.


## 결론

짧은 코드를 작성하고 주변 사람들과 커뮤니케이션할 때, 위 서비스들 한 번 믿고 함께 Gist를 사용해 볼..까요!;
