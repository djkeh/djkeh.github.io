---
layout: post
categories: articles
title: "Hangul test : 지킬(Jekyll)로 깃헙 블로그 만들 때"
excerpt: "한글 테스트 + 지킬(Jekyll)로 블로그 만들면서 부딪쳤던 문제들 정리"
tags: [hangul, korean, jekyll, tip, ruby, gem, frontmatter, pygments, numbering, 지킬, 블로그, 정리]
date: 2015-02-09T02:01:11-09:00
modified:
image:
  feature:
share: false
---

이 포스팅은 한글 출력이 잘 되는지를 시험할 겸 이 깃헙 블로그를 만들면서 만났던 문제점을 한글로 정리한다.


#### 1. 루비 gem 패키지 다운로드

윈도우에서 이와 관련해 뭔가 경로를 찾거나 권한 문제로 잘 되지 않는다면  
보안 프로토콜 문제일 가능성이 있으므로 리포지터리 url 을 `http`에서 `https`로 수정해 주어야 한다.  
수정하기 위한 명령어는 다음과 같다.

{% highlight ruby %}
gem source # 현재 gem 명령어가 잡고 있는 리포지터리 url을 보여준다.
gem source -r "https://rubygems.org" # https://rubygems.org url을 삭제한다. 쌍따옴표 생략 가능.
gem source -a http://rubygems.org # http://rubygems.org url을 추가한다.
{% endhighlight %}

이것만으로 충분하지 않은 경우가 있는데, 바로 Gemfile 을 사용하는 경우이다.  
gem 명령어는 `gem install 패키지명` 의 형태로 보통 실행하는데  
Gemfile 이라는 이름의 파일이 있다면 `gem install` 만으로 연속적인 패키지와 디펜던시들을  
미리 설정한대로 설치할 수 있다.  
Gemfile 안에는 별도의 리포지터리 url 이 설정되어있을 수 있으므로  
파일 안을 확인하여 있을 경우 이것도 `https` 를 `http` 로 바꾸어 주어야 한다.

이 정도면 보안이나 권한 문제로 패키지 다운로드를 실패하지는 않을 것이다.


#### 2. markdown 파일 내에서 HTML 태그 사용

가능하다. 별도의 설정 없이 곧바로 자유롭게 태그를 사용하면 된다.  
단 주의할 것은, block-level HTML 엘리먼트는 사용 규칙이 정해져있다.  
block-level element 에 속하는 것은 `<div>, <table>, <pre>, <p>` 등이 있는데,  
이들은 다른 문단과 반드시 한 개의 공백줄로 분리시켜야 한다. 예를 들면 이렇다.  

{% highlight HTML %}
첫번째 문단이다

<table>
    <tr>
        <td>지금 새벽 3시다 잠도 못자고 죽겠다</td>
    </tr>
</table>

두번째 문단이다
{% endhighlight %}


#### 3. 왜 disqus가 jekyll로 만든 포스트에 나타나질 않지?

`localhost:4000` 에서 보고 있지 않는가? 그렇다면 보이지 않는다.  
웹으로 푸시하고 웹에서 봐라. 잘 될 것이다.


#### 4. octopress 라는게 있는 모양인데 잘 되지 않는다

나도 안 된다. 이유는 모르겠다. 포기한 상태다. 아는 분은 댓글좀 굽신굽신


#### 5. Front Matter

