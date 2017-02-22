/**************************************百度地图**********************************************/
//弹出框对象
var info;
// 地图对象
var map;
// GPS经纬度
var myLat, myLng;
// 地址中文详情
var myAddressDetail;
// 类型是导航还是定位
var myMapFlag;
// 目的地
var deslat, deslng, desname;
var myValue;

//显示地图并定位
function showMyMap() {
	$(".box1").hide();
	// 定位
	getLocation();
}

// 隐蒧地图
function hideMyMap() {
	$(".grounp_tanchu").hide();
	$(".box1").show();
}

//百度地图API功能
function G(id) {
	return document.getElementById(id);
}

//地图搜索
function searchMap(){
	var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
		{"input" : "suggestId"
		,"location" : map
	});

	ac.addEventListener("onhighlight", function(e) {  //鼠标放在下拉列表上的事件
	var str = "";
		var _value = e.fromitem.value;
		var value = "";
		if (e.fromitem.index > -1) {
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str = "FromItem<br />index = " + e.fromitem.index + "<br />value = " + value;
		
		value = "";
		if (e.toitem.index > -1) {
			_value = e.toitem.value;
			value = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		}    
		str += "<br />ToItem<br />index = " + e.toitem.index + "<br />value = " + value;
		G("searchResultPanel").innerHTML = str;
	});

	
	ac.addEventListener("onconfirm", function(e) {    //鼠标点击下拉列表后的事件
	var _value = e.item.value;
		myValue = _value.province +  _value.city +  _value.district +  _value.street +  _value.business;
		G("searchResultPanel").innerHTML ="onconfirm<br />index = " + e.item.index + "<br />myValue = " + myValue;
		
		setPlace();
	});
}

function setPlace(){
	map.clearOverlays();    //清除地图上所有覆盖物
	function myFun(){
		var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
		map.centerAndZoom(pp, 15);
		var marker = new BMap.Marker(pp);
		var rs = getDetailLocation(pp.lng, pp.lat);
		marker.addEventListener("click", function(){
			//alert(JSON.stringify(pp));
			getDetailLocation(pp.lng, pp.lat);
		});
		map.addOverlay(marker);    //添加标注
	}
	var local = new BMap.LocalSearch(map, { //智能搜索
	  onSearchComplete: myFun
	});
	local.search(myValue);
}

//弹出信息窗口
function openInfoWindow(rs){
	var lat = rs.point.lat;
	var lng = rs.point.lng;
	// 纬度
	myLat = lat;
	// 经度
	myLng = lng;
	// 赋值
	myAddressDetail = rs.address;
	// 显示中文详细地址
	$("#desAddress").text(myAddressDetail);
	
	var point = new BMap.Point(lng, lat);
	var opts = {
	  width : 250,     // 信息窗口宽度
	  height: 50,     // 信息窗口高度
	  title : "定位信息"  // 信息窗口标题
	}
	info = new BMap.InfoWindow(rs.address, opts);  // 创建信息窗口对象 
	map.openInfoWindow(info, point); //开启信息窗口
}


function getDetailLocation(lng, lat){
	//alert(JSON.stringify(r));
    var pt = new BMap.Point(lng, lat);
    var geoc = new BMap.Geocoder();
    //得到更详细的信息
    geoc.getLocation(pt, function (rs) {
    	openInfoWindow(rs);
    }); 
}

function mapClick(e){
	//alert(e.point.lng + ", " + e.point.lat);
	map.clearOverlays();
	var pp = new BMap.Point(e.point.lng, e.point.lat);    //获取第一个智能搜索的结果
	map.centerAndZoom(pp, 15);
	var marker = new BMap.Marker(pp);
	var rs = getDetailLocation(pp.lng, pp.lat);
	marker.setAnimation(BMAP_ANIMATION_DROP);
	marker.enableDragging();
	marker.addEventListener("click", function(){
		//alert(JSON.stringify(pp));
		getDetailLocation(pp.lng, pp.lat);
	});
	map.addOverlay(marker);    //添加标注
}

//定位到当前地址后的回调
function showPosition(rs) {
	var lat = rs.point.lat;
	var lng = rs.point.lng;
	// 纬度
	myLat = lat;
	// 经度
	myLng = lng;
	
	// 百度地图
	map = new BMap.Map("container");
	var point = new BMap.Point(lng, lat);
	map.centerAndZoom(point, 15);
	map.addEventListener("touchend", mapClick);
	//alert(JSON.stringify(rs));
	
	var marker = new BMap.Marker(point);  // 创建标注
	map.addOverlay(marker);               // 将标注添加到地图中
	openInfoWindow(rs);
	marker.addEventListener("click", function(){          
		openInfoWindow(rs);
	});
	
	// 赋值
	myAddressDetail = rs.address;
	// 显示中文详细地址
	$("#desAddress").text(myAddressDetail);
	
	//地图搜索
	searchMap();
}


//百度地图定位
function bdlocation(){
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function (r){
		if (this.getStatus() == BMAP_STATUS_SUCCESS) {
			//alert(JSON.stringify(r));
	        var pt = new BMap.Point(r.point.lng, r.point.lat);
	        var geoc = new BMap.Geocoder();
	        //得到更详细的信息
	        geoc.getLocation(pt, function (rs) {
	            //获取地理位置成功 
	            showPosition(rs);
	        }); 
	    } 
	});
}

//获取本地位置
function getLocation() {
	// 判断是否支持 获取本地位置
	if (navigator.geolocation) {
		bdlocation();
	} else {
		x.innerHTML = "浏览器不支持定位.";
	}
}

// 点击定位后，将取得的地理位置放在页面元素中
function dingwei() {
	$("#lng").val(myLng);
	$("#lat").val(myLat);
	$("#mapAddress").val(myAddressDetail);
	$("#addressDetailDiv").text(myAddressDetail);
	$("#adressDetail").val(myAddressDetail);
	hideMyMap();
}

// 异步加载地图后回调,初始化地图
function init() {
	showMyMap();
}

//百度地图API功能,异步加载地图
function loadScript() {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = "http://api.map.baidu.com/api?v=2.0&ak=MOq4GlsxQBuKi6QsjGZWT5uPuYA2F5qp&callback=init";
	document.body.appendChild(script);
}




