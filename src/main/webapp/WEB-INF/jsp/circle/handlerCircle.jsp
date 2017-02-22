<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<c:choose>
 <c:when test="${empty circleModel }">
	<title>新建交易圈</title>
 </c:when>
 <c:otherwise>
 <title>编辑交易圈</title>
 </c:otherwise>
</c:choose>
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport">
<!--script 适配-->
<script src="/static/newhope/html/js/htmlsize.js"></script>
<!--jquery-->
<script src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
<script src="/static/trade/js/tradeCommon.js?v=1"></script>
<!--引入外部自定义js-->
<script src="/static/newhope/html/js/commonFunction.js"></script>
<!-- 城市选择 -->
<link rel="stylesheet" href="/static/newhope/html/css/LArea.css">
<!--动态加载模块-->
<script src="/static/newhope/html/js/template.js"></script>
<!-- fontawesome -->
	<link rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css">
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jquery-weui.min.css"/>
<script src="//cdn.bootcss.com/jquery-weui/0.8.0/js/swiper.min.js"></script>
<script src="//cdn.bootcss.com/jquery-weui/0.8.0/js/city-picker.min.js"></script>
<!--城市选择插件-->
<!--引入onsaleing 自定义样式表-->
<link rel="stylesheet" href="/static/newhope/html/css/common.css" />
<link rel="stylesheet" href="/static/newhope/html/css/hj_setnewCircle.css" />
<style type="text/css">
       /*圈子名称相同*/
        .weui_toast,.weui_toast_text,.weui_toast_visible{
            width:auto;
            height: auto;
            font-size: 1.25rem;
            line-height: 2.2222rem;
            color:#fff;
            opacity:0.75;
            border-radius: 0.2222rem;
        }
       .toolbar{
           text-align:left;
       }
        /*城市选择插件*/
       .weui-picker-modal .picker-item{
           font-size: 0.8333rem;
           color: #333333;
           letter-spacing: 0;
           text-align: center;
       }
       .toolbar-inner>a{
       	  width:3.6111rem;
		  height:1.6667rem;
		  background: #1BBD3D;
		  border-radius: 0.1111rem;
		  color:#fff;
		  font-size: 0.8333rem;
		  text-align: center;
		  line-height:1.6667rem;
		  margin-right:0.6667rem;
		  margin-top:0.2778rem;
       }
       .toolbar .picker-button{
       		color:#fff;
       		padding:0;
       		line-height:1.6667rem;
       		height:1.6667rem;
       }
     
       .toolbar .title{  
       		margin-left:7.6667rem;
			font-size: 0.7778rem;
			color: #999999;
			width:4.6667rem;
			text-align:center;
       }
       .toolbar{
       	 background:#fff;
       }
      
