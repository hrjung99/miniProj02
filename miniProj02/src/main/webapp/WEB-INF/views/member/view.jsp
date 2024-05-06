<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
		<h1>마이페이지</h1>
		
	

		
	</div>
	<form id="viewForm" name="viewForm" action="" method="get">
		<input type="hidden" id="action" name = "action" value="">
		<label>아이디<input type = "text" id="mid" value ="${member.mid}" readonly="readonly"></label><br/>
		<label>비밀번호<input type="password" id="mpass" name="mpass" value="${member.mpass}"></label><br/>
			<label>비밀번호 확인<input type="password" id="mpass2" name="mpass2"value="${member.mpass}"></label><br/>
			<label>이름<input type="text" id="mname" name="mname" value="${member.mname}"></label><br/>
			<label>나이<input type="text" id="mage" name="mage" value="${member.mage}" ></label><br/>
			<label>주소<input type="text" id="madd" name="madd" value="${member.madd}"></label><br/>
			<label>전화번호<input type="text" id="mpno" name="mpno" value="${member.mpno}"></label><br/>
			<label>성별 <input type="text" id="mgender" name="mgender" value="${member.mgender}" readonly="readonly"></label><br/>
		
		
		
		<input type="button" value="수정" onclick = "jsUpdate()">
		<input type ="button" value="탈퇴" onclick="jsDelete()" >
	</form>

</body>
</html>