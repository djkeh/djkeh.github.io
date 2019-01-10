---
layout: post
categories: articles
title:  "Hibernate 공식 문서로 살펴보는 로그 종류"
excerpt: "JPA 쿼리 로깅을 위해 꼭 필요한 정보"
tags: [java,jpa,hibernate,db]
date: 2019-01-08 13:44:16
modified: 2019-01-08 13:44:16
image: 
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

JPA 프레임워크인 Hibernate는 자바 생태계에서 널리 사용 중인 JPA 구현체입니다. 이를 사용해 웹서비스를 개발하고 있을 땐 데이터에 접근하는 과정을 로그로 보고 싶은 요구사항이 있지요. 오늘은 이 내용을 한 곳에 모아 정리합니다.

## 스프링 프레임워크에서 로깅을 설정하는 법

### xml

### java config

### Spring Boot properties


## Hibernate가 제공하는 로그 형태

하이버네이트가 출력하는 모든 정보를 로깅하고 싶다면, 다음 패키지를 로거(logger)로 등록합니다.

```
org.hibernate
```

굉장히 많은 정보가 쏟아져 나오기 때문에 운영단계에서는 사용하지 않습니다. 하지만 원인을 알 수 없는 문제를 찾아야 할 때는 생각해볼 수 있습니다. 상황에 맞는 데이터를 뽑고자 한다면 아래 패키지 정보를 확인하세요.

### 즐겨 살펴볼 로그

* `org.hibernate.SQL`: SQL DML 문장들
* `org.hibernate.type`: 모든 JDBC 파라미터들 (sql 문장에 넣은 변수, prepared statement의 parameter를 말합니다.)

### 필요할 때가 있을 것 같은 로그

* `org.hibernate.tool.hbm2ddl`: SQL DDL 문장들
* `org.hibernate.pretty`: flush 시점에서 세션과 연관된 모든 엔티티들(최대 20개)의 상태
* `org.hibernate.transaction`	트랜잭션 관련 액티비티

### 기타 전체 로그

* `org.hibernate.cache`	모든 second-level 캐시 액티비티
* `org.hibernate.jdbc`	모든 JDBC 리소스 취득
* `org.hibernate.hql.ast.AST`	질의 파싱 동안에 HQL AST와 SQL AST
* `org.hibernate.secure`	모든 JAAS 허가 요청들


## Reference

* [https://docs.jboss.org/hibernate/orm/3.3/reference/ko-KR/html/session-configuration.html#configuration-logging](https://docs.jboss.org/hibernate/orm/3.3/reference/ko-KR/html/session-configuration.html#configuration-logging)
* [http://www.mkyong.com/hibernate/how-to-display-hibernate-sql-parameter-values-log4j/](http://www.mkyong.com/hibernate/how-to-display-hibernate-sql-parameter-values-log4j/)
* [https://www.mkyong.com/hibernate/hibernate-display-generated-sql-to-console-show_sql-format_sql-and-use_sql_comments/](https://www.mkyong.com/hibernate/hibernate-display-generated-sql-to-console-show_sql-format_sql-and-use_sql_comments/)
* [https://jistol.github.io/java/2017/07/12/springboot-hibernate-sql-options/](https://jistol.github.io/java/2017/07/12/springboot-hibernate-sql-options/)
