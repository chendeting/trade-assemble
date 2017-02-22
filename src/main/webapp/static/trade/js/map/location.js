/**************************************百度地图**********************************************/
//百度地图定位
function bdlocation(callback){
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
function getLocation(callback) {
	// 判断是否支持 获取本地位置
	if (navigator.geolocation) {
		bdlocation(callback);
	} else {
		x.innerHTML = "浏览器不支持定位.";
	}
}

//百度地图API功能,异步加载地图
var loadLocation = function loadLocation(callback) {
	var script = document.createElement("script");
	script.type = "text/javascript";
	script.src = "http://api.map.baidu.com/api?v=2.0&ak=MOq4GlsxQBuKi6QsjGZWT5uPuYA2F5qp&callback=getLocation("+ callback +")";
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
	});
	localSearch.search(serchText);
}




