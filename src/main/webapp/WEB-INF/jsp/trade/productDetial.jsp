<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="x5-orientation" content="portrait">
    <meta http-equiv="pragram" content="no-cache">  
	<meta http-equiv="cache-control" content="no-cache, must-revalidate"> 
	<meta http-equiv="expires" content="0"> 
    <title>交易详情</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/jiaoyiquan.css"/>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/mengceng.css">
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
    <script src="/static/newhope/html/js/jquery.downCount.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery-weui.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/plug-in/layer/layer.js"></script>
    <script src="/static/trade/js/tradeCommon.js?v=1"></script>
    <script src="/static/newhope/html/js/dateutil.js?v=1.0"></script> 
    <!--导入插件-->
	<script type="text/javascript" src="/static/newhope/html/js/jqthumb.min.js"></script>
	<script>
	    $(function() {
	        $(".pic li img").jqthumb({
	            width:'100%',
	            height:'100%',
	            after: function(imgObj){
	                imgObj.css('opacity', 0).animate({opacity: 1}, 2000);
	            }
	        })
	    });
	</script>
    <style type="text/css">
        li{
            list-style: none;
        }

    </style>
    
</head>
<body>
<!--蒙层-->
<div style="display: none" class="mengceng">
    <div class="Divimg">
        <img class="bigImg" src="images/pig_icon.png" alt="">
    </div>
</div>
<!--下订单-->
<div class="zhezhaoceng" id="xiadingdan" style="display: none;">
    <div class="transaction_tckbg1">
        <div class="tck_xdd">
            下订单
        </div>
        <div class="tck_line"></div>
        <div class="tck_message_bg">
            <div class="tck_name_head">${productInfo.userInfoModel.name }</div>
            <div class="tck_name_message" id="surplusSpan">剩余${productInfo.surplusNumber}头</div>
            <div class="tck_message_head">交割地址：</div>
            <div class="tck_message_text">${productInfo.pigFarmInfoExModel.mapAddress }</div>
            <div class="tck_message_head">交通情况：</div>
            <div class="tck_message_text">
            	   ${productInfo.pigFarmInfoExModel.limitLength.displayName}
            	   ${productInfo.pigFarmInfoExModel.limitHeight.displayName }
                <br/>                                 
                   ${productInfo.pigFarmInfoExModel.otherTrifficInfo}
            </div>
            <!-- 价格区间 -->
            <c:choose>
              <c:when test="${productInfo.isDiscuss == true}">
              <!--议价显示-->
	            <div>
	                <div class="tck_message_head">出栏价格：</div>
	                <div class="tck_message_text1">议价</div>
	            </div>
              </c:when>
              <c:otherwise>
                <c:choose>
                 <c:when test="${empty productInfo.productPriceList }">
                 <!--均价显示-->
		            <div>
		                 <div class="tck_message_head">出栏价格：</div>
		                 <div class="tck_message_text1">
		                 	<c:choose>
		                 		<c:when test="${!empty productInfo.marketingPrice}">
		                     		<span>¥<fmt:formatNumber value="${productInfo.marketingPrice}" pattern="0.00"/></span><span>元/KG</span>
		                 		</c:when>
		                 		<c:otherwise>
		                 			<span>价格待定</span>
		                 		</c:otherwise>
		                 	</c:choose>
		                 </div>
		            </div>
                 </c:when>
                 <c:otherwise>
                  <!--定价分级显示-->
			            <div>
			                <div class="tck_message_head">出栏价格：</div>
			                <div class="tck_message_text1">
			                    <div class=tck_message_text1>
			                    	<c:choose>
			                    		<c:when test="${empty productInfo.prePrice }">
			                    		<span>议价</span>&nbsp;<span class="issued_junzhong">（${productInfo.preWeightDesc eq null?'未知':productInfo.preWeightDesc}）</span>
			                    		</c:when>
			                    		<c:otherwise>
			                        	<span>¥<fmt:formatNumber value="${productInfo.prePrice}" pattern="0.00"/></span><span>元/KG</span>&nbsp;<span class="issued_junzhong">（${productInfo.preWeightDesc eq null?'未知':productInfo.preWeightDesc}）</span>
			                    		</c:otherwise>
			                    	</c:choose>
			                    </div>
			                </div>
			            </div>
                 </c:otherwise>
                </c:choose>
              </c:otherwise>
            </c:choose>
            <div style="clear: both;"></div>
        </div>
        <div>
            <div class="tck_number_head">数量：</div>
            <input class="tck_number_input" placeholder="请输入订购数量" type="number" id="buyCount"/>
            <input value="${productInfo.surplusNumber }" type="hidden" id="surplusNumber"/>
            <div class="tck_number_unit">头</div>
        </div>
        <input type="button" class="btn_tck_back" id="quxiaodingdan" value="取消"/>
        <input type="button" class="btn_tck_confirm" id="quedingdingdan" value="确定"/>

    </div>
