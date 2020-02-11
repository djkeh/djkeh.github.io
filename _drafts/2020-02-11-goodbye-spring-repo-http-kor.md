---
layout: post
categories: articles
title:  "Goodbye! http - repo.spring 의 http 지원 중단 소식"
excerpt: "스프링 뉴스 2019.09.16"
tags: [git]
date: 2020-02-11 17:30:35
last_modified_at: 2020-02-11 17:30:35
sitemap: false
---

저는 오늘 회사에서 평소처럼 일을 하다가, 다음과 같은 화면을 발견하였습니다.

![gradle error](/images/20200211_goodbye_http/gradle_error.png "gradle이 먹통이 되었다")

![gradle error detail](/images/20200211_goodbye_http/gradle_error_detail.png "gradle이 먹통이 되었다")

프로젝트 캐시를 지운 후 예상치 못한 문제를 만나 당황하였는데, 원인은 비교적 빨리 알아낼 수 있었습니다.

> beginning January 15 2020, Spring’s Maven Repository will no longer support HTTP.

2020년 1월 15일 부로 스프링 저장소는 http를 지원하지 않는다는 스프링 블로그 소식입니다.
소식 발표 자체는 이미 진작에 있었습니다. 블로그 포스팅 날짜가 2019년 9월 16일이네요.

이제 기존 개발환경에서 해당 저장소 경로를 바라보는 설정 구간이 있다면 모두 프로토콜을 https 로 업데이트해 주셔야 합니다.
개발환경의 캐시가 남아있다면 당장은 문제가 나타나지 않겠지만,
곧 나타나게 될 겁니다.


## Reference

* ​[https://spring.io/blog/2019/09/16/goodbye-http-repo-spring-use-https](https://spring.io/blog/2019/09/16/goodbye-http-repo-spring-use-https)
* [https://github.com/spring-gradle-plugins/propdeps-plugin/issues/12](https://github.com/spring-gradle-plugins/propdeps-plugin/issues/12)
