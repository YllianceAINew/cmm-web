/**
 * XMPP Server Management JavaScript
 * AdminLTE 3 Compatible
 */

function onEditHaproxy() {
    var newIpExt = $("#input_haproxy_ip_ext").val();
    var newIpInt = $("#input_haproxy_ip_int").val();
    
    if (!newIpExt || !newIpInt) {
        showNotification("Please fill in all fields", "warning");
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/editHaproxyServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
                showNotification("Operation failed", "danger");
            } else {
                showNotification("HAProxy server updated successfully", "success");
                setTimeout(function() {
                    location.href = xmppUrl;
                }, 1000);
            }
        },
        error: function() {
            showNotification("An error occurred while updating the server", "danger");
        }
    });
}

function onEditFileserver() {
    var newIpExt = $("#input_fileserver_ip_ext").val();
    var newIpInt = $("#input_fileserver_ip_int").val();
    
    if (!newIpExt || !newIpInt) {
        showNotification("Please fill in all fields", "warning");
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/editFileServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
                showNotification("Operation failed", "danger");
            } else {
                showNotification("File server updated successfully", "success");
                setTimeout(function() {
                    location.href = xmppUrl;
                }, 1000);
            }
        },
        error: function() {
            showNotification("An error occurred while updating the server", "danger");
        }
    });
}

function onAddServer() {
    var newIp = $("#input_server_ip").val();
    
    if (!newIp) {
        showNotification("Please enter a server IP address", "warning");
        return;
    }
    
    // Basic IP validation
    var ipPattern = /^(\d{1,3}\.){3}\d{1,3}$/;
    if (!ipPattern.test(newIp)) {
        showNotification("Please enter a valid IP address", "warning");
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/addXmppServer',
        data: {
            serverIp: newIp
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
                showNotification("Operation failed", "danger");
            } else {
                showNotification("XMPP server added successfully", "success");
                setTimeout(function() {
                    location.href = xmppUrl;
                }, 1000);
            }
        },
        error: function() {
            showNotification("An error occurred while adding the server", "danger");
        }
    });
}

function refreshInfo() {
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/updateServerInfo',
        data: {},
        dataType: 'json',
        success: function(res){
            if (res && res.length > 0) {
                for (var i = 0; i < res.length; i++) {
                    if (i == 0) {
                        // HAProxy server
                        $("#cpu_info").text(res[i]['cpu'] || 'N/A');
                        $("#ram_info").text(res[i]['ram'] || 'N/A');
                        $("#memory_info").text(res[i]['memory'] || 'N/A');
                        
                        // Update status badge if present
                        if (res[i]['status']) {
                            var statusBadge = $("#cpu_info").closest('tr').find('.badge');
                            if (res[i]['status'] === 'On') {
                                statusBadge.removeClass('badge-danger').addClass('badge-success').text('State: On');
                            } else {
                                statusBadge.removeClass('badge-success').addClass('badge-danger').text('State: Off');
                            }
                        }
                    } else if (i == (res.length - 1)) {
                        // File server
                        $("#f_cpu_info").text(res[i]['cpu'] || 'N/A');
                        $("#f_ram_info").text(res[i]['ram'] || 'N/A');
                        $("#f_memory_info").text(res[i]['memory'] || 'N/A');
                        
                        // Update status badge if present
                        if (res[i]['status']) {
                            var statusBadge = $("#f_cpu_info").closest('tr').find('.badge');
                            if (res[i]['status'] === 'On') {
                                statusBadge.removeClass('badge-danger').addClass('badge-success').text('State: On');
                            } else {
                                statusBadge.removeClass('badge-success').addClass('badge-danger').text('State: Off');
                            }
                        }
                    } else {
                        // XMPP servers
                        var index = i - 1;
                        $("#time_info" + index).text(res[i]['time'] || 'N/A');
                        $("#cpu_info" + index).text(res[i]['cpu'] || 'N/A');
                        $("#ram_info" + index).text(res[i]['ram'] || 'N/A');
                        $("#memory_info" + index).text(res[i]['memory'] || 'N/A');
                        if ($("#java_info" + index).length) {
                            $("#java_info" + index).text(res[i]['java'] || 'N/A');
                        }
                        
                        // Update status badge if present
                        if (res[i]['status']) {
                            var statusBadge = $("#time_info" + index).closest('tr').find('.badge');
                            if (res[i]['status'] === 'On') {
                                statusBadge.removeClass('badge-danger').addClass('badge-success').text('On');
                            } else {
                                statusBadge.removeClass('badge-success').addClass('badge-danger').text('Off');
                            }
                        }
                    }
                }
            }
        },
        error: function() {
            console.error("Failed to refresh server information");
        }
    });
}

function showNotification(message, type) {
    // Use bootstrap-growl if available, otherwise fallback to alert
    if (typeof $.bootstrapGrowl !== 'undefined') {
        $.bootstrapGrowl(message, {
            ele: 'body',
            type: type,
            offset: {
                from: 'top',
                amount: 100
            },
            align: 'right',
            width: 'auto',
            delay: 3000,
            stackup_spacing: 10
        });
    } else {
        // Fallback to AdminLTE toastr or simple alert
        if (typeof toastr !== 'undefined') {
            toastr[type === 'danger' ? 'error' : type](message);
        } else {
            alert(message);
        }
    }
}

$(document).ready(function () {
    // Set active menu item
    $("li#xmppserver").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    // Handle delete XMPP server
    $(document).on("click", ".deleteXmpp", function(){
        var serverip = $(this).attr("serverIp");
        var $row = $(this).closest('tr');
        
        if (confirm("Do you want to delete the sub-server (" + serverip + ")?")) {
            $.ajax({
                type: 'POST',
                url: baseUrl + 'server/deleteXmpp',
                data: {
                    serverip: serverip
                },
                dataType: 'html',
                success: function(res){
                    if (res == "success") {
                        showNotification("Server deleted successfully", "success");
                        setTimeout(function() {
                            location.href = xmppUrl;
                        }, 1000);
                    } else {
                        showNotification("Operation failed", "danger");
                    }
                },
                error: function() {
                    showNotification("An error occurred while deleting the server", "danger");
                }
            });
        }
    });

    // Pre-populate edit modals with current values
    $('#editHaproxy').on('show.bs.modal', function () {
        var ipText = $("#cpu_info").closest('tr').find('td:first').text().trim();
        if (ipText) {
            // Try to extract IPs if they're in format "IP<br/>(InternalIP)"
            var parts = ipText.split('(');
            if (parts.length > 1) {
                var extIp = parts[0].trim();
                var intIp = parts[1].replace(')', '').trim();
                $("#input_haproxy_ip_ext").val(extIp);
                $("#input_haproxy_ip_int").val(intIp);
            }
        }
    });

    $('#editFileserver').on('show.bs.modal', function () {
        var ipText = $("#f_cpu_info").closest('tr').find('td:first').text().trim();
        if (ipText) {
            // Try to extract IPs if they're in format "IP<br/>(InternalIP)"
            var parts = ipText.split('(');
            if (parts.length > 1) {
                var extIp = parts[0].trim();
                var intIp = parts[1].replace(')', '').trim();
                $("#input_fileserver_ip_ext").val(extIp);
                $("#input_fileserver_ip_int").val(intIp);
            }
        }
    });

    // Clear form on modal close
    $('.modal').on('hidden.bs.modal', function () {
        $(this).find('form')[0]?.reset();
    });

    // Auto-refresh server information every 5 seconds
    setInterval(refreshInfo, 5000);
    
    // Initial refresh after page load
    setTimeout(refreshInfo, 1000);
});
