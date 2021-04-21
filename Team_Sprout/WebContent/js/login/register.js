/**
 * 
 */

var id = "";

$(document).ready(function(){
	
	// 1월 ~ 12월 SELECT박스 생성
	var monthList = "<select>"
				+ "<option>월</option>";
	for(var i = 1; i <= 12; i++){
		monthList += "<option>" + i + "</option>";
	}
	monthList += "</select>";
	
	$("#month").html(monthList);
	
	// 관심분야 checkbox 생성
	initUserLikey();
	
	// 아이디 중복검사
	$("#btnUserId").click(function(){
		var userId = $("#userId").val();
		
		// 빈값인지 확인
		if(!isEmpty(userId)){
			alert("ID가 입력되지 않았습니다.");
			$("#userId").focus();
			return;
		}
		
		// 유효성 검사 (myUtil.js에서 만든 chkRegExp()메서드 사용)
		if(!chkRegExp(userId, "id")){
			alert("ID가 형식에 맞지 않습니다.");
			$("#spUserIdCk").hide();
			$("#spUserIdUse").hide();
			$("#spUserIdReq").show();
			$("#userId").focus();
			return;
		}
		
		// DB에서 중복검사 실행
		$.ajax({
			url : "/Team_Sprout/user/register.do"
			, tpye : "post"
			, data : {
				"userId" : userId
				, "flag" : "CHKID"
			}
			, dataType : "json"
			, success : function(data){
				$("#spUserIdCk").hide();
				$("#spUserIdReq").hide();
				$("#spUserIdUse").val("\'" + userId + "\' 사용 가능");
				$("#spUserIdUse").show();
				id = userId;
			}
			, error : function(xhr){
				console.log(xhr);
				alert("ID 중복검사 중 오류가 발생하였습니다!");
			}
		});
	});
});

// DB에 LIKEY테이블의 값들을 가져와서 관심분야에 넣어준다.
function initUserLikey(){
	$.ajax({
		url : "/Team_Sprout/LikeyServlet"
		, type : "post"
		, dataType : "json"
		, success : function(data){
			makeUserLikey(data);
		}
		, error : function(xhr) {
			console.log(xhr);
			alert("관심분야 목록에 오류가 발생하였습니다.");
		}
	});
}
function makeUserLikey(data) {
	var likeyList = "";
	for(var i = 0; i < data.length; i++){
		if(i == 0){
			likeyList += "<br>";
		}
		if(i > 0 && i % 5 == 0){
			likeyList += "<br><br>";
		}
		likeyList += "&emsp;<label><input type='checkbox' value='&nbsp;"
			+ data[i].likeyCode + "'>" 
			+ data[i].likeyName + "</label>";
	}
	$("#likey").html(likeyList);
}

// 주소 API
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

// 회원가입 버튼 클릭시
function save() {
	var userBir = $("#year").val() + "/" + $("#birth option:selected").val()
				+ "/" + $("#day").val();
	$("#userBir").val(userBir);
	
	// 아이디 빈값일때
	if(!isEmpty($("#userId").val())){
		alert("ID를 입력해주세요.");
		$("#spUserIdCk").hide();
		$("#spUserIdUse").hide();
		$("#spUserIdReq").hide();
		$("#userId").focus();
		return;
	}
	
	// 아이디 중복검사 후 아이디를 수정한뒤 중복검사를 다시하지 않았을 때
	if($("#userId").val() != id) {
		alert("ID 중복검사를 해주세요.");
		$("#spUserIdCk").hide();
		$("#spUserIdUse").hide();
		$("#spUserIdReq").show();
		$("#userId").focus();
		return;
	}
	
	// 비밀번호 빈값 and 정규식
	if(!isEmpty($("#userPw").val())){
		alert("비밀번호를 입력해주세요.");
		$("#userPw").focus();
		return;
	}
	if(!chkRegExp($("#userPw"), "password")){
		alert("비밀번호 형식이 맞지 않습니다.");
		$("#userPw").focus();
		$("#spUserPassReq").show();
	}
	$("#spUserPassReq").hide();
	
	// 비밀번호 & 비밀번호 확인이 일치하지 않을때
	if($("#userPw").val() != $("#userPw2").val()){
		alert("비밀번호가 일치하지 않습니다.");
		$("#userPw").focus();
	}
	
	// 이름 정규식
	if(!chkRegExp($("#userName").val())) {
		alert("이름 형식이 맞지 않습니다.");
		$("#userName").focus();
		$("#spUserNameReq").show();
	}
	$("#spUserNameReq").hide();
	
	// 닉네임 정규식
	if(!chkRegExp($("#userNickName").val())) {
		alert("닉네임 형식이 맞지 않습니다.");
		$("#spUserNickNameReq").show();
		$("#userNickName").focus();
	}
	$("#spUserNickNameReq").hide();
	
	// 생년월일 입력 안했을 때
	if(!isEmpty($("#year").val()) || !isEmpty($("#day").val())){
		alert("생년월일을 입력해주세요.");
		$("#year").focus();
	}
	
	// 주소 입력 안했을때
	if(!isEmpty($("#sample6_postcode").val())){
		alert("주소를 입력해주세요.");
		$("#sample6_postcode").focus();
	}
	if(!isEmpty($("#sample6_detailAddress").val())){
		alert("상세 주소를 입력해주세요.");
		$("#sample6_detailAddress").focus();
	}
	
	if($("#capcha").val() == "N"){
		alert("자동가입방지 문자를 입력해주세요.");
		return;
	}
	
	if(!confirm("저장하시겠습니까?")){
		return;
	}

	$("#flag").val("C");
	
	$.ajax({
		url : "/Team_Sprout/UserServlet"
		, type : "post"
		, data : $("#regiForm").serialize()
		, dataType : "json"
		, success : function(data){
			alert("회원가입 완료!");
		}
		, error : function(xhr) {
			alert("회원가입 오류!");
			console.log(xhr);
		}
	});
}