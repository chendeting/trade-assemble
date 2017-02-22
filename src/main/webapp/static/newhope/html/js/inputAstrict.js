/**
 * Created by dff on 2017/1/18.
 */
function inputAstrict(el,txt,btnId){
    var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
    var name = el.val();
    console.log(el,txt,btnId);
    var flag=false;
    if(name.match(regRule))
    {
    	flag=true;
        el.css({"border":"0.0556rem solid #FA4848"});
        $.toast(txt, "text",function(){
            el.focus();
            el.css({"border":"0.0556rem solid #D8D8D8"});
            btnId.prop("disabled",false);
        });
        
    }
    return flag;
}

//调用模板
/*var nameTxt="猪场名称不能输入表情";
var flag=false;
flag=inputAstrict($("#name"),nameTxt,$("#btn_submit"));
if(flag){
	return;
}*/