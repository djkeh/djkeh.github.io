---
layout: post
categories: articles
title: "자바스크립트로 textarea에 탭 키 입력하기"
excerpt: "그리고 더 나은 자바스크립트로 구현하는 것에 대한 고찰"
tags: [자바스크립트, 탭, 탭키, javascript, tab,  key, input, textarea]
date: 2015-04-09 15:00:23
modified: 2015-04-09 15:00:23
image:
  feature:
  credit:
  creditlink:
share: true
sitemap: false
---

종종 html에서 `<textarea>` 엘리먼트를 이용해 간단한 텍스트 편집기를 만들고 싶을 때가 있다. 보통의 텍스트 에디터라면, 아마 대부분의 키보드 입력을 받아들이는 것을 상상할 것이다. 하지만, 실제로는 그렇게 잘 구현되지 않는다.

한 가지 좋은 예가 **"탭 키"** 입력이다. 뭐 탭 키도 안 눌리는 편집기냐 싶겠지만, 탭 키는 웹 화면에서 기본적으로 html 엘리먼트 탐색 버튼으로 동작한다. 이 말인즉슨 사용자가 탭 키를 누르면, 웹 엘리먼트 포커스가 이동한다. 이건 웹 기반 편집기 사용자, 특히 프로그래머에게 다소 짜증나는 일이 될 수 있다. 많은 프로그래머들이 코드 내부에서 들여쓰기를 하기 위해 탭 키를 사용하고 있지만, 기본적으로 위의 이유 때문에 그들은 탭 키를 사용할 수 없게 된다. 눈치챘겠지만 `<textarea>` 또한 html 문서 엘리먼트 중에 하나다. 그러므로 `<textarea>` 안에서 탭 키를 누르면, 되라는 탭 키 입력은 되지 않고 그 대신 포커스가 다음 엘리먼트로 빠져나가 버릴 것이다.

여기 자바스크립트를 이용해 이 문제를 해결하는 방법을 소개한다. 이하 코드는 개인적인 연습과 공부로 만들어졌으며, 이 코드를 통해 여러분은 여러분의 html 문서 편집기가 탭 키를 입력받을 수 있도록 만들 수 있을 것이다.

##### 0. 답부터 간단하게
게으른 프로그래머, 혹은 그저 급한 사람들을 위해, 정답부터 공개한다.

###### i) 이하 코드를 'tapManager.js' 파일로 저장하고 본인이 사용하는 프로젝트의 적당한 하위 폴더에 넣는다.

{% highlight javascript linenos %}
var TabManager = {
    tabKey: 9, // This number means tab key ascii input.
    enableTab: function(textBox, keyEvent) {
        if(this.isTabKeyInput(keyEvent)) {
            // Put tab key into the current cursor(caret) position.
            this.insertTab(textBox);
            
            // Block(invalidate) actual tab key input by returning key event handler to false.
            this.blockKeyEvent(keyEvent);   
        }
    },
    isTabKeyInput: function(keyEvent) {
        return keyEvent.keyCode == this.tabKey; 
    },
    insertTab: function(textBox) {
        var pos = this.getCaretPosition(textBox);
        var preText = textBox.value.substring(0, pos);
        var postText = textBox.value.substring(pos, textBox.value.length);

        textBox.value = preText + "\t" + postText; // input tab key

        this.setCaretPosition(textBox, pos + 1);
    },
    setCaretPosition: function(item, pos) {
        // Firefox, Chrome, IE9~ Support
        if(item.setSelectionRange) {
            item.focus();
            item.setSelectionRange(pos, pos);
        }
        // ~IE9 Support
        else if (item.createTextRange) {
            var range = item.createTextRange();
            range.collapse(true);
            range.moveEnd('character', pos);
            range.moveStart('character', pos);
            range.select();
        }
    },
    getCaretPosition: function(item) {
        var caretPosition = 0;
        
        // Firefox, Chrome, IE9~ Support
        if(item.selectionStart || item.selectionStart == '0') {
            caretPosition = item.selectionStart;
        }
        // ~IE9 Support
        else if(document.selection) {
            item.focus();
            var sel = document.selection.createRange();
            sel.moveStart('character', -item.value.length);
            caretPosition = sel.text.length;
        }
        
        return caretPosition;
    },
    blockKeyEvent: function(keyEvent) {
        if(keyEvent.preventDefault) {
            keyEvent.preventDefault();
        }
        else {
            keyEvent.returnValue = false;
        }
    }
};
{% endhighlight %}

