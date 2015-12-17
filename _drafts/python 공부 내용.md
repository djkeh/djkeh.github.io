0. 기본적인 레퍼런스(ver. 2.x)
 - https://docs.python.org/2/tutorial

1. 기본 문법
 - 일단 기본 사용법: https://docs.python.org/2/tutorial/introduction.html
 - len(a) : 스트링 a의 길이 리턴
 - chr(n), ord(c) : n으로 지정한 문자를 리턴하거나, 문자 c의 코드값을 리턴한다.
 - a in b : 스트링 a가 스트링 b에 있으면 True 아니면 False를 리턴한다
 - a[i] : 스트링 a의 i 위치에 있는 문자를 리턴한다. 위치는 0이 맨 앞 문자를 의미한다. i가 음수면 뒤 부터 거꾸로 위치를 지정하는데 맨뒤의 문자 위치는 -1이고 그 앞의 문자는 -2로 지정하는 방식이다. 주의할 것은 a[1]='a'처럼 개별 요소가 치환에 사용될 수는 없다. 이런 경우 잘라 붙이기로 새로운 스트링을 만들어야 한다.
 - a[i:j:k] : 스트링 a의 i 위치 부터 j위치까지(j위치는 포함되지 않는다. 직전 위치의 문자까지만) k만큼씩 움직이며 문자를 추출한다. k가 음수면 역방향 진행을 의미한다. i를 생략하면 맨앞이란 의미이고, j를 생략하면 i의 반대편 맨끝을 의미하고 k를 생략하면 1을 의미한다.
 - 배열 길이 구하기: len(array)
  => http://stackoverflow.com/questions/518021/getting-the-length-of-an-array-in-python
 - integer <-> string: str(10), int('10')
  => http://stackoverflow.com/questions/961632/converting-integer-to-string-in-python
 - None: 파이썬의 Null.
  => 파이썬에서 모든 함수는 리턴하는데 심지어 return 구문을 쓰지 않아도 리턴한다. 그 값이 None.
  => None을 써도 파이썬 인터프리터는 출력을 보통 억제하는데, 강제로 보려면 'print' 명령어를 사용할 수 있다.
  => https://docs.python.org/2/tutorial/controlflow.html
 - pass: 파이썬의 null 동작. 이걸 실행해도 아무 일이 일어나지 않는다. 일단 존재해야 하는 코드이지만 당장 할 일이 없거나, 아직 구현되지 않은 부분, 수도 코드, stub 코드 등등에 사용.
  => http://www.tutorialspoint.com/python/python_pass_statement.htm
 - is vs. ==
  => is: 두 객체가 같은 것을 가리키나? ex: a = [1, 2, 3]; b = a; a is b -> True; b = a[:]; a is b -> False
  => ==: 두 객체가 가리키는 변수 값이 같나? ex: 위 두 경우 모두 a == b  -> True
  => http://stackoverflow.com/questions/132988/is-there-a-difference-between-and-is-in-python
 - print without newine
  => 공통: import sys; sys.stdout.write('.')
  => python 2: print('.'), # 희한한 문법이지만 통한다. 단 끝에 스페이스바 하나 추가
  => python 3: print('.', end="")
  => python 3, buffer trouble: print('.', end="", flush=True)
  => http://stackoverflow.com/questions/493386/how-to-print-in-python-without-newline-or-space
 - isinstance(string, unicode): string이 유니코드인지 검사하는 함수. 기본 제공인 듯.
  => http://stackoverflow.com/questions/5259135/check-for-valid-utf8-string-in-python
 - stderr
  => sys.stderr.write("string")
 - 삼항연산자
  => var = condition and True or False
  => var = True if condition else False (2.5 버젼 이상)

