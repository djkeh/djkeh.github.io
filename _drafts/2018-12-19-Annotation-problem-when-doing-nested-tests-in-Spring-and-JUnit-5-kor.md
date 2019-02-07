---
layout: post
categories: articles
title:  "스프링 + JUnit 5 에서 중첩 테스트를 할 때 발생하는 애노테이션 문제"
excerpt: "@Nested 테스트 클래스에서 트랜잭션 설정이 잘 먹지 않는 이유와 해결책"
tags: [java,spring,boot,test,junit,nested,annotation,inherit,inheritance,transaction,transactional,rollback,자바,스프링,부트,테스트,중첩,애노테이션,어노테이션,상속,트랜잭션,롤백]
date: 2018-12-19 17:31:24
last_modified_at: 2018-12-19 17:31:24
sitemap: false
---



## Reference

* [https://jira.spring.io/browse/SPR-15366](https://jira.spring.io/browse/SPR-15366)
* [https://stackoverflow.com/questions/44203244/transaction-roll-back-is-not-working-in-test-case-in-nested-class-of-junit5](https://stackoverflow.com/questions/44203244/transaction-roll-back-is-not-working-in-test-case-in-nested-class-of-junit5)
* [https://stackoverflow.com/questions/53236807/spring-boot-testing-run-script-in-a-nested-test-sql-script-sql/53240875](https://stackoverflow.com/questions/53236807/spring-boot-testing-run-script-in-a-nested-test-sql-script-sql/53240875)
