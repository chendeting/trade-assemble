//弹出框对象
	var info;
	//地图对象 
	var map;
	//GPS经纬度
	var myLat,myLng;
	//地址中文详情
	var myAddressDetail;
	//定位当前地址
	function getLocation() {
		//判断是否支持 获取本地位置
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(showPosition);
		} else {
			x.innerHTML = "浏览器不支持定位.";
		}
	}
	//定位到当前地址后的回调
	function showPosition(position) {
		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		//纬度
		myLat = lat;
		//经度
		myLng = lng;
		//调用地图命名空间中的转换接口   type的可选值为 1:gps经纬度，2:搜狗经纬度，3:百度经纬度，4:mapbar经纬度，5:google经纬度，6:搜狗墨卡托
		qq.maps.convertor.translate(new qq.maps.LatLng(lat, lng), 1, function(res) {
			//取出经纬度并且赋值
			latlng = res[0];
			//根据当前的定位初始化地图
			map = new qq.maps.Map(document.getElementById("container"), {
				center : latlng,
				zoom : 15
			});
			//设置marker标记
			var marker = new qq.maps.Marker({
				map : map,
				position : latlng
			});
			
			//初始化一个弹出窗口
			info = new qq.maps.InfoWindow({map: map});
			
			//添加监听事件 当标记被点击了,获取中文详细地址
	        qq.maps.event.addListener(marker, 'click', function() {
	        	info.open();
	        });
			
	        //得到中文详细地址
	        getMyaddress(latlng);
		});
	}
	
	//得到中文详细地址
	function getMyaddress(myLatlng){
		//初如化获取中文详细地址的对象
	    var geocoder = new qq.maps.Geocoder({
	        complete : function(result){
	        	info.open();
                info.setContent('<div style="width:20sss0px;height:50px;"> 当前位置：<br>'+
                   result.detail.address+'</div>');
                //alert(JSON.stringify(result));
                info.setPosition(result.detail.location);
                //赋值
                myAddressDetail = result.detail.address;
                
                //给链接地图的值
                var deslng = '104.096092';
          	    var deslat = '30.643635';
          	    var desname = "河边上哦";
                var url = "http://api.map.baidu.com/direction?origin=latlng:" + myLat +"," + myLng +"|name:"+ myAddressDetail +"&destination=latlng:"+ deslat +"," + deslng  +"|name:"+ desname +"&mode=driving&region=成都&output=html&src=appName";
          	    //alert(url);
          	    $("#baidudaohang").attr("href", url);
	        }
	    });
	    //调用获取位置方法
	    geocoder.getAddress(myLatlng);
	}
	
	//点击导航
	function daohang(){
	  //104.096092 30.643635
      var deslng = '104.096092';
	  var deslat = '30.643635';
	  $("#daohang").attr("href", url);
	  //导航需要的变量,起点 name:天安门|latlng:39.98871,116.43234 终点 name:天安门|latlng:39.98871,116.43234
	  var url = "http://api.map.baidu.com/direction?origin=latlng:" + myLat +"," + myLng +"|name:"+ myAddressDetail +"&destination=latlng:"+ deslat +"," + deslng  +"|name:"+ '' +"&mode=driving&region=''&output=html&src=appName";
	  alert(url);
	  $("#baidudaohang").attr("href", url);
	  location.href = url;
	} 
	
