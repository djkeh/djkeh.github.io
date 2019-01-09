---
layout: post
categories: articles
title:  "스프링 부트의 복잡한 디펜던시를 보여주는 예"
excerpt: "부트의 디펜던시를 담백하게 사용하기 어려운 이유"
tags: [java,spring,boot,dependency,gradle]
date: 2018-12-08 03:52:08
modified: 2018-12-08 03:52:08
image: 
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

스프링 부트 프로젝트에 다양한 서드 파티 프로젝트 디펜던시를 추가하는 것은 편리하지만, 담백하지 않기도 합니다. 여기서 담백하지 않다는 말씀의 의미는, 여러가지 디펜던시를 추가하다 보면 중복된 디펜던시 설정이 들어가는 것을 의미합니다. 이는 한가지 부트 디펜던시 패키지가 스스로 필요한 추가 디펜던시들을 내부적으로 별도의 `pom.xml`로 가지고 있기 때문입니다. IDE에서 제공하는 스프링 부트 스타터 템플릿을 통해 스프링 부트 프로젝트를 구성하더라도 이와 관련해 별다른 안내를 해주지는 않기 때문에, 완전히 담백한 디펜던시 구성을 하기가 어려운 것은 마찬가지입니다.

이러한 디펜던시 충돌은 프로젝트를 구성하고 작동시키는데는 문제를 일으키지 않습니다. 이것을 스프링 부트의 장점이나 미학으로 볼 수도 있겠죠. 다만 부트 패키지의 특정 서브 패키지 버젼을 올리거나 일부 기능을 수동으로 바꾸는 등, 커스터마이징 하고자 할때는 이 거미줄같이 얽힌 디펜던시 트리로 고생을 할 수도 있습니다.

예를 들어 다음과 같은 시나리오를 함께 생각해 보겠습니다. 이 프로젝트의 목적은 다음의 기술 스택을 각각 부연 설명한 목적에 따라 부트 프로젝트에 추가하는 것입니다.

```
- Spring Security: 로그인 기능을 추가하려고 합니다.
- Spring Web MVC: 스프링 웹 애플리케이션을 구성하려고 합니다.
- Speing Data JPA: JPA 기능을 사용하려고 합니다.
- Spring Data REST: 도메인 모델로부터 REST API를 자동으로 만들려고 합니다.
- Spring HATEOAS: 제공하려는 REST API에 HATEOAS 기능을 추가하려고 합니다.
- Spring Data REST HAL Browser: Data REST로 작성한 API를 간단한 웹 서비스로 확인하려고 합니다.
- Spring Boot Starter Logging: 로깅을 하는데 부트의 지원을 받고자 합니다.
```

위 기능을 그래들 디펜던시로 표현한다면 어떨까요? 아마도 아래와 같을 것입니다.

```gradle
dependencies {
    implementation('org.springframework.boot:spring-boot-starter-security')
    implementation('org.springframework.boot:spring-boot-starter-web')
    implementation('org.springframework.boot:spring-boot-starter-data-jpa')
    implementation('org.springframework.boot:spring-boot-starter-data-rest')
    implementation("org.springframework.boot:spring-boot-starter-hateoas")
    implementation('org.springframework.data:spring-data-rest-hal-browser')
    implementation("org.springframework.boot:spring-boot-starter-logging")
}
```

하지만 실제로 필요한 것만 작성하면 아래와 같이 됩니다.

```gradle
dependencies {
    implementation('org.springframework.boot:spring-boot-starter-security')
    implementation('org.springframework.boot:spring-boot-starter-data-jpa')
    implementation('org.springframework.boot:spring-boot-starter-data-rest')
    implementation('org.springframework.data:spring-data-rest-hal-browser')
}
```

* `spring-boot-starter-security`가 다음을 포함합니다:
  * `spring-boot-starter-logging`
  * `spring-web`
* `spring-boot-starter-data-jpa`가 다음을 포함합니다:
  * `spring-boot-starter-logging`
  * `spring-web`
  * `spring-data-commons`. 이는 또 다음을 포함합니다:
    * `spring-web`
    * `spring-webmvc`
    * `spring-hateoas`
* `spring-boot-starter-data-rest`가 다음을 포함합니다:
  * `spring-data-commons`
  * `spring-hateoas`
  * `spring-boot-starter-web`. 이는 또 다음을 포함합니다:
    * `spring-boot-starter-logging`
* `spring-data-rest-hal-browser`가 다음을 포함합니다:
  * `spring-data-rest-webmvc`. 이는 또 다음을 포함합니다:
    * `spring-data-rest-core`
    * `spring-webmvc`


### Reference

* [https://docs.spring.io/spring-boot/docs/current/reference/html/howto-logging.html](https://docs.spring.io/spring-boot/docs/current/reference/html/howto-logging.html)
