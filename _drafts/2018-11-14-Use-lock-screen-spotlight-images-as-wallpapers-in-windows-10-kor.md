---
layout: post
categories: articles
title:  "윈도우 10에서 잠금화면 추천(스포트라이트) 이미지를 배경화면으로 사용하는 법"
excerpt: "정식적인 방법은 없지만 다운로드 받은 추천 이미지를 사용할 수 있다"
tags: [microsoft,windows,lockscreen]
date: 2018-06-04 15:27:09
last_modified_at: 2018-06-04 15:27:12
sitemap: false
---

잠금화면에 표시되는 대자연의 고해상도 이미지가 무척 멋집니다. 윈도우 10을 사용하신다면 자연스럽게 접하셨을 텐데요, `개인설정 > 잠금화면` 에서 무엇인지 확인해보면 `Windows 추천`이라고 설정되어 있습니다. 이 기능을 검색하기가 조금 난감하셨을 수도 있을 겁니다. 실은 이 기능을 영문 윈도우에서는 `Spotlight`라는 이름으로 서비스하고 있거든요.

공식적으로 이 이미지를 사용자의 로컬 컴퓨터에 다운로드 받거나 바탕화면 이미지로 지정하는 기능은 없습니다. 하지만, 로컬 컴퓨터에 캐싱된 이미지 파일을 직접 찾아내서라도 바탕화면으로 사용하고자 하는 의지가 있으시다면, 아래 방법을 따라가 보세요.

1. 윈도우 탐색기를 열고 상단의 주소 창에 아래의 경로를 복사 및 붙여넣기하고 `Enter` 키를 누릅니다.
  * `%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets`
2. 해당 경로로 이동하면 있는 파일들이 모두 캐싱된 jpg 이미지입니다. 확장자가 빠져있어서 첫 눈에는 그렇게 보이지 않지만요. 모두 선택한 후 복사하여 복사를 원하는 장소에 붙여넣기합니다.
3. 파일을 복사한 위치의 탐색기 좌측 상단의 메뉴에서 `파일 > 명령 프롬프트 열기`를 클릭합니다.
4. 명령 프롬프트가 실행되면 아래의 명령을 입력하고 `Enter` 키를 누릅니다. 해당 경로의 전체 파일명을 수정하는 명령어이니 실행 직전 다른 영향 받는 파일이 없는지 주의하세요.
  * `ren * *.jpg`
5. 앞서 탐색기에서 선택했던 파일들의 확장자가 변경된 것을 확인하여 원하는 이미지를 사용합니다.

이름을 바꾸는 등의 세부적인 작업을 자신만의 방법으로 하시는 경우에는, 캐시 이미지의 위치만 알면 되겠죠. 이하 경로입니다.

```
%LocalAppData%\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets
```

* [https://answers.microsoft.com/ko-kr/windows/forum/windows_10-desktop/윈도우10/f3394cca-dad7-4d00-ac24-329898fb736d](https://answers.microsoft.com/ko-kr/windows/forum/windows_10-desktop/윈도우10/f3394cca-dad7-4d00-ac24-329898fb736d)
* [https://www.howtogeek.com/247643/how-to-save-windows-10s-lock-screen-spotlight-images-to-your-hard-drive/](https://www.howtogeek.com/247643/how-to-save-windows-10s-lock-screen-spotlight-images-to-your-hard-drive/)
