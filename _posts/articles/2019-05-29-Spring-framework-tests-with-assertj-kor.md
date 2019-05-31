---
layout: post
categories: articles
title:  "스프링은 AssertJ로 테스트한다"
excerpt: "최근 스프링 프레임워크 코드 동향 슬쩍 보기"
tags: [java, spring]
date: 2019-05-31 18:43:30
last_modified_at: 2019-05-31 18:43:30
---

오늘은 스프링 프레임워크 오픈 소스의 작은 코드 동향을 소개시켜 드립니다.

일주일 전 @philwebb 이 작업한 코드 커밋 중 하나를 보면, 방대한 분량의 스프링 프레임워크 테스트 코드가 AssertJ로 다시 작성되었습니다. 개인적으로 AssertJ 스타일을 좋아하는 저로써는 신기하고도 반가운 소식이네요. 이슈 #23022 에 따르면 그 목적은 이렇습니다.

* exception 테스트를 포함한 모든 테스트 코드에 적용할 때, AssertJ로 assertion 코드를 표현하는 것이 상당히 이득이다
* 통일된 assertion 스타일을 가져가므로 테스트를 읽기가 더 수월해진다
* JUnit5 로 마이그레이션할 때 훨씬 수월해질 것이다

이 작업 내용들 중 JUnit4 -> AssertJ 마이그레이션을 하는 커밋 9d74da0 을 살펴보는 것도 소소한 재미가 있습니다. 커밋 코멘트는 알기 쉽게 작성되어있는데, 커밋 내용물은 1,636 개의 파일 변경점과 도합 거의 8만 줄에 다다르는 라인 변경점을 한 방에(!) 포함합니다. 아마도 단계적인 브랜치 머지 전략 중에 squash 기능을 사용한 듯 하네요. ~~(그게 아니면 정말 통으로 올렸거나)~~

AssertJ, JUnit5 에 아직 익숙하지 않으신 분들을 위해 참고 링크를 추가해 뒀으니 궁금하신 분은 한 번 구경해 보시는 것도 좋을 것 같아요.

또 재미있는 스프링 코드 동향을 발견하게 되면 알려드릴게요 :)

## Reference

* [https://github.com/spring-projects/spring-framework](https://github.com/spring-projects/spring-framework)
* [https://github.com/spring-projects/spring-framework/issues/23022](https://github.com/spring-projects/spring-framework/issues/23022)
* ​[https://github.com/spring-projects/spring-framework/commit/9d74da0](https://github.com/spring-projects/spring-framework/commit/9d74da0)
* [https://joel-costigliola.github.io/assertj/](https://joel-costigliola.github.io/assertj/)
* [https://junit.org/junit5/](https://junit.org/junit5/)
* [https://howtodoinjava.com/junit5/junit-5-vs-junit-4/](https://howtodoinjava.com/junit5/junit-5-vs-junit-4/)