###### ii) 웹 텍스트 편집기가 있는 html 문서 `<body>` 엘리먼트 끝자락에 이하의 코드처럼 본 자바스크립트를 포함시킨다.

{% highlight html %}
<script type='text/javascript' src='resources/js/TabManager.js'></script>
{% endhighlight %}

###### iii) 다양한 방법으로 쓴다! 자바스크립트 객체명은 "TabManager"이고, 메소드 이름은 "enableTab(textBox, keyEvent)" 이다.

{% highlight html linenos %}
// jQuery approach
$('textarea').on('keydown', function(keyEvent) {
    TabManager.enableTab(this, keyEvent);
} );


// javascript approach
document.getElementById('textEditor').onkeydown = function() {myFunction(keyEvent)};

function myFunction(keyEvent) {
    var textBox = document.getElementById('textEditor');
    TabManager.enableTab(textBox, keyEvent);
}


// html onkeydown event approach
<textarea onkeydown="myFunction(keyEvent)"></textarea>

<script type='text/javascript'>
function myFunction(keyEvent) {
    var textBox = document.getElementById('textEditor');
    TabManager.enableTab(textBox, keyEvent);
}
</script>
{% endhighlight %}

___

만약 당신이 열정적인 프로그래머고 뭔가 자세히 살펴볼 요량이라면, 밑의 자세한 단계를 따라가보기 바란다.

##### 1. 기본 동작을 취소시키기

시작부터 이상하게 들릴지 모르겠지만, 첫번째로 해야할 가장 중요한 일은 키보드 입력을 취소시키는 것이다. 이번 경우 우리는 탭 키를 막을 것이다. 이것으로 포커스 이동이 일어나지 않게 하려는 의도이다. 자바스크립트 메소드에는 이를 위해 `preventDefault()` 가 준비되어 있다. 이 메소드 사용을 위해 키보드 입력을 했을 당시의 키 이벤트 객체가 필요하며, 코드는 다음과 같이 된다:

{% highlight javascript %}
keyEvent.preventDefault();
{% endhighlight %}

그러나 이 코드는 모든 브라우저에서 동작하지 않는다. 이 메소드가 지금 브라우져에서 실제 사용 가능한지 검사해야 하므로, `if` 절을 사용해본다.

{% highlight javascript linenos %}
if(keyEvent.preventDefault) {
    keyEvent.preventDefault();
}
else {
    keyEvent.returnValue = false;
}
{% endhighlight %}

일부 구형 브라우져는 `returnValue` 라는 멤버 변수를 사용한다. 이제 위의 코드는 좀 더 향상된 브라우져 호환성을 제공할 것이다.

이제 이를 하나의 자바스크립트 함수로 감싸보자.

{% highlight javascript linenos %}
function blockKeyEvent(keyEvent) {
    if(keyEvent.preventDefault) {
        keyEvent.preventDefault();
    }
    else {
        keyEvent.returnValue = false;
    }
}
{% endhighlight %}

1단계 끝.

##### 2. 3+1가지 거시기한 문제 인지하기

당연히 되어야 할 것 같은 문단 중간에 탭 키 삽입하기는 당신 생각보다 훨씬 어렵다. 다음의 3가지 사실을 인식하기 바란다:

- *브라우져는 탭 키를 어디에 집어넣어야 할지 모른다! 심지어 커서가 거기 깜빡이고 있는데!*
- *브라우져는 문장 가운데에 글씨를 집어넣는 방법을 모른다!*
- *브라우져는 글씨를 삽입한 뒤에 커서가 어디서 깜빡이고 있어야 하는지를 기억하지 못한다!*

이거보다 날 정말 빡치게 하는 것은:

- **브라우져마다 이 문제들을 해결하도록 제공하는 방법들이 서로 다르다.**

어이쿠.. 우리는 이 문제들을 모두 관리해야 한다.
2단계 끝.

##### 3. 키보드 커서 위치 얻기

이제 "분할 정복" 전략을 써야 할 시간이다. 우리는 먼저 현재 키보드 커서 위치를 `<textarea>` 엘리먼트 안에서 얻어낼 것이다. 이하 코드는 비교적 최신 브라우져에서 이를 하는 방법이다. `<textarea>` 엘리먼트는 자바스크립트 객체로 계속 가지고 있어야 한다. 이하 코드에서는 이를 "textBox"로 명명한다.

{% highlight javascript linenos %}
var caretPosition = 0;

