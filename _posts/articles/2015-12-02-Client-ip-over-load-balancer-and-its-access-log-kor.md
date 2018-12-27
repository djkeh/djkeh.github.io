---
layout: post
categories: articles
title:  "Load Balancer 바깥 클라이언트의 IP 알아내고 Access Log 남기기"
excerpt: "서버, 어플리케이션 레벨에서 X-Forwarded-For 헤더에 접근하는 방법"
tags: [아파치, 톰캣, 스프링, x-forwarded-for, 로그, accesslog, apache, tomcat, httpd, spring, security]
date: 2015-12-02 15:52:10
modified: 2015-12-02 15:52:10
image: 
  feature: 
  credit: 
  creditlink: 
share: true
sitemap: true
---

이번 글은 스프링 프레임워크 및 톰캣 레벨에서 `X-Forwarded-For` 헤더 정보를 이용해 로드밸런서 바깥에서 들어오는 클라이언트의 IP를 알아내고 ACL을 만들어 접근을 통제하는 방법을 다룹니다.


## 1. 기본 아이디어: X-Forwarded-For

서비스에 접근하는 클라이언트를 특정 IP 혹은 IP 범위로 제한하려면 접근하는 클라이언트의 IP를 알아내어 이용할 수 있어야 합니다. 또 이를 로그로 남기는 것도 중요하죠. 기본적으로 서버가 클라이언트의 IP를 알아내고 접근 기록을 로그로 남기는 것은 그리 어렵지 않지만, 클라이언트와 서버 사이에 L4 스위치, 로드밸런서나 프록시 서버가 존재하게 되면 문제가 더 복잡해집니다. 이들은 서버와 클라이언트의 통신을 중개하면서 패킷 헤더에 자신의 IP를 남기게 되기 때문에, 서버측에서 기존의 방법 그대로 request 헤더의 원격 주소를 열어보게 되면 이는 클라이언트가 아닌 L4, 혹은 proxy의 IP이므로 원하는 결과가 아닙니다.

`X-Forwarded-For`는 이 문제를 해결하기 위해 사용하는 http 헤더로 *Squid Caching Server*에서 처음 사용되었다고 알려져 있습니다. 정식 RFC에 포함된 표준 기술은 아니지만 현재 사실상의 표준으로 널리 사용되고 있습니다. 헤더 내용은 다음과 같이 콤마를 구분자(delimiter)로 client IP와 proxy IP로 구성되어 있고, 첫번째 IP를 가져오면 로드밸런서를 넘어오는 원격 클라이언트를 제대로 식별할 수 있습니다.

```
X-Forwarded-For: client, proxy1, proxy2
```

이 헤더는 어플리케이션(스프링 프레임워크, 자바 코드) 레벨, 서버(아파치, 톰캣) 레벨에서 모두 처리할 수 있습니다. 이제 각 레벨에서 `X-Forwarded-For` 헤더를 다루는 방법을 하나씩 살펴보겠습니다.


## 2. 서버(아파치, 톰캣)에서 제어하기

아파치 서버에서 `X-Forwarded-For` 헤더를 읽어 제대로 된 사용자 로그를 남기려면 `/{APACHE_HOME}/conf/httpd.conf` 설정 파일을 열어 다음과 같이 `LogFormat`을 수정합니다.

```
LogFormat "%{X-Forwarded-For}i %l %u %t \"%r\" %>s %b" common
```

