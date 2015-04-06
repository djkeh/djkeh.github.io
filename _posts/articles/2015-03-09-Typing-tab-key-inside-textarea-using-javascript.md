---
layout: post
categories: articles
title: "Typing tab key inside textarea using javascript"
excerpt: "and speculation of better way to compose a javascript source code"
tags: [javascript, tab,  key, input, textarea]
date: 2015-03-09 01:25:23
modified: 2015-03-09 01:25:23
image:
  feature:
  credit:
  creditlink:
share: true
---

In some cases you may want to make a simple text editor using `<textarea>` tag on the web page. If it is a normal text editor, you expect it would work to accept almost every keyboard inputs or whatever the user would be likely to put in. However, the reality doesn't precisely work like that.

One fair example is **"tab"** key. In the web page tab key works as an html element navigator, which means if you push the tab key button, it moves current element focus to the next element. This can be kind of hassle to the user of certain web based text editor, especially to the programmer. Many programmers use tab key in the text editor to have indentation in the context or in the codelet, but for the reason above they basically can't, as you notice that the `<textarea>` is also a part of html document element. Hence if the user push a tab key into the `<textarea>`, nothing pushs in but instead it makes textarea focused out to the next element.

Here I present you very detailed solution for this using javascript. This has been done with my research and practice, and by doing this you will be able to make your web based text editor allow tab keyboard input.

##### 0. The quick answer
For those who are lazy programmers and who just need to hurry, here's my complete answer.

###### i) Save the entire code below to 'tapManager.js' and place it to your decent project subfolder.

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

###### ii) Include the javascript file into the end of `<body>` element.

{% highlight html %}
<script type='text/javascript' src='resources/js/TabManager.js'></script>
{% endhighlight %}

##### iii) Use it! The javascript object name is "TabManager", and the member method name is "enableTab(textBox, keyEvent)".

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

If you're enthusiastic programmer and ready to learn something new in detail, here's my step-by-step explanation.

##### 1. Cancelling out the default action

This would sound a little bit weird from the beginning but, The first and important idea is to cancel out the keyboard input. In this case we're gonna block just the tab key so the focus can't move towards the next element. You can achieve this by using `preventDefault()` javascript method. You need keyEvent object to use this method, so the javascript code goes like this:

{% highlight javascript %}
keyEvent.preventDefault();
{% endhighlight %}

But this won't work on every browswer. You have to check whether you can actually use this key event method, so let's use `if` clause to check this availability.

{% highlight javascript linenos %}
if(keyEvent.preventDefault) {
    keyEvent.preventDefault();
}
else {
    keyEvent.returnValue = false;
}
{% endhighlight %}

In some old browsers they use member variable called `returnValue`. Therefore the above code will enhance the browser compatibility.

Let's package this code into one javascript function.

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

- *Browser doesn't know where to put the tab key even if the cursor is blinking right there!*
- *Browser doesn't know how to insert a single certain word between former and latter sentences.*
- *Browser doesn't remember where the cursor is supposed be after doing the job.*

Moreover what really pisses me off is that:

- **Browsers support different methods to solve these issues.**

Yikes.. we have to take care of all these things ourselves.  
End of step 2. 

##### 3. Getting the keyboard cursor position

It's time for doing "divide and conquer" strategy. We're getting the current keyboard input cursor position inside `<textarea>` element. Below is the code for relatively new browsers to do the job. We have to keep the `<textarea>` element as a javascript object. In this code its name is "textBox".

{% highlight javascript linenos %}
var caretPosition = 0;

// Firefox, Chrome, IE9~ Support
if(textBox.selectionStart || textBox.selectionStart == '0') {
    caretPosition = textBox.selectionStart;
}
{% endhighlight %}

For older browsers like IE8 or IE9, you can use this code.

{% highlight javascript linenos %}
// ~IE9 Support
if(document.selection) {
    textBox.focus();
    var sel = document.selection.createRange();
    sel.moveStart('character', -textBox.value.length);
    caretPosition = sel.text.length;
}
{% endhighlight %}

