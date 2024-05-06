<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Company Homepage</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background-color: #e0f2f1; /* 소주병 초록색의 옅은 버전 */
        color: #333; /* 글자색 */
    }
    .card {
        border: 0;
        background-color: #e0f2f1; /* 카드 배경도 페이지 배경색과 같게 설정 */
    }
    .btn-primary {
        background-color: #004d40;
        border-color: #00251a;
    }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />


<div class="container mt-5">
    <div class="row">
        <div class="col-lg-4">
            <div class="card">
                <img class="card-img-top" src="http://placehold.it/300x200" alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title">Service 1</h5>
                    <p class="card-text">Description of Service 1.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card">
                <img class="card-img-top" src="http://placehold.it/300x200" alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title">Service 2</h5>
                    <p class="card-text">Description of Service 2.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card">
                <img class="card-img-top" src="http://placehold.it/300x200" alt="Card image cap">
                <div class="card-body">
                    <h5 class="card-title">Service 3</h5>
                    <p class="card-text">Description of Service 3.</p>
                    <a href="#" class="btn btn-primary">More Info</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
