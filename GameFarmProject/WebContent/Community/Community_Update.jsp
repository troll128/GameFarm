<%@page import="communityDB.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta charset="utf-8">
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<title>::: 게임팜 :::</title>
<!-- Bootstrap core CSS -->
<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="css/modern-business.css" rel="stylesheet">
<style type="text/css">
h2 {
	color: #0177A8;
	font-family: 'Jeju Gothic';
	font-size: 2em;
	font-weight: bold;
	border-bottom: 1px;
	border-bottom-style: dotted;
	margin-top: 1em;
	padding-bottom: 0.3em;
	margin-bottom: 1em;
}
.card-header {
	font-family: 'Jeju Hallasan';		
}
#customerTable {		
	border: none;
	-webkit-box-flex: 1;
	-ms-flex: 1 1 auto;
	flex: 1 1 auto;
	padding: 0.25rem;
	margin-left: 2em;
	margin-top: -1.25em;
	margin-bottom: 1.1em;		
}
.col-lg-6 {
	display: inline-block;
	width: 49%;
}
.mb-0 {
	margin-left: 2em;
}
#collapseTwo {
	margin-left: 2em;
}
#collapseFour {
	margin-left: 2em;
}
.input-group {
	position: relative;
	display: -webkit-box;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	-webkit-box-align: stretch;
	-ms-flex-align: stretch;
	align-items: stretch;
	width: 40%;
	margin-top: 2em;
	margin-left: auto;
	margin-bottom: 3em;
	text-align: center;
}
/* 게시판 모양 */
label {
	text-align: left;	
	font-size: 1.2em;
}
.form-control {
	width: 120%;
}
/* 게시판 모양 */

/* 버튼 부분 */
#pList {
	text-align: right;
	margin-right: 15%;
}
#buttonfield {
	text-align: right;
	display: inline-block;
	margin-bottom: 15px;
}
#joinbutton {
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	color: #fff;
	height: 50px;
	width: 100px;	
	font-family: 'Jeju Hallasan';
	font-size: 24px;
	margin-top: 20px;
	margin-right: 20px;
}
#joinbutton:HOVER {
	background-color: #0069d9;
	font-weight: bold;
	cursor: pointer;	
}
.imageButton {
	background-color: #ff1100;
	border: none;
	border-radius: 5px;
	color: #fff;
	text-align: center;
	vertical-align: center;
	height: 36px;
	width: 90px;
	font-family: 'Jeju Hallasan';
	font-size: 20px;
}
.imageButton:HOVER {
	background-color: #ff2211;
	font-weight: bold;
	cursor: pointer;
}
/* 버튼 부분 */