2. 문자열 함수
 - a.translate(None, ".#?/:") -> (결과 문자, 대상 문자). 문자열 내 문자 치환. 소스는 바이트 문자열만 해당. 여러 문자는 그냥 쭉 나열하여 적음
 - a.replace(".#?/:", "") -> (대상 문자, 결과 문자). 문자열 내 문자 치환. 유니코드용. 문자열 치환도 가능.
 - a.split(delimiter, number) -> delimiter로 스트링을 쪼개어 list 반환한다. number는 쪼개는 횟수. 생략하면 모두 쪼개며, 기본 delimiter는 공백문자.
 - a.partition('sep') -> 스트링을 sep기준으로 나누어 (sep 이전 스트링, sep, sep 이후 스트링)의 리스트를 리턴한다.
 - a.splitlines() -> 줄단위로 나눈 리스트를 리턴한다. 기본적으로는 라인 구분을 제거하는데 splitlines(True)로 지정하면 남긴다.
 - a.strip() -> 스트링 a의 양쪽에 있는 공백, 탭, 개행등의 White space를 제거한다. lstrip() 좌측 공백제거, rstrip() 우측 제거
 - a.center(w) -> w 길이로 a를 가운데 맞추고 양쪽에 공백으로 채운다. ljust(w), rjust(w) w길이로 a를 좌/우로 맞추고 나머지는 공백으로 채운다
 - a.upper() -> 대문자로 전환
 - a.lower() -> 소문자로 전환
 - a.title() -> 각 단어의 첫자만 대문자로하고 나머지는 소문자로 변환
 - a.isalnum(), a.isalpha(), a.isdigit(), a.islower(), a.isspace(), a.isupper() -> 스트링의 구성 검사. 맞으면 True 리턴
 - a.startswith(), a.endswith() -> 스트링이 지정한 스트링으로 시작하거나 끝나면 True 리턴
 - a.find(sub), a.index(sub) -> 스트링 a에서 sub를 찾아 인덱스를 리턴한다. 못찾으면 find는 -1을 리턴하고 index는 오류를 발생시킨다. rfind(), rindex()는 우측 부터 검색한다.
 - a.capitalize() -> 스트링 a의 첫문자만 대문자로하고 나머지는 소문자로 변환한다.
 - ''.join(list) -> list를 '' string으로 이어붙여준 것을 반환.
  => print 하거나 로그를 찍을 때 문자열과 리스트는 concatenate 되지 않기 때문에 생기는 불편함을 이걸로 해결할 수 있음
  => 리스트 멤버가 모두 문자열이어야 한다.
  => 멤버가 정수일 경우 추가적 해결책: ''.join(str(e) for e in list)
  => http://stackoverflow.com/questions/5618878/how-to-convert-list-to-string

3. Jython
 - Java로 구현한 Python
 - 파이썬 문법을 쓰지만 Java 기능을 이용할 수 있다.
 - 1.0 버젼 도큐먼트: http://www.jython.org/jythonbook/en/1.0/
  => http://www.jython.org/jythonbook/en/1.0/LangSyntax.html#the-difference-between-jython-and-python
  => http://www.jython.org/jythonbook/en/1.0/DataTypes.html#strings-and-string-methods
  => http://www.jython.org/jythonbook/en/1.0/InputOutput.html
 - line by line 파일 읽기 비교 - java vs. jython
  => http://bzimmer.ziclix.com/presentations/jython-intro/slide-14.html

