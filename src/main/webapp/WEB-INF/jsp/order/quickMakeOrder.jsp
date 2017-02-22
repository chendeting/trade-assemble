<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta charset="utf-8">
    <title>下订单</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script src="/static/newhope/html/js/jqueryvalidation.js"></script>
    <script type="text/javascript" src="/static/newhope/html/js/jquery.validate.min.js"></script>
</head>
<body>
 <div class="Part_2" style="display: none;position: absolute;">
      <div class="zhezhao" id="zhezhao" style="margin-top: -2.3rem;">
          <div class="popup">
              <p style="font-size: 1rem;color: #353535;height:2.5rem;line-height: 2.5rem;margin-top: 0px;margin-bottom:0px;position:relative;">下订单</p>
              <div style="width:100%;height: 1px;background-color: #979797;margin-top: 0px;position:relative;"></div>
              <div style="width:16rem;height: 2.4rem;margin: auto;clear: both;">
                  <div style="float: left;font-size: 0.777778rem;width:16rem;height:1.2rem;line-height: 1.2rem;text-align: left;">绵阳三台希望猪场</div>
                  <div style="float: left;font-size: 0.777778rem;width:16rem;height:1.2rem;line-height: 1.2rem;color:#f02b2b;margin-left:0;text-align: left;">剩余
                      <span>400头</span>
                  </div>
              </div>
              <div style="width:16rem;height:1.2rem;line-height:1.2rem;margin: auto;clear: both;">
                  <span style="float: left;font-size: 0.666667rem;color: #848689;">地址：</span>
                  <div style="float: left;margin-left:0.2rem;font-size: 0.666667rem;color:#848689;">XXXXXX</div>
              </div>
              <div style="width:16rem;height:1.2rem;line-height:1.2rem;margin: auto;clear: both;">
                  <span style="float: left;font-size: 0.666667rem;color: #848689;">交通：</span>
                  <div style="float: left;margin-left:0.2rem;font-size: 0.666667rem;color:#848689;">限1.5米内的车辆通过</div>
              </div>
              <div style="width:16rem;height:3.6rem;margin: auto;clear: both;">
                  <div style="width:16rem;height:1.2rem;line-height:1.2rem;margin: auto;clear: both;">
                      <span style="float: left;font-size: 0.666667rem;color: #848689;">价格：</span>
                      <div style="float: left;margin-left:2.2rem;font-size: 0.666667rem;color:#848689;position: absolute;">¥18.86元/kg</div>
                      <div style="float: left;margin-left:6.2rem;font-size: 0.666667rem;color:#848689;position: absolute;">(均重100-110kg)</div>
                  </div>
                  <div style="width:16rem;height:1.2rem;line-height:1.2rem;margin: auto;clear: both;">
                      <div style="float: left;margin-left:2.2rem;font-size: 0.666667rem;color:#848689;position: absolute;">¥12.26元/kg</div>
                      <div style="float: left;margin-left:6.2rem;font-size: 0.666667rem;color:#848689;position: absolute;">(均重110-120kg)</div>
                  </div>
                  <div style="width:16rem;height:1.2rem;line-height:1.2rem;margin: auto;clear: both;">
                      <div style="float: left;margin-left:2.2rem;font-size: 0.666667rem;color:#848689;position: absolute;">¥19.86元/kg</div>
                      <div style="float: left;margin-left:6.2rem;font-size: 0.666667rem;color:#848689;position: absolute;">(均重120kg以上)</div>
                  </div>


              </div>
              <div style="width:16rem;height: 3.5rem;line-height:3.5rem;margin: auto;clear: both;">
                  <span style="float:left;font-size: 0.666667rem;color: #848689;line-height: 3.5rem;">数量：</span>
                  <input style="float:left;width: 5.5rem;height:2.2223rem;border-radius:2rem;border: 2px solid #dddddd;padding-left: 0.633333rem;margin-left: 0.2rem;text-align: left;font-size:0.777778rem;color: #353535;margin-top:0.6rem;position: relative;outline: none; "/>
                  <span style="float: left;font-size:0.666667rem;color: #353535;margin-left:0.3rem;">头</span>

              </div>
              <div>
                  <button id="quxiao" class="submit_change">取消</button>
                  <button id="queren" class="submit_agree">确认</button>
              </div>

          </div>

      </div>
  </div>
  <!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript">
 function orderSubmit(){
	var productId = $("#productId").val();
	if("" == productId || null == productId || undefined == productId){
		alert("产品信息错误");
		return;
	}
	validForm();
	var count = parseInt($("#buyCount").val());
	if(0 == count){
		alert("商品已被抢光！");
		return;
	}
	var version = $("#version").val();
	if($("#orderForm").valid()){
		$.ajax({
			url:"/trade/order/submit?productId="+productId+"&count="+count+"&version="+version,
			cache:false,
			type : 'get',
			success:function(result){
				if(result.success){
				$("#version").val(result.data.version);
				$("#surplusNumber").val(result.data.surplusNumber);
				$(".surplusNumber").text(result.data.surplusNumber);
				alert("下单成功");
				}else{
					if("version_err" == result.msg){
						$("#version").val(result.data);
						orderSubmit();
					}else if("count_err" == result.msg){
						$("#buyCount").val(result.data);
						orderSubmit();
					}else{
						alert(result.msg);
					}
				}
			},
			error:function(){
				alert("系统内部错误");	
			}
		})
	}
 }
   //验证购买数量 
	function validForm() {
		var surplusNumber = $("#surplusNumber").val();
		$("#orderForm").validate({
			rules : {
				buyCount : {
					required : true,
					max : parseInt(surplusNumber),
					digits: true,
					min:1
					
				}
			},	
			messages : {
				buyCount : {
					required : "请输入数量",
					digits: "只能输入正整数",
					max:"最多可购买"+surplusNumber+"头",
					min:"购买数量必须大于0"
				}
			}
		});
	}
 
</script>

</html>