</style>
</head>
<body>

	<div class="createcircleContent createPigcircle">
		<div id="imgParent">
			<c:choose>
				<c:when test="${!empty circleModel.img}">
					<img id="myheadPic" class="myheadPic" src="${imageServer }${circleModel.img}" alt="图片不见了" imgPath="${circleModel.img}">
				</c:when>
				<c:otherwise>
					<img id="myheadPic" class="myheadPic" imgPath=""
						src="/static/newhope/html/images/btn_uploadimg_normal.png"
						alt="图片不见了" imgPath="/static/newhope/html/images/btn_uploadimg_normal.png">
				</c:otherwise>
			</c:choose>
		</div>
		<ul>
			<li>
				<p>
					<span>圈子名称</span> 
					<span id="circleName_fontlimit">10字内</span>
				</p> 
				<input maxlength="10" id="circleName" type="text"
				     placeholder="10字以内" value="${circleModel.name }" />
			</li>
			<li>
                <p>
                    <span>所在区域</span>
                    <span id="citySelect"></span>
                </p>
                <div class="weui-row">
                    <div class="weui-col-70">
                        <div class="content-block">
                            <input  id="start" type="text" >
                            <i class="fa fa-caret-down @upIcon" id="icon_citypicker" aria-hidden="true"></i>
                        </div>
                    </div>
                    <div class="weui-col-30">
                       <!--  <a href="javascript:;" id="location" class="weui_btn weui_btn_mini weui_btn_primary">定位</a> -->
                     <input type="button" id="location" value="定位">
                    </div>
                </div>
            </li>
			<li>
				<p>
					<span>圈子描述</span>
                    <span class="notNull"></span>
				</p> 
				<textarea maxlength="30" name="simpleText"
					id="simpleText" placeholder="请简要说明圈子的基本情况">${circleModel.circleDec }</textarea>
				<span id="simpleText_fontlimti">30字内</span>
			</li>
			<li>
				<p>
                    <span>加入要求</span>
                    <span class="notNull"></span>
                </p>
                <textarea maxlength="30" name="simpleText"
					id="joinCondition" cols="18" rows="5" placeholder="请简要说明加入圈子的基本要求">${circleModel.circleCondition}</textarea>
				<span id="joinCondition_fontlimti">30字内</span>
			</li>
			<li>
                <p>
					<span>私密</span>
                    <span class="notNull"></span>
                </p>
                <div class="weui-row">
                    <div class="weui-col-40">
                    <c:choose>
                     <c:when test="${(circleModel.circleType.value eq 'PRIVATE') == true}">
                        <img id="changeState" src="/static/newhope/html/images/hj/btn_sm_on.png" alt="私密">
                     </c:when>
                     <c:otherwise>
                      <img id="changeState" src="/static/newhope/html/images/hj/btn_sm_off.png" alt="公开">
                     </c:otherwise>
                    </c:choose>
                    </div>
                    <div class="weui-col-60">
                        <span>向右滑动，开启私密交易圈，交易用户由您指定，交易信息不公开</span>
                    </div>
                </div>

            </li>
		</ul>

		<div id="div_footer">
		 	<input type="button" value="提交" id="btn_submit">
			<!-- <a href="javascript:;" class="weui_btn weui_btn_primary" id="btn_submit">提交</a> -->
		</div>
	</div>
	<input type="hidden" id="circleid" value="${circleModel.id}">
	<input type="hidden" id="originalName" value="${circleModel.name }">
	 <!--下拉选择蒙层-->
    <div style="display: none" class="selectType">
		
    </div>
	<!-- 地图 -->
	<%@include file="../map/mapPosition2.html"%>
	
	<script src="//cdn.bootcss.com/jquery/1.11.0/jquery.min.js"></script>
	<script src="//cdn.bootcss.com/jquery-weui/0.8.0/js/jquery-weui.min.js"></script>
	<script src="//cdn.bootcss.com/jquery-weui/0.8.0/js/swiper.min.js"></script>
	<script src="//cdn.bootcss.com/jquery-weui/0.8.2/js/city-picker.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script>
	<!-- 引入上传图片 -->
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript" src="/static/trade/js/uploadImg.js?v=201611191118"></script>
	<!-- 圈子名字重复 -->
	<script type="text/javascript">
		$(function() {
			var circleName = document.querySelector("#circleName");
			var simpleText = document.querySelector("#simpleText");
			var joinCondition = document.querySelector("#joinCondition");
			var circleName_fontlimit = 'circleName_fontlimit';
			var simpleText_fontlimti = 'simpleText_fontlimti';
			var joinCondition_fontlimti = 'joinCondition_fontlimti';
			var bordercolor = '#D8D8D8';
			var fontcolor = '#999999';
			
			
			//圈子名称
			fontLimit(circleName, circleName_fontlimit, bordercolor, fontcolor,
					10);
			//圈子描述
			fontLimit(simpleText, simpleText_fontlimti, bordercolor, fontcolor,
					30);
			//加入要求
			fontLimit(joinCondition, joinCondition_fontlimti, bordercolor,
					fontcolor, 30);
			//字数限制的判定函数
			function fontLimit(eleName, spanId, bordercolor, fontcolor,
					limitcount) {
				eleName.addEventListener("keydown", function() {
					var totallength = eleName.value.length;
					if (totallength >= limitcount) {
						//border变成红色
						$(this).css({
							"border" : "0.0278rem solid #FA4848"
						});
						//span字数限制变红
						$('#' + spanId).css({
							"color" : "#FA4848"
						});
					} else {
						//border变成以前的颜色
						$(this).css({
							"border-color" : bordercolor
						});
						//span变成以前的颜色
						$('#' + spanId).css({
							"color" : fontcolor
						});
					}
				})
			}
			//圈子名称重复：失去焦点
			function differentcirclename(eleName) {
				eleName.addEventListener('blur', function() {
					//失去焦点的时候，判断圈子名是否重复
					//假设重复的名字为   张三的猪圈
					var name = $(this).val();
					if(checkEmpty(name)){
						$.toast("请输入圈子名称", "text");
						return ;
					}
					var originalName = $("#originalName").val();
					if(originalName != name){
							$.ajax({
							   url:"/trade/circle/validename?name="+name+"&circleid="+circleid,
							   cache:false,
							   timeout: 10000,
							   success:function(res){
								   if(!res.success){
								   	  $.toast(res.msg, "text");   
								   }
							   },
							   error:function(XMLHttpRequest,textStatus, errorThrown){
								  if(textStatus == 'timeout'){
									  $.toast("连接超时", "text");
								  }
							   }
							});
						};
				/* 	if ($(this).val() === '张三的猪圈') {
						//提示名字不能相同
						$.toast("名称与其他圈子重复，请输入新名字", "text");
					} */

				})
			}
			;
			differentcirclename(circleName);
			
			//点击提交按钮，判断是否为空
            //遍历所有的li下面的input
            $("li input").blur(function(){
                var totallength = $(this).val().length;
                var idName = $(this).attr("id");
                //圈子名称
                if(idName == 'circleName' && totallength == 0){
                	$(this).css({"border":"0.0556rem solid #FA4848"});
                    $(this).parent().siblings("p").children("span[id=citySelect]").css({"color":"#FA4848"});
                }else{
                	$(this).css({"border-color": '#D8D8D8'});
                    //span变成以前的颜色
                    $(this).parent().siblings("p").children("span[id=citySelect]").css({"color":"#999"});
                }

                //textarea
                $("li textarea").blur(function(){
                    var totallength = $(this).val().length;
                    var idName = $(this).attr("id");
                    //圈子名称
                    if(totallength == 0){
                        $(this).css({"border":"0.0556rem solid #FA4848"});
                        $(this).siblings("p").children("span[class=notNull]").html("此条不能为空");
                        $(this).siblings("p").children("span[class=notNull]").css({"color":"#FA4848"});
                    }else{
                        $(this).siblings("p").children("span[class=notNull]").html(" ");
                        $(this).css({"border-color": '#D8D8D8'});
                        $(this).siblings("span").css({"color":"#999"});
                    }
                });

            });

        });
	</script>
	<script>
	<!--头像图片选择-->
	 var flag = false;
	 if(('${circleModel.circleType.value}' == 'PRIVATE')){
		 flag = true;
	 }
	 
	 //上传照片后的回调
	 function uploadCallback(obj){
	 	uploadCallbackSetValue(obj);
	 }

	 //上传照片后的回调赋值
	 function uploadCallbackSetValue(response){
		 $("#myheadPic").attr("src", response.imageSrc);
		 $("#myheadPic").attr("imgPath", response.imgPath);
	 }
	$(function() {
		// 选择头像图片  点击事件
		$(".myheadPic").click(function() {
			wxChooseImage("uploadCallback");
			/*$.actions({
				actions : [ {
					text : "从手机相册里面选择",
					onClick : function() {
						wxChooseImage("uploadCallback");
					}
				}
				 , {
					text : "拍照上传",
					onClick : function() {
						wxChooseImage("uploadCallback");
					}
				}  
				]
			});*/
		});
		//私密 按钮状态切换
        //默认为公开状态 flag = false
        var changeState = document.querySelector("#changeState");
        changeState.addEventListener("touchstart",function(e){
            xStart = e.changedTouches[0].clientX;
            left = parseInt(changeState.style.left) || 0;
        });

        changeState.addEventListener("touchmove",function(e){
            xEnd = e.changedTouches[0].clientX;
            move = xEnd-xStart;
            if(move > 5 && flag == false){
                //开启私密状态
                $(this).attr("src","/static/newhope/html/images/hj/btn_sm_on.png");
                flag = true;
                //do something
            }else if(move < -5 && flag == true){
                //公开状态
                $(this).attr("src","/static/newhope/html/images/hj/btn_sm_off.png");
                flag = false;
                //do something
            }
        });
		 
	})	
