<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>

<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <jsp:include page="/WEB-INF/views/include/css.jsp" />
	<jsp:include page="/WEB-INF/views/include/js.jsp"/>

</head>

    <jsp:include page="/WEB-INF/views/include/header.jsp" />

<body>

<form id="searchForm" action="list" method="post" >
        <select id="size" name="size" >
        	<c:forEach var="size" items="${sizes}">
        		<option value="${size.codeid}" ${pageRequestVO.size == size.codeid ? 'selected' : ''} >${size.name}</option>
        	</c:forEach>
        </select>
    	<label>제목</label>
    	<input type="text" id="searchKey" name="searchKey" value="${param.searchKey}">
    	<input type="submit" value="검색">
    </form>
    
    <table border="1">
        <tr>
            <th>아이디</th>
            <th>이름</th>
            <th>나이</th>
            <th>성별</th>
            <th>연락처</th>
            <th>권한</th>
            <th>잠금 여부</th>
        </tr>
        <c:forEach var="member" items="${pageResponseVO.list}">
        <tr>
            <td style="cursor:pointer;"><a href="/member/view?mid=${member.mid}">${member.mid}</a></td>
            <td>${member.mname}</td>
            <td>${member.mage}</td>
            <td>${member.mgender}</td>
            <td>${member.mpno}</td>
            <td>${member.member_roles}</td>
            <td>${member.member_account_locked}</td>
        </tr>
        </c:forEach>
    </table>
    
    <button id="goInsert">게시물 등록</button>
    <!--  페이지 네비게이션 바 출력  -->
    <div class="float-end">
        <ul class="pagination flex-wrap">
            <c:if test="${pageResponseVO.prev}">
                <li class="page-item">
                    <a class="page-link" data-num="${pageResponseVO.start -1}">이전</a>
                </li>
            </c:if>

            <c:forEach begin="${pageResponseVO.start}" end="${pageResponseVO.end}" var="num">
                <li class="page-item ${pageResponseVO.pageNo == num ? 'active':''} ">
                    <a class="page-link"  data-num="${num}">${num}</a></li>
            </c:forEach>

            <c:if test="${pageResponseVO.next}">
                <li class="page-item">
                    <a class="page-link"  data-num="${pageResponseVO.end + 1}">다음</a>
                </li>
            </c:if>
        </ul>

    </div>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>

</body>
</html>