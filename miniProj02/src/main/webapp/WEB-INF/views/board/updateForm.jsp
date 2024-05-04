<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>게시물 수정</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
    
    <jsp:include page="/WEB-INF/views/include/css.jsp" />
	<jsp:include page="/WEB-INF/views/include/js.jsp"/>
    
    <style type="text/css">
    	#rForm {
    		text-align:center;
    	}
	    .btitle {
			width: 80%;
			max-width: 800px;
			margin: 0 auto;
		}
		
	    .ck.ck-editor {
			width: 80%;
			max-width: 800px;
			margin: 0 auto;
		}
		
		.ck-editor__editable {
			height: 80vh;
		}
    </style>
</head>
    <jsp:include page="/WEB-INF/views/include/header.jsp" />
<body>

    <h1>게시물 수정</h1>
    <form action="/board/update" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <label>게시물 번호: </label> <input type="text" id="bno" name="bno" value="${board.bno}" readonly="readonly"><br/>
        <label>제목: </label><input class="btitle" type="text" id="btitle" name="btitle" value="${board.btitle}"><br/><br/>
        <textarea id="bcontent" name="bcontent">${board.bcontent}</textarea><br/>       
       <div>
	        <input type="submit" value="수정">
	        <a href="javascript:history.back(-1)">취소</a>
	    </div>
    </form>

<script type="text/javascript">

//ckeditor관련 설정 
let bcontent; //ckeditor의 객체를 저장하기 위한 변수 
ClassicEditor.create(document.querySelector('#bcontent'))
.then(editor => {
	console.log('Editor was initialized');
	//ckeditor객체를 전역변수 bcontent에 설정함 
	window.bcontent = editor;
})
.catch(error => {
	console.error(error);
});

document.getElementById('rForm').addEventListener('submit', function() {
    document.getElementById('bcontent').value = bcontent.getData();
});



menuActive("board_link");


</script>    
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>