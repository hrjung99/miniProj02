<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<!DOCTYPE html>
<html>
<head>
	<title>게시물</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
    <jsp:include page="/WEB-INF/views/include/css.jsp" />
	<jsp:include page="/WEB-INF/views/include/js.jsp"/>

</head>
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
<body>
	<h1>게시물 목록</h1>
	
	<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal"/>
	</sec:authorize>

	<c:choose>
	<c:when test="${empty principal}">
		<h3>이름 : 로그인 정보 없음</h3>
	</c:when>
	<c:otherwise>
		<h3>이름 : ${principal.mname}</h3>
	</c:otherwise>
</c:choose>
	
	
	
	
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
            <th>게시물번호</th>
            <th>제목</th>
            <th>내용</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>count</th>
        </tr>
        <c:forEach var="board" items="${pageResponseVO.list}">
        <tr>
            <td style="cursor:pointer;"><a data-bs-toggle="modal" data-bs-target="#boardViewModel" data-bs-bno="${board.bno}">${board.bno}</a></td>
            <td>${board.btitle}</td>
            <td>${board.bcontent}</td>
            <td>${board.bwriter}</td>
            <td>${board.bdate}</td>
            <td>${board.view_count}</td>
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
    
<!-- 상세보기 Modal -->
<div class="modal fade" id="boardViewModel" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">게시물 상세보기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
	      <label>게시물 번호:</label><span id="bno"></span><br/>
	      <label>제목 : </label><span id="btitle"></span><br/>
	      <label>내용 : </label><span id="bcontent"></span><br/>
	      <label>ViewCount :</label><span id="view_count"></span><br/>
	      <label>작성자 : </label><span id="bwriter"></span><br/>
	      <label>작성일 : </label><span id="bdate"></span><br/>
	      <label>첨부파일 : </label><span id="boardFile" data-board-file-no="" onclick="onBoardFileDownload(this)"></span><br/>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="btnDelete" >삭제</button>
           <button type="button" class="btn btn-secondary" id="btnUpdate">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        
      </div>
    </div>
  </div>
</div>
    
<script>
menuActive("board_link");


document.querySelector(".pagination").addEventListener("click", function (e) {
    e.preventDefault()

    const target = e.target

    if(target.tagName !== 'A') {
        return
    }
    //dataset 프로퍼티로 접근 또는 속성 접근 메서드 getAttribute() 사용 하여 접근 가능 
    //const num = target.getAttribute("data-num")
    const num = target.dataset["num"];
    
    //페이지번호 설정 
    searchForm.innerHTML += `<input type='hidden' name='pageNo' value='\${num}'>`;
    searchForm.submit();
});


document.querySelector("#size").addEventListener("change", e => {
    searchForm.submit();
});

const boardViewModel = document.querySelector("#boardViewModel");
const span_bno = document.querySelector(".modal-body #bno");
const span_btitle = document.querySelector(".modal-body #btitle");
const span_bcontent = document.querySelector(".modal-body #bcontent");
const span_view_count = document.querySelector(".modal-body #view_count");
const span_bwriter = document.querySelector(".modal-body #bwriter");
const span_bdate = document.querySelector(".modal-body #bdate");


boardViewModel.addEventListener('shown.bs.modal', function (event) {
	const a = event.relatedTarget;
	const bno = a.getAttribute('data-bs-bno'); //a.dataset["bs-bno"] //, a.dataset.bs-bno 사용안됨
	console.log("모달 대화 상자 출력... bno ", bno);
	
	span_bno.innerText = "";
	span_btitle.innerText = "";
	span_bcontent.innerText = "";
	span_view_count.innerText = "";
	span_bwriter.innerText = "";
	span_bdate.innerText = "";
	boardFile.innerText = "";


	myFetch("jsonBoardInfo", {
		[`${_csrf.parameterName}`] : "${_csrf.token}", 
		bno : bno 
	}, json => {
	if(json.status == 0) {
		//성공
		const jsonBoard = json.jsonBoard; 
		span_bno.innerText = jsonBoard.bno;
		span_btitle.innerText = jsonBoard.btitle;
		span_bcontent.innerHTML = jsonBoard.bcontent;
		span_view_count.innerText = jsonBoard.view_count;
		span_bwriter.innerText = jsonBoard.bwriter;
		span_bdate.innerText = jsonBoard.bdate;
		//첨부파일명을 출력한다
		boardFile.innerText = jsonBoard.boardFileVO.original_filename;
		//첨부파일의 번호를 설정한다 
		boardFile.setAttribute("data-board-file-no", jsonBoard.boardFileVO.board_file_id);
		
	} else {
		alert(json.statusMessage);
	}
});

})

const onBoardFileDownload = boardFile => {
const board_file_no = boardFile.getAttribute("data-board-file-no");
alert("첨부파일 번호 = " + board_file_no);
location.href = "<c:url value='/board/fileDownload/'/>" + board_file_no;
}




function jsDelete() {
	if (confirm("정말로 삭제하시겠습니까?")) {
		myFetch("delete", {bno : span_bno.innerText}, json => {
			if(json.status == 0) {
				//성공
				alert("게시물 정보를 삭제 하였습니다");
				location = "list";
			} else {
				alert(json.statusMessage);
			}
		});
	}
}

function goUpdateForm(){
    var bno = span_bno.innerText;  // 현재 모달에 표시된 bno 값을 가져옴
    window.location.href = '/board/updateForm/' + bno;  // bno 값을 포함하여 수정 페이지로 리디렉트
}



     // 모달 종료(hide) 버튼
     document.querySelector("#btnDelete").addEventListener("click", jsDelete);
     document.querySelector("#btnUpdate").addEventListener("click", goUpdateForm);

     
	
//function jsView(bno) {
	//인자의 값을 설정한다 
//	bno.value = bno;
	
	//양식을 통해서 서버의 URL로 값을 전달한다
//	listForm.submit();
//	.Modal("#boardViewModel").model();
//	boardViewModel.show();
//}



document.getElementById('goInsert').addEventListener('click', function() {
    window.location.href = '/board/insertForm';
});
  
</script>      
    
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>