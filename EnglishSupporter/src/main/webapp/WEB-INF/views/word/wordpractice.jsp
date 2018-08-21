<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<!-- <script src='../resources/voicerss-tts.min.js'></script> -->
<script type="text/javascript">
	$(function() {
		$('a.say').on('click',function(e) {
			e.preventDefault();
			var text = $('input[name="text"]').val();
			text = encodeURIComponent(text);
			//var apikey = "3100d4db68664b858bb58864ea49e91e";
			var url = 'http://api.voicerss.org/?key=3100d4db68664b858bb58864ea49e91e&hl=en-gb&src='+ text;
		$('audio.audio').attr('src', url).get(0).play();

		});
		
		$('#wordtra').addClass('active');
	});
</script>
<script src="https://cdn.webrtc-experiment.com/RecordRTC.js"></script>
<script src="https://webrtc.github.io/adapter/adapter-latest.js"></script>

<style type="text/css">
.container {
	text-align: center;
}

input {
	border: none;
	background: transparent;
	font-size: 30pt;
	width: 100%;
	text-align: center;
	margin-top: 50px;
	margin-bottom: 10px;
}
</style>
</head>


<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<div class="jumbotron jumbotron-fluid">
		<div class="container">
			<div>
				
				<a href="#" id="mywordstar"><img id="checkmyword" src="" alt="star" border="0" /></a>
				<br>
				<span>[학습어휘종류선택]</span> <br>
				<span id="userworddelete"></span>
					<select id ="level" class="form-control">
					<option value="1">난이도 초급</option>
					<option value="2">난이도 중급</option>
					<option value="3">난이도 상급</option>
					<option value="0">나의단어장</option>
				</select>
			</div>

			<div class="raw">
					<div class="col-md-12">
						<input type="text" name="text" class="" value="" readonly>
					</div>
					<br>
					<div class="col-md-12">
						<span id="meaning"></span>
					</div>
					<br><br>
					<div class="col-md-12">
						<a href="#" class="say btn">sayit</a>
					</div>
							
			</div>
		<div align="center">
		<div><span class="word"></span></div>
			<ul class="pagination">
			
				<li class="page-item"><a class="page-link" href="#" id="before">Previous</a></li>
				<li class="page-item"><a class="page-link" href="#" id="next">Next</a></li>
			</ul>
		</div>
		</div>

	<div class="col-md-12" style="text-align: right">
		<a href="#" class="writeword btn">신규 단어 직접 입력</a>
		</div>
	</div>	
		<div align="center">
	<hr>
	<button id="btn-start-recording">Start Recording</button> <button id="btn-stop-recording" disabled>Stop Recording</button>
	<hr>
		<audio controls id="playaudio"></audio>
		</div>
	
	<audio src="" class="audio" hidden></audio>
	
<%@ include file="/WEB-INF/views/Footer.jsp"%>
<script>
var audio = document.querySelector('#playaudio');

function captureMicrophone(callback) {
    navigator.mediaDevices.getUserMedia({audio: true}).then(callback).catch(function(error) {
        alert('Unable to access your microphone.');
        console.error(error);
    });
}

function stopRecordingCallback() {
    var blob = recorder.getBlob();
    audio.src = URL.createObjectURL(blob);
    audio.play();

    recorder.microphone.stop();
}

var recorder; // globally accessible

document.getElementById('btn-start-recording').onclick = function() {
    //this.disabled = true;
    captureMicrophone(function(microphone) {
        setSrcObject(microphone, audio);
        audio.play();

        recorder = RecordRTC(microphone, {
            type: 'audio',
            recorderType: StereoAudioRecorder,
            desiredSampRate: 16000
        });

        recorder.startRecording();

        // release microphone on stopRecording
        recorder.microphone = microphone;

        document.getElementById('btn-stop-recording').disabled = false;
    });
};

document.getElementById('btn-stop-recording').onclick = function() {
   // this.disabled = true;
    recorder.stopRecording(stopRecordingCallback);
};
</script>					
	<script type="text/javascript">
		var index = 0;
		var listsize=0;
		var wordlist = new Array();
		var level =0;

		$(function() {
			level = 1;
			callwordlist(level)
			//initword(wordlist);
			//단어이동 클릭이벤트 
			$('#before').on('click', function() {
				if(index>0){
					index--;
				}
				$('#meaning').text(wordlist[index].meaningK);
				$('input[name="text"]').val(wordlist[index].word);
				checkstar();
				viewNum();
			});
			
			$('#next').on('click', function() {
				if(index<listsize-1){
					index++;
				}
				$('#meaning').text(wordlist[index].meaningK);
				$('input[name="text"]').val(wordlist[index].word);
				checkstar();
				viewNum();
			});
			
		//난이도별 단어 가져오기 
		$('#level').change(function(){
			index=0; // 인덱스 초기화
			level = $(this).val();
			//console.log(level);
			callwordlist(level);
		});
	});
	
		function initword(wordlist){	
			//console.log(wordlist[index].meaningK);
			$('#meaning').text(wordlist[index].meaningK);
			$('input[name="text"]').val(wordlist[index].word);
			checkstar();
		}
		
		function checkstar(){
			var checked = wordlist[index].wordtype;
			console.log(checked);
			$('#userworddelete').html("");
			if(checked=='star'){
				$('#checkmyword').attr('src','./resources/images/icons/golden.png');
			}else if(checked =='user'){
				$('#checkmyword').attr('src','./resources/images/icons/golden.png');
				var text ='<a id="deletemyword" href="#">삭제</a>';
				$('#userworddelete').html(text);
			}else{
				$('#checkmyword').attr('src','./resources/images/icons/silver.png');
				
			}
		}
		
	function viewNum(){
		console.log(index);
		console.log(listsize);
		var wordnum = index+1;
		$('span.word').text(wordnum+" / "+listsize);
	}
		
		
	function callwordlist(level) {
		$.ajax({
			
			method: "post",
			url: "getMyWords",
			data : {'wordlevel' : level},
			success: function(reps){
				wordlist = reps;
				
				listsize =wordlist.length;
				
				console.log(wordlist);
				console.log(listsize);
				initword(wordlist);
				viewNum();
			},
			
		});
	}
	
	// 별 클릭후 다시 디비에서 단어들을 불러와야 함...
	$('#mywordstar').on('click',function(){
		var src = $('#checkmyword').attr('src');
		console.log(src);
		var word= $('input[name="text"]').val();
		var word = wordlist[index];
		
		if(src.includes('golden')){
			$('#checkmyword').attr('src','./resources/images/icons/silver.png');
			// 나의 단어장에서 해당 단어 삭제처리하기 			
			word.command = 'delete';
		}else{
			$('#checkmyword').attr('src','./resources/images/icons/golden.png');
			//나의 단어장에 해당단어 추가하기 
			word.command = 'insert';
		}
		console.log(word);
		
			$.ajax({
				method: "post",
				url: "controlMyWords",
				data : word,
				success: function(reps){
					var result = reps;
					callwordlist(level);
				}
			});
		
	});
	
	$(function() {
		$('a.writeword').on('click',function(){
			window.open("insertword","newidwindow","top=150,left=150,width=500,height=400");
		});
	});
		
	</script>
</body>
</html>