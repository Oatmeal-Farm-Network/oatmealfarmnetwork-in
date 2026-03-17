    <br><br>
  <hr class="my-3" style="border-color: rgba(255, 255, 255, 0.2);">

  <div class="container">
    <div class="row">
        <div class="col" align="center">
          <a class="footer" href="/shipfolio/">Home |</a>
          <a class="footer" href="/shipfolio/Features.asp">Features |</a>
          <a class="footer" href="/shipfolio/PortfolioBuilder.asp">Portfolio Builder |</a>
          <a class="footer" href="/shipfolio/ChatWithAI.asp">Chat with AI |</a>
          <a class="footer" href="/shipfolio/DesignLibrary.asp">Design Library |</a>
          <a class="footer" href="/shipfolio/Contactus.asp">Contact Us |</a>
          <a class="footer" href="/shipfolio/SetupAccount.asp">Join |</a>
          <a class="footer" href="/shipfolio/Login.asp">Login</a>
        </div>
    </div>
  </div>
  
  <div class="container">
      <div class="row">
          <div class="col-12 copyright">
              Copyright &copy; 2025 ShipFolio. All Rights Reserved.
          </div>
      </div>
  </div>
</div>


<script>
document.addEventListener('DOMContentLoaded', () => {
    // Check if Bootstrap is loaded before trying to use it
    if (typeof bootstrap === 'undefined' || !bootstrap.Collapse) {
        console.error("Bootstrap's JavaScript is required for the navbar toggle logic.");
    }

    const sidebar = document.getElementById('mySidebar');
    const toggleButton = document.getElementById('sidebarToggle');
    const navbarToggler = document.querySelector('.navbar-toggler');
    const navbarCollapse = document.getElementById('navbarNav');
    const toggleIcon = toggleButton ? toggleButton.querySelector('i') : null;

    // Function to initialize the icon state on page load
    const initializeIconState = () => {
        if (toggleIcon && window.innerWidth >= 992) {
            const isCollapsed = sidebar.classList.contains('collapsed');
            if (isCollapsed) {
                // Collapsed state: Chevron points right (>) to expand
                toggleIcon.classList.remove('fa-chevron-left');
                toggleIcon.classList.add('fa-chevron-right'); 
            } else {
                // Expanded state: Chevron points left (<) to collapse
                toggleIcon.classList.remove('fa-chevron-right');
                toggleIcon.classList.add('fa-chevron-left');
            }
        }
    };


    // Function to handle the sidebar toggle logic for desktop (chevron)
    const toggleDesktopSidebar = () => {
        // Only run desktop toggle if screen is large enough
        if (window.innerWidth >= 992) {
             // Close the right navbar menu if it's open on desktop
            if (navbarCollapse && navbarCollapse.classList.contains('show')) {
                 // Use Bootstrap's Collapse if available, otherwise just remove 'show' class
                if (typeof bootstrap !== 'undefined' && bootstrap.Collapse) {
                    const bsCollapse = new bootstrap.Collapse(navbarCollapse, { toggle: false });
                    bsCollapse.hide();
                } else {
                    navbarCollapse.classList.remove('show');
                }
            }
            
            sidebar.classList.toggle('collapsed');
            
            // Toggle the icon class for visual feedback
            if (toggleIcon) {
                if (sidebar.classList.contains('collapsed')) {
                    // Sidebar is collapsed -> show 'expand' icon (chevron right)
                    toggleIcon.classList.remove('fa-chevron-left');
                    toggleIcon.classList.add('fa-chevron-right'); 
                } else {
                    // Sidebar is expanded -> show 'collapse' icon (chevron left)
                    toggleIcon.classList.remove('fa-chevron-right');
                    toggleIcon.classList.add('fa-chevron-left');
                }
            }
        }
    };
    
    // 1. Desktop Toggle Click Handler
    if (toggleButton) {
        // Initialize state on load
        initializeIconState();
        
        // Set click listener
        toggleButton.addEventListener('click', toggleDesktopSidebar);
    }

    // 2. Mobile Logic for the Navbar Hamburger
    if (navbarToggler) {
        navbarToggler.addEventListener('click', () => {
            // Toggle the LEFT sidebar when the RIGHT hamburger is clicked (on mobile)
            if (window.innerWidth < 992) {
                // Toggle the 'collapsed' class on the sidebar. 
                // On mobile, 'collapsed' means OPEN/VISIBLE.
                sidebar.classList.toggle('collapsed');
                
                // Ensure the Bootstrap menu closes itself if it was open
                if (navbarCollapse && navbarCollapse.classList.contains('show')) {
                    if (typeof bootstrap !== 'undefined' && bootstrap.Collapse) {
                         const bsCollapse = new bootstrap.Collapse(navbarCollapse, { toggle: false });
                         bsCollapse.hide();
                    } else {
                        navbarCollapse.classList.remove('show');
                    }
                }
            }
        });
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