4. 파일 읽기/쓰기/붙이기/삭제
 - 읽기/쓰기/붙이기: r/w/a
 - 적절한 읽고 닫기는 파일 포인터 선언, open(), close()가 try - finally 에서 구현되는 것.
  => f = None
        try:
            f = open('file.txt', 'r')
            # f.read() # read entire thing
            # f.readline() # read a line seperated by '\n'
            # f.readlines() # read whole lines as a list
            # do any other stuffs with f
        finally:
            if f is not None:
                f.close()
  => https://docs.python.org/2/tutorial/errors.html
  => http://stackoverflow.com/questions/3770348/how-to-safely-open-close-files-in-python-2-4
 - with: try - finally 로 파일 읽고 닫기를 대체하는 더 간결한 파이썬 구문. 구문이 끝나면 close()가 보장된다
  => with open('workfile', 'r') as f:
        read_data = f.read()
  => https://docs.python.org/2/tutorial/inputoutput.html
  => http://www.pythonforbeginners.com/files/reading-and-writing-files-in-python
  => 2.5 버젼부터 사용 가능하고, 이전 버젼에서는 "from __future__ import with_statement" 를 추가하여 사용 가능
  => __future__ import는 파이썬 스크립트 가장 상위에만 집어넣을 수 있다.
  => https://docs.python.org/2/library/__future__.html
  => http://stackoverflow.com/questions/7918745/python-2-5-2-what-was-instead-of-with-statement
 - file.readlines() 는 유용하다. 일단 한 번 읽으면 특정 줄 하나에 접근하고 싶을 때 배열처럼 이용 가능
  => ex: file.readlines()[13]
  => http://stackoverflow.com/questions/2081836/reading-specific-lines-only-python
 - 파일 존재 여부 체크
  => import os.path
  => if (not) os.path.exists(파일 경로만) -> 파일 경로 검사. 만일 경로가 존재하(지 않으)면.
  => os.path.isfile(파일 이름 포함 풀 경로) -> 파일 검사.
  => os.path.isdir(디렉토리 이름 포함 풀 경로) -> 디렉토리 검사.
  => http://stackoverflow.com/questions/82831/check-whether-a-file-exists-using-python
  => https://docs.python.org/2/library/os.path.html
 - 파일/디렉토리 삭제
  => os.remove(file): 파일
  => os.rmdir(dir): 디렉토리 삭제 (비어있는)
  => os.rmtree(dir): 디렉토리와 컨텐츠 전부 삭제
  => http://stackoverflow.com/questions/6996603/how-do-i-delete-a-file-or-folder-in-python

5. 파이썬 쓰레드
 - 기본: thread 모듈 사용
  => import thread
        thread.start_new_thread ( function, args[, kwargs] )
 - 발전: threading 모듈 사용 (2.4 버전 이후부터 추가)
  => import threading
        class myThread (threading.Thread):
            def __init__(self, threadID, name, counter):
                # To init.
            def run(self):
                # To do.

        thread1 = myThread(1, "Thread-1", 1)
        thread1.start()
  => threading 모듈이 제공하는 추가 메소드
        threading.activeCount(): Returns the number of thread objects that are active.
        threading.currentThread(): Returns the number of thread objects in the caller's thread control.
        threading.enumerate(): Returns a list of all thread objects that are currently active.
  => Thread 클래스가 제공하는 추가 메소드
        run(): The run() method is the entry point for a thread.
        start(): The start() method starts a thread by calling the run method.
        join([time]): The join() waits for threads to terminate.
        isAlive(): The isAlive() method checks whether a thread is still executing.
        getName(): The getName() method returns the name of a thread.
        setName(): The setName() method sets the name of a thread.
 - 동기화(Synchronizing)
  => threading.Lock(): new lock 을 새로 만들어 리턴해준다.
  => 전역에 만들고 Thread 클래스 안에서 acquire(), release()로 락을 걸고 푼다.
  => class myThread (threading.Thread):
            def __init__(self, threadID, name, counter):
                pass
            def run(self):
                threadLock.acquire()
                # To do in lock.
                threadLock.release()

        threadLock = threading.Lock()
 - http://www.tutorialspoint.com/python/python_multithreading.htm

6. 파이썬 for loop 순환
 - for i in range(0, 100):
    item = list[i]
    # To do.
    list[i] = result
 - for i in range(len(list)):
    item = list[i]
    # To do.
    list[i] = result
 - i = 0
    for element in list:
        item = element
        # To do.
        list[i] = result
        i+=1
 - 2.3 버전 이후 개선점: enumerate()
  => enumerate() 는 순회를 돌 리스트의 원소와 함께 인덱스 번호도 만들어줘서 편리.
  => for i, item in enumerate(list):
        # ... compute some result based on item ...
        list[i] = result
  => https://docs.python.org/2.3/whatsnew/section-enumerate.html

