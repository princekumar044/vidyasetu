</div> <!-- Close container div -->
    
    <!-- Footer -->
    <footer class="professional-footer mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <h5><i class="fas fa-graduation-cap"></i> VidyaSetu </h5>
                    <p class="text-light">A professional way where learning <br> meets opportunity.</p>
                    <div class="contact-info">
                        <p><i class="fas fa-envelope me-2"></i> contact@vidyasetu.com</p>
                        <p><i class="fas fa-phone me-2"></i> +1 (555) 123-4567</p>
                        <p><i class="fas fa-map-marker-alt me-2"></i> 123 Education Street, Campus City</p>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="/"><i class="fas fa-home me-2"></i> Home</a></li>
                        <li><a href="/register"><i class="fas fa-user-plus me-2"></i> Register</a></li>
                        <li><a href="/login"><i class="fas fa-sign-in-alt me-2"></i> Login</a></li>
                        <li><a href="/viewdata"><i class="fas fa-users me-2"></i> View Students</a></li>
                        <li><a href="/courses"><i class="fas fa-book me-2"></i> Courses</a></li>
                    </ul>
                </div>
                <div class="col-md-4 mb-4">
                    <h5>Connect With Us</h5>
                    <div class="social-icons mb-3">
                        <a href="#" class="me-3"><i class="fab fa-facebook fa-2x text-light"></i></a>
                        <a href="#" class="me-3"><i class="fab fa-twitter fa-2x text-light"></i></a>
                        <a href="#" class="me-3"><i class="fab fa-linkedin fa-2x text-light"></i></a>
                        <a href="#"><i class="fab fa-github fa-2x text-light"></i></a>
                    </div>
                    <p class="text-light mb-2">Subscribe to our newsletter</p>
                    <div class="input-group mb-3">
                        <input type="email" class="form-control" placeholder="Your email">
                        <button class="btn btn-primary" type="button">Subscribe</button>
                    </div>
                </div>
            </div>
            <hr class="my-4 bg-light">
            <div class="row">
                <div class="col-md-6">
                    <p class="text-light mb-0">&copy; 2026 VidyaSetu - "Where Learning Meets Opportunity". All rights reserved.</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="#" class="text-light me-3">Privacy Policy</a>
                    <a href="#" class="text-light">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>
    
    <!-- Floating Dark Mode Toggle Button (for pages that inherit footer.jsp) -->
    <button class="dark-mode-toggle-btn" onclick="toggleDarkMode()" title="Toggle Dark Mode">
        <i class="fas ${sessionScope.darkMode ? 'fa-sun' : 'fa-moon'} fa-lg"></i>
    </button>
    
    <!-- Toast Notification for Dark Mode -->
    <div id="darkModeToast" class="dark-mode-toast">
        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header">
                <i class="fas fa-palette me-2"></i>
                <strong class="me-auto">Theme Changed</strong>
                <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
            <div class="toast-body" id="toastMessage">
                Switched to Dark Mode
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Custom JS - FIXED: Removed server-side saving -->
    <script>
        // Dark Mode Toggle Function (for pages that inherit footer.jsp)
        function toggleDarkMode() {
            const htmlElement = document.documentElement;
            const isDarkMode = htmlElement.getAttribute('data-bs-theme') === 'dark';
            const newMode = !isDarkMode;
            
            // Update HTML attribute
            htmlElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
            
            // Update icons
            updateDarkModeIcons(newMode);
            
            // Update navbar switch if exists
            updateNavbarSwitch(newMode);
            
            // Show toast notification
            showDarkModeToast(newMode ? 'Dark' : 'Light');
            
            // Save to localStorage only (removed server-side saving)
            localStorage.setItem('darkMode', newMode);
        }
        
        function updateDarkModeIcons(isDarkMode) {
            // Update all moon/sun icons
            const icons = document.querySelectorAll('.fa-moon, .fa-sun');
            icons.forEach(icon => {
                if (isDarkMode) {
                    icon.classList.remove('fa-moon');
                    icon.classList.add('fa-sun');
                } else {
                    icon.classList.remove('fa-sun');
                    icon.classList.add('fa-moon');
                }
            });
            
            // Update floating button icon
            const toggleBtn = document.querySelector('.dark-mode-toggle-btn i');
            if (toggleBtn) {
                if (isDarkMode) {
                    toggleBtn.classList.remove('fa-moon');
                    toggleBtn.classList.add('fa-sun');
                } else {
                    toggleBtn.classList.remove('fa-sun');
                    toggleBtn.classList.add('fa-moon');
                }
            }
        }
        
        function updateNavbarSwitch(isDarkMode) {
            const checkbox = document.getElementById('darkModeSwitch');
            if (checkbox) {
                checkbox.checked = isDarkMode;
            }
            
            // Update navbar label if exists
            const modeLabels = document.querySelectorAll('.navbar-text small');
            modeLabels.forEach(label => {
                if (label.textContent.includes('Mode')) {
                    label.innerHTML = `<i class="fas ${isDarkMode ? 'fa-sun' : 'fa-moon'} me-1"></i>${isDarkMode ? 'Light' : 'Dark'} Mode`;
                }
            });
        }
        
        function showDarkModeToast(mode) {
            const toastElement = document.getElementById('darkModeToast');
            const toastMessage = document.getElementById('toastMessage');
            
            if (!toastElement || !toastMessage) return;
            
            toastMessage.textContent = `Switched to ${mode} Mode`;
            toastElement.style.display = 'block';
            
            // Initialize Bootstrap toast
            const toast = new bootstrap.Toast(toastElement.querySelector('.toast'), {
                autohide: true,
                delay: 3000
            });
            toast.show();
            
            // Hide after animation
            setTimeout(() => {
                toastElement.style.display = 'none';
            }, 3500);
        }
        
        // Initialize dark mode on page load
        document.addEventListener('DOMContentLoaded', function() {
            // Check localStorage first
            const savedMode = localStorage.getItem('darkMode');
            const sessionMode = ${sessionScope.darkMode ? 'true' : 'false'};
            
            let darkMode = false;
            
            if (savedMode !== null) {
                darkMode = savedMode === 'true';
            } else if (sessionMode) {
                darkMode = sessionMode;
            } else {
                // Check system preference
                const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
                darkMode = prefersDark;
            }
            
            // Apply mode if different from current
            const currentMode = document.documentElement.getAttribute('data-bs-theme') === 'dark';
            if (darkMode !== currentMode) {
                document.documentElement.setAttribute('data-bs-theme', darkMode ? 'dark' : 'light');
                updateDarkModeIcons(darkMode);
                updateNavbarSwitch(darkMode);
            }
            
            // Listen for system preference changes
            window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', event => {
                if (!localStorage.getItem('darkMode')) {
                    const newMode = event.matches;
                    document.documentElement.setAttribute('data-bs-theme', newMode ? 'dark' : 'light');
                    updateDarkModeIcons(newMode);
                    updateNavbarSwitch(newMode);
                }
            });
            
            // Set active nav link
            const currentUrl = window.location.pathname;
            const navLinks = document.querySelectorAll('.nav-link');
            
            navLinks.forEach(link => {
                const linkUrl = link.getAttribute('href');
                if (currentUrl === linkUrl) {
                    link.classList.add('active');
                }
            });
            
            // Auto-dismiss alerts after 5 seconds
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(alert => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        });
    </script>
</body>
</html>