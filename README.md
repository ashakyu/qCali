# qCali
## 1.Project Description <br>

- project : <strong> qCali </strong> 
- 소개   : Spring Scheduler를 활용한 커뮤니티형 웹 사이트 구축 프로젝트 <br>
  - 정시를 기준으로 '공통된 질문'을 출력하고, 해당 날짜에만 글을 작성 할 수 있도록 구현 
- 기간  : 3개월 
- 인원        : 4명

      


### 프로젝트 특징 
 - Spring Scheduler 활용
 - OAuth2.0 을 이용한 로그인 구현 (카카오, 네이버와 같은 sns 간편 로그인 기능 구현)
 - 좋아요와 댓글 등 일부 기능 구현을 위한 비동기 처리


 ## 2.개발 환경 <br>

#### Language  : JAVA, Javascript, HTML5, CSS3
#### Framework : Spring boot, Spring MVC, Spring Scheduler, Spring Security, Spring Mail, MyBatis, Bootstrap, jQuery, Aajx
#### DB        : Oracle (11g)
#### Tool      : STS, GitHub, Git, SQL Developer
  
  <div align="center">
  <img src="https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=Spring&logoColor=white"/> 
  <img src="https://img.shields.io/badge/JAVA-007396?style=for-the-badge&logo=Java&logoColor=white"/>
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=Git&logoColor=white"/>
  <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=GitHub&logoColor=white"/>
  <img src="https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=Oracle&logoColor=white"/>
  <img src="https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=Maven&logoColor=white"/>
  <img src="https://img.shields.io/badge/JQuery-0769ad?style=for-the-badge&logo=JQuery&logoColor=white"/>
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=JavaScript&logoColor=white"/>
  <img src="https://img.shields.io/badge/Bootstrap-7952B3?style=for-the-badge&logo=Bootstrap&logoColor=white"/>
</div>
<hr>

## 3. 구현

###  3-1. Spring Scheduler
    * 매일 자정을 기준으로 웹 사이트 내, '공통의 질문'을 출력할 수 있도록 구현 
        : '공통의 질문'에 대해 회원이 게시글을 남길 수 있도록 구현함. 

###  3-2. 로그인
    *  Spring Security를 활용하여 기본 로그인 기능 
    *  SNS 간편 로그인 기능 구현 (OAuth2.0) 네이버와 카카오 로그인 기능 구현
    *  로그인 예외처리 - 비정상 접근 
         : Interceptor를 사용하여 HandlerInterceptorAdapter 클래스 상송을 통해 비정상 접근에 대한 리다이렉트 처리
    *  기타 추가 기능 
         : 비밀번호 찾기의 경우, Spring mail을 활용하여 본인인증 기능 구현

###  3-3. 게시글
    *  전체 공개 및 나만보기(다이어리) 형태로 글을 작성할 수 있도록 구현
    *  페이징 처리 및 게시글 검색, 정렬 (조회수, 좋아요 수) 기능 처리
    *  게시글 좋아요 | 댓글 기능 구현 
        - 비동기 방식으로 처리하기 위하여 Ajax를 활용하여 구현

<hr>

## 4. 회고

- 배치에 대한 이해가 없는 상태에서 특정 시간마다, 작업이 되도록 하기 위해 방법을 찾아가는 과정에 어려움이 있었다. Spring Scheduler와 크론식, 정규식 등 방법을 찾는 과정에서 팀원 간의 의사소통이 주요하게 작용했던 것 같다. 
- DB 설계 과정에서 RDBMS의 특성을 좀 더 이해하게 된 것 같다. 
- Git 을 통한 협업에서 팀원간의 어려움이 있었다. 협업에 앞서, 좀 더 정확한 git 사용법을 익히고 팀원과 git 사용 규칙을 정해서 사용해야 함을 느꼈다. 