7. 리스트 함수 및 요령
 - 기본: https://docs.python.org/2/tutorial/introduction.html#lists
 - 세부: https://docs.python.org/2/tutorial/datastructures.html#more-on-lists
 - list.append(x) -> Add an item to the end of the list; equivalent to a[len(a):] = [x].
 - list.extend(L) -> Extend the list by appending all the items in the given list; equivalent to a[len(a):] = L.
 - list.insert(i, x) -> Insert an item at a given position. The first argument is the index of the element before which to insert, so a.insert(0, x) inserts at the front of the list, and a.insert(len(a), x) is equivalent to a.append(x).
 - list.remove(x) -> Remove the first item from the list whose value is x. It is an error if there is no such item.
 - list.pop([i]) -> Remove the item at the given position in the list, and return it. If no index is specified, a.pop() removes and returns the last item in the list. (The square brackets around the i in the method signature denote that the parameter is optional, not that you should type square brackets at that position. You will see this notation frequently in the Python Library Reference.)
 - list.index(x) -> Return the index in the list of the first item whose value is x. It is an error if there is no such item.
 - list.count(x) -> Return the number of times x appears in the list.
 - list.sort(cmp=None, key=None, reverse=False) -> Sort the items of the list in place (the arguments can be used for sort customization, see sorted() for their explanation).
 - list.reverse() -> Reverse the elements of the list, in place.
 - 리스트 원소 채워넣기의 더 간결한 방법
  => 기존: squares = []
            for x in range(10):
                squares.append(x**2)
  => 발전: squares = [x**2 for x in range(10)]
 - del 커맨드: pop(), remove() 호출 대신 인덱스 번호만 가지고 리스트의 특정 부분, 범위, 또는 전체를 삭제 가능.
  => >>> a = [-1, 1, 66.25, 333, 333, 1234.5]
        >>> del a[0]
        >>> a
        [1, 66.25, 333, 333, 1234.5]
        >>> del a[2:4]
        >>> a
        [1, 66.25, 1234.5]
        >>> del a[:]
        >>> a
        []
  => 변수 전체를 통째로 지울 수도 있음: del a -> 이후 a 참조는 에러.
  => https://docs.python.org/2/tutorial/datastructures.html

8. grinder, nGrinder
 - http://grinder.sourceforge.net/
 - grinder: a Java Load Testing Framework
 - features
  => Generic Approach
  => Flexible Scripting
  => Distributed Framework
  => Mature HTTP Support 
  => http://grinder.sourceforge.net/index.html
 - nGrinder: grinder 가지고 네이버에서 만든 테스트 도구인 거 같다
  => 웹 UI 제공
  => 기초 테스트가 가능한 스켈레톤 스크립트를 자동 생성
  => jython. groovy 지원
  => 한글 가이드: http://devcafe.nhncorp.com/nGrinder/wiki/entry/ngrinder_guide
 - 예제 스크립트: http://grinder.sourceforge.net/g3/script-gallery.html#sequence.py

9. shell command 실행
 - i) os.system("ls -l")
  => 단순한 방법
  => import os
  => 세밀한 제어(stdout, stderr 등)가 불가
 - ii) subprocess.call(["ls", "-l"] (, stdin=None, stdout=None, stderr=None, shell=False) )
  => 좀 더 나은, 권장되는 방법. 파라미터는 리스트로 집어넣는 듯
  => import subprocess
  => https://docs.python.org/2/library/subprocess.html
  => i, ii 문제: stdout을 출력만 할 뿐 변수로 가져오지 못한다. 
 - iii) subprocess.Popen(command (, bufsize=0, executable=None, stdin=None, stdout=None, stderr=None, preexec_fn=None, close_fds=False, shell=False, cwd=None, env=None, universal_newlines=False, startupinfo=None, creationflags=0) )
  => command는 리스트로 받거나, shell=True 값을 추가하면 풀 스트링으로 받을 수 있다.
  => shell=True 는 권장 사항은 아닌데 보안이슈가 있기 때문
  => stdout=subprocess.PIPE 를 추가하면 stdout을 변수로 받을 수 있다. 이상하게 call() 은 안 되었던 듯 하다.
  => Popen 객체는 몇 가지 내장 메소드를 가지는데 이 때 communicate() 메소드가 필요. communicate는 [stdout, stderr] 리스트를 반환한다. 결국 출력을 받기 위해 [0]번 요소가 필요해지게 된다.
  => ex) str = subprocess.Popen("ls -al", shell=True, stdout=subprocess.PIPE).communicate()[0]
 - iv) subprocess.check_output(command (, stdin=None, stdout=None, stderr=None, shell=False) )
  => Popen보다 단순하게 stdout을 받을 수 있다.
  => ex) str = subprocess.check_output("ls -al", shell=True)
  => 근데 2.7 이후부터 지원. 시험 못해봤다.
 - https://docs.python.org/2/library/subprocess.html
 - Fabric
  => http://www.fabfile.org/
  => 이 모든 것을 더 쉽고 세밀하게 만들어주는 파이썬 라이브러리
  => 쉬워보이는데, 튜토리얼 시작부분에서 막혀서 고생 중

