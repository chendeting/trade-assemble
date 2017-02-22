/**************************************百度地图**********************************************/
//弹出框对象
var info;
// 地图对象
var map;
// GPS经纬度
var current_lng, current_lat;
var current_lng,current_lat,current_address,current_district,current_city,current_province,current_detail;

//显示地图并定位
function showMyMap() {
	// 定位
	getLocation();
}


//弹出信息窗口
function openInfoWindow(rs){
	var point = new BMap.Point(rs.point.lng, rs.point.lat);
	var opts = {
	  width : 250,     // 信息窗口宽度
	  height: 50,     // 信息窗口高度
	  title : "定位信息"  // 信息窗口标题
	}
	info = new BMap.InfoWindow(rs.address, opts);  // 创建信息窗口对象 
	map.openInfoWindow(info, point); //开启信息窗口
	
	current_lng = rs.point.lng;
	current_lat =  rs.point.lat;
	current_address = rs.address;
	current_district = rs.addressComponents.district;
	current_city = rs.addressComponents.city;
	current_province = rs.addressComponents.province;
	current_detail = rs.addressComponents.street;
	$("#current_dec").val(rs.address);
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
	//alert(JSON.stringify(rs));
	current_lng = rs.point.lng;
	current_lat =  rs.point.lat;
	current_address = rs.address;
	current_district = rs.addressComponents.district;
	current_city = rs.addressComponents.city;
	current_province = rs.addressComponents.province;
	current_detail = rs.addressComponents.street;
	$("#current_dec").val(rs.address);
	
	var lat = rs.point.lat;
	var lng = rs.point.lng;
	// 百度地图
	map = new BMap.Map("container");
	var point = new BMap.Point(lng, lat);
	map.centerAndZoom(point, 15);
	map.addEventListener("touchend", mapClick);
	
	// 添加定位控件
	var geolocationControl = new BMap.GeolocationControl();
	geolocationControl.addEventListener("locationSuccess", function(e){
		//alert(JSON.stringify(r));
        var pt = new BMap.Point(e.point.lng, e.point.lat);
        var geoc = new BMap.Geocoder();
        //得到更详细的信息
        geoc.getLocation(pt, function (rs) {
            //获取地理位置成功 
            showPosition(rs);
        });
	});
	geolocationControl.addEventListener("locationError",function(e){
	// 定位失败事件
	    alert(e.message);
	});
	map.addControl(geolocationControl);
	
	// 百度地图API功能
	//var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
	//var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
	var top_right_navigation = new BMap.NavigationControl(); //右上角，仅包含平移和缩放按钮
	/*缩放控件type有四种类型:
	BMAP_NAVIGATION_CONTROL_SMALL：仅包含平移和缩放按钮；BMAP_NAVIGATION_CONTROL_PAN:仅包含平移按钮；BMAP_NAVIGATION_CONTROL_ZOOM：仅包含缩放按钮*/
	
	//添加控件和比例尺
	//map.addControl(top_left_control);        
	//map.addControl(top_left_navigation);     
	map.addControl(top_right_navigation);    
	
	var marker = new BMap.Marker(point);  // 创建标注
	map.addOverlay(marker);               // 将标注添加到地图中
	openInfoWindow(rs);
	marker.addEventListener("click", function(){          
		openInfoWindow(rs);
	});

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
function dingwei(callback) {
	$("#current_lng").val(current_lng);
	$("#current_lat").val(current_lat);
	$("#current_address").val(current_address);
	$("#current_district").val(current_district);
	$("#current_city").val(current_city);
	$("#current_province").val(current_province);
	$("#current_detail").val(current_detail);
	
	if(callback){
		callback();
	}
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


/**--------------------------------------只定位-------------------------------------**/
//百度地图定位
function bdlocation1(callback){
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function (r){
		if (this.getStatus() == BMAP_STATUS_SUCCESS) {
			//alert(JSON.stringify(r));
	        var pt = new BMap.Point(r.point.lng, r.point.lat);
	        var geoc = new BMap.Geocoder();
	        //得到更详细的信息
	        geoc.getLocation(pt, function (rs) {
	            //获取地理位置成功 
	        	//alert(JSON.stringify(rs));
	        	//console.log(JSON.stringify(rs));
	        	//纬度，经度，详细地址，区，市，省
	            $("#current_lng").val(rs.point.lng);
	        	$("#current_lat").val(rs.point.lat);
	        	$("#current_address").val(rs.address);
	        	$("#current_district").val(rs.addressComponents.district);
	        	$("#current_city").val(rs.addressComponents.city);
	        	$("#current_province").val(rs.addressComponents.province);
	        	//执行业务逻辑取数的回调函数
	        	callback();
	        }); 
	    } 
	});
}

//获取本地位置
function getLocation1(callback) {
	// 判断是否支持 获取本地位置
	if (navigator.geolocation) {
		bdlocation1(callback);
	} else {
		x.innerHTML = "浏览器不支持定位.";
	}
}

//百度地图API功能,异步加载地图
var loadLocation = function loadLocation(callback) {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = "http://api.map.baidu.com/api?v=2.0&ak=MOq4GlsxQBuKi6QsjGZWT5uPuYA2F5qp&callback=getLocation1("+ callback +")";
	document.body.appendChild(script);
}

//百度地图API功能,异步加载地图
var loadLocationParam = function loadLocationParam(callback) {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = "http://api.map.baidu.com/api?v=2.0&ak=MOq4GlsxQBuKi6QsjGZWT5uPuYA2F5qp&callback="+ callback;
	document.body.appendChild(script);
}

//选择区域后定位
function searchByStationName(province, city, district) {
	var serchText = province+city+district;
	var localSearch = new BMap.LocalSearch(province);
	localSearch.setSearchCompleteCallback(function(searchResult) {
		var poi = searchResult.getPoi(0);
		//alert(poi.point.lng + "," + poi.point.lat);
		$("#current_lng").val(poi.point.lng);
		$("#current_lat").val(poi.point.lat);
		$("#current_address").val(province+city+district);
		$("#current_district").val(district);
		$("#current_city").val(city);
		$("#current_province").val(province);
		
		//alert(JSON.stringify(r));
        var pt = new BMap.Point(poi.point.lng, poi.point.lat);
        var geoc = new BMap.Geocoder();
        //得到更详细的信息
        geoc.getLocation(pt, function (rs) {
            //获取地理位置成功 
            showPosition(rs);
        });
        
	});
	localSearch.search(serchText);
}

$("#return").on("click",function(){
	$(".createPigcircle").show();
    $("#div_mapAddress").hide();
})




















