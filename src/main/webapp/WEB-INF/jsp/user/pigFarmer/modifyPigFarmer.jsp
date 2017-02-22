<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>编辑${pigFarmInfo.name}</title>
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
    <meta name="format-detection" content="telemobile=no">
    <!--script 适配-->
    <script src="/static/newhope/html/js/htmlsize.js"></script>
    <!--jquery-->
    <script src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>

    <!--引入外部自定义js-->
    <script src="/static/newhope/html/js/commonFunction.js"></script>

    <!-- 城市选择 -->
    <link rel="stylesheet" href="/static/newhope/html/css/LArea.css">
    <!--动态加载模块-->
    <script src="/static/newhope/html/js/template.js"></script>

    <!-- fontawesome -->
    <link rel="stylesheet" href="/static/newhope/html/css/font-awesome/css/font-awesome.min.css">

    <!--weui-->
    <link rel="stylesheet" href="/static/newhope/html/css/weui.min.css">
    <link rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css">

    <!--引入onsaleing 自定义样式表-->
    <link rel="stylesheet" href="/static/newhope/html/css/common.css"/>
    <c:choose>
    <c:when test="${pigFarmInfo.source.value eq 'FY'}">
    <link rel="stylesheet" href="/static/newhope/html/css/hj_edit(fangyang)PigCircle.css"/>
    </c:when>  
    <c:otherwise>
     <link rel="stylesheet" href="/static/newhope/html/css/hj_createPigCircle.css"/>
    </c:otherwise>  
    </c:choose>
    <!--  weui城市选择js -->
    <script src="/static/newhope/html/js/jquery-weui.min.js"></script>
    <script src="/static/newhope/html/js/city-picker.min.js?v=2.0"></script>
    <script src="/static/trade/js/tradeCommon.js?v=2.1"></script>
    <script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script> 
    <style type="text/css">
        .toolbar>.toolbar-inner>h1.title{
            text-align: left;
            color:#333333;
            font-size: 0.7778rem;
            line-height: 2.2222rem;
            padding-left: 0.6667rem;
        }
        div.weui_cell_bd,.weui_cell_primary > p{
            color:#333333;
            font-size: 0.7778rem;
        }
        /*城市选择插件*/
        .weui-picker-modal .picker-item{
            font-size: 0.8333rem;
            color: #333333;
            letter-spacing: 0;
            text-align: center;
        }
        .weui-picker-modal{
            background-color: #fff;
        }
        
        #div_mapAddress{
            display: none;
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

        .toolbar>.toolbar-inner>h1.title{
            margin-left:7.6667rem;
            font-size: 0.7778rem;
            color: #999999;
            width:4.6667rem;
            text-align:center;
            padding-left:0;

        }
        .toolbar{
            background: #fff;
        }
    </style>
</head>

<body>
<c:if test="${pigFarmInfo.source.value eq 'FY'}">
    <header>
        <p>提示：放养猪场不能更改猪场名称和手机号码</p>
    </header>
    <section>
        <p>猪场名称：<span>${pigFarmInfo.name}</span></p>
        <input type="hidden" id="name" value="${pigFarmInfo.name}">
        <p>手机号码：<span>${pigFarmInfo.mobileStr}</span></p>
        <input type="hidden" id="mobile" value="${pigFarmInfo.mobile}">
    </section>
 <div class="editPigcircle">
        <ul>   
