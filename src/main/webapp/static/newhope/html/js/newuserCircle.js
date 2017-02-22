

//新用户围观交易圈
$(function(){
    //倒计时插件
    $('.countdown').downCount({
        date: '12/10/2017 12:00:00',
        offset: -5
    }, function () {
        //显示拍卖结束相关的界面
        alert('WOOT WOOT, done!');
    });


    //上拉刷新方法
    //获取第一个参数:滑动区域
    var sectionUl = document.querySelector("#mainindex>section");
    //获取第二个参数,json数据表的名字
    var newUsers = "newUsers";
    //获取第三个参数：添加数据ul的id
    var newuserSaleList = document.querySelector("#newuser_saleList");
    //第四个参数，获取模板名字
    var newusercirclr_addlis = "newusercirclr_addlis";
    //调用公共方法的下拉刷新方法
    dropload(sectionUl,newUsers,newuserSaleList,newusercirclr_addlis);


//    city选择

    //加载城市事件
    $('body').on('click', '#btn_city', function () {
        $('#mainindex').hide();
        $('.container').show();
        $(".letter").show();
    });
    //选择城市 start
    $('body').on('click', '.city-list p', function () {
//            var type = $('.container').data('type');
        $('#mainindex').show();
        //通过id去获取内容
        $('#btn_city > span').html($(this).html()).attr('data-id', $(this).attr('data-id'));
        $('.container').hide();
        $(".letter").hide();
    });

    $('body').on('click', '.letter a', function () {
        var s = $(this).html();
        $(window).scrollTop($('#' + s + '1').offset().top);
    });

})
