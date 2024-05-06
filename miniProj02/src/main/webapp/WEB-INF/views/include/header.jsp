<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
  .navbar {
    background-color: #00695c; /* 진한 소주병 초록색 */
  }
  .nav-link {
    color: #f0f0f0; /* 연한 글자색 */
    transition: color 0.3s ease-in-out;
  }
  .nav-link:hover, .nav-link:focus {
    color: #ffffff; /* 호버시 글자색 */
    background-color: #004d40; /* 더 진한 소주병 초록색 */
  }
  .navbar-brand {
    color: #ffffff; /* 로고 글자색 */
    font-size: 1.25rem; /* 로고 크기 */
    transition: color 0.3s ease-in-out;
  }
  .navbar-brand:hover {
    color: #b2dfdb; /* 호버시 로고 글자색 변경 */
  }
</style>

<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container">
    <a class="navbar-brand" href="<c:url value='/'/>">KOSA</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item active">
          <a class="nav-link" href="<c:url value='/'/>">회사소개</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<c:url value='/board/list'/>">게시물</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<c:url value='/member/list'/>">회원관리</a>
        </li>
        <c:choose>
          <c:when test="${empty loginVO}">
            <li class="nav-item">
              <a class="nav-link" href="<c:url value='/login/loginForm'/>">로그인</a>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                ${loginVO.mname}
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                <a class="dropdown-item" href="<c:url value='/member/view'/>">나의정보</a>
                <a class="dropdown-item" href="<c:url value='/member/logout'/>">로그아웃</a>
              </div>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>
