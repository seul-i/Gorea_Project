<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- 1. 폰트어썸 CDN / 2. jQuery -->
    <script
      src="https://kit.fontawesome.com/52f65b6106.js"
      crossorigin="anonymous"
    ></script>
    <script src="//code.jquery.com/jquery-1.12.4.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/header/header.css" />

    <script type="text/javascript">
      window.onload = function () {
        document.querySelector(".searchBtn").onclick = function () {
          var searchInput = document.tsfrm.querySelector(".search");

          if (!searchInput || searchInput.value.trim() === "") {
            alert("검색어를 입력 하셔야 합니다.");
            return;
          }
          document.tsfrm.submit();
        };
      };
    </script>
  </head>
  <body>
    <c:set
      var="role"
      value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.go_user_role}"
    />
    <c:set
      var="nickname"
      value="${SPRING_SECURITY_CONTEXT.authentication.principal.gorea_UserTO.go_user_nickname}"
    />

    <div class="header-nav">
      <div class="nav1">
        <div class="logo">
          <a href="/korean/main.do"></a>
        </div>

        <div class="info-div">
          <form
            action="korean/total_search.do"
            method="post"
            name="tsfrm"
            style="margin: 0px"
          >
            <ul>
              <li class="search-box">
                <input
                  type="text"
                  class="search"
                  required
                  placeholder="Search"
                />
                <span class="search-boxSpan"></span>
              </li>
              <li class="search-button">
                <a class="searchBtn"
                  ><i
                    class="fa-solid fa-magnifying-glass"
                    style="font-size: 22px"
                  ></i
                ></a>
              </li>

              <li class="weather">
                <a href="#"><img src="/img/header/sunny.png" alt="" /></a>
              </li>
              <li>
                <select
                  name="languages"
                  id="lang"
                  onchange="location.href=this.value"
                >
                  <option value="#">한국어</option>
                  <option value="/english/main.do">영어</option>
                  <option value="/japanese/main.do">일본어</option>
                  <option value="/chinese/main.do">중국어</option>
                </select>
              </li>
              <li>
                <c:if test="${empty SPRING_SECURITY_CONTEXT}">
                  <a href="/korean/login.do">Login</a>
                </c:if>

                <c:if test="${not empty SPRING_SECURITY_CONTEXT}">
                  <c:choose>
                    <c:when test="${role eq 'ROLE_USER'}">
                      <div class="dropdown">
                        <a
                          href="#"
                          class="mypage-toggle"
                          data-nickname="${nickname}"
                          >${nickname}</a
                        >
                        <div class="dropdown-options">
                          <a href="/user/korean/mypage.do">마이 페이지</a>
                          <a href="/logout.do" class="logout">로그아웃</a>
                        </div>
                      </div>
                    </c:when>
                    <c:when test="${role eq 'ROLE_ADMIN'}">
                      <div class="dropdown">
                        <a
                          href="#"
                          class="mypage-toggle"
                          data-nickname="${role }"
                          >ADMIN</a
                        >
                        <div class="dropdown-options">
                          <a href="/admin/adminpage.do">관리자 페이지</a>
                          <a href="/logout.do" class="logout">로그아웃</a>
                        </div>
                      </div>
                    </c:when>
                    <c:otherwise>
                      <!-- 다른 역할에 해당하는 경우 -->
                    </c:otherwise>
                  </c:choose>
                </c:if>
              </li>

              <li class="navbar_toggleBtn">
                <div class="menuBtn">
                  <div class="line1"></div>
                  <div class="line2"></div>
                  <div class="line3"></div>
                </div>
              </li>
            </ul>
          </form>
        </div>
      </div>

      <div class="nav2">
        <ul class="nav-list">
          <li>
            <a href="#">우리들의 서울</a>
            <ul class="dropdown-list">
              <li><a href="#">Best TOP5</a></li>
              <li><a href="#">여행자 추천</a></li>
              <li><a href="#">자유게시판</a></li>
            </ul>
          </li>

          <li>
            <a href="#">에디터 추천</a>
            <ul class="dropdown-list">
              <li><a href="/korean/editRecommend_list.do">에디터 추천장소</a></li>
              <li><a href="#">에디터 추천꿀팁</a></li>
            </ul>
          </li>

          <li><a href="/korean/trend_seoul.do">트렌드 서울</a></li>

          <li>
            <a href="#">여행 정보</a>
            <ul class="dropdown-list">
              <li><a href="#">날씨 정보</a></li>
              <li><a href="#">교통 정보</a></li>
              <li><a href="#">환율 정보</a></li>
              <li><a href="#">방역 정보</a></li>
            </ul>
          </li>

          <li>
            <a href="#">여행자 지원</a>
            <ul class="dropdown-list">
              <li><a href="#">사이트 소개</a></li>
              <li><a href="#">문의하기</a></li>
              <li><a href="#">공지사항</a></li>
            </ul>
          </li>
        </ul>
      </div>

      <ul class="nav-links">
        <li>
          <input
            type="text"
            placeholder="Search"
            style="height: 25px; width: 300px"
          />
          <i class="fa-solid fa-magnifying-glass" style="font-size: 20px"></i>
        </li>
        <li><a href="#">우리들의 서울</a></li>
        <li><a href="#">에디터 추천</a></li>
        <li><a href="#">트렌드 서울</a></li>
        <li><a href="#">여행 정보</a></li>
        <li><a href="#">여행자 지원</a></li>
      </ul>
    </div>
    <script type="text/javascript" src="/js/header/header.js"></script>
  </body>
</html>