By returning `caretPosition`, we'll get the current keyboard cursor position. Let's wrap it into a clean method.

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

End of step 3.

##### 4. Putting in actual tab key

Now we know where to put the tab key. But how? We've got entire content string and the cursor position, but there's no way to put a single character in the middle of a string object. What we're gonna do in this step is to divide a string into two front and back strings. Now you get it? This is the idea.

```
Result = front string + 'tab' + back string
```

So we have to first split the string, put a tab key in the middle of it and then concatenate things together in order.
Here's the implementation.

{% highlight javascript linenos %}
var preText = textBox.value.substring(0, caretPosition);
var postText = textBox.value.substring(caretPosition, textBox.value.length);

textBox.value = preText + "\t" + postText;
{% endhighlight %}

End of step 4.

##### 5. Putting keyboard cursor back to the original position

I guess you'll think "Now, what the hell is this?" at a glance, but you will need this step. What you actually did wasn't like you insert a key input in the middle of the string, instead you made the entire string with a tab key which was put in the middle of it and pasted it into the `<textarea>` element as a value attribute. Think what happens then. You instantly lose your original caret position because it worked like you put a sentence into an empty `<tesxtarea>` element. You'll see cursor is blinking at unexpected position like very front or end of the sentence or wherever. I believe this is out of your intention if you're building a decent text editor. So you have to memorize the original cursor position before inserting a tab key, and then after doing it you have to go back there using your memory.

This is the code for it in the latest browsers.

{% highlight javascript linenos %}
// Firefox, Chrome, IE9~ Support
if(textBox.setSelectionRange) {
    textBox.focus();
    textBox.setSelectionRange(caretPosition, caretPosition);
}
{% endhighlight %}

This is for shitty browsers.

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

Time to wrap them up.

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

##### 6. Abstraction

Seems like we've fulfilled the minimum requirements to do "tab key insertion". I'm afraid you might feel stressed and confused as those were just too much. We want abstraction to make more readable, available, useful and simple code. The every former steps were the preperation for this step. Let's pack it together and make a beautiful and easy function! ...or am I the only one feeling like that? Well.. Please look at this code.

{% highlight javascript linenos %}
function insertTab(textBox) {
    var caretPosition = getCaretPosition(textBox);
    var preText = textBox.value.substring(0, caretPosition);
    var postText = textBox.value.substring(caretPosition, textBox.value.length);

    textBox.value = preText + "\t" + postText; // input tab key

    setCaretPosition(textBox, caretPosition + 1);
}
{% endhighlight %}

In this code we put every step into one function. Thanks to this abstraction, you can put a tab key in a desirable place by simply calling `insertTab()` any time you want. This function will faithfully perform following jobs in order:

1. Get the current keyboard position.
2. Split the text from the current position into 2 front and back texts.
3. Insert a tab key in the middle, Put them altogether in a complete text.
4. Get back to last keyboard position.

Make sure you put every implemented functions from the start to this in a same place or in a same javascript file. Well, except the step 1. We actually didn't bring `blockKeyEvent()` onto the table yet, because we think this action is not directly related to doing "Inserting tab key". Two are logically independent actions, so we're not abstracting it into a function. We're gonna deal with it very soon.

##### 7. Second abstraction, and enabling it in a certain condition

We made `insertTab()`. This will imediately insert a tab key into the text. But when you'd like to do it? We need to define it. Fortunately we already know the answer, which was standing at the very beginning of this article. This code will call `insertTab()` when "we push a tab key inside `<textarea>`". That logic would flow like this:

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

The `enableTab()` knows two things: `<textarea>` element, and **actual keyboard event** which happened at the right moment in this element. This function has them as two parameters "textBox" and "keyEvent".

The "If" condition statement means that the keyboard input was same as the input `ASCII` code number 9, which means "tab key". This is very important, because html event handler will catch every moment of pressing any keyboard input and will react to it. We want this function work only with the tab key. That's how the if statement works.

Then it will insert a tab key using `insertTab()`, and then block the original tab key event using `blockKeyEvent()`. Does it look clear?

Almost done.

##### 8. Calling `enableTab()` on keyboard event

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
