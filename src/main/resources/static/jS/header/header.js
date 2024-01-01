// 네이브바 스크롤 고정
$(document).ready(function() {
	var jbOffset = $('.header-nav').offset();
	$(window).scroll(function() {
		if ($(document).scrollTop() > jbOffset.top) {
			$('.header-nav').addClass('header-navFixed');
		} else {
			$('.header-nav').removeClass('header-navFixed');
		}
	});
});
	
const menuBtn = document.querySelector(".navbar_toggleBtn .menuBtn");
const nav = document.querySelector(".nav-links");
const navlist = document.querySelectorAll(".nav-links li");
    
const navAnimation = () => {
    navlist.forEach((link, index) => {
	// 애니메이션이 있을 때
	if (link.style.animation) {
		// 애니메이션 비움
		link.style.animation = "";
	} else {
		// 애니메이션 없을 때 애니메이션을 추가
		// 딜레이 간격을 줘서 li가 하나씩 차례대로 나타나도록 설정
		link.style.animation = `navLinkFade 0.5s ease forwards ${
		index / 7 + 0.5
		}s`;
		}
	});
};
      
const handleNav = () => {
    nav.classList.toggle("nav-active");
    // nav Animation
    navAnimation();
    // menu 애니메이션 Animation
    menuBtn.classList.toggle("toggle");
    
    const body = document.querySelector("body");
    const navLinks = document.querySelector(".nav-links");

    // 토글 버튼이 활성화된 상태인지 체크
    if (menuBtn.classList.contains("toggle")) {
        navLinks.style.display = 'block';
        body.style.overflow = 'hidden';
    } else {
        navLinks.style.display = 'none';
        body.style.overflow = 'auto';
    }

    // 윈도우의 너비를 체크하여 768 이상이면 토글 비활성화
    checkWindowSize();
};

const checkWindowSize = () => {
    const body = document.querySelector("body");
    const navLinks = document.querySelector(".nav-links");

    if (window.innerWidth >= 880) {
        menuBtn.classList.remove("toggle");
        navLinks.style.display = 'none';
        body.style.overflow = 'auto';
    } else {
    }
};

// 윈도우 크기가 변할 때 checkWindowSize 함수 호출
window.addEventListener("resize", checkWindowSize);


	
const navSlide = () => {
	menuBtn.addEventListener("click", handleNav);
};
	
	const setNavTransition = (width) => {
		if (width > 768) {
			nav.style.transition = "";
		} else {
			nav.style.transition = "transform 0.5s ease-in";
		}
	};
		
	const handleResize = () => {
	const width = event.target.innerWidth;
	setNavTransition(width);
	};

	const init = () => {
	// Toggle Nav
	window.addEventListener("resize", handleResize);
	navSlide();
	};
	
	init();