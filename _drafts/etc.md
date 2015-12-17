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

 - 이클립스(STS)-메이븐 쓰는데 .gitignore 에 "/target/" 이 자꾸 중복 추가된다.
  => properties -> git -> projects -> "Automaticaly ignore derived resouces by adding them to .gitignore" 체크 해제
  => http://stackoverflow.com/questions/19816918/eclipse-or-maven-add-target-to-gitignore

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

 - 스프링 시큐리티 관련 글
  => http://netframework.tistory.com/406

 - toast cloud wdi, centOS 6.5 에 git 최신 버전 깔기
  => 우선 curl 깔기: https git repo 접근이 가능해짐 (yum install curl-devel)
  => https://www.digitalocean.com/community/tutorials/how-to-install-git-on-a-centos-6-4-vps

 - 최신 git 설치
  => http, https 리포지토리 받아올 수 있게 curl-devel 라이브러리 설치
   sudo yum install curl-devel
   sudo tum reinstall git
  => git - 최신버젼 깔기
   sudo yum groupinstall "Development Tools"
   sudo yum install zlib-devel perl-ExtUtils-MakeMaker asciidoc xmlto openssl-devel
   cd ~
   git clone git://github.com/git/git
   cd git
   make configure
   ./configure --prefix=/usr/local
   make all doc
   sudo make install install-doc install-html
   git --version # 버젼 확인
   cd ~
   vi .bashrc
    ---------------
    PATH=$PATH:/usr/local/bin
    export PATH
    ---------------
   . .bashrc # (혹은 로그아웃 후 재접속)
   sudo yum remove git 
   # Optional.
   git config --global user.name "Your Name Here"
   git config --global user.email "your_email@example.com"
   git config --list

 - git flow 설치
  => git clone --recursive git://github.com/nvie/gitflow.git
  => cd gitflow
  => sudo make install
  => git flow version # 테스트
  => https://github.com/nvie/gitflow/wiki/Manual-installation
  => https://github.com/nvie/gitflow

 - tmux, centos 6.5 에서 1.6 이하 버젼 말고 최신으로 깔기 (2.0)
  => git 최신 깔기
  => ncurses 모듈 깔기 (libncurses, ncurses, ncurses-devel 등 관련 몽땅)
  => https://github.com/libevent/libevent : libevent 최신 깃 클론 하고 깔기 (클론 링크: https://github.com/libevent/libevent.git)
  => http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/ : tmux 최신 깃 클론 하고 깔기 (https://github.com/tmux/tmux, 클론 링크: https://github.com/tmux/tmux.git)
  => cannot open shared object file -> http://www.nigeldunn.com/2011/12/11/libevent-2-0-so-5-cannot-open-shared-object-file-no-such-file-or-directory/ (ln -s /usr/local/lib/libevent-2.1.so.5 /usr/lib64/libevent-2.1.so.5)
  => 버젼 확인으로 설치 확인: tmux -V
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

 - openjdk 여러 개 깔렸을 때 버젼 선택법
  => 일단 yum 으로 설치(sudo yum install java-1.8.0-openjdk-devel)
  => 하지만, 여전히 기존의 java 1.7 binary가 사용됨
  => 이를 수정하기 위해서는 다음 명령을 실행하고 각각 1.8을 선택하도록 함
    $ sudo alternatives --config java
    $ sudo alternatives --config javac

 - spring loaded
  => spring boot는 이미 구동된 was에 패키지를 deploy(반영)해서 구동하는 방식과 달리 어플리케이션 자체에 was를 내장하고 구동하는 방식
  => 때문에 수정된 내용을 반영하려면 jvm을 재기동할 필요가 있음
  => spring loaded는 jvm을 재기동하지 않고 개발을 진해하여 개발 생산성을 높여주려는 프로젝트 -> 따라서 수정 소스코드를 저장하면 즉시 반영됨
  => 기반기술은 java 1.4 에 들어간 Java Platform Debugger Architecture (JPDA), "hot swap" 이라고 불리는 기술
  => http://reiphiel.tistory.com/89
  => https://github.com/spring-projects/spring-loaded

 - spring sts + spring boot + gradle 로 mvc 패턴 적용한 기본 웹 어플리케이션 프로젝트 구성하기
  i) gradle support 설치
   => sts dashboard(만약 꺼서 못 찾겠다면 우상단 quick access에 검색 가능) -> 우측 manage, ide extensions 클릭 -> gradle 검색 -> 설치
   => 이제 gradle 기반 프로젝트 생성 가능
  ii) spring starter project
   => 새로운 프로젝트를 spring starter project로 만들기: gradle 선택, 필요 정보 이것저것 입력, 원하는 디펜던시 선택 후 완료
  
  => http://firstboos.tistory.com/280

 - C++ call by value, reference, pointer
  => http://blog.naver.com/ya3344/220200702511

 - cubrid jdbc
  => https://clojars.org/org.clojars.cubrid/cubrid-jdbc
  => http://www.cubrid.org/manual/93/ko/api/jdbc.html

 - git 협업을 위해 이클립스 들여쓰기(indent)를 스페이스로 바꾸고 적응하기
  => 스위치 하나로 다 바꿀 수는 없고 언어마다, 환경마다 세팅이 다 들어가줘야 함
  => 기본적인 설정공간은 preferences
  => java: preferences > java > code style > formatter > active profile 새로 생성하여 편집 > indentation > tab policy -> spaces only, 들여쓰기 크기 탭 크기 모두 4개
  => 인덴트는 하던 대로 tab 누르면 되고, 내어쓰기는 백스페이스로 지우면 스페이스 하나만 지워져서 불편하지만, shift+tab 누르면 인덴트 하날르 지우므로 편리
  => 웹 : preferences > Web > HTML files > Editor (JSP도 커버됨) > indent using spaces 클릭
  => XML : preferences > XML > XML files > Editor (JSPX, Facelet 커버됨) > indent using spaces 클릭
  => CSS : preferences > Web > CSS files > Editor > indent using spaces 클릭
  => 현재 소스코드 인덴트가 뭐로 되어있는지 보려면 공백문자를 특수기호로 보이게 해야 하는데 이 옵션은: preference > general > appearance > editors > text editors > show whitespace characters 체크. 공백문자 지정에 대한 세부 설정도 가능.

 - 엑셀;;
  => 벤치마킹 업무 했을 때 본 averageifs() 내용은 정리하는 편이 좋겠다
  => https://support.office.com/en-us/article/AVERAGEIFS-function-48910c45-1fc0-4389-a028-f7c5c3001690
 
 - 자바 예외
  => http://hyeonstorage.tistory.com/199
  => 예외: 문법오류(컴파일에러), 실행오류(런타임에러)
  => java throw 로 발생시킬 수 있는 3가지 예외: error, exception(체크 예외), RuntimeException(언체크 예외)
   error: Error 클래스의 서브클래스들. 시스템 비정상 상황. VM에서 주로 발생. 코드로 잡으면 안된다
   체크 예외: Exception 서브 클래스이면서 RuntimeException을 상속받지 않는 것들. -> 반드시 예외 처리 코드를 짠다
   언체크 예외: RuntimeException 상속하는 예외들. 명시적 예외처리 강제를 하지 않는다. 런타임 예외라고도 부름. 피할 수 있고, 개발자가 부주의할 경우 발생하도록 만든 것.

 - 자바 직렬화
  => eclipse IDE로 직렬화 UID 쉽게 생성하는 법: http://www.mkyong.com/java/how-to-generate-serialversionuid/
  => 개념: http://blog.naver.com/crazybnn/30097166235
  => 직렬화 객체의 UID 작성 기본 알고리즘: http://logonjava.blogspot.kr/2006/05/serialversionuid.html
  => 자바 메모리는 heap, stack, class 영역으로 구성
  => 직렬화란: heap 영역에 저장된 객체를 class 영역의 method 구현부로 가져와 출력 가능한 바이트 스트림으로 만들기 위한 방법
  => 역직렬화: 딱 반대.
  => 직렬화를 위해 대상 클래스는 Serializable 인터페이스를 구현해야 한다
  => 문제: private static final long serialVersionUID를 만들지 않으면 warning이 뜸
  => 해결1: supressWarning("serial") -> 권장하지 않음
  => 해결2: private static final long serialVersionUID = 1L -> 기본값만 주는 것데 역시 찝찝
  => 해결3: 제대로 설정하기 -> 워닝 부분에서 ctrl+1 로 해결책을 선택하는데 자바 컴파일러로 생성하기를 눌러 만들 수 있다.
  => 추가: JSON과 XML 직렬화 역직렬화 성능은 JSON이 보통 빠르다. Microsoft C#만 예외적으로 XML parsing 성능이 높아 JSON보다 빠르다. http://blog.naver.com/angelkum/130154155881

 - 자바 테크닉: static member class
  => 외곽 클래스의 인스턴스를 사용할 필요가 없는 멤버 클래스를 선언한다면, 항상 static 멤버 클래스로 만들자.
   -> Why?) static을 생략시 각 인스턴스가 외곽 클래스의 인스턴스 참조를 갖게 되며 이러한 참조 저장은 시간과 메모리가 소요 되며, 가비지 컬렉션 대상이 될 외곽 클래스의 인스턴스가 메모리에 계속 남아 있게 된다.
  => http://rego.tistory.com/46

 - 자바 테크닉: 맵 공부, 자바 맵 종류간 비교
  => HashMap: Entry<K, V> 객체의 array 저장. 해싱은 String의 경우 sun.misc.Hashing.stringHash32 함수, 일반 Object는 내부 hashcode 함수 + 비트연산. hash 값에 따라 키순서가 정해지므로 특정 규칙 없이 출력
  => TreeMap: RedBlack Tree로 저장. 키값에 대한 Compartor 구현으로 정렬 순서 변경 가능. 기본은 키값 알파벳 순서 정렬
  => LinkedHashMap: 링크드 리스트 저장. 입력 순으로 출력
  => 특별한 이유가 없다면 검색 성능이 좋은(O(1)) HashMap을 사용
  => 키값이 일정한 수준대로 iterate 하려고 한다면 TreeMap 을 사용 (랜덤 접근 성능: O(logn))
  => 입력 순서가 의미있다면 LinkedHashMap 을 사용 (랜덤 접근 성능: O(n))
  => 비교: http://rangken.github.io/blog/2015/java.map/
  => 기본 공부: http://levin01.tistory.com/233

 - 자바 테크닉: Scanner vs. StringTokenizer vs. String.Split
  => 속도가 빠르게: StringTokenizer
  => 정규식 표현, 더 직관적이고 보기 좋은 코드: split
  => http://stackoverflow.com/questions/691184/scanner-vs-stringtokenizer-vs-string-split

 - 자바 파일 입출력
  => 사용 클래스의 진화(입력의 예): File -> FileReader -> FileInputStream -> DataInputStream -> BufferedInputStream -> BufferedReader
  => http://blog.naver.com/highkrs/220513596942

 - 그래들(gradle)
  => 메이븐과 같은 빌드 도구. xml이 난무하지 않아서 더 좋은 듯.
  => http://kwonnam.pe.kr/wiki/gradle

 - linux screen
  => tmux 못 깔 때 대안
  => 모든 단축키는 ctrl+a 로 시작이 기본 (cf: tmux는 ctrl+b, 물론 변경 가능)
  => screen -S "sessionName": sessionName 세션 생성
  => screen -r (번호.sessionName): 이미 만들어진 세션에 재접속. detached 세션이 하나 뿐이면 자동으로, 2개 이상이면 열고 싶은 세션을 지정해줘야 한다.
  => screen -list: 현재 있는 세션들 목록 출력. 번호.sessionName 을 알 수 있다.
  => ctrl+d: screen 종료
  => ctrl+a, d: 세션 detach
  => ctrl+a, c: 새 윈도우 생성
  => ctrl+a, n: 윈도우 변경
  => ctrl+a, 0~9: 번호로 윈도우 이동
  => ctrl+a, S: 화면 수평 분할. tmux와 달리 분할 화면은 아무것도 없으므로 새 세션을 별도로 생성해 줘야 한다. ctrl+a, c. 이걸 눌러 세션을 만든 뒤 이제 비로소 사용 가능.
  => ctrl+a, |: 화면 수직 분할. 버젼에 따라 지원하지 않는다. (4.00.03 은 안 되는 듯)
  => ctrl+a, Q: 화면 분할 다시 합치기
  => ctrl+a, tab: 분할된 화면 이동
  => ctrl+a, A: 윈도우 이름 변경
  => ctrl+a, :: screen 콘솔입력. 여러 세부 옵션을 명령어로 실행할 수 있다.
   -> source /경로/.screenrc: screenrc를 스크린 끄지 않고 리로드.
  => tmux와 달리 세션, 윈도우, 패널 개념이 아니라 세션, 윈도우까지만 있음. 분할된 윈도우는 서로 다른 윈도우. 윈도우 이동을 누르면 같은 화면 안에서 이동이 이뤄진다. 즉 두 분할된 화면이 같은 윈도우 번호를 보고 있는 것도 가능. 이건 해보는 편이 빠른듯.
  => ctrl+a, ": 윈도우 리스트 표시. 리스트에서 윈도우 선택하여 이동
  => https://www.rackaid.com/blog/linux-screen-tutorial-and-how-to/
  => http://unix.stackexchange.com/questions/7453/how-to-split-the-terminal-into-more-than-one-view
  => ~/.screenrc: 설정파일. ~/.tmux.conf 와 같은 원리.
  => 쓸만한 기본 screenrc: https://gist.github.com/ChrisWills/1337178 -> 24번 줄 메일 기능을 주석처리하는게 좋다

 - linux: jar 파일 읽기
  => jar tf filename.jar
  => http://stackoverflow.com/questions/320510/viewing-contents-of-a-jar-file