</div>
<!--订单成功-->
<div class="zhezhaoceng" id="dingdan_success" style="display: none">
    <div class="transaction_tckbg">
        <div class="transaction_tck_succespic">
        </div>
        <div class="transaction_tck_headtext">订单提交成功</div>
        <div class="transaction_tck_bodytext">
            <div>您的订单已提交成功，我们将尽快与您</div>
            <div>联系！如需了解订单状态，</div>
            <div>可以到“我买到的”进行查询</div>
        </div>
        <input type="button" class="btn_tck_know" id="zhidaole_success" value="知道了"/>
    </div>
</div>
<!--订单失败-->
<div class="zhezhaoceng" id="dingdan_fail" style="display: none;">
    <div class="transaction_tckbg">
        <div class="transaction_tck_failpic">
        </div>
        <div class="transaction_tck_headtext">订单提交失败</div>
        <div class="transaction_tck_bodytext1">
            <div>下手太慢！</div>
            <div>该订单剩余数量仅剩<span id="fail_notify_count"></span>头!</div>
        </div>
        <div class="btn_box">
        <input type="button" class="btn_tck_back" id="zhidaole_fail" value="知道了"/>
        <input type="button" class="btn_tck_newly" id="chongxinqianggou" value="重新抢购"/>
        </div>
    </div>
</div>
<!--取消提醒-->
<div class="zhezhaoceng" id="tixing_remove" style="display: none;">
    <div class="join_part3_tankuang">
        <div class="transaction_cry_pic">
        </div>
        <div class="transaction_tck_revoketext">
            <div>取消了提醒，可能会错过拍猪哦！</div>
            <div>确定取消提醒吗？</div>
        </div>
        <input type="button" class="btn_tck_back" id="zaikankan" value="再看看"/>
        <input type="button" class="btn_tck_confirm" id="qxtx_queding" value="确定"/>
    </div>
</div>
<!--成功设定提醒-->
<div class="light_remind_success" id="tixing_success" style="display: none;">
    <div>你已关注该商品</div>
</div>
<!--轮播 -->
<div class="zhuqunzhaopian">猪群照片</div>
<div class="lunbo">
    <ul class="pic">
    <c:choose>
      <c:when test="${empty productInfo.bidInfoImgModelList}">
     	 <li><img src="/static/newhope/html/images/morentu.png" /></li>
      </c:when>
      <c:otherwise>
        <c:forEach items="${productInfo.bidInfoImgModelList}" var="image">
	     	<c:choose>
	     	  <c:when test="${!empty image.url}">
	     	  	<c:choose>
	     	  		<c:when test="${productInfo.source eq 'FY' }">
		     	  		<c:choose>
		     	  		<c:when test="${fn:startsWith(image.url,'http') }">
	       					<li><img src="${image.url}" /></li>
	           			</c:when>
		        		<c:otherwise>
		        			<li><img src="${imgServer}${image.url}" /></li>
		        		</c:otherwise>	
		     	  		</c:choose>
	     	  		</c:when>
	     	  		<c:otherwise>
	        			<li><img src="${imgServer}${image.url}" /></li>
	     	  		</c:otherwise>
	     	  	</c:choose>
	     	  </c:when>
	     	  <c:otherwise>
	        	<li><img src="/static/newhope/html/images/morentu.png" /></li>
	     	  </c:otherwise>
	     </c:choose>
    	</c:forEach>
      </c:otherwise>
    </c:choose>
    </ul>
    
    <ul class="btn">
   	<c:if test="${!empty productInfo.bidInfoImgModelList}">
	   	 <c:forEach items="${productInfo.bidInfoImgModelList}" var="image" varStatus="num">
	     	<c:choose>
	     	  <c:when test="${num.index == 0}">
					<c:if test="${ fn:length(productInfo.bidInfoImgModelList)>1 }">
		        	 	<li style="margin-left:8.25rem;"></li>
					</c:if>	     	      
	     	  </c:when>
	     	  <c:otherwise>
	     	   <li></li>
	     	  </c:otherwise>
	     	</c:choose>
	     </c:forEach>
   	</c:if>
    </ul>
