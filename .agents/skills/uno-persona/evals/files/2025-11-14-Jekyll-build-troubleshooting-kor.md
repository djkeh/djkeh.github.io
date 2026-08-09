---
layout: post
categories: articles
title: "Jekyll Build Troubleshooting Notes"
excerpt: "Jekyll 빌드 문제를 차근차근 확인하기"
tags: [jekyll, ruby, troubleshooting]
date: 2025-11-14 02:30:00
last_modified_at: 2025-11-14 02:30:00
sitemap: true
---

블로그를 수정하고 배포했는데 빌드가 실패하면 로그를 봐야 합니다. 로그가 길기 때문에 어려울 수 있습니다. 이 글에서는 순서대로 확인할 내용을 정리합니다.

## 빌드 환경부터 확인하기

[Jekyll](https://jekyllrb.com/) 프로젝트는 Ruby와 gem 버전의 영향을 받습니다. 로컬과 배포 환경의 버전을 먼저 비교합니다. `Gemfile.lock`을 같이 확인하면 사용한 의존성 버전을 알 수 있습니다.

![Jekyll 빌드 로그 확인 화면](/images/20251114_jekyll_build/build-log.png)

## 같은 명령으로 재현하기

배포 환경에서 실행하는 명령을 로컬에서도 실행합니다.

```bash
bundle exec jekyll build
```

오류가 재현되면 로그에서 처음 나타난 오류를 찾습니다. 뒤에 나오는 오류는 앞의 오류 때문에 생겼을 수도 있습니다.

## 정리

Ruby 버전, 잠긴 gem 버전, 첫 오류를 차례로 확인하면 원인의 범위를 줄일 수 있습니다.

## Reference

* [https://jekyllrb.com/docs/](https://jekyllrb.com/docs/)
* [https://jekyllrb.com/docs/troubleshooting/](https://jekyllrb.com/docs/troubleshooting/)
