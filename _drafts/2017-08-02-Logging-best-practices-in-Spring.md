---
layout: post
categories: articles
title:  "스프링에서 사용할 수 있는 최선, 최신의 로깅 베스트 프랙티스"
excerpt: "stdout 출력부터 slf4j의 스프링 싱글톤 로거 사용까지"
tags: [java, spring, boot, best, practice, bestpractice, log, logging, slf4j, log4j, log4j2, logback, 자바, 스프링, 베스트프랙티스, 로그, 로깅]
date: 2017-08-02 14:09:58
modified: 2017-08-02 14:09:58
image: 
  feature: 
  credit: 
  creditlink: 
share: true
sitemap: false
---

로깅은 서비스 운영과 유지보수에 있어서 아주 기본적이고 중요한 요소입니다. 보다 빠르고, 적은 리소스를 사용하고, 코드의 디펜던시와 로직에 영향을 끼치지 않으면서 충분한 정보를 간결하고 보기 좋게 정돈하여 보여주는 로그와 그 방법론은 오래 전부터 프로그래머들이 고민했던 이슈였으리라 생각합니다.

오늘은 제가 프로그래밍을 하면서 배워왔던 로깅 기법을 시작부터 가장 최신의 방법까지 순서대로 정리해볼까 합니다. 마지막 단계에서 소개해 드리는 로깅 기법은 가장 좋은 방법이거나 가장 최신의 방법이라 보장해드릴 수는 없지만, 지금 제가 막 도입을 시작했으며 가장 좋은 방법이리라 믿고 있는 방법입니다. 때문에 언제나 그렇지만 이 포스팅에서는 특별히 더욱 댓글과 피드백을 많이 부탁드리고 싶습니다.

또한, 가장 마지막 방법에서는 최근 개발 커뮤니티에서 이슈가 됐었던 정적 로깅을 살짝 정리해서 언급드릴까 합니다.

# 1. stdout(표준 출력)에 직접 뿌리기

가장 첫번째는 시스템 표준 출력으로 보고 싶은 내용을 보고 싶은 위치에서 출력하는 것이겠죠.

```c
printf("[Log] value: %d\n", value);
```

```java
System.out.println("[Log] value: " + value);
```

## 문제점

* 표준 출력은 프로그램이 기본적으로 결과를 출력하는 스트림


# 2. stderr(표준 에러)에 뿌리기


# 3. 로깅 라이브러리를 사용하기

## 아파치 모듈 (C)

## 자바

### Log4J

### LogBack

### Log4J2


# 4. 싱글턴을 적용하기


# 5. 로깅 파사드를 사용하기

## 파사드(Facade) 패턴이란?

## SLF4J


# 6. 프레임워크 IoC 컨테이너를 이용하기

# 7. 반례

- https://github.com/spring-projects/spring-boot/issues/8106