/*================================<!--用户城市选择-->1.如果是新建，则取用户当前定位地址2.如果是修改，则取历史地址=====================================*/
		var circleModel = '${circleModel}';
		var $start = $('#start');
		//自动定位
		function setDefaultAddress() {
			$(".createPigcircle").show();
		    $("#div_mapAddress").hide();
			$start.val($("#current_province").val()+' '+$("#current_city").val()+' '+$("#current_district").val());
			layer.closeAll(); 	
		}
		if (checkEmpty(circleModel)) {
			layer.msg('位置获取中', {
                        icon: 16,
                        shade:  [0.5, '#000000'],
                        time:4000,
                        		});
			var callback = function callback() {
				setDefaultAddress();
			}
			//调用定位，获取位置信息
			loadLocation(callback);
		}else{
			 warpMapAddress('${circleModel.province}', '${circleModel.city}',
					'${circleModel.district}', '${circleModel.lat}',
					'${circleModel.lgn}');
			 
			 $start.val('${circleModel.province}'+' '+'${circleModel.city}'+' '+'${circleModel.district}');	
		}
		
		 $start.cityPicker({
			title : "选择所在区域",
			onClose:function(e){
			  loadLocationParam("searchByStationName('"+e.displayValue[0]+"', '"+e.displayValue[1]+"', '"+e.displayValue[2]+"')");
			  $(".selectType").hide();
			},
            onOpen:function(){
            	//城市选择取消按钮
    			$(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker'  value='取消'>");
            	$(".selectType").css({"display":"block"});             
            	$("input,textarea").each(function(){
                    if($(this).attr("id") === document.activeElement.id){     
                    	console.log("aaaa");
                        $(this).blur();                  
                    }
               });
            }
		});
		 
		 //取消按钮
		
		//确定按钮 picker-button close-picker
		 $(".picker-button").on("click",function(){
		 	$(".selectType").css({"display":"none"});
		 })
		 $(".close-select").on("click",function(){
		 	$(".selectType").css({"display":"none"});
		 })
		 $(".close-picker").on("click",function(){
		 	$(".selectType").css({"display":"none"});
		 })
		 
	
		 
		
		 
/*=======================================================<!--定位结束-->===================================================*/	
//获取表单数据
function getFormData(){
	var type = "PUBLIC";
	
	if(flag){
		type = "PRIVATE";
	}
	var circle = {
			id:$("#circleid").val(),
			name:$("#circleName").val(),
			province:$("#current_province").val(),
			city:$("#current_city").val(),
			district:$("#current_district").val(),
			lat:$("#current_lat").val(),
			lgn:$("#current_lng").val(),
			img:$(".myheadPic").attr("imgPath"),
			circleDec:$("#simpleText").val(),
			circleCondition:$("#joinCondition").val(),
			circleType:type
	};
	return circle;
}
//提交表单
$("#btn_submit").click(function(){
	 var param =$("#circleName").val();
     var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
     if(param.match(regRule)) {
         param = param.replace(/\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g,"");
         $("#circleName").css({"border":"0.0556rem solid #FA4848"});
         $.toast("圈子名称不能输入表情", "text");
         return;
     }
     
	var myheadPicPath = $("#myheadPic").attr("imgPath");
	 if(checkEmpty(myheadPicPath)){
		$.toast("请选择照片", "text");
		return;
	} 
	var input_flag = false;
	 $("li input").each(function(index,item){
         var totallength = $(this).val().length;
         //1）圈子名称
         if(index == 0 && totallength == 0){
             $(this).css({"border":"0.0556rem solid #FA4848"});
             $(this).siblings("p").children("span[id=circleName_fontlimit]").html(" ");
             $(this).siblings("p").children("span[id=circleName_fontlimit]").html("此条不能为空");
             $(this).siblings("p").children("span[id=circleName_fontlimit]").css({"color":"#FA4848"});
             //阻止提交操作：
             input_flag = true;
             //do something
         }else{
             $(this).css({"border-color": '#D8D8D8'});
             //span变成以前的颜色
             $(this).siblings("p").children("span[id=circleName_fontlimit]").html(" ");
             $(this).siblings("p").children("span[id=circleName_fontlimit]").html("10字内");
             $(this).siblings("p").children("span[id=circleName_fontlimit]").css({"color":"#999"});
         }
     })
     //textarea
     $("li textarea").each(function(index,item){
         var totallength = $(this).val().length;
         //圈子名称
         if(totallength == 0){
             $(this).css({"border":"0.0556rem solid #FA4848"});
             $(this).siblings("p").children("span[class=notNull]").html("此条不能为空");
             $(this).siblings("p").children("span[class=notNull]").css({"color":"#FA4848"});
             input_flag = true;
         }else{
             $(this).siblings("p").children("span[class=notNull]").html(" ");
             $(this).css({"border-color": '#D8D8D8'});
             $(this).siblings("span").css({"color":"#999"});
         }
     });
  	if(input_flag){
		return  false;
   	}
	 $.ajax({ 
         type:"POST", 
         url:"/trade/circle/savecircle", 
         dataType:"json",      
         contentType:"application/json",               
         data:JSON.stringify(getFormData()), 
         success:function(res){ 
              if(!res.success){
            	$.toast(res.msg, "text");    
              }else{
                 $.toast(res.msg, "text");      
            	  setTimeout(function(){
            	 	location.href="/trade/circle/list?type=whole";
            	  },2000);
              }                      
         },error:function(XMLHttpRequest,textStatus, errorThrown){
        	 if(textStatus == 'timeout'){
				  $.toast("连接超时", "text");
			  }else{
				  $.toast("系统异常,请联系管理员", "text"); 
			  }
         } 
      });
});

//点击定位按钮的时候
$("#location").on("click",function(e){
    $(".createPigcircle").hide();
    $("#div_mapAddress").show();
    loadScript();
});
var callback1 = function callback1() {
	setDefaultAddress();
}
//用于返回定位信息
function myPosition(){
	dingwei(callback1);
}


	</script>
	 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
	
</body>
</html>