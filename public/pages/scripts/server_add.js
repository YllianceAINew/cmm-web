var FormValidation = function () {
    // validation using icons
    var handleValidation2 = function() {
        // for more info visit the official plugin documentation: 
            // http://docs.jquery.com/Plugins/Validation

            var form2 = $('#form_sample_2');
            
            form2.validate({
                errorElement: 'span', //default input error message container
                errorClass: 'help-block help-block-error', // default input error message class
                focusInvalid: false, // do not focus the last invalid input
                ignore: "",  // validate all fields including form hidden input
                rules: {
                    memberLoginId: {
                        minlength: 3,
                        required: true
                    },
                    memberName: {
                        required: true
                    },
                    memberDepart: {
                        required: true
                    },
                    memberPassword: {
						minlength: 6,
                        required: true
                    },
                    repeatPassword: {
                        minlength: 6,
						equalTo:memberPassword
                    }
                },
				messages: { // custom messages for radio buttons and checkboxes
                    memberLoginId: {
                        required: "이 값은 무조건 입력하여야 합니다.",
						minlength:"3글자 이상이 되여야 합니다."
                    },
                    memberName: {
                        required: "이 값은 무조건 입력하여야 합니다."
                    },
					memberDepart: {
                        required: "이 값은 무조건 입력하여야 합니다."
                    },
                    memberPassword: {
						minlength:"암호6글자 이상이 되여야 합니다.",
                        required: "이 값은 무조건 입력하여야 합니다."
                    },
                    repeatPassword: {
                        minlength:"암호6글자 이상이 되여야 합니다.",
						required: "이 값은 무조건 입력하여야 합니다.",
						equalTo:"암호확인이 정확하지 않습니다."
                    }
                },
                invalidHandler: function (event, validator) { //display error alert on form submit              
                    
                },

                errorPlacement: function (error, element) { // render error placement for each input type
                    var icon = $(element).parent('.input-icon').children('i');
                    icon.removeClass('fa-check').addClass("fa-warning");  
                    icon.attr("data-original-title", error.text()).tooltip({'container': 'body'});
                },

                highlight: function (element) { // hightlight error inputs
                    $(element)
                        .closest('.form-group').removeClass("has-success").addClass('has-error'); // set error class to the control group   
                },

                unhighlight: function (element) { // revert the change done by hightlight
                    
                },

                success: function (label, element) {
                    var icon = $(element).parent('.input-icon').children('i');
                    $(element).closest('.form-group').removeClass('has-error').addClass('has-success'); // set success class to the control group
                    icon.removeClass("fa-warning").addClass("fa-check");
                },

                submitHandler: function (form) {
                    form[0].submit(); // submit the form
                }
            });


    }
	return {
        //main function to initiate the module
        init: function () {
            handleValidation2();
        }

    };

}();

function updateUserInfo(){
    var memId = $.trim($("#memId").val());
    var oldPassword = $.trim($("#oldPassword").val());
    var memberLoginId = $.trim ($("#memberLoginId").val());
    var memberPassword = $.trim($("#memberPassword").val());
    var confirmPassword = $.trim($("#repeatPassword").val());
    var memberName = $.trim($("#memberName").val());
    var memberDepart = $.trim($("#memberDepart").val());
    var memberIP = $.trim($("#memberIP").val());
    var memberDescription = $.trim($("#memberIP").val());
    var memberAcl = [];

    if(memberLoginId.length < 3 || memberName.length < 3 || memberDepart.length < 3)
      {  alertbox("","정보를 3문자이상 입력하여야 합니다.","warning");return; }
    if(oldPassword.length < 6)
        { alertbox("","이전 암호를 입력하십시오.","warning");return;}
    if(memberPassword.length < 6 || confirmPassword.length < 6)
    {
        alertbox("","암호를 6문자이상 입력하여야 합니다.","warning");return;
    }
    if(memberPassword != confirmPassword)
    {
        alertbox("","입력된 암호가 불일치합니다.","warning");return;
    }
    $(".hasChecks").each(function(){
        var child = $(this).find("[type='checkbox']");
        if($(child).is(":checked") == true)
        {
            memberAcl.push($(child).attr("dataVal"));
        }
    });

    $.ajax({
        type:  'POST',
        url: baseUrl + 'server/save',
        data: {
            'memId': memId,
            'memberLoginId': memberLoginId,
            'oldPassword': oldPassword,
            'memberPassword': memberPassword,
            'memberName': memberName,
            'memberDepart': memberDepart,
            'memberIP': memberIP,
            'memberDescription': memberDescription,
            'memberAcl': JSON.stringify(memberAcl)
        },
        dataType:'html',
        success: function(res){console.log(res);
           if(res=="false"){
                alertbox("","이전 암호가 정확하지 않습니다.","warning");return;
            }
            else
               location.href = baseUrl + 'server/index';
        },
        error: function() {

        }
    });
}

$(document).ready(function () {
    FormValidation.init();
    $('li#admin').addClass("active");
    $(".btn-active").removeClass("btn-active");
    $("#msmanager").addClass("btn-active");
});