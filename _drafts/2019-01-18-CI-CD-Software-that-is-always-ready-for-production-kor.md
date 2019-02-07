---
layout: post
categories: articles
title:  "CI/CD: 항상 제품화 준비가 되어있는 소프트웨어"
excerpt: "Pivotal 공식 사이트 번역"
tags: [pivotal,software,integration]
date: 2019-01-18 15:06:08
last_modified_at: 2019-01-18 15:06:08
sitemap: false
---

The ability to respond to user feedback and ship new application code to production quickly and safely are hallmarks of successful cloud-native enterprises. Continuous Integration (CI) and Continuous Delivery (CD) play an important role in this process, allowing teams to dramatically speed up the process of testing new application code and readying it for production deployment. But to get the most value from CI/CD, teams must be ready to shed some old ways of doing things and adopt new development methods.


## What is CI/CD?

CI/CD contains two separate but complementary parts.

Continuous Integration is the process of automatically testing and building software after new bits of application code are integrated into a shared repository. This yields “builds” of the application that are in a working state at all times. Unit tests are included as part of the continuous integration process, thereby validating the functionality of the software. This identifies bugs up-front, and prevents wasted cycles further down the feedback loop.

Continuous Delivery is the process of delivering applications created in the CI process to a production-like environment, where it is put through additional automated tests to ensure the application functions as expected when pushed to production environments and put in the hands of real users. It also ensures the latest build interacts with other software and applications as intended. Successful CD means builds are always ready to deploy to production, either via automation (a related process called Continuous Deployment) or a manual process like cf push.


## Why CI/CD Matters

### Deploy software on-demand based on business requirements

Teams that practice CI/CD can release new application code to production in minutes, when it makes the most business sense to do so rather than based on predetermined release windows.

### Reduce the risk of software not functioning properly in production

With CI/CD, code is put through rigorous automated testing before it can be shipped, significantly reducing the risk of introducing bugs or broken code to production environments.

### Make rapid iteration based on customer feedback a reality

CI/CD compliments Agile methodology and DevOps by providing the functionality required to put continuous learning from users into practice, allowing teams to iterate and ship software in small, rapid batches.

### Recover faster when failures do occur

In the rare instances when failures do occur in production, CI/CD enables teams to reduce their mean time to recovery (MTTR) by quickly pinpointing bad code and pushing fixes to production to minimize the impact on end-users.

### The Big Differences: CI/CD Versus Traditional Development

| CI/CD | TRADITIONAL DEVELOPMENT |
|---|---|
| Software is developed iteratively in small chunks based on frequent user feedback. | Software is developed in large, complex units with less timely user feedback. |
| Tests are written during and applied throughout the development process to ensure quality application code. | Software is thrown over the wall to a QA team for testing after the development process is completed. |
| Security patches and bug fixes are quickly deployed via automation. | Security patches and bug fixes are delivered in bulk at irregular intervals, or immediately through manual exception processes. |
| New application code is frequently integrated with existing code base and tested in real-world scenarios to ensure software is always ready to deploy to production. | New code is integrating with existing software infrequently, usually just prior to deployment, which occurs only in predetermined release windows. |


## Considering CI/CD? What to Keep in Mind

CI/CD helps teams ship high quality software and applications faster, but it does require teams to make changes to their development workflow and adopt new best practices. If you are considering adopting CI/CD, consider the following first:

### Break down siloed teams

With CI/CD, there’s no more throwing application code over the wall to QA, as testing becomes part of the development process, aka DevOps. Rather than relying on a separate group of engineers to test new code, the responsibility falls to development teams. This is requires silo walls be broken down, with QA engineers joining developers, designers and project managers on balanced development teams.

### Developers must commit to writing a lot more tests

As a result, development teams must commit to writing a lot more tests, such as unit tests and end-to-end tests to simulate user flows throughout the application, in order to achieve success. This may result in longer development periods, but the upfront investment in testing gives you confidence in your build automation.

### Teams must introduce new tools and automation

While success of CI/CD depends heavily on organizational and process change, there is also a tools and technology element. Teams must agree on and adopt new tools in order to develop, implement and monitor automated CI/CD pipelines and tests. This means incorporating new testing frameworks like JUnit, modern source code repositories, artifact repositories, and continuous delivery tools like Concourse.

### Legacy approval processes must be rethought.

In traditional environments, getting new software to production may require successfully navigating one or more manual approval processes. For example, some enterprises require new software to get a thumbs up from a change advisory board, which can add days to the process of readying software for production. Enterprises need to reevaluate these manual approval processes, which can lead to bottlenecks, and replace them with automated processes consistent with CI/CD.


## Reference

* [https://pivotal.io/cicd](https://pivotal.io/cicd)
