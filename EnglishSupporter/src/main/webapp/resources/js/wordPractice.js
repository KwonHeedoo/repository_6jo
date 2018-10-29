window.onload = function(){ 
	
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
	
var audio = document.querySelector('#playaudio');

function captureMicrophone(callback) {
    navigator.mediaDevices.getUserMedia({audio: true}).then(callback).catch(function(error) {
        alert('Unable to access your microphone.');
        console.error(error);
    });
}

var data; // globally 

function stopRecordingCallback() {
    var blob = recorder.getBlob();
    audio.src = URL.createObjectURL(blob);
    audio.play();
    recorder.microphone.stop();
  //인코딩을 했으나 정확한 형식으로 되는 것 같지 않음  
}
var recorder; // globally accessible

document.getElementById('btn-start-recording').onclick = function(){
    //this.disabled = true;
    captureMicrophone(function(microphone) {
        setSrcObject(microphone, audio);
        audio.play();

        recorder = RecordRTC(microphone, {
            type: 'audio',
            recorderType: StereoAudioRecorder,
        });

        recorder.startRecording();

        // release microphone on stopRecording
        recorder.microphone = microphone;

        document.getElementById('btn-stop-recording').disabled = false;
    });
};

document.getElementById('btn-stop-recording').onclick = function(){
    recorder.stopRecording(stopRecordingCallback);
};

var index = 0;
var listsize=0;
var wordlist = new Array();
var level =0;

		$(function() {
			level = 1;
			callwordlist(level)
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
			callwordlist(level);
		});
	});
	
		function initword(wordlist){	
			$('#meaning').text(wordlist[index].meaningK);
			$('input[name="text"]').val(wordlist[index].word);
			checkstar();
		}
		
		function checkstar(){
			var checked = wordlist[index].wordtype;
			//console.log(checked);
			$('#userworddelete').html("");
			if(checked=='star'){
				$('#checkmyword').attr('src','./resources/images/icons/golden.png');
			}else if(checked =='user'){
				$('#checkmyword').attr('src','./resources/images/icons/golden.png');
			}else{
				$('#checkmyword').attr('src','./resources/images/icons/silver.png');
				
			}
		}
		
	function viewNum(){
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
				
				console.log(reps);
				console.log(listsize);
				if(listsize>0){
				initword(wordlist);
				viewNum();
				}else{
					$('#meaning').text("");
					$('input[name="text"]').val("There are no words in MyWords");
					$('span.word').text("0 / 0");
					//$('#mywordstar').unbind('click', false); //클릭 이벤트 봉쇄 
				}
			},
			
		});
	}
	
	// 별 클릭후 다시 디비에서 단어들을 불러와야 함...
	$('#mywordstar').on('click',function(){
	if(listsize>0){
		var src = $('#checkmyword').attr('src');
		console.log(src);
		var word= $('input[name="text"]').val();
		var word = wordlist[index];
		
		if(src.includes('golden')){
			$('#checkmyword').attr('src','./resources/images/icons/silver.png');
			// 나의 단어장에서 해당 단어 삭제처리하기 			
			word.command = 'delete';
			console.log('삭제처리');
		}else{
			$('#checkmyword').attr('src','./resources/images/icons/golden.png');
			//나의 단어장에 해당단어 추가하기 
			word.command = 'insert';
		}
			$.ajax({
				method: "post",
				url: "controlMyWords",
				data : word,
				success: function(reps){
					var result = reps;
					console.log(result);
					callwordlist(level);
				}
			});
		}
	});
	
	$(function() {
		$('a.writeword').on('click',function(){
			window.open("insertword","newidwindow","top=150,left=150,width=500,height=300");
		});
	});
}