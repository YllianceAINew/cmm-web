/**
 * Dark Mode Toggle for AdminLTE
 * Toggles between light and dark mode themes
 */

(function() {
  'use strict';

  // Get elements
  var darkModeToggle = document.getElementById('dark-mode-toggle');
  var darkModeIcon = document.getElementById('dark-mode-icon');
  var mainHeader = document.querySelector('.main-header');
  var currentTheme = localStorage.getItem('theme');

  // Initialize dark mode on page load
  function initDarkMode() {
    if (currentTheme === 'dark') {
      enableDarkMode();
    } else {
      disableDarkMode();
    }
  }

  // Enable dark mode
  function enableDarkMode() {
    if (!document.body.classList.contains('dark-mode')) {
      document.body.classList.add('dark-mode');
    }
    if (mainHeader) {
      // Remove light mode classes
      mainHeader.classList.remove('navbar-light', 'navbar-white');
      // Add dark mode class
      if (!mainHeader.classList.contains('navbar-dark')) {
        mainHeader.classList.add('navbar-dark');
      }
    }
    if (darkModeIcon) {
      darkModeIcon.classList.remove('far', 'fa-moon');
      darkModeIcon.classList.add('fas', 'fa-sun');
    }
    localStorage.setItem('theme', 'dark');
  }

  // Disable dark mode
  function disableDarkMode() {
    if (document.body.classList.contains('dark-mode')) {
      document.body.classList.remove('dark-mode');
    }
    if (mainHeader) {
      // Remove dark mode class
      mainHeader.classList.remove('navbar-dark');
      // Add light mode classes
      if (!mainHeader.classList.contains('navbar-light')) {
        mainHeader.classList.add('navbar-light');
      }
      if (!mainHeader.classList.contains('navbar-white')) {
        mainHeader.classList.add('navbar-white');
      }
    }
    if (darkModeIcon) {
      darkModeIcon.classList.remove('fas', 'fa-sun');
      darkModeIcon.classList.add('far', 'fa-moon');
    }
    localStorage.setItem('theme', 'light');
  }

  // Toggle dark mode
  function toggleDarkMode() {
    if (document.body.classList.contains('dark-mode')) {
      disableDarkMode();
    } else {
      enableDarkMode();
    }
  }

  // Event listener for dark mode toggle
  if (darkModeToggle) {
    darkModeToggle.addEventListener('click', function(e) {
      e.preventDefault();
      toggleDarkMode();
    });
  }

  // Initialize on page load
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initDarkMode);
  } else {
    initDarkMode();
  }

})();