10. pip 설치
 - easy_install 설치: https://pypi.python.org/pypi/distribute/0.6.49
 - 압축 해제
 - sudo python setup.py install
 - sudo easy_install pip

11. BeautifulSoup
 - html 파서. 최신 버젼 4.
 - http://www.crummy.com/software/BeautifulSoup/
 - 설치: pip install beautifulsoup4
 - 사용: from bs4 import BeautifulSoup
 - 사용 주의사항
  => lxml: 뷰티풀수프 해석기. 설치 필수
  => http://lxml.de/
  => http://coreapython.hosting.paran.com/etc/beautifulsoup4.html#installing-a-parser
  => 설치: sudo pip install lxml
  => BeautifulSoup() 객체를 만들어 시작할 때 2가지를 반드시 지정하라.
   i) lxml 해석기. 빠르다. 지정 안 하면 기본 해석기를 쓰는데 워닝을 뱉기 때문에라도 불편.
   ii) from_encoding='utf-8'. 자동 인코딩 탐지기를 쓰지 않고 바로 이걸로. 오류가 사라지고 속도가 대폭 향상된다.
    ==> http://coreapython.hosting.paran.com/etc/beautifulsoup4.html#encodings
  => ex) soup = BeautifulSoup(html, "lxml", from_encoding="utf-8")
 - 문서(원문): http://www.crummy.com/software/BeautifulSoup/bs4/doc/
 - 문서(한글): http://coreapython.hosting.paran.com/etc/beautifulsoup4.html
 
12. gzip, zlib, base64
 - gzip: gzip 파일 입출력을 다루게 해주는 모듈.
  => https://docs.python.org/2/library/gzip.html
  => 주의사항: GzipFile() 클래스는 2.6 버젼 이하에서 __enter__(), __exit__()가 기본 구현되어있지 않다. 따라서 with 명령어를 쓸 수 없다. -> 전통적인 try except finally로 파일 처리하고 close() 해줘야 한다.
  => https://mail.python.org/pipermail/tutor/2009-November/072957.html
 - zlib: zlib 압축 알고리즘을 사용하게 해주는 모듈.
  => zlib의 압축 알고리즘은 사실 gzip의 알고리즘과 같으며 두 프로그램의 제작자는 동일인물이다. zlib은 gzip 압축파일을 다루는 일부 메소드를 제공한다.
  => http://www.zlib.net/
  => 주요 메소드: zlib.compress(string, 압축밀도번호(0~9. 9가 제일 강한 압축)), zlib.decompress(string)
  => https://docs.python.org/2/library/zlib.html
 - base64: base64 인코딩 모듈
  => 스트링은 인코딩에 따라 무슨 문자가 나올지 모르며 일부 unprintable한 문자는 셸에서 버그를 일으킬 수 있다. 따라서 표현가능한 문자로 바꿔야 하는데 base64를 쓴다. 다만 덩치가 30%정도 커진다.
  => 압축을 적용하고 -> base64로 인코딩하여 오류 소지를 없애는게 기본 사용법.
  => 주요 사용 메소드: base64.b64encode(string), base64.b64decode(string)
  => ex) outputFile = base64.b64encode(zlib.compress(inputString, 9))


