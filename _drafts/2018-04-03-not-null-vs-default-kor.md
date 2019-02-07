---
layout: post
categories: articles
title:  "NOT NULL vs. DEFAULT"
excerpt: "기본값이 있는데 뭐하러 NULL 체크를 하나요?"
tags: [db, database, mysql, oracle, constraint, null, default, index, ddl, dml, schema, 디비, 데이터베이스, 오라클, 제약, 초기화, 스키마]
date: 2018-04-03 13:08:01
last_modified_at: 2018-04-03 13:08:04
sitemap: false
---

- not null vs. default
 - 차이 있다. 둘은 독립적이며, default를 넣어도 `not null`은 여전히 필요하다
 - `not null`은 쿼리 퍼포먼스를 향상시킴
  - 오라클 db의 경우 `null`이 인덱스에 포함되지 않음
 - https://blog.jooq.org/2014/11/11/have-you-ever-wondered-about-the-difference-between-not-null-and-default/