</div>
<div>
    <div class="transaction_bg_1">
        <c:choose>
         <c:when test="${productInfo.status.value eq 'IN_TRADING' }">
         <!--交易进行中倒计时 -->
	        <div class="transaction_endtime" >
	            <div style="float: left;margin-left: 0.5rem;">距结束</div>
	            <input type="hidden" id="countDownTime" value="<fmt:formatDate value="${productInfo.bidEndTime}" pattern="MM/dd/yyyy HH:mm:ss" />">
	            <ul class="countdown" style="color:#333333;">
	                <li>
	                    <span class="hours" style="float: left;margin-left: 0.4rem;">00</span>
	                </li>
	                <li class="seperator" style="float: left;margin-left: 0.2rem">:</li>
	                <li>
	                    <span class="minutes" style="float: left;margin-left: 0.2rem">00</span>
	                </li>
	                <li class="seperator" style="float: left;margin-left: 0.2rem">:</li>
	                <li>
	                    <span class="seconds" style="float: left;margin-left: 0.2rem">00</span>
	                </li>
	            </ul>
	                <div style="clear: both;"></div>
	        </div>
         </c:when>
         <c:when test="${productInfo.status.value eq 'BEFORE_AUCTION' }">
         <!--交易进行中倒计时 -->
	        <div class="transaction_starttime" >
	            <div style="float: left;margin-left: 0.5rem;">距开始</div>
	            <input type="hidden" id="countDownTime" value="<fmt:formatDate value="${productInfo.bidTime}" pattern="MM/dd/yyyy HH:mm:ss" />">
	            <ul class="countdown" style="color:#333333;">
	                <li>
	                    <span class="hours" style="float: left;margin-left: 0.4rem;">00</span>
	                </li>
	                <li class="seperator" style="float: left;margin-left: 0.2rem">:</li>
	                <li>
	                    <span class="minutes" style="float: left;margin-left: 0.2rem">00</span>
	                </li>
	                <li class="seperator" style="float: left;margin-left: 0.2rem">:</li>
	                <li>
	                    <span class="seconds" style="float: left;margin-left: 0.2rem">00</span>
	                </li>
	            </ul>
	                <div style="clear: both;"></div>
	        </div>
         </c:when>
        </c:choose>
        <a class="transaction_contact" style=" text-decoration:none;line-height:1.5rem;text-align: center;" href="tel:${productInfo.userInfoModel.mobile }">联系TA</a>
        <div class="transaction_message_1" >
            <div class="transaction_number">
            
                <div class="transaction_number_residue">
                   	 剩余${productInfo.surplusNumber }头
                </div>
                <div class="transaction_number_sell">
                                                            已售${productInfo.bidedNumber }头
                </div>
            </div>
            <div class="transaction_name">
                <span style="float: left;">卖家：</span>
                <label style="float: left;">${productInfo.userInfoModel.name }</label>
            </div>
        </div>
    </div>
    <div class="line"></div>
    <div class="issued_module">
        <input class="transaction_navigation" type="button" value="导航" onclick="mapDaoHang()"/>
        <div class="transaction_bg_2">
            <div class="transaction_head" >猪场名字：</div>
            <div class="transaction_message">
        ${productInfo.pigFarmInfoExModel.name }
            </div>
            <div class="transaction_head">交割地址：</div>
            <div class="transaction_message">
               ${productInfo.pigFarmInfoExModel.mapAddress }
            </div>
            <div class="transaction_head" >交通情况：</div>
            <div class="transaction_message">
              <c:choose>
                <c:when test="${productInfo.pigFarmInfoExModel.limitLength.value eq 'UNKNOW' and  productInfo.pigFarmInfoExModel.limitHeight.value eq'UNKNOW' and empty productInfo.pigFarmInfoExModel.otherTrifficInfo}">
                  	未知
                </c:when>
                <c:otherwise>
                	<c:if test="${productInfo.pigFarmInfoExModel.limitLength.value ne 'UNKNOW' }">
                		${productInfo.pigFarmInfoExModel.limitLength.displayName}
                	</c:if>
                	<c:if test="${productInfo.pigFarmInfoExModel.limitHeight.value ne 'UNKNOW' }">
                		${productInfo.pigFarmInfoExModel.limitHeight.displayName}
                	</c:if>
                	<c:if test="${! empty productInfo.pigFarmInfoExModel.otherTrifficInfo }">
                		${productInfo.pigFarmInfoExModel.otherTrifficInfo}
                	</c:if>
                </c:otherwise>
              </c:choose>
            </div>
            <div style="clear: both;"></div>
        </div>
    </div>
    <div class="line"></div>
    <div class="issued_module">
        <div class="transaction_bg_2">
            <div class="transaction_head">交割日期：</div>
            <div class="transaction_message"><fmt:formatDate value="${productInfo.marketingDate}" pattern="yyyy-MM-dd" /></div>
            <div class="transaction_head">出栏数量：</div>
            <div class="transaction_message">
                ${productInfo.marketingNumber}头
            </div>
            <div class="transaction_head">出栏品种：</div>
            <div class="transaction_message">
             		 ${productInfo.pigType.displayName} 
            </div>
            <!-- 价格区间 -->
            <c:choose>
              <c:when test="${productInfo.isDiscuss == true}">
              <!--议价显示-->
	            <div>
	                <div class="transaction_head">出栏价格：</div>
	                <div class="transaction_message">议价</div>
	            </div>
              </c:when>
              <c:otherwise>
                <c:choose>
                 <c:when test="${empty productInfo.productPriceList }">
                 <!--均价显示-->
		            <div>
		                 <div class="transaction_head">出栏价格：</div>
		                 <div class="transaction_message">
		                 	<c:choose>
		                 	<c:when test="${empty productInfo.marketingPrice}">
		                 		<span>价格待定</span>
		                 	</c:when>
		                 	<c:otherwise>
		                 		<span>¥<fmt:formatNumber value="${productInfo.marketingPrice}" pattern="0.00"/></span><span>元/KG</span>
		                 	</c:otherwise>
		                 	</c:choose>
		                 </div>
		            </div>
		            <div class="transaction_head">预估均重：</div>
            		<div class="transaction_message">
               			${productInfo.preAvgWeight}KG
            		</div>
                 </c:when>
                 <c:otherwise>
                  <!--定价分级显示-->
            <div>
                <div class="transaction_head">出栏价格：</div>
                <div class="transaction_message">
                  <c:forEach items="${productInfo.productPriceList }" var="productPrice">
                    <div class="transaction_message_text">
                    	<c:choose>
	                    	<c:when test="${empty productPrice.price}">
	                        <span>议价</span><span class="issued_junzhong">（${productPrice.weightDes eq null ? '未知':productPrice.weightDes}）</span>
	                    	</c:when>
	                    	<c:otherwise>
	                        <span>¥<fmt:formatNumber value="${productPrice.price}" pattern="0.00"/></span><span>元/KG</span>&nbsp;<span class="issued_junzhong">（${productPrice.weightDes eq null ? '未知':productPrice.weightDes}）</span>
	                    	</c:otherwise>
                    	</c:choose>
                    </div>
                  </c:forEach>
                </div>
            </div>
            <div class="transaction_head">预估均重：</div>
            <div class="transaction_message">
               ${productInfo.preAvgWeight}KG
            </div>
                 </c:otherwise>
                </c:choose>
              </c:otherwise>
            </c:choose>
            <div style="clear: both;"></div>
        </div>
    </div>
    <div class="line"></div>
    <div class="issued_module">
        <div class="transaction_bg_2">
            <div class="transaction_head">控料情况：</div>
            <div class="transaction_message">
               ${productInfo.controllerFeedstuffInfo.displayName }
            </div>
            <div style="clear: both;"></div>
        </div>

    </div>
