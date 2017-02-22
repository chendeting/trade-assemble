//拍卖中
$(function(){
    //倒计时插件
    $('.countdown').downCount({
        date: '12/10/2016 12:00:00',
        offset: -5
    }, function () {
        //显示拍卖结束相关的界面
        alert('WOOT WOOT, done!');
    });

    //swiper 日期nav滑动
    var mySwiper2 = new Swiper('#swiper-navdate',{
        watchSlidesProgress : true,
        watchSlidesVisibility : false,
        slidesPerView : 3,
        onTap: function(){
            mySwiper3.slideTo( mySwiper2.clickedIndex)
        }
    })
    //swiper 内容滑动
    var mySwiper3 = new Swiper('#swiper-maincontent',{

        onSlideChangeStart: function(){

            updateNavPosition()
        }

    })

    function updateNavPosition(){
        //移除和添加样式
        $('#swiper-navdate .active-nav').removeClass('active-nav')
        var activeNav = $('#swiper-navdate .swiper-slide').eq(mySwiper3.activeIndex).addClass('active-nav');

        //
        if (!activeNav.hasClass('swiper-slide-visible')) {
//            console.log(1);
            if (activeNav.index()>mySwiper2.activeIndex) {
//                console.log(2);
                var thumbsPerNav = Math.floor(mySwiper2.width/activeNav.width())-1
                mySwiper2.slideTo(activeNav.index()-thumbsPerNav);
                console.log(activeNav.index());
                if(activeNav.index() == 1){
                    console.log("1");
                    var html = "aaa";
                    $("#activeOne").html("");
                    $("#activeOne").append(html);
                }else if(activeNav.index() == 3){
                    console.log("3");
                    var html = "ccc";
                    $("#activeThree").html("");
                    $("#activeThree").append(html);
                }
            }
            else {
//                console.log(3);
                mySwiper2.slideTo(activeNav.index());
                console.log(activeNav.index());
            }
        }
    }

   //调用公共方法的下拉刷新方法
    //获取第一个参数:滑动区域
    var swiperMaincontent = document.querySelector("#swiper-maincontent");
    //获取第二个参数,json数据表的名字
    var datajsonName = "pigItem";
    //获取第三个参数：添加数据ul的id
    var onsaleingList = document.querySelector("#onsaleingList");
    //第四个参数，获取模板名字
    var pigItemTem = "pigItemTem";
    //调用公共方法的下拉刷新方法
    dropload(swiperMaincontent,datajsonName,onsaleingList,pigItemTem);

})

