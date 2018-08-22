<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Confirmed</title>
<!-- google CDN -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var composition = $("#composition").val();
	var confirm = $("#confirm").val();
	
	if(confirm.includes("grammer")){
		grammerCheck(composition, confirm);
	}else if(confirm.includes("emotion")){
		emotionCheck(composition, confirm, null);
	}else if(confirm.includes("repetition")){
		repetitionCheck(composition, confirm, null, null)
	}else{
		result(composition, confirm, null, null, null);
	}
});

// 문법 체크
function grammerCheck(composition, confirm){
	$(function(){
		// \n, \r 등을 공백으로 바꿔줌
		var data = composition.replace(/(\r\n\t|\r\n|\n|\r\t)/gm, " ");
		// [TextGears] Grammar check API
		$.ajax({
			url : "https://api.textgears.com/check.php?text=" + JSON.stringify(data) + "&key=o6qm0xkLbPcr4Wk0"
			, type : "post"
			, success : function(grammer){
				// 텍스트 감정 분석 체크를 한 경우
				if(confirm.includes("emotion")){
					emotionCheck(composition, confirm, grammer);
				// 중복 단어 체크만 한 경우
				}else if(confirm.includes("repetition")){
					repetitionCheck(composition, confirm, grammer, null)
				// 둘 다 체크를 안 한 경우
				}else{
					result(composition, confirm, grammer, null, null);
				}
			}
			, error : function(grammer){ alert("Grammer Error!"); }
		});
	});
}

// 텍스트 감정 분석 체크
function emotionCheck(composition, confirm, grammer){
	$(function() {
		var data = { "documents": [
		    {
  		      "language": "en"
  		      , "id": "1"
  		      , "text": composition
  		    }
  		  ]};
	    // [Microsoft] Text Analytics API
        $.ajax({
            url: "https://eastasia.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment"
            , beforeSend: function(xhrObj){
                xhrObj.setRequestHeader("Content-Type","application/json");
                xhrObj.setRequestHeader("Ocp-Apim-Subscription-Key","148b9c6ad1724028ae05302a71ab45ee");
            }
            , type: "POST"
            , data: JSON.stringify(data)
            		
        })
        .done(function(emotion) {
        	// 중복 단어 체크를 한 경우
            if(confirm.includes("repetition")){
            	repetitionCheck(composition, confirm, grammer, emotion);
            // 체크를 안 한 경우
            }else{
            	result(composition, confirm, grammer, emotion, null);
            }
        })
        .fail(function() { alert("Emotion Error!"); });
    });
}

// 중복 단어 체크
function repetitionCheck(composition, confirm, grammer, emotion){
	$(function() {
		$.ajax({
			url : "repetitionCheck"
			, type : "post"
			, dataType : "json"
			, data : {"composition" : composition, "confirm" : confirm}
			, success : function(repetition){
				result(composition, confirm, grammer, emotion, repetition);	
			}
			, error : function(repetition){ alert("Repetition Error!");}
		});
	});
	
}

// 결과 출력
function result(composition, confirm, grammer, emotion, repetition){
	var wordList = repetition;
	var resultComp = "";
	var repResult = "";
	var emoResult = "";
	var graResult = "";
	
	// 문법 체크를 한 경우
	if(grammer != null){
		var jsonStrGrammer = JSON.stringify(grammer);
		var gra = JSON.parse(jsonStrGrammer);
		if(gra.result == true){
			graResult += '<h3>[Grammer Check]</h3>';
			graResult += '<table>';
			var strIndex = 0;
			// 틀린 단어 & 개선 단어
			$.each(gra.errors, function(index, item){
				if(index != 0){
					graResult += '<tr>';
					graResult += '<td style="color:red;">' + item.bad + '</td>';
					graResult += '<td><b> → </b></td>';
					graResult += '<td style="color:green;">' + item.better + '</td>';
					graResult += '</tr>';
					
					// 틀린 단어에 빨간 밑줄
					resultComp += composition.substring(strIndex, item.offset-2);
					resultComp += ' <span style="text-decoration: underline dotted red;">' + composition.substring(item.offset-1, (item.offset-1) + item.length) + '</span> ';
					strIndex = item.offset + item.length;
				}
			});
			resultComp += composition.substring(strIndex);
			graResult += '</table>';
		}
	// 문법 체크를 하지 않은 경우
	}else{
		resultComp = composition;
	}
	
	// \n를 <br>태크로 변환
	resultComp = resultComp.replace(/\n/g, '<br/>');
	// replaceAll 함수
	String.prototype.replaceAll = function(org, dest) {
	    return this.split(org).join(dest);
	}
	
	// 중복 단어가 있는 경우
	if(wordList.length != 0){
		// 중복 단어에 하이라이트
		$.each(wordList, function(index, item){
			resultComp = resultComp.replaceAll(item.word, '<span style="background-color:yellow;">' + item.word + '</span>');
		});
		resultComp += '<br/><br/>';
		repResult += '<h3>[Synonym Word]</h3>';
		// 유의어가 존재하는 경우
		$.each(wordList, function(index, item){
			repResult += '<p>';
			if(item.meaningK != null){
				repResult += '<b>' + item.word + '</b>';
				repResult += '<br/>';
				repResult += item.meaningK;
			}
			repResult += '</p>';
		});
	}else{
		resultComp += '<br/><br/>';
	}
	
	// 텍스트 감정 분석이 된 경우
	if(emotion != null){
		var jsonStrEmotion = JSON.stringify(emotion);
		var emo = JSON.parse(jsonStrEmotion);
		var emoScore = emo.documents[0].score * 100;
		emoResult += '<p>';
		emoResult += '<h3>[Composition Emotion]</h3>';
		// 감정 수치
		emoResult += emoScore.toFixed(2) + '%';
		// 감정 평가
		if(emoScore.toFixed(2) >= 0 && emoScore.toFixed(2) < 20)
			emoResult += '[<span style="color:red;">Negative</span>]';
		else if(emoScore.toFixed(2) >= 20 && emoScore.toFixed(2) < 40)
			emoResult += '[<span style="color:orange;">Little Negative</span>]';
		else if(emoScore.toFixed(2) >= 40 && emoScore.toFixed(2) < 60)
			emoResult += '[<span style="color:yellow;">Normal</span>]';
		else if(emoScore.toFixed(2) >= 60 && emoScore.toFixed(2) < 80)
			emoResult += '[<span style="color:green;">Little Positive</span>]';
		else if(emoScore.toFixed(2) >= 80 && emoScore.toFixed(2) <= 100)
			emoResult += '[<span style="color:blue;">Positive</span>]';
		emoResult += '</p>';
	}
	
	// 결과 값 출력
	$("#resultComp").html(resultComp);
	$("#repResult").html(repResult);
	$("#emoResult").html(emoResult);
	$("#graResult").html(graResult);
}
</script>
</head>
<body>
<%@ include file="/WEB-INF/views/header.jsp"%>
	<h1>Confirmed Page</h1>
	<input id="composition" type="hidden" value="${composition}">
	<input id="confirm" type="hidden" value="${confirm}">
	<!-- 작성한 문장 -->
	<div id="resultComp"></div>
	<!-- 문법 체크로 수정 된 단어 -->
	<div id="graResult"></div>
	<!-- 중복 단어 및 유의어 -->
	<div id="repResult"></div>
	<!-- 텍스트 감정 분석 결과 -->
	<div id="emoResult"></div>
<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
</html>