---
layout: post
categories: articles
title:  "JSON 데이터를 자바로 파싱하는 가장 빠른 방법"
excerpt: "REST API 출력 데이터를 자바 코드로 파싱하기"
tags: [json, java, parse, parsing, rest, api]
date:   2015-03-10 15:08:19
modified:   2015-03-10 15:08:19
image:
  feature:
  credit:
  creditlink:
share: true
---

### REST API 출력 데이터를 JSON 데이터로 파싱하기

REST API는 JSON 스트링 형태로 결과 데이터를 출력해주는데, 이를 파싱하여 자바 객체로 받아들여 활용할 수 있다. 현재 굉장히 많은 JAVA JSON 라이브러리가 존재하는데([json.org](http://json.org) 에서 관련 자료를 확인할 수 있다), 어떤 것을 사용해야 할까?

오픈 소스에 보다 많은 커뮤니티와 업계에서 사용하여 접근하기 용이하고, 패키지 무게가 가벼우며, 성능이 뛰어난 라이브러리일 수록 좋을 것이다. 2014년 4월 기고된 developer.com 기사에서는 최근 가장 핫한 오픈 소스 JSON 처리 라이브러리 7가지를 소개하고 있는데, 자체 벤치마크 결과 그래프를 함께 제공하여 어떤 라이브러리가 자신의 프로젝트에 가장 적합할지를 선택하는데 도움을 주고 있다.

벤치마크 대상이 된 라이브러리 목록은 다음과 같다.

* Jackson
* Google-gson
* JSON-lib
* Flexjson
* Json-io
* Genson
* JSONij

각 라이브러리의 특징을 기사 내용을 바탕으로 리스트 형식으로 간략하게 요약한다.

##### 1. Jackson
- 상당히 잘 알려진 JSON 라이브러리
- 컨셉: “다목적 자바-JSON 처리 라이브러리. 빠르고 정확하고 가벼우며 개발자에게 친숙하다. (multi-purpose Java library for processing JSON who aims to be the best possible combination of fast, correct, lightweight and ergonomic for developers)”
- 코드가 심플한 편
- 특히 고용량(100MB 이상)의 JSON 데이터 처리 성능이 탁월
- [메이븐(Maven) 저장소](http://repo1.maven.org/maven2/com/fasterxml/jackson/) 지원
- 패키지는 무거운 편

##### 2. Google-gson
- 오우(Oh), 구글!
- 소스코드 구하기, 레퍼런스 찾기 용이
- 하나의 jar 파일로 구성, [메이븐 저장소](http://search.maven.org/#artifactdetails%7Ccom.google.code.gson%7Cgson%7C2.3.1%7Cjar) 지원
- 가벼운 JSON 데이터 처리 성능 탁월, 전반적으로 고성능
- 상대적으로 가벼운 패키지 무게

##### 3. JSON-lib
- [더글라스 크록포트(Douglas Crockford)](http://en.wikipedia.org/wiki/Douglas_Crockford) 작품
- 디펜던시 다소 존재
- [소스코드 다운로드](http://sourceforge.net/projects/json-lib/files/)

##### 4. Flexjson
- 자바 객체를 JSON으로 직렬화하거나 비직렬화할 수 있는 경량 라이브러리
- [다운로드 사이트](http://sourceforge.net/projects/flexjson/files/)
- 다른 외부 라이브러리와 의존성 없음
- 성능은 무난하나 아주 적은 패키지 사이즈가 장점

##### 5. Json-io
- 초경량 라이브러리
- JsonReader, JsonWriter 두 클래스로 구성 -> 직렬화 담당하는 stream 객체가 필요 없음
- [메이븐 저장소](http://search.maven.org/#search&verbar;ga&verbar;1&verbar;json-io) 지원
- 대부분의 경우 JDK의 ObjectInputStream, ObjectOutputStream보다 빠른 직렬화 성능을 제공

##### 6. Genson
- 사용하기 쉽고 확장성이 용이한 것에 초점을 맞춘 라이브러리
- [소스코드 다운로드](https://code.google.com/p/genson/downloads/list)

##### 7. JSONiJ
- [소스코드 다운로드](https://bitbucket.org/jmarsden/jsonij/downloads)
- 다른 의존성 없음
- 소스코드가 다른 라이브러리에 비해 복잡함


### 성능 측정(benchmark) 결과
다음은 위 7종의 라이브러리를 사용한 테스트 결과를 그래프로 나타낸 것이다.

![figure 1.](/images/20150310_json_library/benchmark1.png "그림 1. 작은 용량 직렬화/비직렬화")

- 직렬화(Object->JSON, 실질적 내보내기) 1, 2등: Flexjson, gson
- 종합 1, 2등: gson, genson

![figure 1.](/images/20150310_json_library/benchmark2.png "그림 1. 작은 용량 전체 시간")

- 1, 2등: gson, genson

![figure 1.](/images/20150310_json_library/benchmark3.png "그림 1. 큰 용량 직렬화/비직렬화")

- 직렬화(Object->JSON, 실질적 내보내기) 1, 2등: Jackson, JSON-lib
- 종합 1, 2등: Jackson, JSON-lib

![figure 1.](/images/20150310_json_library/benchmark4.png "그림 1. 큰 용량 전체 시간")

- 1, 2등: Jackson, JSON-lib

![figure 1.](/images/20150310_json_library/benchmark5.png "그림 1. 라이브러리 전체 사이즈")

- 1, 2등: json-io, Flexjson

### 결론
난 gson!

참조: [developer.com - Top 7 Open-Source JSON-Binding Providers Available Today](http://www.developer.com/lang/jscript/top-7-open-source-json-binding-providers-available-today.html)

