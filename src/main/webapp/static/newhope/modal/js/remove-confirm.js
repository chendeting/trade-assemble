//obj->model content
//模态确认删除
function confirm_remove(modal_content, modal_name, url_, that) {

	modal_content.append("<div class='modal_confirm_msg'>"
					+ "<img alt='' src='/static/newhope/icon/warning.png' width='20px' height='20px' style='margin-top: -7px'>"
					+ "<label class='delLabel' style='font-size:20px; margin-left: 10px;'>删除记录</label>"
					+ "<div class='modal_confirm_btn'>"
					+ "<button class='btn btn-danger modaldel' type='button' id='' >确定</button>"
					+ "<button type='button' class='btn btn-info confirm_close' style='margin-left: 5px;'>关闭</button>"
					+ "</div></div>");
	modal_name.modal("show");

	
	var id = that.val();
	var par = that.parent().parent();
	$(".modaldel").click(function() {
		$.ajax({
			url : url_ + id,
			cache : false,
			dataType : "json",
			contentType : "application/json; charset=utf-8",
			success : function(res) {
				if (res) {
					$(".modal_confirm_msg").remove();
					$(".modal_confirm_success").show();
					par.hide();
					par.remove();
				} else {

					$(".modal_confirm_msg").remove();
					$(".modal_confirm_err").show();
				}
			},
			error : function() {

				$(".modal_confirm_msg").remove();
				$(".modal_confirm_err").show();
			}
		});
	});

}
document.onkeydown=function(e){
	if("Escape" == e.code){
	 $("#delModal").modal("hide");
	 $(".modal_confirm_msg").remove();
	 $(".modal_confirm_err").hide();
	 $(".modal_confirm_success").hide();
	}
}

