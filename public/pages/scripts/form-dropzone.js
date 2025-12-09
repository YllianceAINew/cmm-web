var previewFile = [];
var FormDropzone = function () {


    return {
        //main function to initiate the module
        init: function () {  

            Dropzone.options.myDropzone = {
                dictDefaultMessage: "",
                init: function() {
                    this.on("addedfile", function(file) {
                        // Create the remove button
                        var removeButton = Dropzone.createElement("<a href='javascript:;'' class='btn red btn-sm btn-block'>Remove</a>");
                        
                        // Capture the Dropzone instance as closure.
                        var _this = this;

                        // Listen to the click event
                        removeButton.addEventListener("click", function(e) {
                          //console.log(e);
                          // Make sure the button click doesn't submit the form:
                          e.preventDefault();
                          e.stopPropagation();
                          // Remove the file preview.
                          _this.removeFile(file);
                          //console.log(file.name);
                          var k = -1;
                          for(i = 0; i < previewFile.length; i++){
                            if(file.name == previewFile[i]){
                              k = i;
                              break;
                            }
                          }
                          //console.log(k);
                          if(k > -1){
                            previewFile.splice(k, 1);
                          }
                          setPreviewFileField(previewFile);
                          // If you want to the delete the file on the server as well,
                          // you can do the AJAX request here.
                          //console.log(previewFile);
                        });
                        previewFile.push(file.name);
                        // Add the button to the file preview element.
                        file.previewElement.appendChild(removeButton);
                        //console.log(previewFile);
                        setPreviewFileField(previewFile);
                    });
                }            
            }
        }
    };
}();

jQuery(document).ready(function() {    
   FormDropzone.init();
});

function setPreviewFileField (previewFile) {
  $("#previewFile").val(previewFile);
}