13. http 웹 리소스 가져오기
 1) urllib2
  - url 연결 모듈
  - import urllib2
  - response = urllib2.urlopen("http://example.com", timeout = 5)
  - content = response.read()
  - reponse.close()
  - http://stackoverflow.com/questions/24346872/python-equivalent-of-a-given-wget-command
 2) urllib2 + header
  - import urllib2
  - header = {"User-Agent": "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36"}
   => chrome header를 개발자 모드 network 탭에서 패킷을 열어서 찾은 것. 크롬과 동일한 환경에서 웹 페이지를 요청하려는 목적
  - request = urllib2.Request(url="주소", headers=header)
  - response = urllib2.urlopen(request)
  - content = response.read()
  - reponse.close()
  - https://docs.python.org/2/library/urllib2.html?highlight=urllib2#module-urllib2
 3) httplib
  - import httplib
  - header = {"": ""}
   => 사전 형식으로.
  - param = urllib.urlencode({'@param1': 1234, '@param2': 'haha'})
  - conn = httplib.HTTPConnection('url')
   => "http://" 같은 프로토콜 없이 www 부터 루트 호스트이름까지만.
  - conn.request("GET", "나머지 url", param, header)
  - response = conn.getresponse()
  - data = response.read()
  - conn.close()
  
14. python object(객체) 안의 멤버 메소드들 살피기
 - methodList = [method for method in dir(object) if callable(getattr(object, method))]
 - http://stackoverflow.com/questions/34439/finding-what-methods-an-object-has
 - http://www.diveintopython.net/power_of_introspection/index.html

15. mysql 연동
 - 필요 모듈: _mysql, MySQLdb
  => _mysql: C API를 이용하는 raw-level 모듈
  => MySQLdb: _mysql 모듈을 포장한 wrapper
  => mysql_python 설치 필요
  => sudo pip install MySQL-python
 - con = MySQLdb.connect('localhost', 'testuser', 'mypassword', 'mydbname', charset='utf8')
  => charset='utf8' 이 중요하다. 없으면 python -> mysql 로 유니코드 한글을 던질 수 없다. 깨진다.
 - sql 문을 문자열로 만들어 그냥 날리는 형식
 - 예제
    #!/usr/bin/python
    # -*- coding: utf-8 -*-
    import MySQLdb as mdb
    import sys
     
    try:
        con = mdb.connect('localhost', 'dbuser', 'mypassword', 'mydb', port, 'socket_path/mysql.sock', charset='utf8')
        
        cur = con.cursor()
        sql = "SELECT ID FROM articles ORDER BY ID DESC LIMIT 10"
        cur.execute(sql)
        for i in range(cur.rowcount):
            row = cur.fetchone() # cur.fetchall() 도 있다.
            print row[0]

        # con.commit()
     
    except mdb.Error, e:
        if con:
            con.rollback()

        print "Error %d: %s" % (e.args[0], e.args[1])
        sys.exit(1)
    finally:
        if con:
            con.close()
 - sql 문에 변수를 넣어줄 때: 변환명세는 %s. execute(sql, data) 순으로 넣는다. 이때 type(data) == Tuple. 원소가 하나라도 Tuple 형식로 넣는다 (ex: (one, ))
  => ex: sql = "update table set value=%s where id=%s"; data = (value, id); execute(sql, data)
 - http://banasun.tistory.com/46
 - MySQLdb 문서: http://mysql-python.sourceforge.net/MySQLdb.html
 - insert 문 예제: http://dev.mysql.com/doc/connector-python/en/connector-python-example-cursor-transaction.html
 - 한글 깨질 때 참조했던 링크: http://stackoverflow.com/questions/8365660/python-mysql-unicode-and-encoding
 - select 제외하고 db에 변화를 주는 놈들은 commit() 해야 한다.
  => 특히 성공이든 실패했든, 특히 실패할 경우에 분기 처리를 잘해서 반드시 커밋 롤백 둘 중 하나를 해야 락이 걸리지 않고 다른 곳에서 mysql 접근 중에 멈추지 않는다.

