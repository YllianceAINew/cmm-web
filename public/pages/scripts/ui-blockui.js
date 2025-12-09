var UIBlockUI = function() {
    
    var handleSample2 = function() {

        $('#blockui_sample_2_1').click(function() {
            App.blockUI();

            window.setTimeout(function() {
                App.unblockUI();
            }, 2000);
        });

        $('#stopButton').click(function() {
            App.blockUI({
                boxed: true,message:'잠간만 기다려주십시오...'
            });

            window.setTimeout(function() {
                App.unblockUI();
            }, 13000);
        });
        $('#restartButton').click(function() {
            App.blockUI({
                boxed: true,message:'잠간만 기다려주십시오...'
            });

            window.setTimeout(function() {
                App.unblockUI();
            }, 120000);
        });
/*
        $('#stopButton').click(function() {
            App.startPageLoading({message: '잠간만 기다려주십시오...'});

            window.setTimeout(function() {
                App.stopPageLoading();
            }, 12000);
        });

        $('#restartButton').click(function() {
            App.startPageLoading({message: '잠간만 기다려주십시오...'});

            window.setTimeout(function() {
                App.stopPageLoading();
            }, 20000);
        });
*/
        $('#blockui_sample_2_4').click(function() {
            App.startPageLoading({animate: true});

            window.setTimeout(function() {
                App.stopPageLoading();
            }, 2000);
        });
    }

    return {
        //main function to initiate the module
        init: function() {
            handleSample2();
        }

    };

}();

jQuery(document).ready(function() {    
   UIBlockUI.init();
});