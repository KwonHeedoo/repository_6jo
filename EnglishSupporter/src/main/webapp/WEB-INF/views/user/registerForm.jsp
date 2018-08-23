<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>ENGLISH SUPPORTER</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link href="resources/styles/layout.css" rel="stylesheet" type="text/css" media="all">
<style type="text/css">
span#idcheck {
	color: white;

}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
	
	$(function(){
		$("#userid").on('keyup', function(){
			
			$.ajax({
			url : "idcheck"
			,type : "post"
			,data : {"userid" : $(this).val()}
			,success : function(resp){
				if(resp == 1){
					$('#idcheck').text("중복된 아이디가 있습니다");
					$('#idcheck').css("color" , "red");
				}else if(resp == 0){
					$('#idcheck').text("아이디를 사용할수 있습니다");
					$('#idcheck').css("color" , "blue");
				}else if(resp == -1){
					$('#idcheck').text("id는 3~ 7자리로 입력해주세요");
					$('#idcheck').css("color" , "black");
				}
			}
			,error : function(resp){
				alert("통신실패")
			}
			
					});

			});
		});
	
	
	</script>
	
	
	
</head>
<body id="top">
<div class="wrapper row0">
  <div id="topbar" class="hoc clear"> 
    <div class="fl_left">
      <ul>
        <li><i class="fa fa-phone"></i> +00 (123) 456 7890</li>
        <li><i class="fa fa-envelope-o"></i> info@domain.com</li>
      </ul>
    </div>
    <div class="fl_right">
      <ul>
        <li><a href="#"><i class="fa fa-lg fa-home"></i></a></li>
        <li><a href="#">Login</a></li>
        <li><a href="#">Register</a></li>
      </ul>
    </div>
  </div>
</div>

<div class="wrapper row1">
  <header id="header" class="hoc clear"> 
    <div id="logo" class="fl_left">
      <h1><a href="#">ENGLISH SUPPORTER</a></h1>
    </div>
    
    
    <nav id="mainav" class="fl_right">
      <ul class="clear">
        <li id="home"><a href="./">Home</a></li>
        <li id="wordtra"><a href="goWordtest">Word Training</a></li>
        <li><a href="./goComposition">Text Training</a></li>
        <li><a class="drop" href="#">Resume Management</a>
          <ul>
            <li><a href="#">Gallery</a></li>
            <li><a href="#">Full Width</a></li>
            <li><a href="#">Sidebar Left</a></li>
            <li><a href="#">Sidebar Right</a></li>
            <li><a href="#">Basic Grid</a></li>
          </ul>
        </li>
        <li><a class="drop" href="#">MyPage</a>
          <ul>
            <li><a href="#">Level 2</a></li>
            <li><a class="drop" href="#">Level 2 + Drop</a>
              <ul>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
                <li><a href="#">Level 3</a></li>
              </ul>
            </li>
            <li><a href="#">Level 2</a></li>
          </ul>
        </li>
      </ul>
    </nav>
    
  </header>
  </div>
  

	<form id="useridcheck" method="post" action="#">

		<h3 align=left>회원가입양식</h3>

		<div class="form-group">
			<input type="text" class="form-control" placeholder="아이디"
				name="userid" maxlength="20" id="userid">
				<span id="idcheck" ></span>
		</div>

		<div class="form-group">
			<input type="password" class="form-control" placeholder="비밀번호"
				name="userpwd" maxlength="20" id="userpwd">
		</div>
		<div class="form-group">
			<input type="password" class="form-control" placeholder="비밀번호확인"
				name="userpwdCheck" maxlength="20" id="userpwdCheck">

		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="닉네임"
				id="nickname" name="nickname" maxlength="20">
		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="이메일주소"
				id="email" name="email" maxlength="20"> 

		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="생일"
				name="birthdate" maxlength="20"> ex ) 900101 (공백없이)
		</div>
		<div class="form-group">
			<input type="text" class="form-control" placeholder="이름"
				name="username" maxlength="20" id="username">
		</div>

		<p>
			<input id="login" type="button" value="로그인" />
		</p>

	</form>

<!------ Include the above in your HEAD tag ---------->
</body>
	



<div class="wrapper row4">
  <footer id="footer" class="hoc clear"> 
    <div class="one_third first">
      <h6 class="heading">Exative</h6>
      <nav>
        <ul class="nospace">
          <li><a href="#"><i class="fa fa-lg fa-home"></i></a></li>
          <li><a href="#">About</a></li>
          <li><a href="#">Contact</a></li>
          <li><a href="#">Terms</a></li>
          <li><a href="#">Privacy</a></li>
          <li><a href="#">Cookies</a></li>
          <li><a href="#">Disclaimer</a></li>
          <li><a href="#">Online Shop</a></li>
          <li><a href="#">Sitemap</a></li>
        </ul>
      </nav>
      <ul class="faico clear">
        <li><a class="faicon-facebook" href="#"><i class="fa fa-facebook"></i></a></li>
        <li><a class="faicon-twitter" href="#"><i class="fa fa-twitter"></i></a></li>
        <li><a class="faicon-dribble" href="#"><i class="fa fa-dribbble"></i></a></li>
        <li><a class="faicon-linkedin" href="#"><i class="fa fa-linkedin"></i></a></li>
        <li><a class="faicon-google-plus" href="#"><i class="fa fa-google-plus"></i></a></li>
        <li><a class="faicon-vk" href="#"><i class="fa fa-vk"></i></a></li>
      </ul>
    </div>
    <div class="one_third">
      <h6 class="heading">Aenean molestie velit</h6>
      <ul class="nospace linklist contact">
        <li><i class="fa fa-map-marker"></i>
          <address>
          Street Name &amp; Number, Town, Postcode/Zip
          </address>
        </li>
        <li><i class="fa fa-phone"></i> +00 (123) 456 7890</li>
        <li><i class="fa fa-envelope-o"></i> info@domain.com</li>
      </ul>
    </div>
    <div class="one_third">
      <h6 class="heading">Aliquam sit condimentum</h6>
      <form method="post" action="#">
        <fieldset>
          <legend>Newsletter:</legend>
          <input class="btmspace-15" type="text" value="" placeholder="Name">
          <input class="btmspace-15" type="text" value="" placeholder="Email">
          <button type="submit" value="submit">Submit</button>
        </fieldset>
      </form>
    </div>
  </footer>
</div> 
<script src="resources/scripts/jquery.min.js"></script>
<script src="resources/scripts/jquery.backtotop.js"></script>
<script src="resources/scripts/jquery.mobilemenu.js"></script>
<script src="resources/scripts/jquery.flexslider-min.js"></script>
</body>

</html>