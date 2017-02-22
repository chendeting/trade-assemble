function initialPage(type,url,dt,el) {
    //分页功能
    var loading = false;  //状态标记
    var page = 1;    //当前显示页数

    //每一页的显示数量
    var size = 6;

    //页面初始化时，加载8条数据
    $.ajax({
        type: type,
        url: url,
        dataType: 'json',
        data:dt,
        success: function(data){
            //console.log(data.data.objects.length);
            if(data.success==true){


                var result ="";
                //总的数据长度
                //console.log(data.data.totalCount);
                var dataLen = data.data.totalCount;
                if(dataLen <= 6){
                    //就只加载当前的数据
                    $(".weui-infinite-scroll").css("display","none");
                    $(document.body).destroyInfinite();
                    for(var i = 0;i < dataLen;i++){
                        result += template("temp1",data.data.objects[i]);
                    }
                }else{
                    for(var i = 0;i < size;i++){
                        result += template("temp1",data.data.objects[i]);
                    }
                }
                el.append(result);

            }else{
                $(".infinite-preloader").hide();
                $("#inLoading").text(data.msg);
            }
        },error:function(XMLHttpRequest,textStatus, errorThrown){

            if(textStatus == 'timeout'){
                $.toast("连接超时", "text");
                $(".infinite-preloader").hide();
                $("#inLoading").hide();
            }else{
                $.toast("系统内部错误,请联系客服", "text");
            }
        }
    });
}
