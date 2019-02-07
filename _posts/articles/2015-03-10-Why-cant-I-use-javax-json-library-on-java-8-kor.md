---
layout: post
categories: articles
title: "JAVA 8에서 javax.json 라이브러리를 사용 못하는 이유"
excerpt: "Java EE와 Java SE의 차이점"
tags: [java, json]
date: 2015-03-10 15:11:16
last_modified_at: 2019-02-07 09:11:15
---

**Q: JAVA 8을 쓰는데도 javax.json.*; 이 임포트(import) 되지 않아요!**

A: 그것은 해당 JSON 라이브러리 그룹이 Java EE 라이브러리이기 때문이다. JDK 버젼이 최신인 8인데 왜 안되지? 라며 쩔쩔 매고 있었다면 자신이 컴퓨터에 설치한 개발도구가 Java SE 인지 확인해봐야 한다.

Java EE(Enterprise Edition) 는 Java SE(Standard Edition)에서 웹 어플리케이션 개발을 전문적으로 하기 위해 추가적인 라이브러리가 들어간 JDK이다. 거기에는 JSON 데이터를 다루는 라이브러리도 포함되어있다. 또한, Java EE 는 현재 버젼 7까지 나와있다.

때문에 평소 자바 프로그래밍에 널리 사용되는 평범한 Java SE JDK로 json 데이터를 파싱하기 위해선 외부 라이브러리를 사용하는 수밖에 없다. 유명한 것으로는 Jackson, gson 등이 있다.
