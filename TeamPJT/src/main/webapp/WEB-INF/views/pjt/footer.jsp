<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body >
<!-- Footer-->
        <footer class="py-5 bg-dark mt-auto ">
            <div class="container px-4 px-lg-5"><p class="m-0 text-center text-white">Made by 한인형/이동욱/방소희/최서진</p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
        
        <script type="text/javascript">
      //div 텍스트 hidden으로 넘기기
    	<!--
    	$(function() {
    		$("submit").click(function(){
    			console.log("실행")
    			let innerText = document.getElementById("editor").innerHTML
    			$('input[name=board_content]').attr('value',innerText);
    		})
    		
    	})
    		-->
    	function hiddenValue() {
    		let innerText = document.getElementById("editor").innerHTML
    		$('input[name=board_content]').attr('value',innerText);
    	}
    	
    	function check() {
			if($("#board_title").val()==""){
				alert("제목을 입력해주세요");
			}else if($("#board_score").val()==""){
				alert("별점을 입력해주세요");
			}else if($("#board_category").val()==""){
				alert("카테고리를 입력해주세요");
			}else if(document.getElementById("editor").innerHTML==""){
				alert("내용을 입력해주세요");
			}else if($("#board_strength").val()==""){
				alert("장점을 입력해주세요");
			}else if($("#board_weakness").val()==""){
				alert("단점을 입력해주세요");
			}else{
				$("#reg").submit();
			}
		}

    	/* 이미지 업로드 */
    	$("input[type='file']").on("change", function(e) {
    		let formData = new FormData();
    		let fileInput = $('input[name="uploadFile"]');
    		let fileList = fileInput[0].files;
    		let fileObj = fileList[0];

    		if (!fileCheck(fileObj.name, fileObj.size)) {
    			return false;
    		}

    		formData.append("uploadFile", fileObj);

    		$.ajax({
    			url : '/board/uploadFile',
    			processData : false,
    			contentType : false,
    			data : formData,
    			type : 'POST',
    			dataType : 'json',
    			success: function(result) {
    				showUploadImage(result)
    			},
    			error : function(result) {
    				alert("이미지 파일이 아닙니다.");
    			}
    		});

    	});

    	/* var, method related with attachFile */
    	let regex = new RegExp("(.*?)\.(jpg|png)$");
    	let maxSize = 1048576; //1MB	

    	function fileCheck(fileName, fileSize) {

    		if(!regex.test(fileName)){
    			console.log(fileName)
    			alert("해당 종류의 파일은 업로드할 수 없습니다.");
    			return false;
    		}

    		if (fileSize >= maxSize) {
    			alert("파일 사이즈 초과");
    			return false;
    		}

    		return true;

    	}
    	//이미지 출력
    	function showUploadImage(uploadResultArr){
    		/* 전달받은 데이터 검증 */
    		if(!uploadResultArr || uploadResultArr.length == 0){return}
    		
    		let uploadResult = $("#editor");
    		let obj = uploadResultArr[0];
    		let str = "";
    		let fileCallPath = obj.img_uploadPath.replace(/\\/g, '/') + "/s_" + obj.img_uuid + "_" + obj.img_fileName;
    		
    		
    		str += "<img src='/board/display?filename=" + fileCallPath +"'>";
    		str += "<input type='hidden' name='imageList[0].img_fileName' value='"+ obj.img_fileName +"'>";
    		str += "<input type='hidden' name='imageList[0].img_uuid' value='"+ obj.img_uuid +"'>";
    		str += "<input type='hidden' name='imageList[0].img_uploadPath' value='"+ obj.img_uploadPath +"'>";		
    		
       		uploadResult.append(str);   
    	}
    	 
    </script>

    <script type="text/javascript">

    	// 에디터 버튼     
        const editor = document.getElementById('editor');
        const btnBold = document.getElementById('btn-bold');
        const btnItalic = document.getElementById('btn-italic');
        const btnUnderline = document.getElementById('btn-underline');
        const btnStrike = document.getElementById('btn-strike');
        const btnOrderedList = document.getElementById('btn-ordered-list');
        const btnUnorderedList = document.getElementById('btn-unordered-list');

        btnBold.addEventListener('click', function () {
            setStyle('bold');
        });

        btnItalic.addEventListener('click', function () {
            setStyle('italic');
        });

        btnUnderline.addEventListener('click', function () {
            setStyle('underline');
        });

        btnStrike.addEventListener('click', function () {
            setStyle('strikeThrough')
        });

        btnOrderedList.addEventListener('click', function () {
            setStyle('insertOrderedList');
        });

        btnUnorderedList.addEventListener('click', function () {
            setStyle('insertUnorderedList');
        });

        function setStyle(style) {
            document.execCommand(style);
            focusEditor();
        }

        // 버튼 클릭 시 에디터가 포커스를 잃기 때문에 다시 에디터에 포커스를 해줌
        function focusEditor() {
            editor.focus({preventScroll: true});
        }
        

        

       
    </script>
</body>
</html>