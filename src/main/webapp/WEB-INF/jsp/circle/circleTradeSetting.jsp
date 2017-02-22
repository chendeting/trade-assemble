<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="description"
          content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>圈子交易规则设置</title>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jquery-weui.min.css"/>
    <link rel="stylesheet" href="/static/newhope/html/css/demos.css">
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/selfSetCircleOff.css"/>
</head>
<body>

<div id="warp">
   
    <!--定时区-->
    <div class="same-bg">
        <p class="auction-title">统一拍卖时间</p>

        <p class="slide-btn"><img id="time" flagValue="IS_BID_TIME" src="/static/newhope/html/images/hj/btn_sm_off.png" alt=""></p>
    </div>
    <div class="weui_cells weui_cells_form">
        <div class="weui_cell">
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" id="startTime" type="text" value="${startTime }" placeholder="起始时间">
                <span class="zhi">至</span>
                <i class="fa fa-caret-down" aria-hidden="true"></i>
            </div>
            <div class="weui_cell_bd weui_cell_primary">
                <input class="weui_input" id="endTime" type="text" value="${endTime }" placeholder="终止时间">
                <i class="fa fa-caret-down" aria-hidden="true"></i>
            </div>
        </div>
    </div>
    <div id="picker-container"></div>


    <!--分级区-->
    <div class="same-bg">
        <p class="auction-title tip-p">猪只定价分级</p>
        <p class="slide-btn"><img id="rank" flagValue="IS_LEVEL" src="/static/newhope/html/images/hj/btn_sm_off.png" alt=""></p>
        <p class="tip-content">改变圈子价格模式（不影响已上架商品）</p>
    </div>
    <div class="rankBox">
        <input type="hidden" id="interval-input" value="${intervalArray }">
        <div class="interval-box">
            <div class="interval-bar"></div>
            <div class="interval-top-box">

            </div>
            <div class="interval-bar-button-box"> 

            </div>
        </div>
        <div class="edit-btn">
            <button class="del-cancel-btn">返回新增分级</button>
            <button class="del-btn">删除分级重量</button>
            <button class="add-btn">新增分级重量</button>
        </div>
    </div>
	<div class="on-off">
        <div>
            <button class="off">取消</button>
            <span class="on-off-word">新增分级重量</span>
            <button class="on">确定</button>
        </div>
        <p><input class="rank-input" type="number" placeholder="请输入分级重量" id="input_weight"/><span class="unit">KG</span></p>
    </div>
    <!--定价区-->
    <div class="same-bg unfiedPrice">
        <p class="auction-title tip-p">统一价格</p>
        <p class="slide-btn"><img id="price" flagValue="IS_PRICE" src="/static/newhope/html/images/hj/btn_sm_off.png" alt=""></p>
        <p class="tip-content">改变圈子价格模式（不影响已上架商品）</p>
    </div>
</div>
<script src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<script src="/static/newhope/html/js/fastclick.js"></script>
<script src="/static/trade/js/util/dateUtil.js"></script>
<script src="/static/trade/js/tradeCommon.js?v=1"></script> 

<script>
    $(function () {
        FastClick.attach(document.body);
    });