</div>

<!--交易进行中抢猪按钮-->
<c:choose>
 <c:when test="${productInfo.status.value eq 'IN_TRADING' }">
 	<c:choose>
 	   <c:when test="${productInfo.isPrice == true }">
 	   		<c:choose>
 	   		 <c:when test="${!empty productInfo.productPriceList}">
 	   		 	  <c:choose>
 	   		 	  	<c:when test="${productInfo.surplusNumber >0 }">
			 	  		<input class="transaction_qzsubmit" id="lijiqiangzhu"  type="button" value="立即抢猪"/> 
			 	 	</c:when>
			 	  	<c:otherwise>
			 	   		<input class="transaction_qzsubmit" style="background-color: #ccc;border-color: #ccc" id="saler_over"  type="button" value="已抢光" /> 
			 	  	</c:otherwise>
 	   		 	  </c:choose>
			 </c:when>
			 <c:otherwise>
			 	 <input class="transaction_qzsubmit" style="background-color: #ccc;border-color: #ccc" id="saler_over"  type="button" value="立即抢猪" /> 
			 </c:otherwise>
			 </c:choose>
 	   </c:when>
 	   <c:otherwise>
 	   	 	<c:choose>
 	 			<c:when test="${productInfo.surplusNumber >0 }">
			 	  <input class="transaction_qzsubmit" id="lijiqiangzhu"  type="button" value="立即抢猪"/> 
			 	 </c:when>
			 	  <c:otherwise>
			 	   <input class="transaction_qzsubmit" style="background-color: #ccc;border-color: #ccc" id="saler_over"  type="button" value="已抢光" /> 
			 	  </c:otherwise>
			</c:choose>	
 	   </c:otherwise>
 	</c:choose>
 </c:when>
 <c:when test="${productInfo.status.value eq 'BEFORE_AUCTION' }">
 <!--交易未开始提醒按钮-->
 	<c:choose>
		<c:when test="${productInfo.hasPushMsg != true }">
			<input class="transaction_txsubmit"  type="button" value="提醒我" data-id="${productInfo.id }"/>
		</c:when>
		<c:otherwise>
			<input class="transaction_qxtxsubmit" data-id="${productInfo.id }"   type="button" value="取消提醒"/>
		</c:otherwise> 	
 	</c:choose>
 </c:when>
 <c:otherwise>
 <input class="transaction_qzsubmit" style="background-color: #ccc;border-color: #ccc" type="button" value="已结束" /> 
 </c:otherwise>