// Firefox, Chrome, IE9~ Support
if(textBox.selectionStart || textBox.selectionStart == '0') {
    caretPosition = textBox.selectionStart;
}
{% endhighlight %}

IE8, 9 같은 구형 브라우져는 다음의 코드를 쓴다.

{% highlight javascript linenos %}
// ~IE9 Support
if(document.selection) {
    textBox.focus();
    var sel = document.selection.createRange();
    sel.moveStart('character', -textBox.value.length);
    caretPosition = sel.text.length;
}
{% endhighlight %}

`caretPosition`을 반환하는 것으로, 우리는 현재 키보드 커서 위치를 얻을 수 있다. 깨끗하게 함수로 감싸보자.

{% highlight javascript linenos %}
function getCaretPosition(textBox) {
    var caretPosition = 0;

    // Firefox, Chrome, IE9~ Support
    if(textBox.selectionStart || textBox.selectionStart == '0') {
        caretPosition = textBox.selectionStart;
    }
    // ~IE9 Support
    else if(document.selection) {
        textBox.focus();
        var sel = document.selection.createRange();
        sel.moveStart('character', -textBox.value.length);
        caretPosition = sel.text.length;
    }

    return caretPosition;
}
{% endhighlight %}

3단계 끝.

##### 4. 탭 키 실제로 집어넣기

이제 탭 키를 넣을 위치를 알았다. 그러나 어떻게? 우리에겐 전체 문장과 커서 위치가 있다. 하지만 문자 하나를 스트링 객체 한가운데에 집어넣을 방법은 없다. 우리가 할 일은 전체 문장을 둘로 쪼개는 것이다. 눈치 챘는가? 이것이 그 아이디어다.

```
Result = front string + 'tab' + back string
```

그러니까 먼저 문장을 커서 위치를 기준으로 나누고, 탭 키 문자를 가운데에 집어넣은 후 전체를 순서대로 다시 이어붙이는 것이다.
구현은 아래와 같다.

{% highlight javascript linenos %}
var preText = textBox.value.substring(0, caretPosition);
var postText = textBox.value.substring(caretPosition, textBox.value.length);

textBox.value = preText + "\t" + postText;
{% endhighlight %}

4단계 끝.

##### 5. 키보드 커서를 원래 위치로 되돌려놓기

내 생각에 여러분은 아마 "이 단계는 대체 뭐야?"  라고 할 거 같은데, 우리는 이 단계가 필요하다. 우리가 직전 단계에서 한 일은 문장 중간에 탭 키를 곱게 삽입한게 아니라, 문장 전체를 꺼내 탭 키를 중간에 삽입하여 재조립한 다음 통째로 `<textarea>` 엘리먼트 안에 value 어트리뷰트로 다시 붙여 넣은 것이다. 이렇게 빈 `<textarea>` 객체 안으로 문장을 붙여넣었으니 원래의 커서 위치가 사라지는 것은 당연하다. 커서는 당초 예상과는 달리 문장의 맨 앞이나 맨 뒤에서 깜박이게 될 것이고, 그 곳은 우리가 의도한 위치가 아니다. 때문에 우리는 탭 키를 삽입할 때 원래의 커서 위치를 기억해 두었다가, 작업이 끝나고 나서 이를 이용해 원래 자리로 커서를 되돌려놔야 한다.

이하가 이를 위한 최신 브라우저용 코드다.

{% highlight javascript linenos %}
// Firefox, Chrome, IE9~ Support
if(textBox.setSelectionRange) {
    textBox.focus();
    textBox.setSelectionRange(caretPosition, caretPosition);
}
{% endhighlight %}

이것은 낡아빠진 브라우저용이다.

{% highlight javascript linenos %}
// ~IE9 Support
else if (textBox.createTextRange) {
    var range = textBox.createTextRange();
    range.collapse(true);
    range.moveEnd('character', caretPosition);
    range.moveStart('character', caretPosition);
    range.select();
}
{% endhighlight %}

잘 정리해보자.

{% highlight javascript linenos %}
function getCaretPosition(textBox, caretPosition) {
    // Firefox, Chrome, IE9~ Support
    if(textBox.setSelectionRange) {
        textBox.focus();
        textBox.setSelectionRange(caretPosition, caretPosition);
    }
    // ~IE9 Support
    else if (textBox.createTextRange) {
        var range = textBox.createTextRange();
        range.collapse(true);
        range.moveEnd('character', caretPosition);
        range.moveStart('character', caretPosition);
        range.select();
    }
}
{% endhighlight %}

##### 6. 추상화

