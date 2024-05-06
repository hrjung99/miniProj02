<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>로그인</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<meta name="_csrf_parameter" content="${_csrf.parameterName}"/>
<link rel="stylesheet" href="/css/style.css"> <!-- 별도의 CSS 파일로 스타일 정의 -->

<jsp:include page="/WEB-INF/views/include/css.jsp" />
<jsp:include page="/WEB-INF/views/include/js.jsp"/>

<style type="text/css">
    body {
        background-color: #9bbbae; /* 소주병의 연한 초록색 */
    }
    h1 {
        color: #2e5339; /* 소주병의 진한 초록색 */
        text-align: center;
    }
    form {
        text-align: center;
        margin-top: 50px;
    }
    input[type="text"], input[type="password"] {
        width: 80%;
        max-width: 300px;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    input[type="submit"] {
        padding: 10px 20px;
        border-radius: 5px;
        border: none;
        color: white;
        background-color: #2e5339; /* 소주병의 진한 초록색 */
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #1d3927; /* 더 진한 초록색 */
    }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />

<!-- 로그인시 오류 메시지 출력 -->
<h1>로그인</h1>
<form action="/login" method="post">
    <%-- csrf 토큰 설정 --%>
    <sec:csrfInput/>
    아이디 : <input type="text" name="mid"/><br/>
    비밀번호 : <input type="password" name="mpass"/><br/>
    <input type="submit" value="로그인">
</form>

<script>
    var msg = "${error ? exception : ''}";
    if (msg !== "")  {
        alert(msg);
    }
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
