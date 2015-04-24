---
layout: post
categories: articles
title:  "기타"
excerpt: "기타"
tags: []
date: 2015-03-17 15:08:17
modified: 2015-03-17 15:08:17
image: 
  feature: filename
  credit: image owner
  creditlink: original link
share: true
sitemap: false
---

 - 여러 properties가 저장되어 있어 하나를 선택할 수 있는 프로젝트에서 properties 를 못 읽는 것 같다!
  => tomcat\bin 폴더에 setenv.bat 만들었나여? -ㅅ-
  => 내용 : set "JAVA_OPTS=%JAVA_OPTS% -Dspring.profiles.active=읽을이름"
  => https://docs.oracle.com/cd/E40518_01/integrator.311/integrator_install/src/cli_ldi_server_config.html
http://blog.woniper.net/231
  => http://docs.spring.io/spring-boot/docs/current/reference/html/boot-features-external-config.html#boot-features-external-config-profile-specific-properties
  => http://blog.woniper.net/231

 - github 안에 있는 플젝이 분명 이클립스 플젝인데 이클립스 import > general > existing projects.. 안돼요
  => .projects 만들어줘야 하는데 이걸 만들어주는 플러그인이 별도로 있거나 방법이 있다. 이 쪽으로 검색
  => Spring STS에서 만든 maven 빌드의 플젝인가여? 그럼 메뉴가 틀림. import > maven > existing maven projects

 - spring STS 는 gradle 관련 플러그인이 이미 설치되어 있을텐데 gradle 플젝을 못 읽어요
  => gradle 이 설치되어 있을 것
  => build.gradle 파일 안에 apply plugin: 'eclipse' 구문이 있는지 확인할 것
  => 윈도우즈 cmd -> 해당 플젝 루트 폴더에서 gradle eclipse -> .projects 생성됨
  => import > general > existing projects 로 로드

 - spring 으로 REST api 를 설계하고 싶어요
  => http://spring.io/guides/gs/rest-service/
  => 여기서 배울 수 있는 것:
   ==> @RestController vs. @Controller
   ==> Application.java 의 존재
   ==> @SpringBootApplication = @Configuration + @EnableAutoConfiguration + @EnableWebMvc + @ComponentScan
   ==> 스프링 빈을 @Bean 으로 Application.java 소스 파일 안에서 정의하는 법
   ==> 컨트롤러가 뷰가 아니라 json 객체를 그대로 반환하여 표시한다는 사실

 - *.properties 파일은 어떻게 쓰는건가
  => gradle project의 경우 resource 폴더 안에 관리
  => 그래들, 메이븐 등의 빌드 도구가 자동으로 연결 관리해주거나 사용자가 xml 문서 등으로 지정
  => gradle 편하다. 아무 설정 없이 폴더 안에 지정된 이름으로 넣어놓는 것으로 알아서 됨.
  => 톰캣이 정해놓은 기본 이름 : application.properties
  => 여러 프로퍼티를 만들고 톰캣이 지정하게 함으로써 알파 서버, 베타 서버, 리얼 서버 등 여러 서버에 올리고 바꿔가며 개발 가능
  => 스프링 프로젝트에서 그 값을 @Value 어노테이션으로 가져와 사용한다. ( ex: @Value("${propertie_text}") private String text; )

 - url 이 변할 수도 있나요? 변할 이름을 변수로도 활용할 수 있나요?
  => @RequestMapping("http://test.com/url/url2/url3.html"): 일반적인 고정 url 스프링 어노테이션
  => @RequestMapping("http://test.com/url/{variable}/url3.html"): url 에 변수를 집어넣은 형태.
  => 이 때 해당 컨트롤러 메소드 파라미터에 @PathVariable 이 정의되어야 한다: @PathVariable String variable
  => url 에 정규표현식(regex) 적용 가능: {variable:regex} (ex: {symbolicName:[a-z-]+})

 - cmd 너무 불편해요! 창 크기, 버퍼 사이즈, 줄 길이, 실행할 때 위치..
  => cmd 제목표시줄 우클릭 -> 속성 에서 모두 조절할 수 있지만, 매번 한다는 건 피곤
  => 그러나 레지스트리에 변경 내용이 사실 기록되어있다 -> [HKEY_CURRENT_USER\Console\{실행파일이름}]
  => 보통은 cmd 커맨드로 명령 프롬프트를 실행하므로 이름은 "%SystemRoot%_system32_cmd.exe" 가 된다
  => 따라서 다른 곳에서 다른 방법으로 연 cmd 에는 이 저장 내용이 반영되지 않는다.
  => 방법은 lnk 파일을 만들어 그것을 실행하는 것. lnk로 실행할 때의 cmd 설정이 레지스트리에 남는다.
  => lnk를 용도에 따라 만들고 모두 설정을 잡은 후, batch로 모아서 실행시키면 편리

 - 스프링으로 주기적인 반복 작업(스케쥴링)이 가능한가요?
  => 예 가능합니다
  => @EnableScheduling
  => @Scheduled
  => http://spring.io/guides/gs/scheduling-tasks/#scratch
  => http://docs.spring.io/spring-framework/docs/3.2.0.M1/api/org/springframework/scheduling/annotation/Scheduled.html#fixedRate()

 - toast cloud wdi, centOS 6.5 에 git 최신 버전 깔기
  => 우선 curl 깔기: https git repo 접근이 가능해짐 (yum install curl-devel)
  => https://www.digitalocean.com/community/tutorials/how-to-install-git-on-a-centos-6-4-vps

 - tmux, centos 6.5 에서 1.6 이하 버젼 말고 최신으로 깔기 (2.0)
  => git 최신 깔기
  => ncurses 모듈 깔기 (libncurses, ncurses, ncurses-devel 등 관련 몽땅)
  => https://github.com/libevent/libevent : libevent 최신 깃 클론 하고 깔기
  => http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/ : tmux 최신 깃 클론 하고 깔기
  => cannot open shared object file -> http://www.nigeldunn.com/2011/12/11/libevent-2-0-so-5-cannot-open-shared-object-file-no-such-file-or-directory/ (ln -s /usr/local/lib/libevent-2.0.so.5 /usr/lib64/libevent-2.0.so.5)
  => screen 보다 좋은 이유: vertical split ㅋㅋ
  => 최신 버젼의 이점: zoom mode (1.8 이상)

 - classpath 알아내는 법
  => http://www.mkyong.com/java/how-to-print-out-the-current-project-classpath/

 - popup 에 iframe 을 넣으려는데 막힐 때?
  => http://stackoverflow.com/questions/28647136/how-to-disable-x-frame-options-response-header-in-spring-security
 
 - 현재 url을 알아내는법, 자바스크립트
  => http://stackoverflow.com/questions/1034621/get-current-url-in-web-browser
  => window.location.href: 풀네임
  => window.location.origin: http://호스트 까지만
  => window.location.host: 호스트 이름만

 - AtomicLong 은 ==도, equals()도 뜻대로 안 동작한다. 왜일까.

 - 오버 엔지니어링: 엔지니어링은 투자, 적정한 비용을 들여 투자하는 계획을 산정하고 업무하는 것이 개발자의 역량
  => http://minslovey.tistory.com/117

 - linux : kill, pkill, killall
  => http://blog.naver.com/khc00013/220257187281

 - heredoc?
  => http://blog.naver.com/questzz/220191312933
  => php 에서도 사용한다. heredoc, nowdoc

 - linux 문자열 split을 하는 방법
  => http://stackoverflow.com/questions/918886/how-do-i-split-a-string-on-a-delimiter-in-bash
   ==> tr 명령어로 실행하는 법이 있는데 이해하기는 쉬운 편
   ==> IFS 를 잠시 변조해서 알아서 ';' 를 delimiter로 사용하게끔 하여 split 하는 방식이 더 우아해 보인다.
  => IFS: Internal field separator. 대부분의 Unix 셸(CLI) 프로그램에서 지원. bash 도 지원(man bash 참조). 셸 변수 항목에서 보여주고 있다. 즉 셸 기본 매개변수. ${IFS}로 사용 가능. 기본값은 대부분 tab, space, newline.
   ==> http://en.wikipedia.org/wiki/Internal_field_separator
