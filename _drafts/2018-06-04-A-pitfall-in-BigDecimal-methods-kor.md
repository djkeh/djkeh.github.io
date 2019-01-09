---
layout: post
categories: articles
title:  "눈치채기 어려운 BigDecimal.multiply() 의 위험"
excerpt: "곱셈 후 반올림을 하려고 할 때 주의사항"
tags: [java]
date: 2018-06-04 15:27:09
modified: 2018-06-04 15:27:12
image: 
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

`multiply(BigDecimal multiplicand, MathContext(int scale, RoundingMode roundingMode))`을 사용할 때 `scale = 0`는 `Bigdecimal.divide()`에 등장하는 `scale = 0`와 다르게 동작한다.

* divide -> 소수점 표현이 0자리 -> 소수점 첫째에서 반올림 -> 정수
* multiply -> 소수점 제한이 없음 -> 반올림 하지 않음 -> 소수
* javadoc 참고
* 해결방안
  * 정수 결과를 만들고 싶을 때 `multiply(Bigdecimal, MathContext(0, RoundingMode)`를 쓰지 말 것
  * `multiply().setScale(0, RoundingMode)`가 대안이 될 수 있음
