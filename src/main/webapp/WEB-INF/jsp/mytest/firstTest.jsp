<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>firstTest</title>
</head>
<body>
<br><a href="/mine/publishedProduct/toMinePublishedPage#unPublished">上架存数据到推送表测试</a>

<br>
	<br><a href="/static/newhope/html/map/video.html?v=1">视h</a>
	<br><a href="/static/newhope/html/map/qqMap.html?v=1">腾讯地图</a>
	<a href="/static/newhope/html/map/mypublish.html?v=1">LBSMAP</a>
	<a href="http://apis.map.qq.com/uri/v1/routeplan?type=drive&from=我的家&fromcoord=39.980683,116.302&to=中关村&tocoord=39.9836,116.3164&policy=1&referer=myapp">腾讯地图uri web地图导航</a>  
<br/>  
<a href="http://api.map.baidu.com/direction?origin=latlng:34.264642646862,108.95108518068|name:我家&destination=大雁塔&mode=driving&region=西安&output=html&src=yourCompanyName|yourAppName">百度地图uri web地图导航</a>  
<br/> 
<br>
<input type="button" onclick="choose()">
	<a href="http://rock.tunnel.qydev.com/trade/pigfaram/modify?pigFarmId=1">朴根亨</a>
	<BR>
	<br><a href="http://rock.tunnel.qydev.com//user/applyCircle/mineShare.do?circleId=4&userId=24&circleMasterId=999&circleRole=BUYER">code</a>
	<BR>
	
	<br>
	<br><a href="http://rock.tunnel.qydev.com/trade/product/toPublishPage?source=ZXE&circleId=25">上架</a>
	<br>
	<br><a href="/user/userInfo/mycirclelist">圈子</a>
	
	<br><a href="/static/newhope/html/map/myMap3.html?v=22">浏览器定位</a>
	<br><a href="/static/newhope/html/map/myMap.html?v=22">地图测试H5</a>
	<br><a href="/trade/auctionpage">地图测试jsp</a>
	<br><input type="button" value="click me" onclick="firstTest()">
	<br><input type="button" value="add" onclick="add()">
	<br><input type="button" value="update" onclick="update()">
	<br><input type="button" value="deletet" onclick="deletet()">
	<br><input type="button" value="page" onclick="page()">
	<br><input type="button" value="list" onclick="listq()">
	<br><input type="button" value="detail" onclick="detail()">
	<br><input type="button" value="product" onclick="product()">
	<br><input type="button" value="添加消息" onclick="addmessage()">
	<br><input type="button" value="消息测试" onclick="sendMsg()">
	<br><input type="button" value="添加缓存" onclick="addCache()">
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script src="../static/plug-in/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
document.write("<script charset='utf-8' src='http://map.qq.com/api/js?v=2.exp&libraries=convertor'><\/script>");

	function firstTest(){
		$.ajax({
			url : "/wechart/secondTest",
			type : "POST",
			data : {
				mobile : '13880809720'
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function addmessage(){
		$.ajax({
			url : "/wechart/addmessage",
			type : "POST",
			data : {
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function add(){
		$.ajax({
			url : "/wechart/add",
			type : "POST",
			data : {
				account : '13880809720'
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function update(){
		alert('update');
		$.ajax({
			url : "/wechart/update",
			type : "POST",
			data : {
				account : '13880809720'
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function deletet(){
		$.ajax({
			url : "/wechart/delete",
			type : "POST",
			data : {
				account : '13880809720'
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function page(){
		$.ajax({
			url : "/wechart/page",
			type : "POST",
			data : {
				account : '13880809720'
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function listq(){
		$.ajax({
			url : "/wechart/list",
			type : "POST",
			data : {
				account : '13880809720'
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function detail(){
		$.ajax({
			url : "/wechart/detail?_v="+new Date(),
			type : "POST",
			data : {
				account : '13880809720'
			},
			cache : false,
			success : function(response) {
				if(response == 'sessionTimeout'){
                    //session失效时的处理
                    alert("跳转");//信息提示
                    location.href="/trade/mine/sessionTimeout.do";//跳转到session失效页面
                }
			},
			error:function(data){
            }
		});
	}
	function product(){
		var productString = '${product}';
		alert(productString);
	}
	
	function sendMsg(){
		$.ajax({
			url : "/sendMsgTest.do",
			type : "POST",
			data : {
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	function  test(){
	    window.open('/static/newhope/html/map/qqMap.html','newwindow','height=100,width=400') ;
	   }
	
	function addCache(){
		$.ajax({
			url : "/test/addCache.do",
			type : "POST",
			data : {
			},
			cache : false,
			success : function(response) {
				alert(JSON.stringify(response));
			},
			error : function() {
			}
		});
	}
	
	//业务函数
	function getData(){
		alert($("#current_lng").val());
		//各种ajax取数,渲染
		alert('查你的列表');
	}

	//被回调的初始函数
	var test = function test(){
		getData();
	}

	//使用方法
	loadLocation(test);
	
	function choose(){
		alert('选城讪');
		loadLocation(test);
	}
</script>
</html>
