<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta charset="utf-8">
     <meta http-equiv="cache-control" content="no-cache">
    <title>我的猪场</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">
    <style type="text/css">
    .err-msg{
    width:20rem;
    height: 2rem;
    text-align: center;
    line-height:2rem;
    color: #848689;
    font-size:0.8rem;
    margin-top: 2rem;
    position: absolute;
    }
    </style>
</head>
<body>

<div style="font-family: 'Microsoft YaHei';" id="container">
                 <div class="zhuchang_1" >
                         <div style="width:18rem;height:3rem;margin: auto;">
                               <div class="zhuchang_find_icon"></div>
                               <input type="text" class="zhuchang_find" id="zhuchang_find" placeholder="输入养户姓名定位猪场"/>
                         </div>
                 </div>
         <!-- 数据列表 -->
         <c:choose>
           <c:when test="${result.success eq true}">
           <c:forEach items="${result.data}" var="farmer">
                 <div class="data_table">
                    <div class="zhuchang_2">
                            <div class="zhuchang_3">
                                <div class="zhuchang_3_head">猪场组织:</div>
                                <div class="zhuchang_3_message">${farmer.organizeName }</div>
                            </div>
                            <div class="line2"></div>
                        <div class="zhuchang_4">
                            <div class="zhuchang_4_head">养户:</div>
                            <div class="zhuchang_4_message">${farmer.farmerName }</div>
                        </div>
                        <div class="zhuchang_4">
                                <div class="zhuchang_4_head">所在地区:</div>
                                 <c:choose>
                              <c:when test="${fn:length(farmer.areaName) <20}">
                               <div class="zhuchang_4_message">${farmer.areaName}</div>
                              </c:when>
                              <c:otherwise>
                              <div class="zhuchang_4_message">${fn:substring(farmer.areaName, 0,19)}...</div>
                              </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="zhuchang_6">
                            		<div class="zhuchang_4_head">详细地址:</div>
                               		<div class="zhuchang_6_message">${farmer.addressGroupCode}</div>
                            		<div style="clear: both;"></div>
                        </div>
                        <div class="zhuchang_4">
                            <div class="zhuchang_4_head">交通情况:</div>
                            <div class="zhuchang_4_message">${farmer.trifficInfo.displayName }</div>
                        </div>
                    </div>
                    <div class="wall"></div>
                 </div>
         </c:forEach>
         </c:when>
           <c:otherwise>
           <c:choose>
             <c:when test="${!empty result.msg}">
              <div class="err-msg">${result.msg}</div>
             </c:when>
             <c:otherwise>
              <div class="err-msg">猪小易出现了异常，请联系管理员...</div>  
             </c:otherwise>
           </c:choose>
           </c:otherwise>
         </c:choose>           
</div>
 
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
<script type="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="/static/trade/js/tradeCommon.js"></script>
<script type="text/javascript">
$(function() {
	//搜索绑定标识
	var to = false;
	$('#zhuchang_find').keyup(function() {
		if (to) {
			clearTimeout(to);
		}
		to = setTimeout(function() {
			var farmerName = $('#zhuchang_find').val();
			search(farmerName);
		}, 250);
	});
});
//根据养户名字查询
function search(farmerName){
	 $(".err-msg").hide();
	 $(".data_table").remove();
	$.ajax({
		url:"/trade/mine/farmerdata?farmerName="+farmerName,
		cache:false,
		type:"get",
		success:function(result){
			if(result.success){
		     var container = $("#container");
			 var farmerList = result.data;
				 $.each(farmerList,function(index,farmer){
					 var trifficInfoName = "";
					 var organizeName = farmer.organizeName;
					 var farmerName = farmer.farmerName;
					 var addressGroupCode = farmer.addressGroupCode;
					 var areaName = farmer.areaName;
					 if(checkObjNotEmpty(farmer.trifficName)){
						 trifficInfoName = farmer.trifficName;
					 }
					 if(checkEmpty(organizeName)){
						 organizeName = "";
					 }
					 if(checkEmpty(farmerName)){
						 farmerName = "";
					 }
					 if(checkEmpty( addressGroupCode)){
						 addressGroupCode = "";
					 }else{
						 if(addressGroupCode.length >18){
							 addressGroupCode = addressGroupCode.substring(0,18)+"...";
							}
					 }
					 if(checkEmpty( areaName)){
						 areaName = "";
					 }
					 container.append(
					     '<div class="data_table">'
			                    +'<div class="zhuchang_2">'
			                    +'<div class="zhuchang_3">'
			                    +'<div class="zhuchang_3_head">猪场组织:</div>'
			                    +'<div class="zhuchang_3_message">'+organizeName+'</div>'
			                    +'</div>'
			                    +'<div class="line2"></div>'
			                    +'<div class="zhuchang_4">'
			                    +'<div class="zhuchang_4_head">养户:</div>'
			                    +'<div class="zhuchang_4_message">'+farmerName+'</div>'
			                    +'</div>'
			                    +'<div class="zhuchang_4">'
			                    +'<div class="zhuchang_4_head">所在地区:</div>'
			                    +'<div class="zhuchang_4_message">'+areaName+'</div>'
			                    +'</div>'
			                    +'<div class="zhuchang_4">'
			                    +'<div class="zhuchang_4_head">详细地址:</div>'
			                    +'<div class="zhuchang_4_message">'+addressGroupCode+'</div>'
			                    +'</div>'
			                    +'<div class="zhuchang_4">'
			                    +'<div class="zhuchang_4_head">交通情况:</div>'
			                    +'<div class="zhuchang_4_message">'+trifficInfoName+'</div>'
			                    +'</div>'
			                    +'</div>'
			                    +'<div class="wall"></div>'
			            +'</div>');  	 
				 })
			 }else{
				 $(".err-msg").text("没有更多猪场信息了...");	
				 $(".err-msg").show();	
				return;
			 }
		},
		error:function(){
			$(".err-msg").text("系统内部错误,请联系管理员");	
			$(".err-msg").show();	
		}
	})
}
</script>
</html>