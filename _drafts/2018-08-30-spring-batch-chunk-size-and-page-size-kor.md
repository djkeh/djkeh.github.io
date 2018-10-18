---
layout: post
categories: articles
title:  "Spring Batch - chunk size vs. page size"
excerpt: "chunk size와 page size의 차이 이해 및 LazyInitializationExcetion 문제 해결"
tags: [java, spring, batch, chunk, page, size, exception, couldnotinitializeproxy, lazyinitializationexception, 자바, 스프링, 배치, 청크, 페이지, 사이즈, 크기, 예외, 오류]
date: 2018-08-30 15:37:46
modified: 2018-08-30 15:37:46
image: 
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

`LazyInitializationExcetion` 문제가 생기면, `chunk size`와 `page size`를 맞출 것

* ref: http://jojoldu.tistory.com/146