이제 "탭 키 입력"을 하기 위한 최소한의 조건을 만족시킨 것 같다. 아마 과정이 너무 많아서 제법 스트레스를 받았으리라 염려되지만, 우리는 더 읽기 좋고, 가용성 높고, 쓸모 있고 단순한 코드를 만들기 위해 추상화를 해야 한다. 지난 모든 스텝은 이 과정을 위한 준비 작업에 해당한다. 이제 모든 것을 하나에 담고 아름답고 쉬운 함수로 뽑아내보자! ...나만 이렇게 해야 한다고 느끼나.. 워 코드는 아래에 있다.

{% highlight javascript linenos %}
function insertTab(textBox) {
    var caretPosition = getCaretPosition(textBox);
    var preText = textBox.value.substring(0, caretPosition);
    var postText = textBox.value.substring(caretPosition, textBox.value.length);

    textBox.value = preText + "\t" + postText; // input tab key

    setCaretPosition(textBox, caretPosition + 1);
}
{% endhighlight %}

위 코드로 우리는 모든 과정을 하나의 함수에 담을 수 있다. 추상화 덕분에, 이제 탭 키를 원하는 위치에 삽입하는 기능을 단순히 `insertTab()` 함수 호출 한 번을 통해 사용할 수 있다. 이 함수는 이하의 기능을 순서대로 확실히 실행할 것이다:

1. 현재 키보드 커서 위치를 가져온다.
2. 현재 커서 위치서부터 글을 2개로 나눈다.
3. 중간에 탭키를 삽입하고, 하나의 완성된 문장으로 만든다.
4. 마지막 키보드 커서 위치로 돌아간다.

위에서 처음부터 구현했던 모든 함수들을 같은 파일 취이나 자바스크립트 파일 안에 담는다. 1단계만 빼고. `blockKeyEvent()` 는 아직 안으로 가져오지 않았는데, 이유는 "탭 키를 삽입한다"는 동작과는 직접 연관이 있어보이지 않기 때문이다. 둘은 논리적으로 독립적인 동작이므로, 이것을 하나의 함수로 추상화하지 말고, 조만간 처리하기로 한다. 

##### 7. 2번째 추상화, 그리고 동작 조건 달기

이제 `insertTab()`이 만들어졌다. 이것은 즉시 텍스트 가운데에 탭 키를 삽입할 것이다. 하지만 언제 그렇게 해야 하는가? 이것을 정할 필요가 있다. 다행히도 답은 이미 맨 처음부터 정해져있다.  이하의 코드는 `insertTab()`을 "`<textarea>` 안에서 탭 키를 눌렀을 때" 실행시킬 것이다.

{% highlight javascript linenos %}
function enableTab(textBox, keyEvent) {
    if(keyEvent.keyCode == 9) {
        // Put tab key into the current cursor(caret) position.
        insertTab(textBox);
        
        // Block(invalidate) actual tab key input by returning key event handler to false.
        blockKeyEvent(keyEvent);   
    }
}
{% endhighlight %}

`enableTab()`은 두 가지를 안다: `<tedxtares>` 엘리먼트와, 이 엘리먼트 안에서 방금 일어났던 **실제 키 입력 이벤트**다. 각각은 "textBox"와 "keyEvent" 파라미터로 담겨있다.

"if" 조건문의 내용이 의미하는 것은 키입력이 `ASCII` 코드 9번과 일치하는지를 검사하라는 것인데, 이것이 "탭 키"를 의미한다. 이것은 아주 중요한데, html 이벤트 핸들러는 모든 키보드 입력을 잡아내서 반응하기 때문이다. 이 함수는 오로지 탭 키에만 반응하도록 한다. 그것이 if 조건문이 동작하는 방식이다.

다음 `insertTab()` 함수를 통해 탭 키를 삽입하고는, 원래의 탭 키 입력을 `blockKeyEvent()` 함수를 이용해 막아버린다. 선명하게 보이는가?

거의 다 왔다.

##### 8. `enableTab()` 을 키보드 이벤트 때 호출하기



Okay, Let's call the function on the keyboard event handler! This code is the presentation of using keyboard event handler in the `<textarea>` called `onkeydown` event handler, using jQuery.

{% highlight javascript linenos %}
$('textarea').on('keydown', function(event) {
    enableTab(this, event);
} );
{% endhighlight %}

jQuery `.on()` is one of the easiest way to use event handler. The other ways like pure javascript or inline html attribute are shown on the early part of this page.

Now the working code is prepared. Test the code and see how it works.

