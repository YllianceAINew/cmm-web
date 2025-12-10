/**
 * SIP Server Management JavaScript
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
        url: baseUrl + 'server/editSipHaproxyServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
                showNotification("Operation failed", "danger");
            } else {
                showNotification("SIP HAProxy server updated successfully", "success");
                setTimeout(function() {
                    location.href = sipUrl;
                }, 1000);
            }
        },
        error: function() {
            showNotification("An error occurred while updating the server", "danger");
        }
    });
}

function onAddServer() {
    var newIpExt = $("#input_server_ip_ext").val();
    var newIpInt = $("#input_server_ip_int").val();
    
    if (!newIpExt || !newIpInt) {
        showNotification("Please fill in all fields", "warning");
        return;
    }
    
    // Basic IP validation
    var ipPattern = /^(\d{1,3}\.){3}\d{1,3}$/;
    if (!ipPattern.test(newIpExt) || !ipPattern.test(newIpInt)) {
        showNotification("Please enter valid IP addresses", "warning");
        return;
    }
    
    $.ajax({
        type: 'POST',
        url: baseUrl + 'server/addSipServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
                showNotification("Operation failed", "danger");
            } else {
                showNotification("SIP server added successfully", "success");
                setTimeout(function() {
                    location.href = sipUrl;
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
        url: baseUrl + 'server/updateKamServerInfo',
        data: {
            type: 2
        },
        dataType: 'json',
        success: function(res){
            if (res && res.length > 0) {
                // Update main HAProxy/Kamailio server (first item)
                if (res[0]) {
                    $("#start_time").text(res[0]["start_time"] || 'N/A');
                    $("#cpu_info").text(res[0]["cpu"] || 'N/A');
                    $("#ram_info").text(res[0]["ram"] || 'N/A');
                    $("#memory_info").text(res[0]["memory"] || 'N/A');
                    
                    // Update status badge if present
                    if (res[0]["status"]) {
                        var statusBadge = $("#cpu_info").closest('tr').find('.badge');
                        if (res[0]["status"] === 'on') {
                            statusBadge.removeClass('badge-danger').addClass('badge-success').text('State: On');
                        } else {
                            statusBadge.removeClass('badge-success').addClass('badge-danger').text('State: Off');
                        }
                    }
                }

                // Update SIP sub-servers (remaining items)
                for (var i = 1; i < res.length; i++) {
                    var index = i;
                    $("#start_time" + index).text(res[i]["start_time"] || 'N/A');
                    $("#cpu" + index).text(res[i]["cpu"] || 'N/A');
                    $("#ram" + index).text(res[i]["ram"] || 'N/A');
                    $("#memory" + index).text(res[i]["memory"] || 'N/A');
                    if ($("#sync_call" + index).length) {
                        $("#sync_call" + index).text(res[i]["sync_call"] || 'N/A');
                    }
                    
                    // Update status badge if present
                    if (res[i]["status"]) {
                        var statusBadge = $("#start_time" + index).closest('tr').find('.badge');
                        if (res[i]["status"] === 'on') {
                            statusBadge.removeClass('badge-danger').addClass('badge-success').text('On');
                        } else {
                            statusBadge.removeClass('badge-success').addClass('badge-danger').text('Off');
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
    $("li#sipserver").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    // Handle delete SIP server
    $(document).on("click", ".deleteSip", function(){
        var serverip = $(this).attr("serverIp");
        var $row = $(this).closest('tr');
        
        // Extract IP from the serverIp attribute (might contain HTML)
        var cleanIp = serverip.replace(/<br\s*\/?>/gi, ' ').replace(/[()]/g, '').trim();
        
        if (confirm("Do you want to delete the sub-server (" + cleanIp + ")?")) {
            $.ajax({
                type: 'POST',
                url: baseUrl + 'server/deleteSip',
                data: {
                    serverip: serverip
                },
                dataType: 'html',
                success: function(res){
                    if (res == "success") {
                        showNotification("Server deleted successfully", "success");
                        setTimeout(function() {
                            location.href = sipUrl;
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

    // Clear form on modal close
    $('.modal').on('hidden.bs.modal', function () {
        $(this).find('form')[0]?.reset();
    });

    // Auto-refresh server information every 5 seconds
    setInterval(refreshInfo, 5000);
    
    // Initial refresh after page load
    setTimeout(refreshInfo, 1000);
});
