/**
 * Proxy Server Management JavaScript
 * AdminLTE 3 Compatible
 */

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
        url: baseUrl + 'server/addProxyServer',
        data: {
            serverIpExt: newIpExt,
            serverIpInt: newIpInt
        },
        dataType: 'html',
        success: function(res){
            if (res == "error"){
                showNotification("Operation failed", "danger");
            } else {
                showNotification("Proxy server added successfully", "success");
                setTimeout(function() {
                    location.href = proxyUrl;
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
        url: baseUrl + 'server/updateProxyServerInfo',
        data: {
            type: 3
        },
        dataType: 'json',
        success: function(res){
            if (res && res.length > 0) {
                for (var i = 0; i < res.length; i++) {
                    $("#start_time" + i).text(res[i]["start_time"] || 'N/A');
                    $("#cpu" + i).text(res[i]["cpu"] || 'N/A');
                    $("#ram" + i).text(res[i]["ram"] || 'N/A');
                    $("#memory" + i).text(res[i]["memory"] || 'N/A');
                    
                    // Update status badge if present
                    if (res[i]["status"]) {
                        var statusBadge = $("#start_time" + i).closest('tr').find('.badge');
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
    $("li#proxyserver").addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");

    // Handle delete proxy server
    $(document).on("click", ".deleteProxy", function(){
        var serverip = $(this).attr("serverIp");
        var $row = $(this).closest('tr');
        
        // Extract IP from the serverIp attribute (might contain HTML)
        var cleanIp = serverip.replace(/<br\s*\/?>/gi, ' ').replace(/[()]/g, '').trim();
        
        if (confirm("Do you want to delete the proxy server (" + cleanIp + ")?")) {
            $.ajax({
                type: 'POST',
                url: baseUrl + 'server/deleteProxy',
                data: {
                    serverip: serverip
                },
                dataType: 'html',
                success: function(res){
                    if (res == "success") {
                        showNotification("Proxy server deleted successfully", "success");
                        setTimeout(function() {
                            location.href = proxyUrl;
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

    // Clear form on modal close
    $('.modal').on('hidden.bs.modal', function () {
        $(this).find('form')[0]?.reset();
    });

    // Auto-refresh server information every 5 seconds
    setInterval(refreshInfo, 5000);
    
    // Initial refresh after page load
    setTimeout(refreshInfo, 1000);
});
