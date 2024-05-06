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
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
        body {
            background-color: #e0ffe0; /* 밝은 초록색 배경 */
        }
        h1, h3 {
            color: #006400; /* 진한 초록색 */
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #008000; /* 표준 초록색 */
            color: white;
        }
        .pagination .page-item .page-link {
            color: #006400; /* 진한 초록색 */
            background-color: #ccffcc; /* 매우 연한 초록색 */
            border-color: #006400;
        }
        .pagination .page-item.active .page-link {
            color: white;
            background-color: #006400; /* 진한 초록색 */
            border-color: #004d00;
        }
        .btn-secondary {
            background-color: #006400; /* 진한 초록색 */
            border-color: #004d00;
        }
        .btn-secondary:hover {
            background-color: #004d00;
            border-color: #002200;
        }
        .modal-content {
            background-color: #f0fff0; /* 매우 연한 초록색 */
        }
    </style>
<jsp:include page="/WEB-INF/views/include/css.jsp" />
<jsp:include page="/WEB-INF/views/include/js.jsp"/>
</head>

<jsp:include page="/WEB-INF/views/include/header.jsp" />

<body>
    <div class="container mt-3">
        <form id="searchForm" action="list" method="post" class="mb-3">
            <div class="form-group">
                <label for="size">건수:</label>
                <select id="size" name="size" class="form-control">
                    <c:forEach var="size" items="${sizes}">
                        <option value="${size.codeid}" ${pageRequestVO.size == size.codeid ? 'selected' : ''} >${size.name}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="form-group">
                <label for="searchKey">이름:</label>
                <input type="text" id="searchKey" name="searchKey" class="form-control" value="${param.searchKey}">
            </div>
            <button type="submit" class="btn btn-search">검색</button>
        </form>
        
        <table class="table table-bordered">
            <thead class="table-success">
                <tr>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>나이</th>
                    <th>성별</th>
                    <th>연락처</th>
                    <th>권한</th>
                    <th>잠금 여부</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="member" items="${pageResponseVO.list}">
                    <tr>
                        <td><a href="/member/view?mid=${member.mid}" class="text-success">${member.mid}</a></td>
                        <td>${member.mname}</td>
                        <td>${member.mage}</td>
                        <td>${member.mgender}</td>
                        <td>${member.mpno}</td>
                        <td>${member.member_roles}</td>
                        <td>${member.member_account_locked}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <nav aria-label="Page navigation example">
            <ul class="pagination">
                <c:if test="${pageResponseVO.prev}">
                    <li class="page-item"><a class="page-link" href="#" data-num="${pageResponseVO.start -1}">이전</a></li>
                </c:if>
                <c:forEach begin="${pageResponseVO.start}" end="${pageResponseVO.end}" var="num">
                    <li class="page-item ${pageResponseVO.pageNo == num ? 'active':''}">
                        <a class="page-link" href="#" data-num="${num}">${num}</a>
                    </li>
                </c:forEach>
                <c:if test="${pageResponseVO.next}">
                    <li class="page-item"><a class="page-link" href="#" data-num="${pageResponseVO.end + 1}">다음</a></li>
                </c:if>
            </ul>
        </nav>
    </div>

    <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
