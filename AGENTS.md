# djkeh.github.io 기술 블로그를 위한 프로젝트 가이드라인

## 1. 프로젝트 개요

이 프로젝트는 백엔드 개발자 김은호의 프로그래밍 기술과 동향에 관한 이야기를 포스팅하는 기술 블로그다.

- Github Pages 호스팅을 이용해 블로그를 웹에 노출한다.
  - Github 저장소 주소: https://github.com/djkeh/djkeh.github.io
  - 기술블로그 사이트 주소: https://djkeh.github.io/
- 주 사용 언어: markdown, yaml, ruby
- 프로젝트 의존성 관리: `/Gemfile`, `/Gemfile.lock`
- 정적 웹사이트 생성 프레임워크: Jekyll
  - 프레임워크 공식 홈페이지: https://jekyllrb.com/
  - 프레임워크 사용 설명을 확인할 수 있는 공식 문서 진입 페이지: https://jekyllrb.com/docs/
- 기본 설정 파일: `/_config.yml`
- 사용 중인 Jekyll 테마: So Simple Jekyll Theme
  - 테마 식별자(`_config.yml`, `Gemfile` 등에서 사용): `jekyll-theme-so-simple`
  - 테마 저장소: https://github.com/mmistakes/so-simple-theme

## 2. 주요 디렉토리 구조

- `/_data`: 블로그 저자, 내비게이션 바 링크, 테마의 언어(locale)별 출력 텍스트 정보
- `/_drafts`: 블로그 포스팅의 초안. 여기 저장한 글은 인터넷(public)에 노출되지 않음
- `/_posts`: 블로그 포스팅
  - `/_posts/articles`: 기술 블로그. 별도의 언급이 없으면 이 글을 작성한다
  - `/_posts/blog`: 개인적인 생각과 일상을 담은 글
- `/about`: `about` 페이지
- `/images`: 블로그 포스팅에 사용할 이미지 자료들

## 3. 콘텐츠 작성 가이드

- 한국어 포스트는 기본적으로 한국어로 작성, 별도로 영어 포스트를 요청할 경우 영어로 작성함
- 문서 작성 언어는 kramdown 호환되는 markdown을 사용 (`*.md`)
- 블로그 포스팅 파일명은 `{YYYY-MM-DD}-{제목}-{언어}.md`와 같은 형식을 준수할 것
  - `YYYY-MM-DD`: 파일을 작성한 날짜를 `YYYY-MM-DD` 형식으로 작성할 것
  - `{제목}`: 영문, 소문자 kebab case로 작성하되 첫 번째 단어의 첫 글자와 고유명사 및 줄임말만 대문자를 사용하여, 인터넷 브라우저에서 사람이 읽고 접속하기 용이한 제목을 최대 72자가 넘지 않도록 작성할 것
  - `{언어}`: 블로그 포스팅은 기본적으로 한국어로 작성하므로, `kor`로 작성할 것. 별도 요청이 있을 경우 해당 요청에 맞는 언어로 작성 (예: 영어로 써달라고 요청할 경우, `eng`)
  - 파일명 예시: `2026-03-01-This-is-AI-written-title-kor.md`
- 글의 기본적인 스타일은 `/_posts/articles` 안에 들어있는 기존의 블로그 포스팅들을 참고
  - 서론, 몇 가지 소주제로 정리된 본문, 전체 내용을 정리하는 결론 구조
  - 결론 작성 후, 글 가장 마지막에는 h2 태그(`##`)로 `Reference`를 제목으로 쓰는 참조 영역을 만들고, 글을 작성하는데 참고했거나, 읽는 사람이 글을 이해하는데 도움을 줄 수 있는 웹사이트 참고 문서의 링크들을 목록으로 정리함. 링크는 링크 텍스트를 실제 링크와 동일하게 작성
  - 글의 타겟 독자는 한국의 20~50대 개발자 및 기술자로 설정하고, 한 눈에 이해하기 쉽게 잘 요약 정리하면서 블로그 주인 Uno 특유의 문체와 스타일로 작성할 것
  - 글의 이해를 돕기 위한 참고 이미지를 적극적으로 활용하며, 직접 생성하거나 인터넷에서 검색하여 붙여 넣을 것. 어려울 경우에는, 이미지를 넣기 적절한 곳에 예시로라도 이미지 문법을 작성하여 나에게 가이드할 것
    - 이미지 저장 위치(디텍토리): `/images/{YYYYMMDD}_{title}`
      - `{YYYYMMDD}`: 블로그 포스팅 파일 작성일자와 동일한 일자를 `yyyyMMdd` 포맷으로 작성
      - `{title}`: 블로그 포스팅 제목과 잘 어울리게 매우 짧게 요약한 제목을 2단어 내외의 영문 snake case로 작성
      - 이미지 디렉토리명 예시: `/images/20260301_ai_sample`
    - 이미지 태그 문법 예시: `![AI 생성 이미지 샘플](/images/20260301_ai_sample/ai-sample-1.png)`
    - 이미지 태그를 가이드할 경우 예시: `![여기에 AI 생성 이미지 샘플을 넣어주세요](/images/???/???.png)`
  - h1 태그(`#`)는 사용하지 않음. 본문에서 최상위 헤딩(heading) 태그는 h2(`##`)임
  - 소주제를 h2 태그(`##`)로 구분하고, 필요에 따라 h3(`###`), h4(`####`) 태그를 계층적으로 사용함
  - 코드 블록: 내용이 평문(plain text)이 아닌 경우에는 항상 코드 블록 안에서 사용한 프로그래밍 언어를 명시함 (예: ````java`).
- 퍼머링크(permalink): `/:categories/:title/` 구조로 설정됨. Front Matter의 제목이 SEO에 영향을 주므로, URL 친화적인(kebab case) 제목을 사용할 것

### 블로그 포스팅 마크다운 파일의 헤딩(heading)으로 사용할 Front Matter 형식

모든 블로그 포스팅은 마크다운(`*.md`) 형식으로 작성하며, 문서의 맨 위에 아래와 같은 Front Matter를 포함한다.

```yaml
---
layout: post
categories: articles # 개인 일상일 경우, blog
title: "블로그 포스팅 제목"
excerpt: "블로그 포스팅 내용을 요약한 한 줄 설명" # `~다` 대신 `~기`로 종결, 조사(~을/~를) 생략 등 간결한 문체로 30자 내외로 요약
tags: [태그1, 태그2] # 이 포스팅을 가장 잘 설명하는 영문 소문자 키워드를 최대 3개까지 뽑아서 사용
date: YYYY-MM-DD HH:mm:ss # 글 작성 현재 일시 (UTC) 기준으로 시, 분, 초까지 정확하게 작성
last_modified_at: YYYY-MM-DD HH:mm:ss # 첫 작성은 위 `date`와 동일, 수정일 경우 수정 현재 일시 (UTC)
sitemap: false # 인터넷에 노출할 경우 true
---
```

## 4. 개발 명령어

- 로컬 미리보기: `bundle exec jekyll serve`
- 의존성 설치: `bundle install`
