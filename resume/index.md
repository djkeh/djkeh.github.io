---
layout: page
title: Eunho Kim
excerpt: "Uno's Resume"
search_omit: true
share: false
sitemap: false
---

# Basic info.

Eunho Kim (김은호)  
Server Programmer (Java, Spring)  
Gangnam-gu, Seoul, Republic of Korea  
+82-10-2778-5309  
[djkehh@gmail.com](mailto:djkehh@gmail.com)


# Education

### Graduate, Soongsil University, Seoul, South Korea *(Feb 2014 – Mar 2005)*

* A Bachelor Degree in Telecommunications & Electronic Engineering (GPA: 3.3/4.5)
* Relevant Courses
  * C/C++
  * Data Structure
  * Algorithm
  * OS
  * Embedded Programming
  * Data Communication
  * Computer Network


# Work Experience

## NHN Entertainment, Gyeonggi-do, South Korea *(Now – Jan 2015)*

### Server Programmer

#### TOAST Meetup *(Now - Apr 2017)*

* Used techniques: Java(Spring Boot), HTML/CSS/Javascript, MySQL, Git(GitHub)
* Project description: TOAST Meetup is the technical blog run by NHN Entertainment. Its goal is to share valuable information and programming trends to the public and thereby drag other programmers' attention to the brand TOAST and relevant products. NHN Entertainment is thinking of developing a brand new version of TOAST Meetup from the inside, which I simply call "V2(Version 2)" for now, to improve the service quality and reduce its operation cost. This is currently ongoing project.
* Product page: [http://meetup.toast.com](http://meetup.toast.com)
* Achievements
  * Analyzing current TOAST Meetup service to find out what the problem is and what should be corrected to enhance work efficiency
  * Conducting V2 project from service planning to the development only with design and markup support
  * Managing blog operations such as contacting the author, revising articles and publishing to the blog

#### Unsudowon, Friend Recommendation Event *(Mar 2017 - Jan 2017)*

* Used techniques: Java(Spring), HTML/CSS/Javascript, Shell Script, Python, MySQL, Git(GitHub)
* Project description: Unsudowon is mobile app which offers a variety of fortune telling servicess based on machine learning technology and over 1500 sample images of human faces and palms. Unsudowon mainly consists of 3 parts: Tensor Flow core engine, web application server and mobile app. This project is about holding the New Year holiday event to have new Payco users, as Unsudowon uses Payco account and OAuth login system for operating member service.
* Product page
  * Android: [https://play.google.com/store/apps/details?id=com.nhnent.unse](https://play.google.com/store/apps/details?id=com.nhnent.unse)
  * iPhone: [https://itunes.apple.com/app/id1177304977](https://itunes.apple.com/app/id1177304977)
* Achivements
  * Designed the event purpose data model
  * Developed REST API for the event, interlocking logic between the service and the external Payco member API, the entire front page, and the script that draws the event winners and matches user delivery information 
  * Completed the project in time with cooperation of 2 programmers despite given 8 business days of very tight schedule

#### TOAST Cloud Health Dashboard *(Nov 2016 - Dec 2017)*

* Used techniques: Java(Spring), HTML/CSS/Javascript, MySQL, Git(GitHub)
* Project description: TOAST Cloud Health Dashboard is the web service which shows the availability of the entire services of TOAST Cloud and related products in real time. [Amazon AWS Service Health Dashboard](http://status.aws.amazon.com) is one of good comparison to this service. The main purpose of this project is to monitor every TOAST Cloud service availability in real time, provide it to the customer and most of all, respond to the unexpected service failure instantly. The core service and API has been prepared in former step, so the main purpose of this project is to present it on the TOAST Cloud website.
* Product page(Korean): [https://cloud.toast.com/dashboard](https://cloud.toast.com/dashboard)
* Achivements
  * Analyzed other dashboard services from major competitors leading the market such as Amazon, and composed summarized feature list from every detailed aspects from them for the report
  * Conducted entire project from service planning to the development only with design and markup support

#### Spell Checker API *(Jul 2016 - Jan 2016)*

* Used techniques: C/C++(Apache module), Java(Spring), HTML/CSS/Javascript, Git(GitHub), Markdown(Confluence Wiki, Github)
* Project description: Spell Checker API is a [TOAST Cloud](https://cloud.toast.com) product designed in RESTful web API. This API takes certain Korean paragraph which is expected to have typos and returns back the corrected paragraph as the result. The spell checker engine was present but was made of unsustainable old legacy code written in C programming language. The main objective of this project is to analyze, debug, refine the engine code and move it to Apache module program using C++ to build more convenient and sustainable web API. The product presentation page is made of Java, Spring.
* Product description page(Korean): [https://cloud.toast.com/service/spellchecker](https://cloud.toast.com/service/spellchecker)
* User manual(Korean): [http://docs.cloud.toast.com/ko/Upcoming%20Products/Spell%20Checker/ko/Overview](http://docs.cloud.toast.com/ko/Upcoming%20Products/Spell%20Checker/ko/Overview)
* Achivements
  * Analyzed old legacy errata correction engine code written in C programming language and performed code refactoring
  * Increased the engine performance and code readability by correcting critical bugs, adjusting internal cache algorithm and removing vague explanations in header files
  * Designed API server, TOAST Cloud product web page and program architecture on basis of the old legacy engine codes
  * Developed API server using apache module programming, and product service page using Java, Spring
  * Acknowledged in refactoring project source codes and organizing documentation
  * Documented service description, manual, very detailed and well structered operating guide for internal service operators and developers in markdown language

#### PAYCO Data Analysis *(Jan 2016 - Oct 2015)*

* Used techniques: Java(Hadoop MR, Streaming), HTML/CSS/Javascript, Python, Shell Script, Git(GitHub)
* Project description: The goal of this project is to collect and analyze [Payco](https://play.google.com/store/apps/details?id=com.nhnent.payapp) user payment log and product search query log to gain valuable information and provide personalized ads to the customer.
* Achivements
  * Utilized Hadoop cluster system and developed MR programs to analyze about 6 months of payment logs from millions of users
  * Developed a webpage to report summerized and visualized data

#### Address Search API *(Jul 2016 - Apr 2015)*

* Used techniques: C++, Java(Spring Boot), HTML/CSS/Javascript, Python, Shell Script, Git(GitHub), Markdown(Confluence Wiki, Github)
* Project description: Address Search API is a [TOAST Cloud](https://cloud.toast.com) product which provides unified address search experience. South Korea currently has 2 different local address systems, one of which is old, deprecated but still present. Most competitors provide the service to search two addresses separately, which means the user can't search old address in new address search input box and vice versa, even two addresses mean same location. It also means it needs to be sure for users to know which kind of address it is before searching. This product has single search input to query two types of addresses without care. The address search engine distinguishes address query and gives the search result. The Address Search API is designed in RESTful way, Richardson Maturity Level 2.
* Product description page(Korean): [https://cloud.toast.com/service/addresssearch](https://cloud.toast.com/service/addresssearch)
* User manual(Korean): [http://docs.cloud.toast.com/ko/Common/Address%20Search/ko/Overview](http://docs.cloud.toast.com/ko/Common/Address%20Search/ko/Overview)
* Service architecture
  * A batch script server to download address information periodically from the government agency server (Python)
  * A script to dump collection data from downloaded address information (Python, Shell Script)
  * Search engine (C++, Apache)
  * Address Search API server (Java, Tomcat)
  * TOAST Cloud Console front-end
* Achivements
  * Designed API server and program architecture applying MVC web application design pattern
  * Developed and maintained API web application, batch scripts and web front-end pages
  * Performed code refactoring to the legacy Java codes that are written in combination of relatively old C programming style and unorganized file hierarchy, based on MVC design pattern
  * Documented service description, manual, very detailed and well structered operating guide for internal service operators and developers in markdown language


# Internship Experience & Etc.

## BC Card, Seoul, South Korea *(Aug 2014 – June 2014)*

### Intern

* Developed test modules (C++, Pro*C, Oracle)
* Performed test QA more than 200 subprograms containing SQL transactions

## NAVER Intern, Gyeonggi-do, South Korea *(Jan 2014 – Sep 2013)*

### Natural Language Processing Team IT Assistant

* Developed spell check resource management system (HTML, PHP, Javascript, MySQL)
* Directed editing technical document about overall functions and usage of the system
* Demonstrated complete system in front of the team

## NAVER Software Membership, Seoul, South Korea *(Aug 2013 – Feb 2013)*

### Project K3 – Web Based Music Composition Program

* Developed real-time music composition program based on Web Audio API
* Assumed composition module development part
* Demo(Korean): [http://youtu.be/dcpifU3yHms](http://youtu.be/dcpifU3yHms)

## Concept One Accessories Intern, New York, United States *(Feb 2011 – Jul 2010)*

### MIS/Operations department IT Assistant

* Managed various kind of documents, reports and Excel spreadsheets
* Automated producing reports and conducting tasks using VBA script language
* Performed various kind of IT support

## Private Tutor, Cram School, Seoul, South Korea *(Dec 2007 – Dec 2006)*

* Taught English to middle/high school students


# Skills

* Programming languages
  * C/C++
  * Java
  * Linux Shell Script
  * Python
  * HTML5/CSS3/Javascript
  * PHP
* Frameworks
  * Spring
* Databases
  * MySQL
  * Oracle
  * MariaDB
  * Cubrid
* Tools & Editors
  * Eclipse
  * Notepad++
  * Sublime Text
  * Vim
* Version control
  * Git
* Certificates
  * Engineer Information Processing, Human Resources Development Service of Korea, 2013-12-13


# Languages

* Korean, native
* English, fluent
  * TOEIC: 855, 2013-05-25
  * OPIc: IH, 2012-09-22


# Extracurricular Activity

## Korean Translation, Atlassian Bitbeaker *(Now - Nov 2016)*

* Bitbeaker: Android client for Atlassian Bitbucket
* Proposed Korean Translation on Nov.
* Initiated Translation on Feb.
* Released Alpha version on Mar.
* Committed first polished revision on Apr.
* Expecting to publish release version on milestone v3.3
* Issue: [https://bitbucket.org/bitbeaker-dev-team/bitbeaker/issues/366/korean-translation](https://bitbucket.org/bitbeaker-dev-team/bitbeaker/issues/366/korean-translation)
* Translation: [https://crowdin.com/project/bitbeaker/ko#](https://crowdin.com/project/bitbeaker/ko#)

## Hackathon, Opencamp, Zeropage of Chung-Ang University *(Apr 2014)*

* Won 1st place out of 12 teams for making an Android app 
* Project: Harmony, dynamic volume controller based on the street noise
* Role: Project Leader
* Detail
  * Performed project idea presentation to public
  * Selected 3 members(2 app programmers, 1 designer)
  * Directed entire work and distributed roles to members
  * Programmed core algorithm: dynamic volume controller using low-pass filter

## Club Festival Exhibition, SoongSil Computer Club of Soongsil University *(Sep 2011 - Sep 2005)*

* Directed various C programming project exhibitions 3 times


# Interest

* Playing piano
* Sports and exercises like workout, crossfit, badminton and sport climbing
* Reading, scrapping and sometimes writing technical articles from tech blogs such as [TOAST Meetup](http://meetup.toast.com), [Kakao Tech Blog](http://tech.kakao.com), [Naver D2 Hello World](http://d2.naver.com/helloworld), including personal tech blogs like [Outsider's Dev Story](https://blog.outsider.ne.kr).


# Etc.

* Military service: army, honorable discharge
