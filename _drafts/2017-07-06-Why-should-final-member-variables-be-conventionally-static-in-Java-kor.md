---
layout: post
categories: articles
title:  "왜 자바에서 final 멤버 변수는 관례적으로 static을 붙일까?"
excerpt: "자바 final, static 키워드와 코딩 best practice 고찰"
tags: [java, final, static, member, variable, field, class, local, instance, scope, convention, practice, bestpractice, 자바, 파이널, 스타틱, 정적, 상수, 변수, 멤버, 필드, 어트리뷰트, 클래스, 인스턴스, 로컬, 스코프, 관례, 컨벤션, 프랙티스, 베스트프랙티스, 습관]
date: 2017-07-06 15:39:13
modified: 2017-07-06 15:39:13
image: 
  feature: 
share: false
sitemap: false
---

오늘도 기초 정리입니다! 오늘은 자바 개발에서 꽤나 보편적으로 볼 수 있는 코드를 하나 정리해보려고 합니다. 바로 클래스의 `private static final` 멤버 변수 이야기입니다. 저는 현업에서 클래스 상수나 로그 구현체를 이런 식으로 만드는 것을 자주 보았는데요, 관련한 내용들을 가능한 짧고 간단하게 메모 스타일로 정리해 보겠습니다.


# 왜 final 변수는 static 이야?

흔히 클래스의 멤버 변수를 상수(`final`)로 만들고자 할 땐, 클래스 상수(`static final`)로 만들어주곤 합니다. 사실 이 말 속에 답이 대략 나타나는 것 같은데요^^; 하지만 이참에 자바 기본을 정리해 보죠.


## final 키워드

`final` 키워드는 프로그래밍 언어에서 'constant', '상수'와 같은 단어와 비교되는 단어인데요, 자바에서 기본적으로 다음의 의미를 가집니다.

> final은 해당 entity가 오로지 한 번 할당될 수 있음을 의미합니다.
> - 위키피디아

그래서 위 의미를 바탕으로 다음 세 경우에 따라 구체적으로 작용합니다.

* final 변수
  * 해당 변수가 생성자나 대입연산자를 통해 한 번만 초기화 가능함을 의미합니다. 상수를 만들 때 응용합니다.
* final 메소드
  * 해당 메소드를 오버라이드하거나 숨길 수 없음을 의미합니다.
* final 클래스
  * 해당 클래스는 상속할 수 없음을 의미합니다. 문자 그대로 상속 계층 구조에서 '마지막' 클래스입니다.
  * 보안과 효율성을 얻기 위해 자바 표준 라이브러리 클래스에서 사용할 수 있는데, 대표적으로 `java.lang.System`, `java.lang.String` 등이 있습니다.

### 몇가지 세부 분석

final 멤버 변수는 반드시 상수가 아닙니다. 왜냐면 `final`의 정의가 '상수이다'가 아니라 '한 번만 초기화 가능하다'이기 때문입니다. 다음의 코드를 보시죠.

```java
public final class Test {
  private final int value;

  public Test(int value) {
    this.value = value;
  }

  public int getValue() {
    return value;
  }
}
```

이 코드에서 final 멤버 변수 `value`는 생성자를 통해 초기화 되었습니다. 즉 이 클래스의 인스턴스들은 각기 다른 `value` 값을 갖게 되겠죠. 각 인스턴스 안에서는 변하지 않겠지만, 클래스 레벨에서 통용되는 상수라고는 할 수 없습니다.

한 편, private 메소드와 final 클래스의 모든 메소드는 명시하지 않아도 `final` 처럼 동작합니다. 왜냐면 오버라이드가 불가능하기 때문이죠.