16. 정규표현식
 - import re
 - re.sub('대상패턴'. '결과문자', 원본 소스) -> 원본소스에서 대상패턴 매칭하여 결과문자로 치환. 바이트 스트림, 유니코드 모두 적용. 결과 리턴.
 - http://blog.dokenzy.com/archives/259

17. dict 공부
 - 사전 파일, 일종의 Map
 - https://docs.python.org/2/library/stdtypes.html#dict
 - https://docs.python.org/2/tutorial/datastructures.html#dictionaries

18. 타임 딜레이 만들기
 - import time
 - time.sleep(5) -> 5초
 - http://stackoverflow.com/questions/510348/how-can-i-make-a-time-delay-in-python

19. 파이썬 숫자 표현법
 - print "%04d" % (i) -> i 숫자 앞에 4자리 0을 붙여준다.
 - http://stackoverflow.com/questions/134934/display-number-with-leading-zeros

20. 파이썬 예외처리
 - try:, except:, finally:
 - 사용자 정의한 예외 클래스로 except 받기도 가능
 - 여러개 except 묶어 받기: except (Exception1, Exception2):
 - 예외 메시지 활용: except Exception, e: -> str(e) 로 확인
 - raise: 예외 던지기(==throw) (ex: raise Exception, raise UserException())
  => raise만 단독으로 쓰면 예외를 처리할 except를 만들 순 없고 단지 예외만 던진다. 이 때 예외명은 직전 발생한 예외가 된다
  => ex:
    >>> try:
    ...     raise NameError('HiThere')
    ... except NameError:
    ...     print 'An exception flew by!'
    ...     raise
    ...
    An exception flew by!
    Traceback (most recent call last):
    File "<stdin>", line 2, in ?
    NameError: HiThere
 - https://docs.python.org/2/tutorial/errors.html
 - KeyboardInterrupt: 내장 예외 중 하나. 사용자가 ctrl+c 등으로 키보드 인터럽트 걸었을 때를 캐치해준다. 유용한듯.
  => 
  => http://effbot.org/zone/stupid-exceptions-keyboardinterrupt.htm

21. 파이썬 클래스
 - object: 레퍼런스 정확히 안 찾아봤는데 모종의 파이썬 최상위 클래스인 듯.
 - self: 메소드 내에서 인스턴스 속성을 가리킴
 - 인스턴스 속성은 동일 클래스로부터 생성되었어도 서로 다른 인스턴스 간에는 상호 접근 불가능
 - dir(인스턴스명): 인스턴스의 모든 속성을 받기
 - 스크립트 스타일에 익숙해지자. 파이썬 클래스는 일종의 dict로 생각하자. 미리 속성(멤버 변수) 만들 필요 없다.
 - 특별 메소드
    __init__ : 인스턴스 생성 초기화 작업 위해 자동 호출.
    __del__ : 인스턴스 소명 시 호출. gc가 자동정리 하므로 많이 사용되지는 않음
 - __slots__
    => 사용할 속성명을 미리 지정하는 기법
    => 이외의 self 속성을 맘대로 정할 수 없다
    => 클래스를 많이 만들어 메모리를 많이 차지하고 gc가 일어날 때 메모리 사용을 줄여 퍼포먼스를 높이는 튜닝 방법
    => 클래스 안에서 정의하여 사용한다.
    => 예
        class Test(object):
            __slots__ = ("attr1", "attr2")
 - 예문
    class Name(parent class): #부모 클래스 생략가능, 괄호까지 통째로 생략 가능. 생략 문법은 python 2 문법인듯. python 3부터는 생략하지 않는 것을 권고하는 듯.
        attr1 = 10 #클래스 속성(멤버변수)
        def __init__(self, hey): #특별 메소드: 생성자
            Name.attr = hey
        def func1(self, n): #메소드
            self.attr2 = 20 #인스턴스 속성
            return n+1
    >>> Name.attr1
    10
    >>> a = Name()
    >>> a.attr1
    10
    >>> a.func1(10)
    11
    >>> a.attr2
    20
 - https://wikidocs.net/28
 - https://wikidocs.net/1076
 - http://www.dongwun.com/tc/142
 - 제너레이터(generator): https://docs.python.org/2/tutorial/classes.html#generators

