<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head lang="en">
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
<meta name="format-detection" content="telephone=no">
<meta name="description"
	content="Write an awesome description for your new site here. You can edit this line in _config.yml. It will appear in your document head meta (for Google search results) and in your feed.xml site description.">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>统一定价</title>
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/weui.min.css" />
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/huadongjiazai.min.css" />
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
<link type="text/css" rel="stylesheet" href="/static/newhope/html/css/unified-price.css">
<style type="text/css">
	.weui_toast,
	.weui_toast_text,
	.weui_toast_visible {
	  width: auto;
	  height: auto;
	  font-size: 1.25rem;
	  line-height: 2.2222rem;
	  color: #fff;
	  opacity: 0.75;
	  border-radius: 0.2222rem;
	  
	}
</style>
<!--动态加载模块-->
    <script src="/static/newhope/html/js/template.js"></script>
</head>
<body>

	<script type="text/html" id="afterTodayPrice">
		<div class="wall"></div>
		{{each data as circlePrice index}}
			<div class="price_box">
				<div class="price_interval">
					<p class="counterpoise-title">
						<input type="hidden" name="weightMin" value="{{circlePrice.weightMin}}"/>
						均重
						{{circlePrice.weightMin}}
						{{if circlePrice.weightMax}}
							<input type="hidden" name="weightMax" value="{{circlePrice.weightMax}}"/>
							-{{circlePrice.weightMax}}KG
						{{else}}
						KG以上
						{{/if}}
						
					</p>
					<p class="btn-box">
						<input type="hidden" name="isDiscuss" value="{{circlePrice.isDiscuss ? 'true' : 'false'}}"/>
						{{if circlePrice.isDiscuss}}
							<span class="bargain current" onclick="enterIsShow(this)">议价</span> 
							<span class="entering" onclick="enterIsShow(this)">录入价格</span>
						{{else}}
							<span class="bargain" onclick="enterIsShow(this)">议价</span> 
							<span class="entering current" onclick="enterIsShow(this)">录入价格</span>
						{{/if}}
					</p>
				</div>
				{{if circlePrice.isDiscuss}}
					<div class="price_body" style="display:none;">
						<input type="number" class="price_entry" name="price" value="" /> <span class="price_unit"> 元/KG </span>
					</div>
				{{else}}
					<div class="price_body">
						<input type="number" class="price_entry" name="price" value="{{circlePrice.price}}" /> <span class="price_unit"> 元/KG </span>
					</div>
				{{/if}}
				<div style="clear: both;"></div>
			</div>
		{{/each}}
		<input class="join_input_submit" type="button" value="提交" onclick="submitForm()"/>
	</script>
	<script type="text/html" id="afterTodayLevel">
		<div class="wall"></div>
		{{each data as circleLevel index}}
			<div class="price_box">
				<div class="price_interval">
					<p class="counterpoise-title">
						<input type="hidden" name="weightMin" value="{{circleLevel.weightMin}}"/>
						均重
						{{circleLevel.weightMin}}
						{{if circleLevel.weightMax}}
							<input type="hidden" name="weightMax" value="{{circleLevel.weightMax}}"/>
							-{{circleLevel.weightMax}}KG
						{{else}}
						KG以上
						{{/if}}
						
					</p>
					<p class="btn-box">
						<input type="hidden" name="isDiscuss" value="false"/>
						<span class="bargain" onclick="enterIsShow(this)">议价</span> 
						<span class="entering current" onclick="enterIsShow(this)">录入价格</span>
					</p>
				</div>
				<div class="price_body">
					<input type="number" class="price_entry" name="price" value="" /> <span class="price_unit"> 元/KG </span>
				</div>
				<div style="clear: both;"></div>
			</div>
		{{/each}}
		<input class="join_input_submit" type="button" value="提交" onclick="submitForm()"/>
	</script>
	<script type="text/html" id="beforeToday">
		<ul class="detail-ul">
			{{each data as circlePrice index}}
				<li>
					<span>
						{{if circlePrice.weightMax}}
							均重{{circlePrice.weightMin}}-{{circlePrice.weightMax}}KG：
						{{else}}
							均重{{circlePrice.weightMin}}KG以上：
						{{/if}}
					</span>
					{{if circlePrice.isDiscuss}}
						议价
					{{else}}
						{{circlePrice.price}}元/KG
					{{/if}}
				</li>
			{{/each}}
		</ul>
	</script>
	<div class="calendar">
		<input id="input" type="text" data-toggle='date' style="display: none"/>
	</div>

	<div class="price-form" style="display: none;">
		<div class="warning-box">注意：当日价格设定后该圈所有未开拍猪只将按该价格售卖</div>
		<p class="date-title date-after">2017年1月4日统一定价</p>
		<input type="hidden" name="priceDate" id="priceDate"/>
	</div>
	<div class="before-price" style="display: none">
		<p class="date-title date-before">2017年1月4日统一定价</p>
	</div>
	<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
	<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-3.1.1.min.js"></script>
	<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-weui.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/trade/js/tradeCommon.js"></script>
	<!--动态加载模块-->
    <script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/template.js"></script>
	<script>
		var circleId = '${circleModel.id}';
		var userId = '${userId}';
		var isLevel = '${circleModel.isLevel}';
		$(function(){
			$(".calendar").calendar({
                container: ".calendar",
                input: "#input",
				multiple : true,
				value : []
            });
			
            getHavePricingDate();
            //切换月份与年时初始化日历
            $(".link,.icon-only").click(function(){
            	historyBackground();
            	getHavePricingDate();
            })
           historyBackground();
		});
		//当天之前的日期样式
		function historyBackground(){
			 //获取当天日期
            var myDate=new Date();
            var todayDate =myDate.getFullYear();
            todayDate += (String(myDate.getMonth()+1)).length==1?"0"+(myDate.getMonth()+1):(myDate.getMonth()+1);
            todayDate += String(myDate.getDate()).length==1?"0"+(myDate.getDate()):myDate.getDate();
            $(".picker-calendar-day").each(function(){
                //获取当前的日期
                var dataDT=($(this).data("date")).split("-");
                var clickDate=dataDT[0];
                clickDate+=dataDT[1].length==1?"0"+(parseInt(dataDT[1])+1):dataDT[1]+1;
                clickDate+=dataDT[2].length==1?"0"+dataDT[2]:dataDT[2];
                if(clickDate<todayDate){
                    $(this).addClass("historyDate");
                }
            });
		};
		//点击录入价格和议价
		function enterIsShow(thisObj){
			$(thisObj).addClass("current").siblings("span").removeClass("current");
            if($(thisObj).hasClass("bargain")){
				$(thisObj).parent().find("input[name='isDiscuss']").val("true");
                $(thisObj).parent().parent().siblings(".price_body").hide();
            }else{
				$(thisObj).parent().find("input[name='isDiscuss']").val("false");
                $(thisObj).parent().parent().siblings(".price_body").show();
            }
		}
		//渲染已设置价格日期
		function getHavePricingDate(){
			var firstDayObj = $(".calendar").find(".picker-calendar-month-current .picker-calendar-row:first-child").find(".picker-calendar-day:first-child")
			var lastDayObj = $(".calendar").find(".picker-calendar-month-current .picker-calendar-row:last-child").find(".picker-calendar-day:last-child")
			var beginSearchDate = firstDayObj.data("year")+"-"+(firstDayObj.data("month")+1)+"-"+firstDayObj.data("day");
			var endSearchDate = lastDayObj.data("year")+"-"+(lastDayObj.data("month")+1)+"-"+lastDayObj.data("day");
			$.ajax({
				type : "POST",
				url : "/circle/circlePrice/queryPriceDataPage",
				data : "circleId="+circleId+"&beginSearchDate="+beginSearchDate+"&endSearchDate="+endSearchDate,
				dataType : "json",
				success : function(result){
					var today=new Date();
					var todayFullYear = today.getFullYear();
					var todayMonth = today.getMonth()+1;
					todayMonth = parseInt(todayMonth) >= 10 ? todayMonth : "0"+todayMonth;
					var todayDay = today.getDate();
					todayDay = parseInt(todayDay) >= 10 ? todayDay : "0"+todayDay;
					today = todayFullYear + todayMonth + todayDay + "";
					
					$(".calendar").data("calendar").value=result;
					$(".calendar").data("calendar").updateValue();
					
					$(".picker-calendar-day-selected").each(function(i,item){
		                var dateArr=$(this).data("date").split('-');
		                var dateFullYear = dateArr[0];
						var dateMonth = parseInt(dateArr[1])+1;
						dateMonth = parseInt(dateMonth) >= 10 ? dateMonth : "0"+dateMonth;
						var dateDay = dateArr[2];
						dateDay = parseInt(dateDay) >= 10 ? dateDay : "0"+dateDay;
						var date = dateFullYear + dateMonth + dateDay + "";
						
						var txt = "";
						if (date < today){
							//对已设置价格的日期做选中处理
							txt='<div class="havePrcing" data-status="todayBef"> <img src="/static/newhope/html/images/write.png"/></div>';
						} else {
							txt='<div class="havePrcing" data-status="todayAft"> <img src="/static/newhope/html/images/write.png"/></div>';
						}
						$(this).append(txt);
					});
			        allClick();
				}
			});
		}
		
		//为日期添加点击事件
		function allClick(){
            var dateVal='';
            //有选中图片的点击事件
            $(".havePrcing").click(function(){
                //获取当前点击日期
                dateVal=$(this).parent().data("date")
                var dateArr=dateVal.split('-');
                var currentDate=dateArr[0]+'年'+(parseInt(dateArr[1])+1)+'月'+dateArr[2]+'日';
				var priceDateStr = dateArr[0]+'-'+(parseInt(dateArr[1])+1)+'-'+dateArr[2];
                getPrice(priceDateStr,currentDate,$(this).data("status"));
            });

            //点击某一天的事件
            $(".picker-calendar-day").click(function(){
                //获取当天日期
                var myDate=new Date();
                var todayDate =myDate.getFullYear();
                todayDate += (String(myDate.getMonth()+1)).length==1?"0"+(myDate.getMonth()+1):(myDate.getMonth()+1);
                todayDate += String(myDate.getDate()).length==1?"0"+(myDate.getDate()):myDate.getDate();
                //console.log(todayDate);
                //获取当前点击的日期
                var dataDT=($(this).data("date")).split("-");
                var clickDate=dataDT[0];
                clickDate+=dataDT[1].length==1?"0"+(parseInt(dataDT[1])+1):dataDT[1]+1;
                clickDate+=dataDT[2].length==1?"0"+dataDT[2]:dataDT[2]
                //只对未定价并且大于等于当天日期的的日期做相应处理,和上面的click方法进行区分
                if($(this).find(".havePrcing").length==0 && clickDate >= todayDate){
                    dateVal=$(this).data("date")
                    var dateArr=dateVal.split('-');
                    var currentDate=dateArr[0]+'年'+(parseInt(dateArr[1])+1)+'月'+dateArr[2]+'日';
                    
                    var priceDateStr = dateArr[0]+'-'+(parseInt(dateArr[1])+1)+'-'+dateArr[2];
                    getPrice(priceDateStr,currentDate);
                }
            });
        };
        
        //根据圈子Id和指定日期获取价格
        function getPrice(priceDateStr,currentDate,priceStatus){
        	$.ajax({
				type : "POST",
				url : "/circle/circlePrice/queryListByCircleIdAndDate",
				data : "circleId="+circleId+"&priceDateStr="+priceDateStr+"&isLevel="+isLevel,
				dataType : "json",
				success : function(result){
					if (result.success){
						//当天之前已选中的，点击后显示的内容
		                if(priceStatus=="todayBef"){
		                    var html = template("beforeToday",result);
		                    $(".before-price").append(html);
		                    $(".date-before").text(currentDate+'统一定价');
		                    $(".calendar").hide();
		                    $(".before-price").show();
		                }
		                //当天及之后的，点击后显示的内容
		                else{
		                	$("#priceDate").val(priceDateStr);
		                	var html="";
		                	if (result.msg == "price"){
		                		html = template("afterTodayPrice",result);
		                	} else if (result.msg == "level"){
		                		html = template("afterTodayLevel",result);
		                	}
		                    $(".price-form").append(html);
		                    $(".date-after").text(currentDate+'统一定价');
		                    $(".calendar").hide();
		                    $(".price-form").show();
		                }
					} else {
						$.toast(result.msg,"text");
					}
				}
			});
        }
        
        //提交圈子价格数据
        function submitForm(){
        	var requireOk = true;
        	$(".price_entry:visible").each(function(){
        		if (checkEmpty($(this).val())){
        			$.toast("录入价格时，价格不能为空！","text");
        			requireOk = false;
        			return false;
        		}
        	});
        	if (requireOk){
        		var circlePriceArr = [];
        		var priceDate =$("#priceDate").val();
        		$(".price-form").find(".price_box").each(function(){
        			var circlePrice = {
        					creator:userId,
        					version:1,
        					circleId:circleId,
        					priceDate:priceDate,
        					weightMin:$(this).find("input[name='weightMin']").val()
        			};
        			if ($(this).find("input[name='isDiscuss']").val() == "true"){
        				circlePrice.isDiscuss = true;
        			} else {
        				circlePrice.isDiscuss = false;
        				circlePrice.price = $(this).find("input[name='price']").val();
        			}
        			
        			if (!checkEmpty($(this).find("input[name='weightMax']").val())){
        				circlePrice.weightMax = $(this).find("input[name='weightMax']").val();
        			}
        			circlePriceArr.push(circlePrice);
        		});
        		
        		$(".join_input_submit").attr("disabled","disabled");
        		$.ajax({
    				type:"POST",
    				url : "/circle/circlePrice/saveCirclePrice",
    				data:JSON.stringify( circlePriceArr ),
    				contentType:"application/json",
    				dataType:"json",
    				success:function(result){
    					if (result.success){
    						location.reload(true);
    					} else {
    						$(".join_input_submit").removeAttr("disabled");
    						$.toast(result.msg,"text");
    					}
    				},
    				error:function(){
    					$(".join_input_submit").removeAttr("disabled");
    					$.toast("操作异常，请联系管理员！","text");
    				}
    			});
        	}
        };
      
	</script>
	 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
</html>