`Front Matter` 란 [jekyll](http://jekyllrb.com/) 에서 포스트나 페이지를 관리하는데 사용하기 위해 읽어들이는  
[YAML](http://yaml.org/) 방식의 문서의 헤더 양식이다.  
모든 포스트나 페이지 글 위에 삽입하면 되며 생김새와 각 명령어의 기능은 다음과 같다.

{% highlight YAML %}
---
layout: post // post, page 중 하나를 넣어 이것이 한 페이지에 속하는 블로그 포스트인지, 홈페이지를 구성하는 하나의 큰 페이지인지를 결정한다.
title: "제목" // 포스트나 페이지의 제목을 넣는다.
date: 2015-02-08T20:39:51-09:00 // 생성일로, 양식은 년-월-일T시:분:초-GMT시간 으로 추측된다.
modified: 2015-02-08T22:21:31-09:00 // 변경일
categories: articles // 어느 페이지에 속하는지를 표시한다.
excerpt: "요약문" // 이 페이지에 대한 요약문을 정하는 것 같은데, 정확히 어떤 동작을 보이는지 아직 모르겠다.
tags: [haroopad] // 태그를 지정할 수 있다. 해시태그인지 어떻게 동작하는지는 역시 아직 모른다.
image: // so-simple-theme 에서 글 맨 위에 노출될 큰 사진을 결정할 때 쓴다. 기본 폴더는 images.
  feature: test.jpg // 사진 파일 이름
  credit: Me // 사진 제작자 및 저작권자
  creditlink: me.org // 저작권자의 홈페이지이거나 이 사진을 직접 구할 수 있는 링크
share: true // so-simple-theme 의 사이드바에 공유 버튼이 추가된다.
comments: true // 블로그 포스트 하나하나마다 개별적으로 disqus 댓글 버튼을 추가해줄 수 있다.
---
{% endhighlight %}


#### 6. Jekyll 에서 Pygments 코드 색깔 처리와 줄 번호

[jekyll](http://jekyllrb.com/)은 [pygments](http://pygments.org/)를 이용한 syntax highlighting 을 지원한다.  
md 파일 안에서 다음의 코드를 이용한다.

{% highlight html %}
{% raw %}
{% highlight language %}
소스코드를 여기에 넣는다.
{% endhighlight %}
{% endraw %}
{% endhighlight %}

줄 번호 처리가 안되어서 아쉬웠는데 방법이 있었다. 파라미터로 `linenos`를 삽입하면 줄 번호가 삽입된다.  
`linenos=table` 을 삽입하면, 줄 번호가 `<table>` 태그로 코드에서 분리되어 표시되므로  
코드 복사에도 더 편리하다.

{% highlight html linenos %}
{% raw %}
{% highlight language linenos %}
소스코드를 여기에 넣는다.
{% endhighlight %}
{% endraw %}
{% endhighlight %}

{% highlight html linenos=table %}
{% raw %}
{% highlight language linenos=table %}
소스코드를 여기에 넣는다.
{% endhighlight %}
{% endraw %}
{% endhighlight %}

실험을 해보면 `linenos=li`도 작동한다. 모양은 table과 똑같다.  
하지만 줄 번호와 코드 간격이 너무 넓어서 마음에는 안 든다..

위 소스코드에서 `{$` 는 어떻게 넣었을까? `raw` 와 `endraw` 를 사용한다.

{% highlight html linenos=table %}
{% raw %}
{% highlight language linenos=table %}
{% raww %} // w 하나 뺀다
소스코드를 여기에 넣는다.
{% endraww %} // w 하나 뺀다
{% endhighlight %}
{% endraw %}
{% endhighlight %}


#### 7. [Updated] 더 나은 Pygments 줄 번호 처리법 - thanks to [박현재](http://hyeonjae.github.io/)

[http://demisx.github.io/jekyll/2014/01/13/improve-code-highlighting-in-jekyll.html](http://demisx.github.io/jekyll/2014/01/13/improve-code-highlighting-in-jekyll.html)  
이 사이트를 참고하면 linenos로 출력되는 줄번호를 소스코드 복사에서 제외시키고  
보다 유려한 디자인으로  출력할 수 있다.

결과물:

{% highlight ruby linenos %}
def show
  puts "Printing a very lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong line"
  @widget = Widget(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @widget }
  end
end
{% endhighlight %}

이밖에 여러 컬러 테마를 적용할 수 있지만  
잘 되지 않아서 적용시키지는 않았다.

> 위 포스팅에서 사용한 코드 블럭은 Jykell 2.x 버젼의 `Pygments` 문법으로 표현한 것이다.
> 현재는 Jykell 3.x 로 본 블로그가 버젼업하고, 코드 하일라이팅 방식을 블로그 옵션에서 변경하였다.
> 따라서 위 내용이 제대로 표시되지 않을 수 있다.


#### 8. 2017/06/02 Update: 코드 표현 방식 변화

Jykell이 버젼업하고, `Pygments` 기능을 다른 기능으로 대체함에 따라  
기존의 코드 블럭 표시 방법을 더이상 사용할 수 없게 되었다.  
이제는 평범하게 <code>```</code> 문법을 사용해 코드 블럭을 표시하며,  
줄 번호는 사용할 수 없다.

```ruby
# 예시
def show
  puts "Printing a very lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong lo-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-ong line"
  @widget = Widget(params[:id])
  respond_to do |format|
    format.html # show.html.erb
    format.json { render json: @widget }
  end
end
```
