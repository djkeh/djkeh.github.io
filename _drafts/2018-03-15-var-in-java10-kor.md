---
layout: post
categories: articles
title:  "Java 10의 새로운 기능 : var"
excerpt: "지역 변수 타입 추론을 가능하게 하는 새로운 방법"
tags: []
date: 2018-03-15 13:48:37
last_modified_at: 2018-03-15 13:48:40
sitemap: false
---

`var` 등장: 지역 변수 타입 추론을 지원하는 새로운 기능

```java
// as-is
CollectionLinq<Tuple<String, CollectionLinq<Tuple<Integer, Group<Integer, Order>>>>> customerOrderGroups =
    from(customerList)
    .select(c -> tuple(
      c.companyName(),
      from(c.orders())
          .groupBy(o -> o.orderDate().year())
          .select(into((year, orders) -> tuple(
              year,
              from(orders)
                  .groupBy(o -> o.orderDate().month())
          )))
  ));

// to-be
var customerOrderGroups =
    from(customerList)
    .select(c -> tuple(
       c.companyName(),
       from(c.orders())
           .groupBy(o -> o.orderDate().year())
           .select(into((year, orders) -> tuple(
               year,
               from(orders)
                   .groupBy(o -> o.orderDate().month())
           )))
   ));

// assigning anonymous type
var person = new Object() {
   String name = "bob";
   int age = 5;
};
```

`var`는 동적 타입이 아니다.

```java
// error
var a = 10;
a = "string";
```

http://benjiweber.co.uk/blog/2018/03/03/representing-the-impractical-and-impossible-with-jdk-10-var/

