<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="language" value="${language}" />

<!DOCTYPE html>
<html lang="UTF-8">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Gorea SignUp</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- 1. 폰트어썸 CDN / 2. jQuery -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="stylesheet" type="text/css" href="/css/join/join.css">
<link rel="stylesheet" type="text/css" href="/css/footer/footer.css">
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&family=Noto+Sans+KR&family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">


<script type="text/javascript">
$(function(){
	
	const viewUrl = window.location.href;

	// URL에서 '/어떤언어/' 부분을 정규표현식을 사용하여 추출
	const languageCodeMatch = viewUrl.match(/\/([a-z]+)\//i);
	const languageCode = languageCodeMatch ? languageCodeMatch[1] : null;

	console.log(languageCode);
	
    
	let isUsernameAvailable = false;
    let isNicknameAvailable = false;
 
    $("#username").on("change keyup",function(){
    	
    	// 회원가입 조건을 만족시킬때 ture로 사용할 변수선언 ( id, nickname 중복검사)
        let username = $("#username").val();
        
     	// 아이디가 빈칸이거나 "admin"일 경우 메시지 표시
     	if(languageCode === 'korean'){
     		
     		if (!username || username.toLowerCase().includes("admin") || username.toLowerCase().includes("google")) {
            	
                $("#result_checkUsername").html("해당 아이디로는 가입이 불가능합니다.").css("color", "red");
                return;
            }
            
            if (!/^[a-zA-Z]/.test(username)) {
                $("#result_checkUsername").html("아이디의 첫 글자는 영문자로 시작해야 합니다.").css("color", "red");
                return;
            }
     		
     	} else if(languageCode === 'english'){
     		
			if (!username || username.toLowerCase().includes("admin") || username.toLowerCase().includes("google")) {
            	
                $("#result_checkUsername").html("This ID cannot be registered.").css("color", "red");
                return;
            }
            
            if (!/^[a-zA-Z]/.test(username)) {
                $("#result_checkUsername").html("The first letter of your ID must start with an English letter.").css("color", "red");
                return;
            }
     		
     	} else if(languageCode === 'japanese'){
     		
			if (!username || username.toLowerCase().includes("admin") || username.toLowerCase().includes("google")) {
            	
                $("#result_checkUsername").html("このIDは登録できません。").css("color", "red");
                return;
            }
            
            if (!/^[a-zA-Z]/.test(username)) {
                $("#result_checkUsername").html("ID の最初の文字は英語の文字で始まる必要があります。").css("color", "red");
                return;
            }
     		
     	} else if(languageCode === 'chinese'){
     		
			if (!username || username.toLowerCase().includes("admin") || username.toLowerCase().includes("google")) {
            	
                $("#result_checkUsername").html("该ID无法注册。").css("color", "red");
                return;
            }
            
            if (!/^[a-zA-Z]/.test(username)) {
                $("#result_checkUsername").html("您的身份证件的第一个字母必须以英文字母开头。").css("color", "red");
                return;
            }
     		
     	}
     	
        $.ajax({
            type:'post', //post 형식으로 controller 에 보내기위함!!
            url:"/checkUsername.do", // 컨트롤러로 가는 mapping 입력
            data: {"username":username}, // 원하는 값을 중복확인하기위해서  JSON 형태로 DATA 전송
            success: function(data){ 
                if(data == "N"){ // 만약 성공할시
                	if(languageCode === 'korean'){
                		result = "사용 가능한 아이디 입니다.";
                	} else if(languageCode === 'english'){
                		result = "ID is available.";
                	} else if(languageCode === 'japanese'){
                		result = "IDは利用可能です.";
                	} else if(languageCode === 'chinese'){
                		result = "身份证可用。.";
                	}
                    	$("#result_checkUsername").html(result).css("color", "#007DC3");
                    	$("#username").trigger("focus");
                    	
                    	isUsernameAvailable = true;
                 
             	}else{ // 만약 실패할시
					if(languageCode === 'korean'){
	                 	result="이미 사용중인 아이디 입니다.";
                	} else if(languageCode === 'english'){
                     	result="This ID is already taken.";
                	} else if(languageCode === 'japanese'){
                     	result="この ID はすでに取得されています。";
                	} else if(languageCode === 'chinese'){
                     	result="该 ID 已被占用。";
                	}
                     	$("#result_checkUsername").html(result).css("color","red");
                     	$("#username").trigger("focus");
             }
                 
         },
            error : function(error){alert(error);}
        });
        
    });
    
    $("#nickname").on("change keyup",function(){
        
        let nickname = $("#nickname").val();
        
     	// 아이디가 빈칸이거나 "admin"일 경우 메시지 표시
        if (!nickname) {
            $("#result_checkNickname").html("닉네임을 작성해주세요.").css("color", "green");
            return;
        }
         
        $.ajax({
            type:'post', //post 형식으로 controller 에 보내기위함!!
            url:"/checkUserNickname.do", // 컨트롤러로 가는 mapping 입력
            data: {"nickname":nickname}, // 원하는 값을 중복확인하기위해서  JSON 형태로 DATA 전송
            success: function(data){ 
                if(data == "N"){ // 만약 성공할시
					if(languageCode === 'korean'){
	                    result = "사용 가능한 닉네임 입니다.";
                	} else if(languageCode === 'english'){
                        result = "Available nickname.";
                	} else if(languageCode === 'japanese'){
                        result = "使用可能なニックネーム。";
                	} else if(languageCode === 'chinese'){
                        result = "可用昵称。";
                	}
                    	$("#result_checkNickname").html(result).css("color", "#007DC3");
                    	$("#nickname").trigger("focus");
                    	
                    	isNicknameAvailable = true;
                    	console.log(isNicknameAvailable);
//                         checkBothRequests();
                 
             	}else{ // 만약 실패할시
					if(languageCode === 'korean'){
	                 	result="이미 사용중인 닉네임 입니다.";
                	} else if(languageCode === 'english'){
                     	result="this nickname is already using.";
                	} else if(languageCode === 'japanese'){
                     	result="このニックネームはすでに使用されています。";
                	} else if(languageCode === 'chinese'){
                     	result="该昵称已被使用。";
                	}
                     	$("#result_checkNickname").html(result).css("color","red");
                     	$("#nickname").trigger("focus");
             }
                 
         },
            error : function(error){alert(error);}
        });
        
    });
    
    $("#username").on('input', function(){
        // 사용자가 아이디 텍스트를 변경할 때 변수 초기화
        isUsernameAvailable = false;
        console.log(isUsernameAvailable);
    });

    $("#nickname").on('input', function(){
        // 사용자가 닉네임 텍스트를 변경할 때 변수 초기화
        isNicknameAvailable = false;
        console.log(isNicknameAvailable);
    });

    if(languageCode === 'korean'){
    	$("#submitBtn").click(function(){
            if (!isUsernameAvailable && !isNicknameAvailable) {
                alert("아이디와 닉네임 중복검사를 해주세요.");
            } else {
                // 회원가입 완료
                alert("회원가입이 완료되었습니다.");
                document.joinfrm.submit();
            }
        });
	} else if(languageCode === 'english'){
		$("#submitBtn").click(function(){
	        if (!isUsernameAvailable && !isNicknameAvailable) {
	            alert("Please check for duplicate ID and nickname.");
	        } else {
	            // 회원가입 완료
	            alert("welcome! Sign up is complete.");
	            document.joinfrm.submit();
	        }
	    });
	} else if(languageCode === 'japanese'){
     	$("#submitBtn").click(function(){
            if (!isUsernameAvailable && !isNicknameAvailable) {
                alert("IDとニックネームが重複していないか確認してください。");
            } else {
                // 회원가입 완료
                alert("いらっしゃいませ！サインアップが完了しました。");
                document.joinfrm.submit();
            }
        });
	} else if(languageCode === 'chinese'){
		$("#submitBtn").click(function(){
	        if (!isUsernameAvailable && !isNicknameAvailable) {
	            alert("请检查 ID 和昵称是否重复。");
	        } else {
	            // 회원가입 완료
	            alert("欢迎！注册完成。");
	            document.joinfrm.submit();
	        }
	    });
	}
    
    
        
});
</script>

</head>

<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h3 class="mb-3">Go!rea SIGN UP</h3>
				<form class="validation-form" name="joinfrm" novalidate="" action="/${language}/joinOk.do" method="post">
					
					<!-- 아이디 중복검사 확인  ----------------------------------------------------->
					<div class="mb-3">
						<div class="input-group">
							<input type="text" class="form-control" id="username" name="username" placeholder="ID" required="">
						</div>
						<div style="margin-top: 10px;">
							<span id="result_checkUsername" style="font-size:15px;"></span>
						</div>
					</div>

					<!-- 비밀번호 입력 필드 ----------------------------------------------------->
					<c:choose>
			    		<c:when test="${language eq 'korean'}">
			    		
				    		<div class="mb-3">
				    			<label for="firstName"></label>
								<input type="password" name="password" class="form-control" id="password" 
								placeholder="비밀번호를 8자 이상 입력해주세요." required="" minlength="8">
							</div>
	
							<!-- 비밀번호 확인 입력 필드 -->
							<div class="mb-3">
								<label for="firstName"></label>
								<input type="password"
									class="form-control" id="confirm-password" placeholder="비밀번호 확인"
									required="" minlength="8">
								<div class="invalid-feedback" id="password-confirm-feedback"  style="font-size:15px; margin-top: 10px;">
									비밀번호가 일치하지 않습니다.</div>
							</div>

			    		</c:when>
			    		
			    		<c:when test="${language eq 'english'}">
			    		
				    		<div class="mb-3">
				    			<label for="firstName"></label>
								<input type="password" name="password" class="form-control" id="password" 
								placeholder="Please enter a password of at least 8 characters" required="" minlength="8">
							</div>
	
							<!-- 비밀번호 확인 입력 필드 -->
							<div class="mb-3">
								<label for="firstName"></label>
								<input type="password"
									class="form-control" id="confirm-password" placeholder="Password check"
									required="" minlength="8">
								<div class="invalid-feedback" id="password-confirm-feedback"  style="font-size:15px; margin-top: 10px;">
									Passwords do not match.</div>
							</div>

			    		</c:when>
			    		
			    		<c:when test="${language eq 'japanese'}">
			    		
				    		<div class="mb-3">
				    			<label for="firstName"></label>
								<input type="password" name="password" class="form-control" id="password" 
								placeholder="8文字以上のパスワードを入力してください" required="" minlength="8">
							</div>
	
							<!-- 비밀번호 확인 입력 필드 -->
							<div class="mb-3">
								<label for="firstName"></label>
								<input type="password"
									class="form-control" id="confirm-password" placeholder="パスワードチェック"
									required="" minlength="8">
								<div class="invalid-feedback" id="password-confirm-feedback"  style="font-size:15px; margin-top: 10px;">
									パスワードが一致していません。</div>
							</div>

			    		</c:when>
			    		
			    		<c:when test="${language eq 'chinese'}">
			    		
				    		<div class="mb-3">
				    			<label for="firstName"></label>
								<input type="password" name="password" class="form-control" id="password" 
								placeholder="请输入至少8位字符的密码" required="" minlength="8">
							</div>
	
							<!-- 비밀번호 확인 입력 필드 -->
							<div class="mb-3">
								<label for="firstName"></label>
								<input type="password"
									class="form-control" id="confirm-password" placeholder="密码检查"
									required="" minlength="8">
								<div class="invalid-feedback" id="password-confirm-feedback"  style="font-size:15px; margin-top: 10px;">
									密码不匹配。</div>
							</div>

			    		</c:when>
					</c:choose>
					
					<!-- 닉네임 중복검사 확인  ----------------------------------------------------->
					<div class="mb-3">
						<c:choose>
				    		<c:when test="${language eq 'korean'}">
				        		<div class="mb-3">
				        			<label for="firstName"></label>
									<input type="text" class="form-control" id="nickname" name="userNickname" placeholder="NickName" required="">
								</div>
				    		</c:when>
				    		
				    		<c:when test="${language eq 'english'}">
				        		<div class="mb-3">
				        			<label for="firstName"></label>
									<input type="text" class="form-control" id="nickname" name="userNickname" placeholder="NickName" required="">
								</div>
				    		</c:when>
				    		
				    		<c:when test="${language eq 'japanese'}">
				        		<div class="mb-3">
				        			<label for="firstName"></label>
									<input type="text" class="form-control" id="nickname" name="userNickname" placeholder="ニックネーム" required="">
								</div>
				    		</c:when>
				    		
				    		<c:when test="${language eq 'chinese'}">
				        		<div class="mb-3">
				        			<label for="firstName"></label>
									<input type="text" class="form-control" id="nickname" name="userNickname" placeholder="昵称" required="">
								</div>
				    		</c:when>
						</c:choose>
						
						<!-- 닉네임 중복검사 확인  -->
						<div style="margin-top: 10px;">
							<span id="result_checkNickname" style="font-size:15px;"></span>
						</div>
					</div>
					
					<!-- 닉네임 중복검사 확인  & 성 이름 ----------------------------------------------------->
					
						<c:choose>
				    		<c:when test="${language eq 'korean'}">
				    		
					    		<div class="mb-3">
									<label for="email"></label> 
									<div class="input-group">
										<input type="email" class="form-control" id="email" name="userMail" placeholder="your@e-main.com" required="">
										<input class="btn btn-primary2" type="button" id="" value="인증번호 전송" style="font-size:13px;">
									</div>
								</div>
								
								<hr/>
								<label style="color: grey;"> 선택 입력사항 </label>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="firstName"></label> <input type="text"
											class="form-control" id="firstName" name="userFirstname" placeholder="이름" value=""
											required="">
									</div>
									<div class="col-md-6 mb-3">
										<label for="lastName"></label> <input type="text"
											class="form-control" id="lastName" name="userLastname" placeholder="성" value=""
											required="">
									</div>
								</div>

				    		</c:when>
				    		
				    		<c:when test="${language eq 'english'}">
				    		
				    			<div class="mb-3">
									<label for="email"></label> 
									<div class="input-group">
										<input type="email" class="form-control" id="email" name="userMail" placeholder="your@e-main.com" required="">
										<input class="btn btn-primary2" type="button" id="" value="Send Code" style="font-size:13px;">
									</div>
								</div>
								
								<hr/>
								<label style="color: grey;"> select input </label>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="firstName"></label> <input type="text"
											class="form-control" id="firstName" name="userFirstname" placeholder="Firstname" value=""
											required="">
									</div>
									<div class="col-md-6 mb-3">
										<label for="lastName"></label> <input type="text"
											class="form-control" id="lastName" name="userLastname" placeholder="lastName" value=""
											required="">
									</div>
								</div>

				    		</c:when>
				    		
				    		<c:when test="${language eq 'japanese'}">
				    		
				    			<div class="mb-3">
									<label for="email"></label> 
									<div class="input-group">
										<input type="email" class="form-control" id="email" name="userMail" placeholder="your@e-main.com" required="">
										<input class="btn btn-primary2" type="button" id="" value="コードを送信する" style="font-size:13px;">
									</div>
								</div>
								
								<hr/>
								<label style="color: grey;"> 入力を選択 </label>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="firstName"></label> <input type="text"
											class="form-control" id="firstName" name="userFirstname" placeholder="名前" value=""
											required="">
									</div>
									<div class="col-md-6 mb-3">
										<label for="lastName"></label> <input type="text"
											class="form-control" id="lastName" name="userLastname" placeholder="名字." value=""
											required="">
									</div>
								</div>

				    		</c:when>
				    		
				    		<c:when test="${language eq 'chinese'}">
				    		
				    			<div class="mb-3">
									<label for="email"></label> 
									<div class="input-group">
										<input type="email" class="form-control" id="email" name="userMail" placeholder="your@e-main.com" required="">
										<input class="btn btn-primary2" type="button" id="" value="发送代码" style="font-size:13px;">
									</div>
								</div>
								
								<hr/>
								<label style="color: grey;"> 选择输入 </label>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="firstName"></label> <input type="text"
											class="form-control" id="firstName" name="userFirstname" placeholder="姓名" value=""
											required="">
									</div>
									<div class="col-md-6 mb-3">
										<label for="lastName"></label> <input type="text"
											class="form-control" id="lastName" name="userLastname" placeholder="名" value=""
											required="">
									</div>
								</div>

				    		</c:when>
						</c:choose>
					
					<div class="mb-3">
						<select id="country" name="userNation">
    						<option value="대한민국">대한민국</option>
	    					<option value="미국">American</option>
	    					<option value="일본">日本人</option>
	    					<option value="중국">中国人</option>
	    					<option value="기타국가">Etc</option>
						</select>
					</div>
					
						<c:choose>
				    		<c:when test="${language eq 'korean'}">
				    			<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement1" required=""> 
									<label class="custom-control-label" for="aggrement1">Go!rea 서비스 이용약관.</label>
								</div>
								<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement2" required=""> 
									<label class="custom-control-label" for="aggrement2">개인정보 수집, 제공 및 활용 동의</label>
								</div>
								
								<div class="mb-4"></div>
								<input type="button" id="submitBtn" value="회원가입" class="btn btn-primary btn-lg btn-block" style="cursor: pointer;" />
				    		</c:when>
				    		
				    		<c:when test="${language eq 'english'}">
								<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement1" required=""> 
									<label class="custom-control-label" for="aggrement1">Go!rea Service Terms of Use.</label>
								</div>
								<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement2" required=""> 
									<label class="custom-control-label" for="aggrement2">Consent to collection, provision and use of personal information</label>
								</div>
								
								<div class="mb-4"></div>
								<input type="button" id="submitBtn" value="SIGN UP" class="btn btn-primary btn-lg btn-block" style="cursor: pointer;" />
				    		</c:when>
				    		
				    		<c:when test="${language eq 'japanese'}">
								<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement1" required=""> 
									<label class="custom-control-label" for="aggrement1">Go!reaサービス利用規約。</label>
								</div>
								<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement2" required=""> 
									<label class="custom-control-label" for="aggrement2">個人情報の収集・提供・利用への同意</label>
								</div>
								
								<div class="mb-4"></div>
								<input type="button" id="submitBtn" value="サインアップ" class="btn btn-primary btn-lg btn-block" style="cursor: pointer;" />
				    		</c:when>
				    		
				    		<c:when test="${language eq 'chinese'}">
				        		<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement1" required=""> 
									<label class="custom-control-label" for="aggrement1">Go!rea 服务使用条款。</label>
								</div>
								<div class="custom-control custom-checkbox">
					        		<input type="checkbox" class="custom-control-input" id="aggrement2" required=""> 
									<label class="custom-control-label" for="aggrement2">同意收集、提供和使用个人信息</label>
								</div>
								
								<div class="mb-4"></div>
								<input type="button" id="submitBtn" value="成为会员" class="btn btn-primary btn-lg btn-block" style="cursor: pointer;" />
				    		</c:when>
						</c:choose>
				</form>
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/includes/footer.jsp"></jsp:include>
	
	<script type="text/javascript">
	
	 	var language = '${language}';
	 	
	    document.addEventListener('DOMContentLoaded', function () {
	        var countrySelect = document.getElementById('country');
	
	        if (language === 'korean') {
	            countrySelect.value = '대한민국';
	        } else if (language === 'english') {
	            countrySelect.value = '미국';
	        } else if (language === 'japanese') {
	        	countrySelect.value = '일본';
	        } else if (language === 'chinese') {
	        	countrySelect.value = '중국';
	        }

	    });
	
        // 비밀번호 일치 확인
        document.getElementById('confirm-password').oninput = function() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirm-password').value;
            const feedback = document.getElementById('password-confirm-feedback');

            if (password !== confirmPassword) {
                feedback.style.display = 'block';
            } else {
                feedback.style.display = 'none';
            }
        };
    </script>
</body>
</html>