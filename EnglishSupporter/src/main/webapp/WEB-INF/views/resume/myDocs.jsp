<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Resume</title>
<script src="resources/jquery-3.3.1.min.js"></script>
<script src="resources/jquery.serialize-object.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style>

input[type='text'], input[type='date'] {
margin:0 auto;
height: 28px;
width: 100%
}
::placeholder{
 color: #dad9d9;
 font-size: 9pt;
}

.add{
width: 30px;
margin-left: 0;
}

.box{
height: 55px;
}
h5{
font-weight: bold;
}

ul.tabs {
    margin: 0;
    padding: 0;
    float: left;
    list-style: none;
    height: 32px;
    border-bottom: 1px solid #eee;
    border-left: 1px solid #eee;
    width: 100%;
    font-family:"dotum";
    font-size:12px;
}
ul.tabs li {
    float: left;
    text-align:center;
    cursor: pointer;
    width:150px;
    height: 31px;
    line-height: 31px;
    border: 1px solid #eee;
    border-left: none;
    font-weight: bold;
    background: #fafafa;
    overflow: hidden;
    position: relative;
}
ul.tabs li.active {
    background: #FFFFFF;
    border-bottom: 1px solid #FFFFFF;
}
.tab_container {
    border-top: none;
    clear: both;
    float: left;
    background: #FFFFFF;
}
.tab_content {
    padding: 5px;
    font-size: 12px;
    display: none;
    margin: 0 auto;
}
.tab_container .tab_content ul {
    width:100%;
    margin:0px;
    padding:0px;
}
.tab_container .tab_content ul li {
    padding:5px;
    list-style:none
}

 #container {
	 width:100%;
    overflow: auto;
    margin-top: 20px;
    margin-bottom: 30px;
}
</style>
</head>
<body>
	<%@ include file="/WEB-INF/views/header.jsp"%>
<div id="container">
    <ul class="tabs">
        <li rel="tab1">COVER LETTER</li>
        <li rel="tab2">RESUME(CV)</li>
    </ul>
    <div class="tab_container">
        <!-- #tab1 -->
        <div id="tab1" class="tab_content">
        2222Mortal Kombat returns after a lengthy hiatus and puts players back into the Tournament for 2D fighting with gruesome combat.
        </div>
        <!-- #tab2 -->
        <div id="tab2" class="tab_content">
        3333Halo: Reach is the culmination of the superlative combat, sensational multiplayer, and seamless online integration that are the hallmarks of this superb series.
        </div>
        <!-- #tab3 -->
    </div>
    <!-- .tab_container -->
</div>
<!-- #container -->
	<%@ include file="/WEB-INF/views/Footer.jsp"%>
</body>
<script type="text/javascript">
$(function () {

    $(".tab_content").hide();
    $(".tab_content:first").show();

    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active").css("color", "#333");
        //$(this).addClass("active").css({"color": "darkred","font-weight": "bolder"});
        $(this).addClass("active").css("color", "#d00202");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).fadeIn()
    });
});

</script>
</html>