/* 툴팁 표시 */
[data-tooltip-text]:hover {
	position: relative;
}
[data-tooltip-text]:hover:after {
	background-color: #000000;
	background-color: rgba(0, 0, 0, 0.5);
	-webkit-box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
	-moz-box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
	box-shadow: 0px 0px 3px 1px rgba(50, 50, 50, 0.4);
	-webkit-border-radius: 5px;
	-moz-border-radius: 5px;
	border-radius: 5px;
	color: #FFFFFF;
	font-size: 16px;
	font-family: "Jeju Gothic";
	font-weight: normal;
	content: attr(data-tooltip-text);
	margin-bottom: 10px;
	top: 30%;
	left: 110%;	
	padding: 7px 12px;
	position: absolute;
	width: auto;
	min-width: 400px;
	max-width: 900px;
	word-wrap: break-word;
	z-index: 9999;
}
/* 툴팁 표시 */
</style>
<script type="text/javascript">
function check() {
	if(document.fr.comm_subject.value.length==0) {
		alert("제목은 비울 수 없습니다!");
		document.fr.comm_subject.select();
		return;
	}		
	if(document.fr.comm_content.value.length==0) {
		alert("내용을 입력하세요!");
		document.fr.comm_content.select();
		return;
	}
	document.fr.submit();
}
function handleFileSelect() {	// 이미지 미리보기
	var files = document.getElementById('comm_image').files[0]; //파일 객체
	var reader = new FileReader();
	//파일정보 수집        
	reader.onload = (function(theFile) {
		return function(e) {
			//이미지 뷰
			var img_view = [ '<img src="', e.target.result, '" title="', escape(theFile.name), '"/>' ].join('');
			document.getElementById('new_comm_image').innerHTML = img_view;
			};
		})(files);
	reader.readAsDataURL(files);
}
function imageDeleteAction(comm_number, pageNum) {	// 사진 삭제 
	if (confirm("업로드한 사진을 삭제하시겠습니까?") == true){    //확인
		location.href='./imageDeleteAction.co?comm_number='+comm_number+'&pageNum='+pageNum;
	} else { //취소
		return;
	}
}	
</script>
</head>
<body>
<%
//한글처리
request.setCharacterEncoding("utf-8");
// 현재 글의 번호와 페이지 번호를 리퀘스트 값으로 가져온다.
int comm_number = Integer.parseInt(request.getParameter("comm_number"));
String pageNum = request.getParameter("pageNum");
// cb에 담긴 게시물의 값들을 CommunityBean cb 변수에 담는다.
CommunityBean cb = (CommunityBean)request.getAttribute("cb");
%>
<!-- 헤더 -->
<jsp:include page="../inc/header.jsp"></jsp:include>
<!-- 헤더 -->
	
	<!-- 본문 -->
	<div class="container">
		<br>
		<!-- 페이지 위치 -->
		<h1 class="mt-4 mb-3">	게임 이야기</h1>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="index.jsp">게임팜</a></li>
			<li class="breadcrumb-item active">게임 이야기</li>
		</ol>
		<!-- 페이지 위치 -->
		<!-- 이용 수칙 -->
			<div class="card advance">
				<h5 class="card-header">
				<a class="collapsed" data-toggle="collapse" data-parent="#accordion"
						href="#collapseTwo" aria-expanded="false"
						aria-controls="collapseTwo">
						커뮤니티 이용 수칙
				</a>
				</h5>
				<div id="collapseTwo" class="collapse" role="tabpanel"
				aria-labelledby="headingTwo">
					1. 욕설과 비방 금지!<br><br>
					2. 음란물 게재 금지! <br><br>
					3. 광고나 상업성 게시물 금지!<br><br>
					4. 위 사항을 하나라도 위반하면 해당 계정은 영구 정지합니다.
				</div>
			</div>
		<!-- 이용 수칙 -->				
				<hr>
		<!-- 게시판 -->		
		<form action="./CommunityUpdateAction.co?comm_number=<%=comm_number%>&pageNum=<%=pageNum%>" name="fr" method="post" enctype="multipart/form-data"><!-- 첨부 파일이 있을 때는 enctype을 꼭 넣어주고 없을 때는 꼭 빼야한다. -->
		<div class="col-lg-8 mb-4">
			<div class="control-group form-group">
				<div class="controls">
					<label>제목</label>
					<input type="text" name="comm_subject" value="<%=cb.getComm_subject()%>"class="form-control" required data-validation-required-message="제목을 입력하세요." placeholder="제목을 입력하세요." required>
					<br>
					<label>작성자</label>
					<input type="text" name="mem_id" value="<%=cb.getMem_id()%>"class="form-control" style="width:40%;" readonly>　	
					<br>			
					<label>내용</label>
					<textarea rows="10" cols="75" name="comm_content" class="form-control" placeholder="내용을 입력해주세요~" required><%=cb.getComm_content()%></textarea>					<br>	
					<%
					if (cb.getComm_image()==null) { // 파일이 없다면?	 %>
					<label>사진 업로드</label>
						<input type="file" name="comm_image" class="form-control" id="comm_image" onchange="handleFileSelect()">
						<!-- 새로운 사진 미리보기 -->
						<div id="new_comm_image"></div>								
					<%		
					} else { // 기존 파일이 존재한다면? %>
					<label>기존 사진: </label>
						<span style="color:green;"><%=cb.getComm_image()%></span>
						<button type="button" class="imageButton" data-tooltip-text="주의: 기존 사진을 삭제하면 수정 작업들이 사라집니다." onclick="imageDeleteAction(<%=cb.getComm_number()%>, <%=pageNum%>)">삭제하기</button>
						<br>
						<!-- 기존 사진 미리보기 -->
						<span style="color:green;"><img alt="originally_comm_image" src="./upload/<%=cb.getComm_image()%>" class=img-fluid rounded"></span><br>
					<label>새로운 사진 업로드</label>
					<input type="file" name="comm_image" class="form-control" id="comm_image" onchange="handleFileSelect()">	
					<!-- 새로운 사진 미리보기 -->
					<div id="new_comm_image"></div>	
					<%
					}
					%>
				</div>
			</div>	
		<p id="pList">
		<button type="button" onclick="check()" id="joinbutton">수정완료</button>
		<button type="reset" id="joinbutton">다시쓰기</button>
		<button type="button" onclick="history.back()" id="joinbutton">취소</button>		
		</p>
		</div>
	</form>	
	<br>
	<!-- 게시판 -->
</div>		
<!-- 푸터 -->
<jsp:include page="../inc/footer.jsp"></jsp:include>
<!-- 푸터 -->
<!-- Bootstrap core JavaScript -->
<script src="vendor/jquery/jquery.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
