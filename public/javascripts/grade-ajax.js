function hideGradeForm(form, score){
 $(form).hide();
 $("input", form).unbind("blur");
 $("input", form).blur();
 $("span.grade", $(form).parents("td")).text(score);
 $("span.grade", $(form).parents("td")).show();
}

function showGradeForm(form){
 $(form).show();
 $("span", $(form).parents("td")).hide();
 $("input", form).focus();
 $("input", form).blur(function(event){
   $(form).submit();
 });
}

function newGradeSuccessHandler(status, grade, request) {
 var form = $(this);
 hideGradeForm(this, grade.score);
 form.attr("action", grade.update_url);
 form.attr("method", "put");
 $("input[type=hidden]", this).remove();
 form.unbind("ajax:success");
 form.bind("ajax:success", updateGradeSuccessHandler);
};

function updateGradeSuccessHandler(status, grade, request){
 hideGradeForm(this, grade.score || '--');
};

$(document).ready(function() {
 $(".grade-form").hide();
 $("td.editable").each(function(i, td){
   $(td).click(function(event){
     showGradeForm($("form", td));
   });
   if($("span.grade", td).text() == "--") { 
     $("form", td).bind("ajax:success", newGradeSuccessHandler);
   } else {
     $("form", td).bind("ajax:success", updateGradeSuccessHandler);
   };
   $("form", td).bind("ajax:error", function(event, request, status){
     alert("There was an error: " + request.responseText);
     $("input", td).focus();
   });
 });
 
 $('#grade-table').sorttable({items: '>:not(.nosort)'}).disableSelection();
 
});