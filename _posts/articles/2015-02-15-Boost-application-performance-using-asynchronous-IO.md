---
layout: post
title: "Boost application performance using asynchronous IO"
date: 2015-02-15T20:39:51-09:00
modified:
categories: articles
excerpt:
tags: [async, asynchronous, io, boost, performance, intel, posix, aio, api, ibm]
image:
  feature:
share: true
---

본 페이지는 IBM에서 소개하는 비동기 IO 문서를 알기 쉽게 요약하여 정보를 빠르게 전달함을 목적으로 하며, 원문은 [원문 링크](http://www.ibm.com/developerworks/library/l-async/)를 클릭하여 확인할 수 있다.

### 비동기 IO (AIO): 소개

 - 기존에 리눅스에서 가장 흔히 사용하는 IO는 동기 IO (synchronous I/O)
 - 요청작업(request)이 끝날 때까지(satisfied) 어플리케이션 대기(block)
 - 장점: cpu 필요없다
 - 문제의식: 종종 다른 프로세스 IO 요청을 겹쳐 받을(overlap) 필요성을 느낌
 - posix의 AIO(Asynchronous IO) API(Application Program Interface)가 이를 지원 ([※ POSIX(Portable Operating System Interface)](http://ko.wikipedia.org/wiki/POSIX): 이식 가능 운영 체제 인터페이스)
 
 ### AIO(Asynchronous IO) 란?

 - 비교적 최근 삽입된 리눅스 AIO는 2.6 버젼 커널부터 표준 스펙, 그러나 2.4 버젼도 패치로 이용가능
 - 기본 개념: 한 프로세스가 몇 개의 IO 작업을 하는 것을, 일단 세우거나(block) 다른 넘 끝날 때까지 기다리기(wait) 없이 허용하기
 - 시간이 지나거나 IO 완료를 알림받은 뒤에, 프로세스는 IO 결과를 받을 수 있다

### IO 모델

![Alt text](http://www.ibm.com/developerworks/library/l-async/figure1.gif "그림 1. 리눅스 IO 모델 간략 구조")

# 1. 동기 정지 IO (Synchronous blocking I/O)
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure2.gif "그림 2. 동기 정지 IO 모델의 전형적인 흐름도")
 - 가장 흔한 모델
 - 사용자 공간(user-space)에 있던 어플리케이션이 정지(block)를 일으키는 시스템 함수 호출(system call)
 - 이로써 한 작업당 한 번의 사용자공간-커널공간의 문맥 교환([context](http://en.wikipedia.org/wiki/Context_(computing)) switching) 발생
 - 정지된 어플리케이션은 CPU를 사용하지 않고 커널(kernel) 응답을 기다림
 - 응답이 되돌아오면 데이터도 사용자 공간 버퍼로 돌아오고, 어플리케이션은 정지가 풀림(unblocked)
 - 이해하기 쉽다
 - 효율적이고 전형젹
 - 어플리케이션 관점에서 보면 그냥 오래 걸리는 거 같지만 실은 커널의 다른 일 기다리느라 서있는(blocked) 거다 -> 개선 포인트

# 2. 동기 비정지 IO (Synchronous non-blocking I/O)
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure3.gif "그림 3. 동기 비정지 IO 모델의 전형적인 흐름도")
 - 1의 개선안
 - 그런데 사실 1에 비해 비효율적인 방식 -> 이유는 더 잦은 시스템 호출과 문맥 교환(context switch)
 - 비정지로 장치가 열리는 것의 의미: IO를 즉시 완료하는 대신, IO가 완료될 때까지 어플리케이션은 계속 물어보고(system call), 커널은 아직 완료되지 않았다는 에러 코드를(EAGAIN or EWOULDBOLCK) 반환
 - 매우 비효율적
 - IO 지연(latency) 초래

# 3. 비동기 정지 IO (Asynchronous blocking I/O)
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure4.gif "그림 4. 비동기 정지 IO 모델의 전형적인 흐름도")

# 4. 비동기 비정지 IO (Asynchronous non-blocking I/O (AIO)) - 우리의 관심사
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure5.gif "그림 5. 비동기 정지 IO 모델의 전형적인 흐름도")