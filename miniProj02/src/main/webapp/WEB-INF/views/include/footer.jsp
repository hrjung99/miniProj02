<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
  .footer {
    background-color: #e0f2f1; /* 소주병 초록색의 옅은 버전 */
    padding: 20px 0;
    border-top: 1px solid #b2dfdb; /* 경계선 색상 */
    box-shadow: 0 -4px 6px rgba(0,0,0,0.1); /* 상단 그림자 */
    border-radius: 8px 8px 0 0; /* 상단 모서리 둥글게 */
  }
  .footer-link {
    color: #00695c; /* 연한 소주병 초록색 */
    transition: color 0.2s; /* 색상 변화 효과 */
  }
  .footer-link:hover {
    color: #004d40; /* 호버 시 진한 소주병 초록색 */
    text-decoration: none; /* 밑줄 없애기 */
  }
  .footer-text {
    color: #004d40; /* 텍스트 색상 */
  }
</style>

<div class="container">
  <footer class="footer">
    <ul class="nav justify-content-center pb-3 mb-3">
      <li class="nav-item"><a href="#" class="nav-link px-2 footer-link">홈</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 footer-link">기능</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 footer-link">가격</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 footer-link">자주 묻는 질문</a></li>
      <li class="nav-item"><a href="#" class="nav-link px-2 footer-link">회사 소개</a></li>
    </ul>
    <p class="text-center footer-text">&copy; 2021 KOSA, Inc</p>
  </footer>
</div>
