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
	
const menuBtn = document.querySelector(".navbar_toggleBtn .header-menuBtn");
const nav = document.querySelector(".nav-links");
const navlist = document.querySelectorAll(".nav-links li");
const body = document.querySelector("body");
const navLinks = document.querySelector(".nav-links");

const navAnimation = () => {
    navlist.forEach((link, index) => {
        if (link.style.animation) {
            link.style.animation = "";
        } else {
            link.style.animation = `navLinkFade 0.5s ease forwards ${index / 7 + 0.5}s`;
        }
    });
};

const handleNav = () => {
    nav.classList.toggle("nav-active");
    navAnimation();
    menuBtn.classList.toggle("toggle");

    if (menuBtn.classList.contains("toggle")) {
        navLinks.style.display = 'block';
        body.style.overflow = 'hidden';
        navLinks.style.overflowY = 'auto';
    } else {
        navLinks.style.display = 'none';
        body.style.overflow = 'auto';
    }
};

const checkWindowSize = () => {
    if (window.innerWidth >= 880) {
//        menuBtn.classList.remove("toggle");
        navLinks.style.display = 'none';
        body.style.overflow = 'auto';
    } else {
        // 다른 처리가 필요하다면 여기에 추가
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