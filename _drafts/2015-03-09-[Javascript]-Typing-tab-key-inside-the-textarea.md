---
layout: post
categories: articles
title:  "[Javascript] Typing tab key inside the textarea"
excerpt: "and better way to compose a javascript source code of it"
tags: [javascript, tab,  key, input, textarea]
date: 2015-03-09 01:25:23
modified: 2015-03-09 01:25:23
image:
  feature:
  credit:
  creditlink:
share: true
---

In some cases you may want to make a simple text editor using `<textarea>` tag on the web page. If it is a normal text editor, you expect it would work to accept most keyboard inputs or whatever the user would be likely to put in. However, the reality doesn't precisely work like that.

One fair example is **"tab"** key. In the web page tab key works as an html element navigator, which means that if you push tab key button, it moves the focus to the next element. This can be kind of hassle for the text editor and its user, especially programmer. Many programmers use tab key to make indentation to the context or codelet. They basically can't put tab inputs into the `<textarea>`. This is also part of the html document element so if they push a tab key into the textarea, nothing pushs in but instead it makes textarea focused out to the next element.

Here I present you the step-by-step solution for this. Doing this javascript programming you will be able to make your web text editor allow tab keyboard input.

##### 0. The quick answer
For those who are lazy programmers and who just need to hurry, here's my complete answer.

###### i) Save the entire code below to 'tapManager.js' and place it to your decent project subfolder.

{% highlight javascript linenos %}
var TabManager = {
    tabKey : 9, // This number means tab key ascii input.
    enableTab : function(textBox, keyEvent) {
        if(this.isInputTabKey(keyEvent)) {
            // Put tab key into the current cursor(caret) position.
            this.insertTab(textBox);
            
            // Block(invalidate) actual tab key input by returning key event handler to false.
            this.blockKeyEvent(keyEvent);   
        }
    },
    isInputTabKey : function(keyEvent) {
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
        var caretPosition = 0;
        
        // Firefox, Chrome, IE9~ Support
        if(item.selectionStart || item.selectionStart == '0') {
            caretPosition = item.selectionStart;
        }
        // ~IE9 Support (yet, not fully tested)
        else if(document.selection) {
            item.focus();
            var sel = document.selection.createRange();
            sel.moveStart('character', -item.value.length);
            caretPosition = sel.text.length;
        }
        
        return caretPosition;
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

###### ii) Include the javascript file into the end of `<body>` element.

{% highlight html linenos %}
<script type='text/javascript' src='resources/js/TabManager.js'></script>
{% endhighlight %}

##### iii) Use it! The javascript object name is `TabManager`, and the member method name is `enableTab(textBox, keyEvent)`. 

{% highlight jQuery linenos %}
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

If you're enthusiastic programmer and ready to learn something new in detail, here's my step-by-step explanation.

##### 1. Cancelling out the default action
This would sound a little bit weird but, The first step is to cancel out the keyboard input. In this case we're gonna block the tab key so the focus can't move towards the next element. You can achieve this by using `preventDefault()` javascript method. You need keyEvent object to use this method, so the javascript code goes like this:

{% highlight javascript linenos %}
keyEvent.preventDefault();
{% endhighlight %}

But this won't work on every browswer. You have to check whether you can actually use this key event method, so let's use if clause to check this availability.

{% highlight javascript linenos %}
if(keyEvent.preventDefault) {
    keyEvent.preventDefault();
}
else {
    keyEvent.returnValue = false;
}
{% endhighlight %}

In some old browsers they use member variable called `returnValue`. Hence the above code will enhance the browser compatibility.

Let's package this code into the javascript function.

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

End of step 1.

##### 2. Realizing 3+1 shitty matters

tossing tab key input in the middle of the textarea paragraph is pretty much tougher than you expect. You need to understand this 3 facts:

- Browser doesn't know where to put the tab input even if the cursor is blinking right there!
- Browser doesn't know how to insert a single certain word between former and latter sentences.
- Browser doesn't remember where the cursor is supposed be after doing the job.

Moreover what really pisses me off if that:

- Browsers support different methods to solve these issues.

Dumbass.. we have to take care of all these things ourselves. 

##### 3. Getting the keyboard cursor position

Let's get simple. This is the code for relatively new browsers. You have to keep the textarea element to javascript object. In this code it's `textBox`.

{% highlight javascript linenos %}
// Firefox, Chrome, IE9~ Support
if(textBox.selectionStart || textBox.selectionStart == '0') {
    caretPosition = item.selectionStart;
}
{% endhighlight %}

