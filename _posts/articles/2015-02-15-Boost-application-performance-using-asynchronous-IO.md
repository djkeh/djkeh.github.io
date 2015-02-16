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

본 페이지는 IBM에서 소개하는 비동기 IO 문서를 알기 쉽게 한글로 요약하여 정보를 전달함을 목적으로 하며, 원문은 [원문 링크](http://www.ibm.com/developerworks/library/l-async/)를 클릭하여 확인할 수 있다.

### 비동기 IO (AIO): 소개

- 기존에 리눅스에서 가장 흔히 사용하는 IO는 동기 IO (synchronous I/O)
- 요청작업(request)이 끝날 때까지(satisfied) 어플리케이션 블록(block)
- 장점: cpu 필요없다
- 문제의식: 종종 다른 프로세스 IO 요청을 겹쳐 받을(overlap) 필요성을 느낌
- posix의 AIO(Asynchronous IO) API(Application Program Interface)가 이를 지원 ([※ POSIX(Portable Operating System Interface)](http://ko.wikipedia.org/wiki/POSIX): 이식 가능 운영 체제 인터페이스)
  
  
### AIO(Asynchronous IO) 란?

- 비교적 최근 삽입된 리눅스 AIO는 2.6 버젼 커널부터 표준 스펙, 그러나 2.4 버젼도 패치로 이용가능
- 기본 개념: 한 프로세스가 몇 개의 IO 작업을 하는 것을, 일단 세우거나(block) 다른 넘 끝날 때까지 기다리기(wait) 없이 허용하기
- 시간이 지나거나 IO 완료를 알림받은 뒤에, 프로세스는 IO 결과를 받을 수 있다
  

### IO 모델

![Alt text](http://www.ibm.com/developerworks/library/l-async/figure1.gif "그림 1. 리눅스 IO 모델 간략 구조")

##### 1. 동기 블로킹 IO (Synchronous blocking I/O)
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure2.gif "그림 2. 동기 블로킹 IO 모델의 전형적인 흐름도")

- 가장 흔한 모델
- 사용자 공간(user-space)에 있던 어플리케이션이 블록을 일으키는 시스템 함수 호출(system call)
- 이로써 한 작업당 한 번의 사용자공간-커널공간의 문맥 교환([context](http://en.wikipedia.org/wiki/Context_(computing)) switching) 발생
- 정지된 어플리케이션은 CPU를 사용하지 않고 커널(kernel) 응답을 기다림
- 응답이 되돌아오면 데이터도 사용자 공간 버퍼로 돌아오고, 어플리케이션은 블록이 풀림(unblocked)
- 이해하기 쉽다
- 효율적이고 전형젹
- 어플리케이션 관점에서 보면 마치 프로세싱이 오래 걸리는 거 같지만 실은 커널의 다른 일 기다리느라 그저 블록 되어있는 거다 -> 개선 포인트

##### 2. 동기 넌블로킹 IO (Synchronous non-blocking I/O)
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure3.gif "그림 3. 동기 넌블로킹 IO 모델의 전형적인 흐름도")

- 1의 개선안
- 그런데 사실 1에 비해 비효율적인 방식 -> 이유는 더 잦은 시스템 호출과 컨텍스트 스위칭(context switch)
- 넌블록으로 장치가 열리는 것의 의미: IO를 즉시 완료하는 대신, IO가 완료될 때까지 어플리케이션은 계속 물어보고(system call), 커널은 아직 완료되지 않았다는 에러 코드를(EAGAIN or EWOULDBOLCK) 반환
- 매우 비효율적
- IO 지연(latency) 초래

##### 3. 비동기 블로킹 IO (Asynchronous blocking I/O)
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure4.gif "그림 4. 비동기 블로킹 IO 모델의 전형적인 흐름도")

- IO는 넌블로킹으로, 알림(notification)을 블로킹으로 하는 방식
- 따라서 넌블로킹 IO(non-blocking IO) 는 설정되어 있다
- "select()" 라는 시스템 함수 호출이 어플리케이션을 정지(block)시킨다
- select() 는 IO 설명자(descriptor)에서 뭐 반응(activity)이 있나 보는데, 한 개가 아닌 여러 개의 IO 설명자에 대한 알림 기능을 수행할 수 있는 것이 특징
- select() 의 문제: 아직도 비효율적. 고성능 IO로는 비추천

##### 4. 비동기 넌블로킹 IO (Asynchronous non-blocking I/O (AIO)) - 우리의 관심사
![Alt text](http://www.ibm.com/developerworks/library/l-async/figure5.gif "그림 5. 비동기 넌블로킹 IO 모델의 전형적인 흐름도")

- 시스템 콜 요청(request)이 즉시 IO 개시 여부를 반환
- 어플리케이션은 이제 하고 싶은 다른 일 한다. IO 는 백그라운드에서 실행
- IO 응답(response)가 도착하면 신호(signal)나, 쓰레드 기반 콜백(callback)으로 IO 전달(transaction)을 완료
- 단일 프로세스가 여러 개의 IO 요청이 예상되는 환경 속에서 컴퓨터 연산이나 IO 작업을 병렬 수행하는 기능은 처리 속도와 IO 속도 사이에 틈을 유발한다
- IO 작업 한 개 이상이 처리 중 상태에 빠져있는 동안(pending), cpu는 다른 업무를 볼 수 있다

### 비동기 IO 를 만든 동기

- 블로킹 모델은 IO가 시작할 때 어플리케이션을 블록
- 프로세싱과 IO가 동시에 일어날 수 없다는 한계점
- 동기 넌블로킹 모델은 둘의 동시 사용을 허용하지만, 어플리케이션이 계속 IO 상태를 체크
 => 비동기 넌블로킹 IO: IO알림을 포함해 프로세싱과 IO의 동시 발생을 허용

### 리눅스 AIO 소개

리눅스 AIO 는 커널 버젼 2.5에 처음 소개되어 2.6에서 정식 표준으로 자리잡았다. 기존의 전통적인 IO 모델에서는 단일한 핸들로 식별되는 하나의 블로킹 IO가 있었고 이를 파일 설명자(descriptor)로 불렀으며 이들이 파일, 파이프, 소켓 등등에 모두 적용되었다. 사용자는 하나의 전달(transfer)을 하고 시스템 콜이 그에 대한 리턴을 해줬다.

이제 AIO에서는 복수의 전달을 할 수 있다. 이를 위해 각각의 전달들을 식별하기 위한 식별자가 필요하고, 이것이 AIOCB(AIO Control Block) 구조로 구현된다. AIOCB는 전달에 관한 모든 정보를 담고 있고, 데이터에 관한 사용자 버퍼까지 포함하고 있다. 한 IO에서 알림이 발생하면(이를 완료(completion)라 부른다), 이를 유일하게 식별하기 위해 AIOCB 구조가 준비된다.

### AIO API

| API 함수 | 설명 |
|---|---|
| aio_read | 비동기식 읽기 작업을 요청한다. |
| aio_error | 비동기 요청 상태를 확인한다. |
| aio_return | 완료된 비동기 요청 동작의 상태를 리턴한다. |
| aio_write | 비동기식 작업을 요청한다. |
| aio_suspend | 한 개 이상의 비동기 요청이 완료되거나 실패할 때까지 호출 과정을 잠시 중단한다. |
| aio_cancel | 비동기 IO 요청을 취소한다. |
| lio_listio | IO 작업 리스트를 개시한다. |

