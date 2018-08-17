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
				, success : repetitionCheck
				, error : function(resp){ alert("Error!");}
			});
		}else if(confirm.includes("grammer")){
			grammerCheck(null, composition, confirm);
		}else if(confirm.includes("emotion")){
			emotionCheck(null, composition, confirm);
		}
		
	});
});
	
function repetitionCheck(resp, composition, confirm){
	var item = resp.wordList;
	var result = "";
	
	for(var i in item){
		result += "<p>";
		result += item[i];
		result += "</p>";
		result += "<br/>";
	}
	
	if(confirm.includes("grammer")){
		grammerCheck(resp, composition, confirm);
	}else if(confirm.includes("emotion")){
		emotionCheck(resp, composition, confirm);
	}else{
		$("#result").html(result);
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
        	alert(data.documents.score);
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
	<div id="result"></div>
</body>
</html>