</c:choose>
 <!--交易未取消提醒按钮-->
<input type="hidden" id="nowDate" value="<fmt:formatDate value="${nowDate}" pattern="MM/dd/yyyy HH:mm:ss" />">
<!--轮播控制-->
<script type="text/javascript">
    $(function(){
        var listLen = $(".pic li").length, i=0,setInter,speen = 5000;

        $(".btn li:last").css({"margin":"0rem 0rem 0rem 0.5rem"});
        $(".btn li:first").addClass("on");
        $(".pic li:first").show();

        $(".btn li").each(function(index,element){
            $(element).click(function(){
                i = index;
                $(this).addClass("on").siblings().removeClass("on");
                $(".pic li").eq(index).animate({opacity:"show"},200).siblings().animate({opacity:"hide"},200);
            })
            $(element).hover(function(){
                clearInterval(setInter);
            },function(){
                outPlay();
            });
        });
        out_fun = function(){
            if(i < listLen){i++;}else{i=0;};
            $(".btn li").eq(i).addClass("on").siblings().removeClass("on");
            $(".pic li").eq(i).animate({opacity:"show"},2000).siblings().animate({opacity:"hide"},2000);
        }

        outPlay = function(){
            setInter = setInterval("out_fun()",speen);
        }
        outPlay();
    })
</script>
<!--倒计时插件-->
<script type="text/javascript">
    //2) 倒计时插件
    	
    $('.countdown').downCount({
    	targetDate :$("#countDownTime").val(),
        nowDate:$("#nowDate").val(),
        offset: 8
    }, function () {
      	location.reload();
    });
