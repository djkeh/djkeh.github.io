---
layout: post
categories: articles
title:  "NOT NULL vs. DEFAULT"
excerpt: "기본값이 있는데 뭐하러 NULL 체크를 하나요?"
tags: [db]
date: 2018-04-03 13:08:01
last_modified_at: 2018-04-03 13:08:01
sitemap: false
---

관계형 데이터베이스(RDBMS)의 테이블 스키마(schema)를 설계할 때, 각 레코드에 다양한 세부 옵션(???)을 설정하곤 하는데요, `NOT NULL`과 `DEFAULT`는 정말 많이 사용하는 옵션 중 하나입니다. 그렇다면,

```
DEFAULT 값이 세팅되어 있다면, 특히 DEFAULT NULL이 세팅되어 있다면, NOT NULL은 필요 없을까요?
```

## NOT NULL

`NOT NULL`은 해당 레코드 값으로 `NULL`을 사용할 수 없음을 의미합니다. 이는 첫 데이터 `INSERT`뿐만 아니라 데이터의 `UPDATE`에도 적용됩니다.

## DEFAULT

첫 데이터를 `INSERT`할 때 해당 레코드에 값을 직접 지정하지 않았을 경우, 기본으로 입력될 초기값을 지정합니다. `NULL`, `0`, `NOW()`등을 포함해 다양한 값을 지정해서 `INSERT` 작업에 편의성을 더해줄 수 있습니다.


## DEFAULT 설정 후에도 NOT NULL이 필요한 이유

이런 질문이 떠오른 이유는 아마도 생각 중에 가벼운 실수가 있었거나 `NOT NULL`의 성질을 "(특히 처음 입력할 때) 데이터가 반드시 있어야 한다" 로 이해했기 때문이 아닐까 싶어요. 지극히 보편적인 `INSERT` 시나리오만 떠올렸을 때 둘의 역할이 겹치는 것처럼 보일 때도 있고요. 하지만 다음을 고려해보면 `DEFAULT`와 `NOT NULL`은 서로 완전히 독립적인 키워드


## Reference

- not null vs. default
 - 차이 있다. 둘은 독립적이며, default를 넣어도 `not null`은 여전히 필요하다
 - `not null`은 쿼리 퍼포먼스를 향상시킴
  - 오라클 db의 경우 `null`이 인덱스에 포함되지 않음
 - https://blog.jooq.org/2014/11/11/have-you-ever-wondered-about-the-difference-between-not-null-and-default/