</script>
<script src="/static/newhope/html/js/jquery-weui.min.js"></script>
<script>
    (function($){$.fn.addBack=$.fn.addBack||$.fn.andSelf;$.fn.extend({actual:function(method,options){if(!this[method]){throw'$.actual => The jQuery method "'+method+'" you called does not exist'}var defaults={absolute:false,clone:false,includeMargin:false};var configs=$.extend(defaults,options);var $target=this.eq(0);var fix,restore;if(configs.clone===true){fix=function(){var style="position: absolute !important; top: -1000 !important; ";$target=$target.clone().attr("style",style).appendTo("body")};restore=function(){$target.remove()}}else{var tmp=[];var style="";var $hidden;fix=function(){$hidden=$target.parents().addBack().filter(":hidden");style+="visibility: hidden !important; display: block !important; ";if(configs.absolute===true){style+="position: absolute !important; "}$hidden.each(function(){var $this=$(this);tmp.push($this.attr("style"));$this.attr("style",style)})};restore=function(){$hidden.each(function(i){var $this=$(this);var _tmp=tmp[i];if(_tmp===undefined){$this.removeAttr("style")}else{$this.attr("style",_tmp)}})}}fix();var actual=/(outer)/.test(method)?$target[method](configs.includeMargin):$target[method]();restore();return actual}})})(jQuery);

    (function ($) {
        var intervalArray=[];
        var interval_data=$("#interval-input").val();
        if(interval_data&&interval_data.length>0){
            interval_data=interval_data.split(",");
        }
        interval_fun(interval_data);
        function interval_fun(data) {
            var top="",button="";
            var interval_top=$(".interval-top-box");
            var interval_button=$(".interval-bar-button-box");
            interval_top.hide();
            interval_button.hide();
            button='<div class="interval-button"> <div class="interval-bar-button">重</div> <div class="interval-bar-button-text">0KG</div> </div>';
            if(data&& $.isArray(data)&&data.length>0){
                data=$.unique(data.sort(function(a,b){return a-b}));
                intervalArray=data;
                var interval=[];
                $(data).each(function(i){
                    if(i>0){
                        interval[i]=data[i]-data[i-1];
                    }else{
                        interval[i]=data[i];
                    }
                });
                var cont=0;
                $(interval).each(function(i){
                    cont=cont+parseFloat(interval[i]);
                });
                var average=cont/interval.length;
                var deviation=[];
                $(interval).each(function(i){
                    deviation[i]=(interval[i]-average)/average;
                });
                $("#interval-input").val(data.join(","));
                var postion=[];
                $(data).each(function(i){
                    var this_deviation=0;
                    for (var k=0;k<=i;k++){
                        this_deviation=this_deviation+deviation[k];
                    }
                    this_deviation=this_deviation.toFixed(5)*5;
                    postion[i]=((i+1)/data.length)*85+this_deviation;
                    button=button+'<div class="interval-button" style="left:'+postion[i]+'%"> <div class="interval-del-button">X</div> <div class="interval-bar-button">重</div> <div class="interval-bar-button-text">'+data[i]+'KG</div></div>';
                    if(i==0){
                        top=top+'<div class="tag" style="left:'+postion[i]/2+'%">0-'+data[i]+'KG</div>';
                    }else{
                        top=top+'<div class="tag" style="left:'+(postion[i]+postion[i-1])/2+'%">'+data[i-1]+'-'+data[i]+'KG</div>';
                    }
                });
                top=top+'<div class="tag" style="left:'+(100+postion[postion.length-1])/2+'%">'+data[data.length-1]+'KG以上</div>';
            }
            interval_top.html(top);
            interval_button.html(button);
            interval_top.find(".tag").each(function(){
                $(this).css("marginLeft","-"+$(this).actual('outerWidth')/2+"px");
            });
            interval_top.show();
            interval_button.show();
        }

        $(document).on("click", ".interval-del-button", function (){
	        if($(".interval-del-button").length<1){
	            $.toast("至少保留一个分组重量，否则请关闭定价分级开关", "text");
	            return;
	        }
            var this_button=$(this).closest(".interval-button");

            var index=$(this_button).index('.interval-button')-1;
            intervalArray.splice(index,1);
            interval_fun(intervalArray);
            
            //变更分级设定时调用方法后台
            //alert(intervalArray);
            changeLevel(intervalArray);
            
        });

        $(".del-cancel-btn").click(function () {
            $(".rankBox").removeClass("del-state");
        });
        $(".del-btn").click(function () {
            $(".rankBox").addClass("del-state");
        });
        $(".add-btn").click(function () {
        	if(intervalArray.length > 3){
        		$.toast("最多设置5个级别", "text");
        		return;
        	};
            $(".on-off").show();
            //var rankVal;
           
        });
        $(".rank-input").keyup(function(){
    		wholeNumCheck($(this));
    	})
        $(".on").click(function () {
            var rankVal=$(".rank-input").val();
            if(rankVal.length>0) {
            	//console.log(typeof rankVal);
            	//console.log(intervalArray);
            	//console.log(intervalArray.indexOf(rankVal));
            	if(intervalArray.indexOf(rankVal)==-1){
            		$(".on-off").hide();
		            $(".unfiedPrice").show();
	            	intervalArray.push(rankVal);
	                interval_fun(intervalArray);
            	}else{
            		$.toast("分级重量不能重复", "text");	
                	return;
            	}
	           
            }else{
            	$.toast("请输入分级重量", "text");	
            	return;
            }
            
          //变更分级设定时调用方法后台
            //alert($("#input_weight").val());
            //alert(intervalArray);
            changeLevel(intervalArray);
            $("#input_weight").val("");
        });
        $(".off").click(function () {
        	intervalArray = [];
        	/* $(".interval-bar-button-box").empty();
        	$(".interval-top-box").empty(); */
            $(".on-off").hide();
            $(".unfiedPrice").show();
        });
        $(".rank-input").focus(function(){
            $(".unfiedPrice").hide();
        });
    })(jQuery);