22. 파이썬 모듈
 - 단일 클래스나 함수로 구성된 .py 파일을 모듈로 부르는 법
  => test.py 내용(변수, 함수, 클래스) 전체 가져오기: import test
  => test.py -> TestClass 가져오기: from test import TestClass
  => 별명달기: from test import TestClass as abc
 - 이렇게 하면 스크립트 루트에 .pyc, .pyo 파일이 생긴다. 컴파일된 바이트코드
  => 딱히 이것을 미리 만들어 쓴다고 성능 업은 없는 것으로 알려짐
  => 불필요하다
 - 삭제 / 관리
  => 버젼관리(git): .gitignore에 .pyc, .pyo 추가
  => 커맨드: rm *.pyc *.pyo 삭제, find . -name "*.pyc" -exec rm -rf {} \;, find . | grep '.pyc$\|.pyo$' | xargs rm
  => pyclean: 이런 이름의 모듈이 있는 것 같다
  => sys.dont_write_bytecode = True: 파이썬 소스레벨 제어. 이후 임포트된 파일은 pyc가 생기지 않는다. 좋은 듯
  => http://stackoverflow.com/questions/785519/how-do-i-remove-all-pyc-files-from-a-project
  => http://stackoverflow.com/questions/154443/how-to-avoid-pyc-files
  => http://blog.bluekyu.me/2012/10/pyc-pyo.html
  => https://wikidocs.net/77

23. 커맨드라인 인자 전달
 - sys.argv
 - 들어온 인자 수 조사: len(sys.argv), 기본적으로 sys.argv[0]이 스크립트 파일명이므로 기대하는 인자 수 조사는 기대값 + 1 이어야 한다.

24. 파이썬 람다
 - 입력 받아 결과를 리턴
 - (lambda 인자1(, 인자2, ...): 표현식)(입력1(, 입력2, ...))
 - ex: str = (lambda x: "result")("nothing")
 - ex: doubleIt = (lambda x: x*2 )(30)
 - ex: concat_result = (lambda x, y: x+y)("concat", "string")
 - https://wiki.python.org/moin/Powerful%20Python%20One-Liners
 - https://wikidocs.net/64
 - http://jinson.tistory.com/208

25. 간단한 한 줄짜리 if
 - 버전 2.5 이상
 - variable = value_when_true if condition else value_when_false
 - ex: data = "yes" if x == 0 else "no"
 - http://stackoverflow.com/questions/2802726/putting-a-simple-if-then-statement-on-one-line

26. url encoding & decoding
 - import urllib
 - decoding: urllib.unquote(url), urllib.unquote_plus(url)
  => unquote_plus() 는 unquote() 동작에 "+" 기호를 스페이스로 바꿔주는 것까지 한다
  => 한번에 안 되면 여러번 해봐라. encoding을 중첩해서 저장하는 사례가 있다.
 - encoding: urllib.urlencode({'param1': 1, 'param2': 2})
  => 특이하게도 완성된 스트링을 encode해주는게 아니라 dict으로 받아서 encoding된 스트링을 조합해주는 식
 - https://docs.python.org/2/library/urllib.html

27. url 파싱
 - import urlparse
 - url을 분석하기: urlparse.urlparse(url)
  => url을 프로토콜, 호스트네임, 포트, 파라미터 등으로 분석하여 튜플로 내어준다.
  => urlparse.urlsplit(url)도 유사한 동작을 하는데 URL로부터 파라미터를 파싱하지 않는 차이가 있다. 언제 구분해서 쓸 지는 아직 잘 이해 안됐다.
 - hostname 추출하기: hostname = urlsplit("http://www.naver.com/etc").hostname -> "www.naver.com"
 - https://docs.python.org/2/library/urlparse.html
 
28. 디버깅
 - import pdb
 - 자세한건 나중에 공부해보자
 - https://docs.python.org/2/library/pdb.html