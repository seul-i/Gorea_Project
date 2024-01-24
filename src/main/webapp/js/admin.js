        function toggleSidebar() {
    var sidebar = document.querySelector('aside');
    sidebar.classList.toggle('visible');
    var toggleButton = document.querySelector('.toggle-sidebar-btn');
    toggleButton.style.display = sidebar.classList.contains('visible') ? 'none' : 'block';
}

function hideSidebar() {
    var sidebar = document.querySelector('aside');
    sidebar.classList.remove('visible');
}

function toggleSubmenu(submenuId) {
    // 모든 서브메뉴를 숨깁니다.
    var submenus = document.querySelectorAll('.submenu');
    submenus.forEach(function(submenu) {
        if (submenu.id !== submenuId) {
            submenu.style.display = 'none';
            // 해당 서브메뉴에 연결된 인디케이터를 '∨'로 설정합니다.
            var associatedIndicator = document.querySelector(`a[data-target='${submenu.id}'] .submenu-indicator`);
            if (associatedIndicator) {
                associatedIndicator.innerHTML = '∨';
            }
        }
    });

    // 선택된 서브메뉴를 토글합니다.
    var targetSubmenu = document.getElementById(submenuId);
    var indicator = document.querySelector(`a[data-target='${submenuId}'] .submenu-indicator`);
    if (targetSubmenu.style.display === 'block') {
        targetSubmenu.style.display = 'none';
        indicator.innerHTML = '∨';
    } else {
        targetSubmenu.style.display = 'block';
        indicator.innerHTML = '∧';
    }
}