</script>
<!--表单控制-->
<script type="text/javascript">
    <!-- 订单成功弹窗控制-->
    var seckillUrl = "";
    var oid = "";
    var this_obj ;
    var isClickConfirm = false;
    $(function(){
    	//立即抢购点击
        $("#lijiqiangzhu").click(function(){
        	var cid = '${productInfo.circleId}';
        	$.ajax({
        		url:"/trade/product/"+'${productInfo.id}',
        		cache:false,
        		success:function(res){
        		   if(res.success){
        			   seckillUrl = res.msg;
	            	  $("#xiadingdan").show();
        		  }else{
        			  if(res.msg == 'error03'){
        				  location.href=res.data+"?circleId="+cid;
      				}
      				else if(res.msg == 'error02')
      				{
      					$.toast("您不是该圈的买家","text");
      				}else if(res.msg == 'error01')
      				{
      					location.href=res.data+"?circleId="+cid;
      				}else{
      					$.toast("系统内部错误,请联系客服","text");
      				}      		  
        		 }	 
        		},
        		error:function(XMLHttpRequest,textStatus, errorThrown){
					   if(textStatus == 'timeout'){
						  $.toast("连接超时", "text");
					  } 
				   }
        	})
        });
        //取消订单点击
        $("#quxiaodingdan").click(function(){
        	if(!isClickConfirm){
            $("#buyCount").val("");
           	 $("#xiadingdan").hide();
           	}else{
           	 location.reload();	
           	}
        });
        //确认下单
        $("#quedingdingdan").click(function(){
        	var this_obj = $(this);
        	this_obj.prop("disabled",true);
        	var boyCount = $("#buyCount").val();
        	if(checkEmpty(boyCount)){
        		$.toast("请输入数量","text");
        		this_obj.prop("disabled",false);
        		return;
        	}
        	if(checkEmpty(seckillUrl)){
        		this_obj.prop("disabled",false);
        		$.toast("非法的访问方式","text");
        		return;
        	}
        	isClickConfirm = true;
        	
        	$.ajax({
        		url:seckillUrl+"?pid="+'${productInfo.id}'+"&count="+boyCount,
    			cache:false,
    			type : 'post',
    			success:function(res){
    				if(res.success){
    					//$("#oid").val(result.data);
    					$("#buyCount").val("");
    					 oid = res.data;
    					 $("#xiadingdan").hide();
    			         $("#dingdan_success").show();
    				}else{
       			         this_obj.prop("disabled",false);
    					if("count_err" == res.msg){
    						$("#buyCount").val(res.data.surplusNumber);
    						$("#surplusNumber").val(res.data.surplusNumber);
    						//下单剩余
    						$("#surplusSpan").text("剩余"+res.data.surplusNumber+"头");
    						//剩余
    						$(".transaction_number_residue").text("剩余"+res.data.surplusNumber+"头");
    						//已售
    						$(".transaction_number_sell").text("已售"+res.data.bidedNumber+"头");
    						 if(res.data.surplusNumber > 0){
    								$("#xiadingdan").hide();
    								$("#fail_notify_count").text(res.data.surplusNumber);
    								$("#dingdan_fail").show();
    							}else{
    								$("#fail_notify_count").text("0");
    								$(".btn_box").empty();
    								$(".btn_box").append('<input type="button" class="btn_tck_know"  id="fail_notify_zhidaole" value="知道了"/>');
    								$("#xiadingdan").hide();
    								$("#dingdan_fail").show();
    							} 
    					}else{
    						 $.toast(res.msg, "text");
    						 return;
    		            	  setTimeout(function(){
    		            	 	location.href="/trade/product/list";
    		            	  },2000);
    					}	
    				}
    			},
    			error:function(XMLHttpRequest,textStatus, errorThrown){
					  if(textStatus == 'timeout'){
						  $.toast("连接超时", "text");
					  }
				   }
        	});
        });
        //是否跳转详情？？？？？？？？？？？？？？？
        $("#zhidaole_success").click(function(){
        	if(checkObjNotEmpty(oid)){
	         	location.href="/mine/bought/list";      
             }else{
	         	location.href="/mine/bought/list";      
             }
            //$("#dingdan_success").hide();
        });
    });
    <!--订单失败弹窗控制-->
    $(function(){
        $("#zhidaole_fail").click(function(){
            location.reload();
        });
        $("#chongxinqianggou").click(function(){
            $("#dingdan_fail").hide();
            $("#xiadingdan").show();
        });
    });
   
    <!--提醒弹窗控制-->
    $(function(){
        $(document).on("click",".transaction_txsubmit",function(){
        	this_obj = $(this);
        	var cid = '${productInfo.circleId}';
        	$.ajax({
        		url:"/trade/product/remind/"+'${productInfo.id}',
        		cache:false,
        		success:function(res){
        		   if(res.success){
	            	  //===============================这里改变提醒状态
                  	  this_obj.val("取消提醒");
	            	  this_obj.addClass("transaction_qxtxsubmit");
                  	  this_obj.removeClass("transaction_txsubmit");
	            	  $("#tixing_success").show ().delay (3000).fadeOut ();
        		  }else{
        			  if(res.msg == 'error03'){
        				  location.href=res.data+"?circleId="+cid;
        				}
        				else if(res.msg == 'error02')
        				{
        					$.toast(res.data,"text");
        				}else if(res.msg == 'error01')
        				{	
        					location.href=res.data+"?circleId="+cid;
        				}else{
        					$.toast("系统内部错误,请联系客服","text");
        				}         		  
        			}	 
        		},
        		error:function(XMLHttpRequest,textStatus, errorThrown){
					   if(textStatus == 'timeout'){
						  $.toast("连接超时", "text");
					  } 
				   }
        	})
        });
        $(document).on("click",".transaction_qxtxsubmit",function(){
        	this_obj = $(this);
            $("#tixing_remove").show();
        });
        $("#zaikankan").click(function(){
            $("#tixing_remove").hide();
        });
        $("#qxtx_queding").click(function(){
        	var pid = this_obj.data("id");
      		$.ajax({
      		url:"/trade/product/cancleRemind/"+pid,
      		cache:false,
      		success:function(res){
      		   if(res.success){
	            	if(res.msg == 'sessionTimeout'){
	            	  location.href=res.data;	
	            	}else{
	            	  //===============================这里改变提醒状态
                 	 this_obj.addClass("transaction_txsubmit");
                 	 this_obj.val("提醒我");
                 	 this_obj.removeClass("transaction_qxtxsubmit");
 		 			 $("#tixing_remove").hide();
	            	}
      		  }else{
      			$.toast(res.msg, "text");
					setTimeout(function(){
					location.reload();
				}, 2000);       		  
      			}	 
      		},
      		error:function(XMLHttpRequest,textStatus, errorThrown){
					   if(textStatus == 'timeout'){
						  $.toast("连接超时", "text");
					  } 
				   }
      	})
        });
    });
	//购买数量输入后，控制最大购买数
	$("#buyCount").keyup(function(){
		wholeNumCheck($(this));
		var buyCount = parseInt($(this).val());
		var surplusNumber = parseInt($("#surplusNumber").val());
		if(buyCount>surplusNumber){
		 $(this).val(surplusNumber);	
		}
	});
	 $(document).on("click","#fail_notify_zhidaole",function(){
		 location.href="/trade/product/list"; 
	 })	
	 
	function mapDaoHang() {
		//alert('${productInfo.pigFarmInfoExModel.lat}' + '  ' + '${productInfo.pigFarmInfoExModel.lng}');
		loadScript('', '${productInfo.pigFarmInfoExModel.lat}', '${productInfo.pigFarmInfoExModel.lng}', '${productInfo.pigFarmInfoExModel.mapAddress}')
	}
</script>
<!--图片点击放大-->
<script>
    //图片点击事件
    $(document).ready(function(){
    	$(".pic li").click(function(){
            var imgSrc=$(this).find("img").attr("src");
            $(".mengceng").find("img").attr("src",imgSrc);
            $(".mengceng").show();
            $(".Divimg .bigImg").jqthumb({
                width:'100%',
                height:'100%',
                after: function(imgObj){
                    imgObj.css('opacity', 0).animate({opacity: 1}, 2000);
                }
            })
        })
        //蒙层点击事件
        $(".mengceng").on("click",function(){
            $(".mengceng").hide();
        })
    })
</script>
<!-- 导航 -->
<%@include file="../map/mapNavigation.html"%>
<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>