##### 9. Javascript Object: Making more beautiful code

We ain't done yet. We're gonna use powerful javascript object feature and contain everything in the object. This would be the most exciting moment.

First, Prepare a javascript file named `TabManager.js`. We're making **TabManager object**. the "TabManager.js" file has only one thing. It is TabManager object. The file starts like this:

{% highlight javascript %}
var TabManager = {};
{% endhighlight %}

Then we're going to put repeating, meaningful and useful member variables. What could it be? Sure it's tab key ascii code. People can't really recognize just a digit number 9 actually means a tab key.

{% highlight javascript linenos %}
var TabManager = {
    tabKey: 9
};
{% endhighlight %}

The way to define a javascript object member variable is to write the name, colon and the value. If there are many members, the delimiter is comma.  
What else? Well, maybe we can abstract if condition. `keyEvent.keyCode == 9` doesn't really look intuitive, does it? How about this:

{% highlight javascript linenos %}
var TabManager = {
    tabKey: 9,
    isTabKeyInput: function(keyEvent) {
        return keyEvent.keyCode == this.tabKey; 
    }
};
{% endhighlight %}

The way to define a javascript object member method is to write the name, colon and `function()`. Put parameters in the parenthesis if you need. Then it's followed by braces to implement its function. `this` means the object itself, so `this.tabkey` means the tabkey is the member of this object, and therefore writing `this.` is necessary.

So, how would these members take an effect? Behold the change below:

{% highlight javascript linenos %}
var TabManager = {
    tabKey: 9,
    enableTab : function(textBox, keyEvent) {
        if(this.isTabKeyInput(keyEvent)) {
            this.insertTab(textBox);
            this.blockKeyEvent(keyEvent);   
        }
    },
    isTabKeyInput: function(keyEvent) {
        return keyEvent.keyCode == this.tabKey; 
    }
};
{% endhighlight %}

How do you feel? The `enableTab()` member function looks more beautiful and readable.  
Here I present you the complete `TabManager` object code.

**FINAL CODE!!!**

{% highlight javascript linenos %}
var TabManager = {
    tabKey: 9,
    enableTab : function(textBox, keyEvent) {
        if(this.isTabKeyInput(keyEvent)) {
            this.insertTab(textBox);
            this.blockKeyEvent(keyEvent);
        }
    },
    isTabKeyInput: function(keyEvent) {
        return keyEvent.keyCode == this.tabKey; 
    },
    insertTab : function(textBox) {
        var pos = this.getCaretPosition(textBox);
        var preText = textBox.value.substring(0, pos);
        var postText = textBox.value.substring(pos, textBox.value.length);

        textBox.value = preText + "\t" + postText; // input tab key

        this.setCaretPosition(textBox, pos + 1);
    },
    setCaretPosition : function(item, pos) {
        // Firefox, Chrome, IE9~ Support
        if(item.setSelectionRange) {
            item.focus();
            item.setSelectionRange(pos, pos);
        }
        // ~IE9 Support
        else if (item.createTextRange) {
            var range = item.createTextRange();
            range.collapse(true);
            range.moveEnd('character', pos);
            range.moveStart('character', pos);
            range.select();
        }
    },
    getCaretPosition : function(item) {
        var pos = 0;
        
        // Firefox, Chrome, IE9~ Support
        if(item.selectionStart || item.selectionStart == '0') {
            pos = item.selectionStart;
        }
        // ~IE9 Support (yet, not fully tested)
        else if(document.selection) {
            item.focus();
            var sel = document.selection.createRange();
            sel.moveStart('character', -item.value.length);
            pos = sel.text.length;
        }
        
        return pos;
    },
    blockKeyEvent : function(keyEvent) {
        if(keyEvent.preventDefault) {
            keyEvent.preventDefault();
        }
        else {
            keyEvent.returnValue = false;
        }
    }
};
{% endhighlight %}

That's more like it. The way it works is that you just go like `TabManager.enableTab()`. This is how it looks like in the event handler code, represented by jQuery.

{% highlight javascript linenos %}
$('textarea').on('keydown', function(event) {
    TabManager.enableTab(this, event);
} );
{% endhighlight %}

#### Conclusion

1. Make TabManager.js and copy-paste full javascript object code above into the file.
2. Embed into the html file.
3. call `TabManager.enableTab(this, event)`.

I don't think this is the perfect way to make a tab-key-enabling javascript object, but somehow I believe this has a lot about it. Any comments and corrections for better way of doing this would be welcomed.

End of Document.
