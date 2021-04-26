<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/Team_Sprout/css/prj/prjInsert.css">
</head>
<body>
	<!-- 상단 전체   -->
	<div class="col-sm-12">

		<!-- 왼쪽 공백 2 -->
		<div class="col-sm-2"></div>

		<!-- 프로젝트 등록 창 -->
		<div class="col-sm-8">

			<form action="">
				<div class="form-group">
					<br><br>
					<!-- 프로젝트 제목 -->
					<label>프로젝트 제목 </label>
					<br>
					<input type="text" class="form-control" id="PjName">

					<!-- 프로젝트 카테고리 -->
					<br><br><label>프로젝트 카테고리</label><br>
					<select class="form-control" id="PjCategoty">
						<option>주얼리</option>
						<option>전자제품</option>
						<option>영화/음반</option>
					</select>

					<!-- 프로젝트 대표 이미지 (썸네일) -->
					<br><br><label>프로젝트 대표 이미지 </label><br>
					<input type="file" id="prjFile">

					<!-- 프로젝트  -->
					<br><br><label>프로젝트 목표 금액</label><br>
					<input type="text" class="form-control" id="prjMoney">원

					<!--  프로젝트 리워드 옵션  -->
					<br><br><p><h4>프로젝트 리워드 옵션 </h4></p>  
					<span style="color: red;">* 프로젝트 성공 시 후원자에게 전달할 리워드를 입력해주세요.</span>
					<br><br>
					<!-- 리워드 옵션 부분 -->
					<div id="option">
						<p>옵션1</p> 
						
						<label>후원금액 </label><br>
						<input type="text" class="form-control" id="prjOpPrice">원<br>
						
						<br><label>옵션내용 </label><br>
						<input type="text" class="form-control" id="prjOpContent">
						
					</div>
					
					<!-- 옵션 추가 버튼 -->
					<br><button type="button" class="btn btn-success" onclick="insertOption()">옵션 추가</button>
					
					<!-- 프로젝트 마감일 -->
					<br><br><label>프로젝트 마감일</label><br>
					<input type="date" class="form-control" id="prjDeadLine">

					<!-- 프로젝트 소개글 -->
					<br><br><label>프로젝트 소개글</label><br>
					<textarea rows="20" class="form-control" id="prjIntroText">
					</textarea>
					
					<!-- 은행선택 -->
					<br><br><label>은행선택</label>
					 <span style="color: red;">* 프로젝트 성공시 후원금을 입금받을 계좌를 입력하세요.</span>
					<br>
					<select class="form-control" id="prjBank">
						<option>은행을 선택해주세요.</option>
						<option>국민은행</option>
						<option>우리은행</option>
						<option>우체국</option>
						<option>기업은행</option>
					</select>
					
					<!-- 예금주 -->
					<br><br><label>예금주</label><br>
					<input type="text" class="form-control" id="prjBankUser">
					
					<!-- 계좌번호 -->
					<br><br><label>계좌번호</label><br>
					<input type="text" class="form-control" id="prjBankNum">
					
					<br><br>
					
					<!-- 신청하기 버튼 -->
					<button type="button" class="btn btn-success">신청하기</button>
				</div>
			</form>
		</div>

		<!-- 오른쪽 공백 2 -->
		<div class="col-sm-2"></div>
	</div>
</body>
<script type="text/javascript">
	function upload(){
		if(confirm("게시글을 등록 하시겠습니까?")){
			alert("게시글 등록이 완료되었습니다.");
			document.getElementById("fmTitle").value = $("#title").val();
			document.getElementById("fmContent").value = $("#content").val();
			document.getElementById("flag").value = "C";
			var fm = document.getElementById("fm");
			fm.method = "post";
			fm.action = "faqBoard.do";
			fm.submit();
		} else {
			return;
		}
	}
	
	function cancel(){
		if(confirm("글 작성을 취소하시겠습니까?")){
			alert("목록으로 돌아갑니다.");
			var fm = document.getElementById("fm");
			fm.method = "post";
			fm.action = "faqBoard.do";
			fm.submit();
		} else {
			return;
		}
	}
	function insertOption(){
		for(i = 1; i < 5; i)
		
		
	}
</script>
</html>