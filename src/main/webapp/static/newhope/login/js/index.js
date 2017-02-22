/**
 * Created by liunian on 2016/4/1.
 */
$(function(){
    $(".input_out").bind({
        focus:function(){
            if (this.value == this.defaultValue){
                this.value="";
            };

        },
        blur:function(){
            if (this.value == ""){
                this.value = this.defaultValue;

            }
        }
    });

})
$(document).ready(function(){
    $(".input_out").change(function(){
        if (this.value==""){
            $(this).css("color","#999999");
            $(this).css("font-size","12px");
        }
        else {
        $(this).css("color","#000000");
        $(this).css("font-size","12px");}

    });
});