* 참고: [jls-8.4.3.3](http://docs.oracle.com/javase/specs/jls/se8/html/jls-8.html#jls-8.4.3.3)

하지만 private 메소드에 여전히 `final` 명시는 가능합니다. 불필요하냐구요? 네 사실 그렇습니다 ㅎㅎ 그래도 일단 의미는 구분됩니다.

* private: 자식 클래스에서 안 보입니다. (오버라이드도 물론 금지입니다.)
* final: 자식 클래스에서 보이지만, 오버라이드가 금지됩니다.

이렇게 불필요한 명시를 그렇다고 특별 취급해서 막을 필요는 없기 때문에, 컴파일러가 에러를 내거나 하지는 않습니다. 비슷한 예로 인터페이스의 메소드에 `public`을 붙이거나, final 클래스 메소드에 `final`을 붙이는 등의 경우도 문제가 생기지는 않지요. 

그렇다면 private 메소드와 final 메소드는 inline 메소드로 컴파일러 최적화가 될까요? 확인해보진 않았습니다만, 가능은 하더라도 항상 보장되진 않을 것으로 보입니다. 최적화 동작은 컴파일러와 내부 세팅에 의해 일어나기 때문입니다.


## static 키워드

`static` 키워드는 프로그래밍 언어에서 '전역', '정적'의 의미로 통용합니다. 자바에서는 다음과 같이 구체적으로 작용합니다.

* static 멤버 변수
  * 클래스 변수라고도 부릅니다.
  * 모든 해당 클래스는 같은 메모리를 공유합니다.
  * 인스턴스를 만들지 않고 사용 가능합니다.
* static 메소드
  * 클래스 메소드라고도 부릅니다.
  * 오버라이드 불가합니다.
  * 상속 클래스에서 보이지 않습니다.
* static 블록
  * 클래스 내부에 만들 수 있는 초기화 블록입니다.
  * 클래스가 초기화될 때 실행되고, `main()` 보다 먼저 수행됩니다.
* static import
  * 다른 클래스에 존재하는 static 멤버들을 불러올 때 사용합니다.
  * 멤버 메소드를 곧바로 사용할 수 있습니다.


## 그래서 왜 static final이라고? - 클래스 멤버 변수를 final로 지정하는 의도의 확인

그것은 클래스에서 사용할 해당 멤버 변수의 데이터와 그 의미, 용도를 고정시키겠다는 뜻이겠죠. 해당 클래스를 쓸 때 변하지 않고 계속 일관된 값으로 쓸 것을 멤버 상수로 지정할 것입니다. 예를 만들어 볼까요?

* `기독교` 클래스에서 멤버 변수 `신의 이름`을 만들어 사용한다면 해당 클래스를 언제 어디서 어떻게 쓰든 변함없이 `하나님`이겠죠?
* `중학교 성적` 클래스에서 `과목 최대 점수` 변수를 만든다면 `100`일 것입니다.

이 값들은 모든 클래스 인스턴스에서 똑같이 써야할 값이고, 프로그래머는 이들을 프로그램 처음부터 끝까지 바뀌지 않는 논리로 의도할 것입니다. 그렇다면 **인스턴스가 만들어질 때마다 새로 메모리를 잡고 초기화시키지 말고**, 클래스 레벨에서 한 번만 잡아서 하나의 메모리 공간을 쭉 쓰면 되지 않을까요? 상수로 만들 의도였으니 동시성 문제도 없고요. 그렇다면~

```
public static final String NAME_OF_GOD = "하나님";
public static final int MAX_SUBJECT_SCORE = 100;
```

와 같이 만들어두면 효율적이겠죠~

이것이 코딩 관례가 되어, 멤버 상수는 `static final`로 만드는 practice가 생겼다 하겠습니다.


# final 변수를 final static으로 디자인하지 않는 경우가 있을까?

위에서 잠시 언급한 것처럼, 각 인스턴스마다 서로 다른 final 멤버 변수를 생성사에서 초기화시키는 식으로 사용하는 경우에는 `static`을 사용하지 말아야 하겠네요~


# static 멤버 변수는 final이어야 할까?


# 참조

* [https://stackoverflow.com/questions/1415955/private-final-static-attribute-vs-private-final-attribute](https://stackoverflow.com/questions/1415955/private-final-static-attribute-vs-private-final-attribute)
* [http://www.javaworld.com/article/2077399/core-java/private-and-final.html](http://www.javaworld.com/article/2077399/core-java/private-and-final.html)
* [https://en.wikipedia.org/wiki/Final_(Java)](https://en.wikipedia.org/wiki/Final_(Java))
* [https://en.wikipedia.org/wiki/Static_(keyword)](https://en.wikipedia.org/wiki/Static_(keyword))