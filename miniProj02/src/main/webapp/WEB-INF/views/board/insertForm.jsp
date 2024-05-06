<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html>
<html>
<head>
	<title>게시물 등록</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="_csrf" content="${_csrf.token}"/>
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<meta name="_csrf_parameter" content="${_csrf.parameterName}"/>
	
    
    <jsp:include page="/WEB-INF/views/include/css.jsp" />
	<jsp:include page="/WEB-INF/views/include/js.jsp"/>
	
	
	<style type="text/css">
        body {
            background-color: #e0ffe0; /* 밝은 초록색 배경 */
        }
        h1 {
            color: #006400; /* 진한 초록색 */
            text-align: center;
        }
        #rForm {
            text-align: center;
            margin: 20px auto;
            width: 80%;
            max-width: 600px;
        }
        .btitle, #bcontent {
            width: 100%;
            margin-bottom: 20px;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btitle {
            height: 40px;
        }
        #bcontent {
            height: 200px; /* Textarea 높이 */
        }
        input[type="submit"], a {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            color: white;
            background-color: #006400; /* 진한 초록색 */
            text-decoration: none;
            margin-right: 10px;
        }
        input[type="submit"]:hover, a:hover {
            background-color: #004d00; /* 더 진한 초록색 */
        }
    </style>
	
	
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
	<h1>게시물 등록</h1>
<%-- 로그인 사용자 정보 출력 --%>
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
    <form id="rForm" action="insert" method="post">
		<%-- csrf 토큰 설정 --%>
		<sec:csrfInput/>
		<!-- 게시물 토큰을 설정한다 -->
        <input type="hidden" id="board_token" name="board_token" value="${board_token}"><br/>
        <input class="btitle" id="btitle" name="btitle" required="required" placeholder="게시물 제목을 입력해주세요"><br/>
        <textarea id="bcontent" name="bcontent" required="required" placeholder="게시물 내용을 입력해주세요">
        </textarea>
        <div id="div_file">
			<input  type='file' name='file' />
		</div>
        
        
        <br/>
    <div>
        <input type="submit" value="등록">
        <a href="javascript:history(-1)">취소</a>
    </div>
    
    </form>
    
<script type="text/javascript">
	//상단 메뉴에서 게시물이 선택되게 함  
	menuActive("board_link");
	
	
	const csrfParameter = document.querySelector("meta[name='_csrf_parameter']").content;
	const csrfToken = document.querySelector("meta[name='_csrf']").content;
	//이미지 업로드 URL
	const board_image_url = "<c:url value='/board/boardImageUpload?board_token=${board_token}&'/>" + csrfParameter + "=" + csrfToken;
	//cfeditor관련 설정 
	let bcontent; //cfeditor의 객체를 저장하기 위한 변수 
	ClassicEditor.create(document.querySelector('#bcontent'),{
		//이미지 업로드 URL을 설정한다 
		ckfinder: {
			uploadUrl : board_image_url
		}
	})
	.then(editor => {
		console.log('Editor was initialized');
		//ckeditor객체를 전역변수 bcontent에 설정함 
		window.bcontent = editor;
	})
	.catch(error => {
		console.error(error);
	});
	
	

    const rForm = document.getElementById("rForm");
    rForm.addEventListener("submit", e => {
    	//서버에 form data를 전송하지 않는다 
    	e.preventDefault();
    	
    	myFileFetch("insert", "rForm", json => {
			switch(json.status) {
			case 0:
				//성공
				alert("게시물을 등록 하였습니다");
				location = "list";
				break;
			default:
				alert(json.statusMessage);
			}
		});
    });
    
</script>
  <%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>
