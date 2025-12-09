var FormValidationMd = function() {

    var handleValidation3 = function() {
        // for more info visit the official plugin documentation: 
        // http://docs.jquery.com/Plugins/Validation
        var form1 = $('#form_sample_3');
        var error1 = $('.alert-danger', form1);
        var success1 = $('.alert-success', form1);

        form1.validate({
            errorElement: 'span', //default input error message container
            errorClass: 'help-block help-block-error', // default input error message class
            focusInvalid: false, // do not focus the last invalid input
            ignore: "", // validate all fields including form hidden input
            messages: {
                oldpwd: {
                    required: '이전 암호를 입력하여야 합니다.'
                },
                'newpwd': {
                    required: '새 암호를 입력하여야 합니다.',
                    minlength: jQuery.validator.format("새암호는 {0}글자 이상이여야 합니다.")
                },
                'confirmpwd': {
                    required: '새암호에 대한 확인을 하여야 합니다.',
                    equalTo:"암호확인이 정확하지 않습니다."
                }
            },
            rules: {
                oldpwd: {
                    required: true
                },
                newpwd: {
                    minlength: 6,
                    required: true
                },
                confirmpwd: {
                    required: true,
					equalTo:newpwd
                }
            },

            invalidHandler: function(event, validator) { //display error alert on form submit              
                success1.hide();
                error1.show();
                App.scrollTo(error1, -200);
            },

            errorPlacement: function(error, element) {
                error.insertAfter(element); // for other inputs, just perform default behavior
            },

            highlight: function(element) { // hightlight error inputs
                $(element)
                    .closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function(element) { // revert the change done by hightlight
                $(element)
                    .closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function(label) {
                label
                    .closest('.form-group').removeClass('has-error'); // set success class to the control group
            },

            submitHandler: function(form) {
                success1.show();
                error1.hide();
				form.submit();
            }
        });
    }

    return {
        //main function to initiate the module
        init: function() {
            handleValidation3();
        }
    };
}();

jQuery(document).ready(function() {
    FormValidationMd.init();
});