이것으로 간단하게 로드밸런서를 넘어 원격 클라이언트의 IP를 제대로 로그에 표시할 수 있습니다. 로그 형식에 사용하는 탈출 문자는 아파치에서 정한 고유의 문법을 따르고 있습니다. 위 로그 포맷을 이해하거나 변경하고자 한다면 [이 문서](http://httpd.apache.org/docs/2.4/mod/mod_log_config.html)를 참조한다. 또한 아파치 레벨에서 ACL까지 만들어 제어할 수 있지만, 그 방법은 여기서는 [관련 참조 문서](https://www.lesstif.com/pages/viewpage.action?pageId=20775886)만 남겨놓고 지나가도록 합니다.

톰캣도 기본 개념은 같습니다. 톰캣 설정 파일은 각 설정을 *'밸브'*라는 단위로 관리하는데, 여기서 클라이언트의 접속 로그는 *'액세스 로그'*라고 불리며 관리되고 있습니다. 톰캣의 기본 액세스 로그는 `/{TOMCAT_HOME}/conf/server.xml` 파일 안에서 다음과 같은 `<Valve>` 코드로 활성화됩니다.

```xml
<Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
    prefix="localhost_access_log" suffix=".txt"
    pattern="%h %l %u %t &quot;%r&quot; %s %b" />
```

여기서 패턴 파라미터를 다음과 같이 바꾸는 것이 기본입니다.

```
pattern="%{X-Forwarded-For}i %l %u %t &quot;%r&quot; %s %b"
```

톰캣의 로그 패턴은 Apache 웹서버에서 사용하는 `LogFormat`과 유사한 형식을 사용합니다. 톰캣의 로그 패턴 레퍼런스는 [이 페이지](https://tomcat.apache.org/tomcat-8.0-doc/config/valve.html)를 참고하면 됩니다.

만약 자바 프로그램에서 ACL을 관리하지 않고 서버에서 ACL을 관리하거나 단순히 로그만 남기고자 한다면 이 설정으로 충분합니다. 그러나 지금 톰캣 서버는 로그 표시만 `X-Forwarded-For` 헤더를 보고 했을 뿐, request 헤더는 원래 상태 그대로 어플리케이션으로 넘겨줬습니다. 때문에 프로그램 속에서 IP 보안 관리를 하고 있다면  `X-Forwarded-For` 헤더를 보도록 소스코드를 바꾸지 않는 한 문제가 여전히 남아있습니다. 만약 서버가 애당초 로드밸런서를 가리키는 중간 IP를 걷어내고 원격 클라이언트 IP를 보내 준다면 프로그램 단에서 ACL 구현을 할 때 좀 더 수월할 것입니다. 기존의 IP를 알아내는 프로그램 로직을 수정하지 않아도 되죠.

톰캣이 이 일을 할 수 있습니다. 로드밸런서의 IP를 벗겨내고 원격 클라이언트의 IP를 헤더에 담아 프로그램에 올려줄 수 있는데, 이를 위해 request 헤더를 `X-Forwarded-For` 헤더로 간주하기 위한 밸브를 별도로 열어줘야 합니다. 같은 `/{TOMCAT_HOME}/conf/server.xml` 설정 파일에 다음과 같은 `<Valve>` 설정을 추가합니다.

```xml
<Valve className="org.apache.catalina.valves.RemoteIpValve" />
```

이렇게 하면 톰캣은 원격 접속자의 IP를 알아내기 위해 기존의 request 헤더 대신 `X-Forwarded-For` 헤더를 참조합니다. 이 밸브 설정에 관한 보다 구체적인 설명은 [이 기술문서(Tomcat 8.0 기준)](https://tomcat.apache.org/tomcat-8.0-doc/api/org/apache/catalina/valves/RemoteIpValve.html)를 참조하세요.

이제 톰캣에서 보내준 `X-Forwarded-For` 헤더를 자바 프로그램이 request 헤더로 받고 곧바로 IP 관리를 할 수 있을 것입니다. 하지만, 이번에는 톰캣에서 다른 문제가 생깁니다. `X-Forwarded-For` 헤더를 보기 위해 `RemoteIpValve`를 열었기 때문에 구조가 달라지면서 IP를 가져올 위치도 달라져 버렸습니다. 때문에 방금 전에 보여드린 액세스 로그 패턴이 제대로 작동하지 않고 `%{X-Forwarded-For}i`가 아무것도 보여주지 않을 것입니다. 이 경우 다음의 패턴을 사용하시면 됩니다.

```
pattern="%{org.apache.catalina.AccessLog.RemoteAddr}r %l %u %t &quot;%r&quot; %s %b"
```

이와 관련된 정보는 [이 웹페이지](https://github.com/cloudfoundry/java-buildpack/issues/75)에서 보실 수 있습니다.


## 3. Spring Security 프레임워크 내에서 제어하기

어플리케이션 안에서 인증과 보안 설정을 관리하면서 IP 관리는 서버에서 한다면, 비슷한 기능의 관리 포인트가 2 곳으로 나뉘므로 유지보수가 번거로워지겠죠. 이번엔 자바 코드에서 `X-Forwarded-For` 헤더를 제어하는 방법을 살펴보겠습니다. `HtttpServletRequest` 객체에서 IP를 가져오기 위해 특정 이름의 헤더를 읽고자 한다면, `getHeader()` 메소드를 사용할 수 있습니다. 따라서 `X-Forwarded-For` 헤더를 읽으려면 이렇게 하시면 됩니다.

```java
String ip = request.getHeader("X-Forwarded-For");
```

앞서 말씀드렸다시피 `X-Forwarded-For` 라는 헤더 이름은 표준이 아닙니다. 때문에 다른 이름을 사용하여 헤더를 패키징하는 프록시 서버나 로드밸런서 제품을 대비할 필요가 있습니다. 예를 들면 이런 식입니다.

```java
String ip = request.getHeader("X-Forwarded-For");
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getHeader("Proxy-Client-IP");
}
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getHeader("WL-Proxy-Client-IP");
}
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getHeader("HTTP_CLIENT_IP");
}
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getHeader("HTTP_X_FORWARDED_FOR");
}
if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
    ip = request.getRemoteAddr();
}
```

한 편, 헤더를 읽어온 결과가 비었음을 조사하기 위해 `ip == null || ip.length() == 0`와 같은 방법이 쓰였지만, Apache에서 배포하여 널리 사용되는 라이브러리들 중 Commons Lang 라이브러리의 `StringUtils` 클래스를 사용하면 이렇게 구현할 수도 있습니다.

```java
String ip = request.getHeader("X-Forwarded-For");
if(StringUtils.isBlank(ip)) {
    ip = request.getRemoteAddr();
}
```

[메이븐 저장소](https://mvnrepository.com/artifact/org.apache.commons/commons-lang3)에도 등록되어 있어서 쉽게 사용이 가능합니다. 관련 문서는 [여기](https://commons.apache.org/proper/commons-lang/)를 참조하세요.

이제 Spring Security 프레임워크를 이용해 ACL을 만들어 접속 IP를 제한하는 방법을 알아보겠습니다. 이를 위해 Spring Security가 어떻게 ACL을 만들어 접근하는 사용자를 가려내는지를 우선 이해할 필요가 있습니다.

코드 레벨에서 Spring Security는 `authorizeRequests()` 메소드를 이용해 접근 사용자 정책을 관리합니다. 기본적인 구현 방식은 다음과 같습니다.

```java
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http.authorizeRequests().antMatchers("/**").access("permitAll");
    }

}
```

* `@Configuration`은 이 클래스가 Spring 설정용 클래스로 간주됨을 의미합니다.
* `@EnableWebSecurity`은 본 클래스가 Spring Security를 사용할 것임을 의미합니다.
* `configure()` 메소드를 오버라이드하여 보안 설정을 직접 작성합니다.
  * `HttpSecurity http`: 이 인자에 웹 기반 보안 설정을 http request에 적용합니다.
    * `authorizeRequests()`: 다음의 요청에 권한 설정을 합니다.
    * `antMatchers(String)`: 'url이 문자열 패턴과 일치하면' 이라는 조건을 답니다. 이 때 패턴은 `Apache Ant` 에서 사용하여 보편화된 문자열 표현식 문법을 사용합니다. "/\*\*" 는 결과적으로 루트부터 전체에 걸친 url 선택을 하게됩니다. authorizeRequests()는 이외에도 url 패턴 표현에 정규표현식을 지원하는 `RegexMatchers(String)`를 제공하고 있습니다.
    * `access(String)`: String 설정값에 따라 접근 권한을 설정합니다. **"permitAll"** 은 모두 허용입니다. 관련 레퍼런스는 [이곳](http://docs.spring.io/spring-security/site/docs/3.2.8.RELEASE/reference/htmlsingle/#el-common-built-in)을 참조하세요.
* 위 예제는 제가 단지 예시로 작성했습니다만 모두 통과시키는 보안 설정이므로 사실상 없는 것과 차이가 없습니다.

이제 위 방법으로 접근 IP를 제어해보겠습니다. 다음과 같이 하면 됩니다.

```java
http.authorizeRequests().antMatchers("/**").access(hasIpAddress("10.24.0.0/16"));
```

이제 IP가 `10.24`로 시작하는 유저들만 서비스에 접근이 가능해졌습니다.

그러나 이대로 사용하면 Spring은 L4의 IP를 볼 것이기 때문에, 여기서 바라볼 유저 IP를 `X-Forwarded-For` 헤더의 클라이언트 IP로 만들어줘야 합니다. 만약 Spring Boot를 통해 웹 어플리케이션을 작성하고 Embedded Tomcat을 사용해 서버를 구성한 경우라면, `application.properties` 파일을 통해 Embedded Server에 설정값을 주입하여 이 문제를 쉽고 자연스럽게 해결할 수 있습니다. 다음의 코드를 스프링 프로젝트의 `application.properties` 파일 안에 삽입합니다.

```
server.tomcat.remote-ip-header=x-forwarded-for
server.tomcat.protocol-header=x-forwarded-proto
server.tomcat.access-log-enabled=true
server.tomcat.access-log-pattern=%{X-Forwarded-For}i (, %h) %l %u %t &quot;%r&quot; %s %b
```

이것은 Apache Tomcat의 `server.xml` 내부에 `<Valve>` 형태로 설정하는 내용을 스프링 부트 프로퍼티를 통해 전달하는 문장입니다. 원격 IP 헤더를 `X-Forwarded-For`로 선택하도록 한 후 액세스 로그를 활성화시키고 로그 패턴을 정의했습니다. 관련 문서는 [여기](http://docs.spring.io/spring-boot/docs/current/reference/html/common-application-properties.html)를 참조하세요.

만약 서버를 스프링 부트가 제공하는 Embedded Tomcat으로 쓰지 않고 직접 시스템에 설치한 Tomcat으로 구성하려는 경우에는 방법이 달라집니다. 더 이상 자바 코드나 프로퍼티를 통해서는 어플리케이션 밖에 있는 외부 서버의 설정을 변경할 수 없습니다. 이 때는 위 2번 `서버에서 제어하기`에서 살펴본 바와 같이 서버의 설정을 직접 수정하셔야 합니다.


## 4. 마무리

여기까지 Spring Security와 Apache Tomcat 설정을 통해 로드밸런서, 프록시 서버를 통해 들어온 클라이언트 IP의 ACL를 관리하고 로그를 남기는 방법을 살펴봤습니다. 로드밸런서를 타고 넘어온 클라이언트의 IP 주소 정보에 `X-Forwarded-For` 헤더를 통해 접근할 수 있다는 점을 알았고, 이를 서버와 어플리케이션(스프링 프레임워크) 레벨에서 구현하는 법을 공부했습니다. 질문이나 더 나은 방법에 관한 제안은 댓글을 통해 언제든 자유롭게 부탁드립니다.

감사합니다.