</script>
<script>
    $("#startTime").picker({
        title: "选择拍卖时间",
        cols: [
               {
                   textAlign: 'center',
                   values: ['00点', '01点', '02点', '03点', '04点', '05点', '06点', '07点', '08点', '09点', '10点', '11点', '12点', '13点', '14点', '15点', '16点', '17点', '18点', '19点', '20点', '21点', '22点', '23点']
               },
               {
                   textAlign: 'center',
                   values: ['00分', '10分','20分','30分','40分','50分']
               }
        ],
        onChange:function () {
            //console.log($(".picker-selected").html());
        },
        onClose : function(){
        	$("#endTime").click();
        }
    }
    );
    
    $("#endTime").picker({
        title: "选择拍卖时间",
        cols: [
               {
                   textAlign: 'center',
                   values: ['00点', '01点', '02点', '03点', '04点', '05点', '06点', '07点', '08点', '09点', '10点', '11点', '12点', '13点', '14点', '15点', '16点', '17点', '18点', '19点', '20点', '21点', '22点', '23点']
               },
               {
                   textAlign: 'center',
                   values: ['00分', '10分','20分','30分','40分','50分']
               }
        ],
        onClose : function(){
        	//alert($("#startTime").val());
        	//alert($("#endTime").val());
        	timeSetting($("#startTime").val(), $("#endTime").val());
        }
    });

    //滑动按钮状态切换

    var time = document.querySelector("#time");
    var rank = document.querySelector("#rank");
    var price = document.querySelector("#price");

    var timeInput = $(".weui_cells");
    var rankBox = $(".rankBox");
    var priceBox=$(".priceBox");
	

    function changeStateBtn(changeState,id, status) {
        //默认为关闭状态 flag = false
        var flag = false;
        var xStart;
        var left;
        changeState.addEventListener("touchstart",function(e){
            xStart = e.changedTouches[0].clientX;
            left = parseInt(changeState.style.left) || 0;
        });
        
        if(status == '1'){
            //开启状态
            $(changeState).attr("src","/static/newhope/html/images/hj/btn_sm_on.png");
            flag = true;
            id.show();
        }
        
        changeState.addEventListener("touchmove",function(e){
        	var this_ = $(this);
            var xEnd = e.changedTouches[0].clientX;
            var move = xEnd-xStart;

            if(move > 5 && flag == false){
                //开启状态
                this_.attr("src","/static/newhope/html/images/hj/btn_sm_on.png");
                flag = true;
                //do something
                id.show();
                //调用后台数据设为打开
                openOrCloseSetting(changeState, 1);
            }else if(move < -5 && flag == true){
                //关闭状态
                this_.attr("src","/static/newhope/html/images/hj/btn_sm_off.png");
                flag = false;
                id.hide();
				//调用后台数据设为关闭
				if($(changeState).attr("id") != 'time')
				{
					$.confirm("关闭后将会影响已有的定价信息，确认关闭？","", function() {
						openOrCloseSetting(changeState, 0);
				  	}, function() {
				  		this_.attr("src","/static/newhope/html/images/hj/btn_sm_on.png");
				        flag = true;
				        id.show();	
				  	return;
				  });
				}else{
					openOrCloseSetting(changeState, 0);
				}
				
            }
        });
    }


    /*--------------------------------------------------这里实现自己的JS-----------------------------*/
    //初始化按钮状态
    function initBtnStatus(obj, id, status){
    	if(status == '1'){
            //开启状态
            $(obj).attr("src","/static/newhope/html/images/hj/btn_sm_on.png");
            flag = true;
            id.show();
        }
    }
    
    //初始化展示数据
    function init(){
    	var priceStatus = ('${circleModel.isPrice}' == 'true') ? '1' : '0';
        var timeStatus = ('${circleModel.isBidtime}' == 'true') ? '1' : '0';
        var rankStatus = ('${circleModel.isLevel}' == 'true') ? '1' : '0';
        
        changeStateBtn(time,timeInput, timeStatus);
        changeStateBtn(rank,rankBox, rankStatus);
        changeStateBtn(price,priceBox, priceStatus);
        
        if('${startTime}'){
        	//var startTime = '${startTime}'.split(":")[0] + "点 "+ '${startTime}'.split(":")[1] +"分";
        	//$("#startTime").val(startTime);
        }
        if('${endTime}'){
            //var endTime = '${endTime}'.split(":")[1] + "点 " + '${endTime}'.split(":")[1] + "分";
            //$("#endTime").val(endTime);
        }
    	
    }
    
    //设置打开或关闭设置
    function openOrCloseSetting(obj, flag){
    	var settingType = $(obj).attr("flagValue");
    		$.ajax({
    			url : "/trade/circle/openOrCloseSetting.do?&_d=" + new Date(),
    			data : {
    				settingType : settingType,
    				flag : flag,
    				circleId : '${circleModel.id}'
    			},
    			cache : false,
    			dataType : 'json',
    			success : function(data) {
    				if (data.success) {
    					if(flag == 0){
    					if(settingType == 'IS_LEVEL')	
    					location.reload();
    					}
    				} else {
    					$.toast(data.msg, "text");
    				}
    			}
    		});
    }
    
  	//时间设置
    function timeSetting(startTime, endTime){
  		//alert(startTime.split(" ")[0].substring(0,startTime.split(" ")[0].length-1));
  		//alert(startTime.split(" ")[1].substring(0,startTime.split(" ")[1].length-1));
  		//alert(startTime + " "+ endTime);
    	var startTime_data = startTime.split(" ")[0].substring(0,startTime.split(" ")[0].length-1) + ":"+ startTime.split(" ")[1].substring(0,startTime.split(" ")[1].length-1);
        var endTime_data = endTime.split(" ")[0].substring(0,endTime.split(" ")[0].length-1) + ":" + endTime.split(" ")[1].substring(0,endTime.split(" ")[1].length-1);
    	
    	var nowDate = getNowFormatDate();
    	startTime = (nowDate+" "+startTime).split(/[- : \/]/);
    	endTime = (nowDate+" "+endTime).split(/[- : \/]/);
    	startTime = new Date(startTime[0], startTime[1]-1, startTime[2], startTime[3], startTime[4]);
    	endTime = new Date(endTime[0], endTime[1]-1, endTime[2], endTime[3], endTime[4]);
    	//alert(startTime >= endTime);
    	if(startTime >= endTime){
    		$.toast("开拍时间不能等于或者大于结束时间", "text");
    		return;
    	}
    	$.ajax({
			url : "/trade/circle/timeSetting.do?&_d=" + new Date(),
			data : {
				startTime : startTime_data,
				endTime : endTime_data,
				circleId : '${circleModel.id}'
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				if (data.flag != 'succeed') {
					$.toast(data.msg, "text");
		            return;
				} 
			}
		});
    }
    
    //变更分级时设置后台
    function changeLevel(intervalArray){
    	intervalArray = intervalArray.join(",");
    	$.ajax({
			url : "/trade/circle/changeLevel.do?&_d=" + new Date(),
			data : {
				intervalArray : intervalArray,
				circleId : '${circleModel.id}'
			},
			cache : false,
			dataType : 'json',
			success : function(data) {
				if (data.flag != 'succeed') {
					$.toast(data.msg, "text");
				} 
			}
		});
    }
    
    //初始化
    init();
</script>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>