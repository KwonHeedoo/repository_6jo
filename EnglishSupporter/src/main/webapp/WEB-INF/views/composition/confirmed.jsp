<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Confirmed</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	var composition = $("#composition").val();
	var confirm = $("#confirm").val();
	
	$(function(){
		if(confirm.includes("repetition")){
			$.ajax({
				url : "repetitionCheck"
				, type : "post"
				, dataType : "json"
				, data : {"composition" : composition, "confirm" : confirm}
				, success : function(resp){
					repetitionCheck(resp, composition, confirm);	
				}
				, error : function(resp){ alert("Error!");}
			});
		}else if(confirm.includes("grammer")){
			grammerCheck(null, composition, confirm);
		}else if(confirm.includes("emotion")){
			emotionCheck(null, composition, confirm);
		}else{
			var result = "<p>" + composition + "</p>"
			$("#result1").html(result);
		}
		
	});
});
	
function repetitionCheck(resp, composition, confirm){
	var wordList = resp;
	var result1 = "";
	var result2 = "";
	
	result1 = composition.replace(/\n/g, '<br/>');
	
	String.prototype.replaceAll = function(org, dest) {
	    return this.split(org).join(dest);
	}
	
	$.each(wordList, function(index, item){
		result1 = result1.replaceAll(item.word, '<span style="background-color:yellow;">' + item.word + '</span>');
	});
	result1 += "<br/><br/>";
	
	$.each(wordList, function(index, item){
		result2 += "<p>";
		result2 += item.word;
		result2 += "<br/>";
		result2 += item.meaningK;
		result2 += "</p>";
	});
	
	if(confirm.includes("grammer")){
		grammerCheck(resp, composition, confirm);
	}else if(confirm.includes("emotion")){
		emotionCheck(resp, composition, confirm);
	}else{
		$("#result1").html(result1);
		$("#result2").html(result2);
	}
}

function grammerCheck(resp, composition, confirm){
	$(function(){
		var data = composition.replace(/(\r\n\t|\n|\r\t)/gm, " ");
		alert(JSON.stringify(data));
		/* $.ajax({
			url : "https://api.textgears.com/check.php?text="+JSON.stringify(data)+"&key=o6qm0xkLbPcr4Wk0"
			, type : "post"
			, success : function(data){
				alert(JSON.stringify(data));
			}
			, error : function(data){ alert("Error!"); }
		}); */
	});
}

function emotionCheck(resp, composition, confirm){
	$(function() {
		var data = { "documents": [
		    {
  		      "language": "en"
  		      , "id": "1"
  		      , "text": composition
  		    }
  		  ]};
      
        $.ajax({
            url: "https://eastasia.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment"
            , beforeSend: function(xhrObj){
                // Request headers
                xhrObj.setRequestHeader("Content-Type","application/json");
                xhrObj.setRequestHeader("Ocp-Apim-Subscription-Key","148b9c6ad1724028ae05302a71ab45ee");
            }
            , type: "POST"
            // Request body
            , data: JSON.stringify(data)
            		
        })
        .done(function(data) {
            alert(JSON.stringify(data));
        })
        .fail(function() {
            alert("Error!");
        });
    });
}
</script>
</head>
<body>
	<h1>Confirm Page</h1>
	<input id="composition" type="hidden" value="${composition}">
	<input id="confirm" type="hidden" value="${confirm}">
	<div id="result1"></div>
	<div id="result2"></div>
	<div id="result3"></div>
	<div id="result4"></div>
</body>
</html>