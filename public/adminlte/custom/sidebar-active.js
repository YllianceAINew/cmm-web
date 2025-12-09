/**
 * Sidebar Active Menu Highlighter
 * Automatically highlights the active menu item based on current URL
 */
$(function () {
  'use strict'

  // Get current page URL
  var url = window.location.href;
  
  // Remove any existing active classes
  $('.nav-sidebar .nav-link').removeClass('active');
  $('.nav-sidebar .nav-item').removeClass('menu-open');
  
  // Find and activate current menu item
  $('.nav-sidebar .nav-link').each(function() {
    var linkUrl = $(this).attr('href');
    
    if (linkUrl && url.indexOf(linkUrl) !== -1) {
      // Add active class to current link
      $(this).addClass('active');
      
      // If it's a submenu item, open parent menu
      var parent = $(this).closest('.nav-treeview').prev('.nav-link');
      if (parent.length) {
        parent.addClass('active');
        parent.parent('.nav-item').addClass('menu-open');
      }
    }
  });
  
  // Dashboard special handling
  if (url.indexOf('dashboard/index') !== -1 || url.indexOf('dashboard') !== -1) {
    $('#menu-dashboard').addClass('active');
  }
  
  // Server menu handling
  if (url.indexOf('server/') !== -1) {
    $('#menu-server').addClass('active');
    $('#menu-server').parent('.nav-item').addClass('menu-open');
  }
  
  // Member menu handling
  if (url.indexOf('member/') !== -1) {
    $('#menu-member').addClass('active');
    $('#menu-member').parent('.nav-item').addClass('menu-open');
  }
  
  // Log menu handling
  if (url.indexOf('log/') !== -1) {
    $('#menu-log').addClass('active');
    $('#menu-log').parent('.nav-item').addClass('menu-open');
  }
});