</c:if>
<c:if test="${pigFarmInfo.source.value eq 'ZXE'}">
   <div class="createPigcircle">
        <ul>     
            <li>
                <p>
                    <span>猪场名称</span>
                    <span id="circleName_fontlimit">15字内</span>
                    <span class="errMes">此条不能为空</span>
                </p>
                <input value="${pigFarmInfo.name}" maxlength="15" id="name" type="text" placeholder="请创建您的猪场名称"/>
            </li>
            <li>
                <p>
                    <span>手机号码</span>
                    <span id="mobileNumber"></span>
                    <span class="errMes" id="mobileErr">此条不能为空</span>
                </p>
                <input value="${pigFarmInfo.mobile}" id="mobile"  maxlength="15"  type="number" placeholder="请输入您的手机号码" />
            </li>
 </c:if>
            <li>
                <p>
                    <span>交割地址</span>
                    <span class="notNull"></span>
                    <span class="errMes" style="display: none">提交失败，请填写详细交割地址</span>
                </p>
                <div class="weui-row">
                    <div class="weui-col-70">
                        <!--地址定位-->
                        <div class="content-block">
                            <input type="text" id='start'/>
                            <i class="fa fa-caret-down @upIcon" id="icon_citypicker" aria-hidden="true"></i>
                        </div>
                    </div>
                    <div class="weui-col-30">
                        <!--按钮-->
                       <!--  <a href="javascript:;" id="location" class="weui_btn weui_btn_mini weui_btn_primary">定位</a> -->
                       <input type="button" id="location" value="定位">
                    </div>
                </div>
                <input id="detailAddr"  maxlength="30" value="${empty pigFarmInfo.mapAddress?pigFarmInfo.address :pigFarmInfo.mapAddress   }" type="text" placeholder="请填写门牌号等详细地址" />
            </li>
            
            
            <li>
                <p>
                    <span>交通情况</span>
                    <span class="notNull"></span>
                </p>
                <div class="weui-row">
                    <div class="weui-col-14" >
                        <p>限高</p>
                    </div>
                    <div class="weui-col-86" >
                        <!--下拉框-->
                        <!--限高-->
                        <div class="content-block">
                            <input type="text" id="heightLimit" 
                            value="${pigFarmInfo.limitHeight.displayName eq null ? '未知':pigFarmInfo.limitHeight.displayName }" 
                            data-values="${pigFarmInfo.limitHeight.value eq null ? 'UNKNOW': pigFarmInfo.limitHeight.value}"/>
                            <i class="fa fa-caret-down @upIcon" aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
                <div class="weui-row">
                    <div class="weui-col-14">
                        <p >限长</p>
                    </div>
                    <div class="weui-col-86">
                        <!--下拉框-->
                        <!--限长-->
                        <div class="content-block">
                            <input id="lengthLimit" type="text" value="${pigFarmInfo.limitLength.displayName eq null ? '未知':pigFarmInfo.limitLength.displayName }" data-values="${pigFarmInfo.limitLength.value eq null ? 'UNKNOW': pigFarmInfo.limitLength.value}"/>
                            <i class="fa fa-caret-down @upIcon"  aria-hidden="true"></i>
                        </div>
                    </div>
                </div>
                <textarea maxlength="15" name="otherTransportDetail" id="otherTransportDetail" placeholder="填写其他交通情况">${pigFarmInfo.otherTrifficInfo}</textarea>
                <span>15字内</span>
            </li>
        </ul>

        <div id="div_footer">
            <!--<input type="button" value="提交" id="btn_submit"/>-->
            <input type="button" value="提交" id="btn_submit">         
        </div>
        <input type="hidden" id="id" value="${pigFarmInfo.id}">
       
    </div>
      <!--下拉选择蒙层-->
	    <div style="display: none" class="selectType">
			
	    </div>
	<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/inputAstrict.js"></script>    
    <script type="text/javascript">
    var $start = $("#start");
    var limitHeightValue = '${pigFarmInfo.limitHeight.value}';
    var limitLengthValue = '${pigFarmInfo.limitLength.value}';
    if(checkEmpty(limitHeightValue)){
    	limitHeightValue = 'UNKNOW';
    }
    if(checkEmpty(limitLengthValue)){
    	limitLengthValue = 'UNKNOW';
    }
	var pigFarmObj = {
			id:$("#id").val(),
			name:"${pigFarmInfo.name}",
			mobile:"${pigFarmInfo.mobile}",
			pigFaramAddress:{
				provName:"${pigFarmInfo.pigFaramAddress.provName}",
				cityName:"${pigFarmInfo.pigFaramAddress.cityName}",
				countyName:"${pigFarmInfo.pigFaramAddress.countyName}"
			},
			limitHeight:limitHeightValue,
			limitLength:limitLengthValue,
			lat:"${pigFarmInfo.lat}",
			lng:"${pigFarmInfo.lng}",
			otherTrifficInfo:"${pigFarmInfo.otherTrifficInfo}",
			source:"${pigFarmInfo.source.value}",
			//详细地址
			address:"${pigFarmInfo.address}",
			mapAddress:"${pigFarmInfo.mapAddress}"
			
	};
	 //var regRule = /\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g;
        $(function(){
        	 //input框改变的时候
            $(document).on("input propertychange", "ul>li", function(){
                $(this).removeClass("err");
                $(this).children("p").children("span[class=errMes]").hide();
                $(this).children("p").children("span[class=errMes]").css({"border-color":'#D8D8D8'});
            });
            
            //检查手机号方法
            function is_mobile_number(a) {
                var pattern = /^1[34578]\d{9}$/;
                if (pattern.test(a)) {
                    return true;
                }
                return false;
            }
            //判断手机号是否正确
            $("#mobile").change(function(){
                if(!is_mobile_number($(this).val())){
                    $("#mobileNumber").hide();
                    $(this).siblings("p").children("span[class=errMes]").show();
                    $(this).siblings("p").children("span[class=errMes]").html("请输入正确的手机号");
                    $(this).siblings("p").children("span[class=errMes]").css({"color":"#FA4848"});
                }
            })
        //提交按钮事件	
        $("#btn_submit").click(function(){
        	$("#btn_submit").prop("disabled",true);
        	var passValid = true;
        	$("ul>li>input").each(function(){
                if($(this).val().length == 0){
                    $(this).parent("li").addClass("err");
                    $(this).siblings("p").children("span[class=errMes]").show();
                    passValid = false;
                }
        	});
        	
            if(!passValid){
            	 $("#btn_submit").prop("disabled",false);
            	return;
            }
            if(is_mobile_number($("#mobile").val())){
                $("#mobile").css({"border-color":'#D8D8D8'});
            }else{
            	$("#mobileNumber").hide();
                $("#mobileErr").show();
                $("#mobileErr").html("请输入正确的手机号");
                $("#mobileErr").css({"color":"#FA4848"});
            	 $("#btn_submit").prop("disabled",false);
            	return;
            }	//表情正则验证
            	//名称验证
	            var nameTxt="猪场名称不能输入表情";
	            var flag=false;
	            flag=inputAstrict($("#name"),nameTxt,$("#btn_submit"));
	            if(flag){
	            	return;
	            }
	            var name = $("#name").val();
            	/* var name = $("#name").val(); 
            	if(name.match(regRule)) 
                {
                    $("#name").css({"border":"0.0556rem solid #FA4848"});
                    $.toast("猪场名称不能输入表情", "text",function(){
                    	$("#name").val("");
                		//$("#name").val(name.replace(/\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g,""));
                    	$("#name").css({"border":"0.0556rem solid #D8D8D8"});
                    	$("#btn_submit").prop("disabled",false);
                    });
                    return;
                } */
            	pigFarmObj.name=name;
            	var mobile = $("#mobile").val();pigFarmObj.mobile=mobile;
            	//详细地址
             	var detailAddr = $("#detailAddr").val();
                //假如提交失败，交割地址报错
                //阻止提交操作：
                if(checkEmpty(detailAddr)||checkEmpty(pigFarmObj.pigFaramAddress.provName)||
                		   checkEmpty(pigFarmObj.pigFaramAddress.cityName)||checkEmpty(pigFarmObj.pigFaramAddress.countyName)){
                    //出错了
                    $("#detailAddr").css({"border":"0.0556rem solid #FA4848"});
                    $("#detailAddr").siblings("p").children("span[class=notNull]").html("提交失败，请填写详细交割地址");
                    $("#detailAddr").siblings("p").children("span[class=notNull]").css({"color":"#FA4848"});
                    //do something
                     $("#btn_submit").prop("disabled",false);
                    return;
                }else {
                	var addrTxt="详细地址不能输入表情";
                	flag=inputAstrict($("#detailAddr"),addrTxt,$("#btn_submit"));
                	if(flag){
                    	return;
                    };
                	/* if(detailAddr.match(regRule)) 
                    {
                        $("#detailAddr").css({"border":"0.0556rem solid #FA4848"});
                        $.toast("详细地址不能输入表情", "text",function(){
                    		$("#detailAddr").val(detailAddr.replace(/\uD83C[\uDF00-\uDFFF]|\uD83D[\uDC00-\uDE4F]/g,""));
                        	$("#detailAddr").css({"border":"0.0556rem solid #D8D8D8"});
                        	$("#btn_submit").prop("disabled",false);
                        });
                        return;
                    } */
                    //地址正确
                    $("#detailAddr").css({"border":"0.0556rem solid #D8D8D8"});
                    $("#detailAddr").siblings("p").children("span[class=notNull]").html(" ");
                    pigFarmObj.address=detailAddr;
                }
              //其它交通情况
            	var otherTransportDetail =$("#otherTransportDetail").val();
            	pigFarmObj.otherTrifficInfo=otherTransportDetail;
            	$.ajax({ 
                    type:"POST", 
                    url:"/user/pigFaram/handler", 
                    dataType:"json",      
                    contentType:"application/json",               
                    data:JSON.stringify(pigFarmObj), 
                    success:function(res){ 
                         if(!res.success){
                       	   $.toast(res.msg, "text");
                       	   $("#btn_submit").prop("disabled",false);
                         }else{
                        	 $.toast(res.msg, "text");
      		            	  setTimeout(function(){
      		            	 	location.href="/user/pigFaram/toPigFaramListPage";
      		            	  },2000);
                       	 }
                    },error:function(XMLHttpRequest,textStatus, errorThrown){
                    	 $("#btn_submit").prop("disabled",false);
                   	 if(textStatus == 'timeout'){
           				  $.toast("连接超时", "text");
           			  }else{
           				 $.toast("系统异常,请联系管理员", "text");
           			  }
                    } 
                 });
            });
            
             //限制高度操作
            $("#heightLimit").select({
                title: "选择限高条件",
                multi: false,
                items: [
                    {
                        title: '${heightType[0].displayName}',
                        value: '${heightType[0].value}'
                    },
                    {
                        title: '${heightType[1].displayName}',
                        value: '${heightType[1].value}'
                    },
                    {
                        title: '${heightType[2].displayName}',
                        value: '${heightType[2].value}'
                    },
                    {
                        title: '${heightType[3].displayName}',
                        value: '${heightType[3].value}'
                    },
                    {
                        title: '${heightType[4].displayName}',
                        value: '${heightType[4].value}'
                    }
                ],
                onClose:function(e){
                	if(checkObjNotEmpty(e.data.values)){
                	   pigFarmObj.limitHeight = e.data.values;
                	}
                	$(".selectType").css({"display":"none"});    
                },
                onChange:function(){
                	$(".selectType").css({"display":"none"});    
                },
                onOpen:function(){
               	 //取消按钮
                   $(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker close-select'  value='取消'>");
                   $(".selectType").css({"display":"block"});  
                   $("input,textarea").each(function(){
                       if($(this).attr("id") === document.activeElement.id){                            	
                           $(this).blur();                  
                       }
                   });
               }               
            });
            //限长操作
            $("#lengthLimit").select({
                title: "选择限长条件",
                multi: false,
                items: [
                    {
                    	title: '${lengthType[0].displayName}',
                        value: '${lengthType[0].value}'
                    },
                    {
                    	title: '${lengthType[1].displayName}',
                        value: '${lengthType[1].value}'
                    },
                    {
                    	title: '${lengthType[2].displayName}',
                        value: '${lengthType[2].value}'
                    },
                    {
                    	title: '${lengthType[3].displayName}',
                        value: '${lengthType[3].value}'
                    },
                    {
                    	title: '${lengthType[4].displayName}',
                        value: '${lengthType[4].value}'
                    },
                    {
                    	title: '${lengthType[5].displayName}',
                        value: '${lengthType[5].value}'
                    },
                    {
                    	title: '${lengthType[6].displayName}',
                        value: '${lengthType[6].value}'
                    }
                ],
                onClose:function(e){
                	if(checkObjNotEmpty(e.data.values)){
                	pigFarmObj.limitLength = e.data.values
                	}
                	$(".selectType").css({"display":"none"});  
                },
                onChange:function(){
                	$(".selectType").css({"display":"none"});    
                },
                onOpen:function(){
               	 //取消按钮
                   $(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker close-select'  value='取消'>");
                   $(".selectType").css({"display":"block"});
                   $("input,textarea").each(function(){
                       if($(this).attr("id") === document.activeElement.id){                            	
                           $(this).blur();                  
                       }
                   });
               }
            });
            //城市选择
             var province = "${pigFarmInfo.pigFaramAddress.provName}";
             var city = "${pigFarmInfo.pigFaramAddress.cityName}";
             var town = "${pigFarmInfo.pigFaramAddress.countyName}";
             $start.val(province+' '+city+' '+town); 
             //console.log(province+' '+city+' '+town);
             $start.cityPicker({
                title: "选择所在区域",
                onClose:function(e){
                	if(pigFarmObj.pigFaramAddress.provName!=e.displayValue[0] || pigFarmObj.pigFaramAddress.cityName!=e.displayValue[1]
                	||pigFarmObj.pigFaramAddress.countyName!=e.displayValue[2]){
                		pigFarmObj.pigFaramAddress.provName=e.displayValue[0];
                    	pigFarmObj.pigFaramAddress.cityName=e.displayValue[1];
                    	pigFarmObj.pigFaramAddress.countyName=e.displayValue[2];	
                		$("#btn_submit").prop("disabled",true);
                		loadLocationParam("searchByStationName('"+e.displayValue[0]+"', '"+e.displayValue[1]+"', '"+e.displayValue[2]+"')");
                		layer.msg('位置获取中...', function(){
                		pigFarmObj.lat = $("#current_lat").val();
                   	    pigFarmObj.lng = $("#current_lng").val();
                   	    $("#detailAddr").val($("#current_address").val());
                   	 	pigFarmObj.mapAddress=$("#current_address").val();
                   	 	$("#btn_submit").prop("disabled",false);
                		},
                		{
        			    icon: 16,
        			    shade:  [0.5, '#000000'],
        			    time:10000,
        			    })
                	}
                	$(".selectType").css({"display":"none"});    
      			},
	            onOpen:function(){
	            	 //取消按钮
                    $(".toolbar-inner").append("<input type='button' class='cityPickerCancel close-picker close-select'  value='取消'>");
                    $(".selectType").css({"display":"block"});
                    $("input,textarea").each(function(){
                        if($(this).attr("id") === document.activeElement.id){                             	
                            $(this).blur();                  
                        }
                    });
	            }
            });
        });
          	//点击定位按钮的时候
            $("#location").on("click",function(e){
                $(".createPigcircle").hide();
                $(".editPigcircle").hide();
                /* $("section").hide();
            	$("header").hide(); */
                $("#div_mapAddress").show();
                if("${pigFarmInfo.pigFaramAddress.provName}" == ""){
                	loadScript();
                }else{
            		loadLocationParam("searchByStationName('"+pigFarmObj.pigFaramAddress.provName+"', '"+pigFarmObj.pigFaramAddress.cityName+"', '"+pigFarmObj.pigFaramAddress.countyName+"')");
                }
            });
            /* $("#mapLocation").on("click",function(){
                $(".createPigcircle").show();
                $("#div_mapAddress").hide();
            }); */
            //用于返回定位信息
            function myPosition(){
            	//dingwei();
            dingwei(callback);
            }
        	var callback = function callback() {
    			setDefaultAddress();
    		}
            function  setDefaultAddress() {
            	 if(checkObjNotEmpty($("#current_province").val()&&($("#current_province").val()).indexOf("HTML")==-1 )
             		   	&&checkObjNotEmpty($("#current_city").val()&&($("#current_city").val()).indexOf("HTML")==-1)
             		   	&&(checkObjNotEmpty($("#current_district").val()&&($("#current_district").val()).indexOf("HTML")==-1))){	
            	$(".createPigcircle").show();
            	$(".editPigcircle").show();
            	$("section").show();
            	$("header").show();
                $("#div_mapAddress").hide();
            	pigFarmObj.pigFaramAddress.provName=$("#current_province").val();;
            	pigFarmObj.pigFaramAddress.cityName=$("#current_city").val();;
            	pigFarmObj.pigFaramAddress.countyName=$("#current_district").val();
            	pigFarmObj.address=$("#current_address").val();
            	pigFarmObj.mapAddress=$("#current_address").val();
            	pigFarmObj.lat = $("#current_lat").val();
            	pigFarmObj.lng = $("#current_lng").val();
            	$("#detailAddr").val($("#current_address").val());
            	$start.val($("#current_province").val()+' '+$("#current_city").val()+' '+$("#current_district").val());
            	 }else{
            		 $(".createPigcircle").show();
                     $("#div_mapAddress").hide();
            	 }
    		}  
    </script>
	
	<!-- 地图 -->
	<!-- 地图 -->
	<%@include file="../../map/mapPosition2.html"%>
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>