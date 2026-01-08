# djkeh.github.io를 위한 Copilot 가이드라인

이 저장소는 **So Simple Theme**를 사용하는 Jekyll 기반의 개인 기술 블로그입니다.

## 사이트 아키텍처

- **프레임워크**: Jekyll (GitHub Pages 호환).
- **테마**: 원격 테마 `mmistakes/so-simple-theme`.
- **콘텐츠 구조**:
  - `_posts/articles/`: 기술 소개 포스팅.
  - `_posts/blog/`: 개인적인 생각 및 일기.
  - `_drafts/`: 작성 중인 초안 포스트. 인터넷에 노출되거나 검색되어서는 안됨.
- **데이터**: 사이트 전역 설정 및 메타데이터는 `_data/` 및 `_config.yml`에 위치함.

## 콘텐츠 관리 워크플로우

- **네이밍 규칙**: 한국어 포스트는 `YYYY-MM-DD-title-kor.md`, 영어 포스트는 `YYYY-MM-DD-title.md` 형식을 사용함.
- **Front Matter**:
  ```yaml
  ---
  layout: post
  categories: articles # 또는 blog
  title: "포스트 제목"
  excerpt: "간략한 요약"
  tags: [태그1, 태그2]
  date: YYYY-MM-DD HH:mm:ss
  last_modified_at: YYYY-MM-DD HH:mm:ss
  sitemap: false # 인터넷에 노출할 경우 true
  ---
  ```
- **이미지**: 애셋 관리를 위해 이미지는 `/images/YYYYMMDD_slug/` 경로에 배치함. 참조 시 `/images/...`와 같은 절대 경로를 사용함.

## 콘텐츠 작성 요령

- 한국어 포스트는 기본적으로 한국어로 작성, 영어 포스트는 영어로 작성함.
- 전체적으로 마크다운 문법을 활용하여 작성.
- 글의 기본적인 스타일은 프로젝트 `/_posts/articles` 안에 들어있는 마크다운 문서들을 참고.
  - 서론, 몇 가지 소주제로 정리된 본문, 전체 내용을 정리하는 결론 구조
  - 결론 작성 후, 글 가장 마지막에는 h2 태그(`##`)로 참조(Reference) 링크 항목을 정리함. 링크는 링크 텍스트를 실제 링크와 동일하게 작성.
  - 소주제를 h2 태그(`##`)로 구분하고, 필요에 따라 h3(`###`), h4(`####`) 태그를 사용함.
  - 소주제 h2 태그(`##`) 직전에는 비어있는 줄(개행)을 1개가 아닌 2개 추가할 것.
  - h1 태그(`#`)는 Front Matter에 이미 포함되어 있으므로, 본문에서는 사용하지 않음.

## 개발 명령어

- **로컬 미리보기**: `bundle exec jekyll serve`
- **의존성 설치**: `bundle install`

## 코딩 패턴 및 컨벤션

- **언어**: 대부분의 기술 콘텐츠는 한국어임 (파일명에 `-kor` 접미사 사용).
- **Markdown**: kramdown 호환 Markdown을 사용함.
- **코드 블록**: 구문 강조를 위해 항상 언어를 명시함 (예: ` ```java `).
- **퍼머링크**: `/:categories/:title/` 구조로 설정됨. Front Matter의 제목이 SEO에 영향을 주므로 URL 친화적인 제목을 사용함.

## 주요 파일

- `_config.yml`: 메인 사이트 설정.
- `_data/navigation.yml`: 사이드바/헤더 내비게이션 링크.
- `Gemfile`: Ruby 의존성 및 Jekyll 플러그인.

