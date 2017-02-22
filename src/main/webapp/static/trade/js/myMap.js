// GPS经纬度
var myLat, myLng;
// 地址中文详情
var myAddressDetail;
// 类型是导航还是定位
var myMapFlag;
// 目的地
var deslat, deslng, desname;

// 定位当前地址
function getLocation() {
	// 判断是否支持 获取本地位置
	if (navigator.geolocation) {
		bdlocation();
	} else {
		x.innerHTML = "浏览器不支持定位.";
	}
}

//定位到当前地址后的回调
function showPosition(rs) {
	var lat = rs.point.lat;
	var lng = rs.point.lng;
	// 纬度
	myLat = lat;
	// 经度
	myLng = lng;
	
	myAddressDetail = rs.address;
	var url = "http://api.map.baidu.com/direction?origin=latlng:" + myLat
	+ "," + myLng + "|name:" + myAddressDetail
	+ "&destination=latlng:" + deslat + "," + deslng + "|name:"
	+ desname + "&mode=driving&region=''&output=html&src=appName";
	//alert(url);
	location.href = url;
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

// 显示地图并定位
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

// 初始化地图
function init() {
	showMyMap();
}

// 异步加载地图库函数文件
function loadScript(myMapFlagPar, deslatPar, deslngPar, desnamePar) {
	myMapFlag = myMapFlagPar;
	deslat = deslatPar;
	deslng = deslngPar;
	desname = desnamePar;
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = "http://api.map.baidu.com/api?v=2.0&ak=MOq4GlsxQBuKi6QsjGZWT5uPuYA2F5qp&callback=init";
	document.body.appendChild(script);
}
























