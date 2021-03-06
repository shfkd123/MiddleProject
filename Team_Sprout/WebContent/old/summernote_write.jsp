<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="utf-8">
<head>
	<meta charset="uft-8" />
	<title>summernote</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    
	<script type="text/javascript">
        /* summernote에서 이미지 업로드시 실행할 함수 */
	 	function sendFile(file, editor) {
            // 파일 전송을 위한 폼생성
	 		data = new FormData();
	 	    data.append("uploadFile", file);
	 	    $.ajax({ // ajax를 통해 파일 업로드 처리
	 	        data : data,
	 	        type : "POST",
	 	        url : "./summernote_imageUpload.jsp",
	 	        cache : false,
	 	        contentType : false,
	 	        processData : false,
	 	        success : function(data) { // 처리가 성공할 경우
                    // 에디터에 이미지 출력
	 	        	$(editor).summernote('editor.insertImage', data.url);
	 	        }
	 	    });
	 	}
	</script>
</head>
<body>
	<h1>summernote</h1>
	<form name="writeForm" action="./summernote_insert.jsp" method="post">
		<textarea id="summernote">Hello Summernote</textarea>
        <script>
//             $(document).ready(function() {
//                 $('#summernote').summernote({ // summernote를 사용하기 위한 선언
//                     height: 400,
// 					callbacks: { // 콜백을 사용
//                         // 이미지를 업로드할 경우 이벤트를 발생
// 					    onImageUpload: function(files, editor, welEditable) {
// 						    sendFile(files[0], this);
// 						}
// 					}
// 				});
// 			});
$(function(){
$('#summernote').summernote({
height: 600,
fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
fontNamesIgnoreCheck : [ '맑은고딕' ],
focus: true,

callbacks: {
onImageUpload: function(files, editor, welEditable) {
            for (var i = files.length - 1; i >= 0; i--) {
             sendFile(files[i], this);
            }
        }
}

});

})
function sendFile(file, el) {
var form_data = new FormData();
       form_data.append('file', file);
       $.ajax({
         data: form_data,
         type: "POST",
         url: './profileImage.mpf',
         cache: false,
         contentType: false,
         enctype: 'multipart/form-data',
         processData: false,
         success: function(img_name) {
           $(el).summernote('editor.insertImage', img_name);
         }
       });
    }

		</script>
		</form>
</body>
</html>