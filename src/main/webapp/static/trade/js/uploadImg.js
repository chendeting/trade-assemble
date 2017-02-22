//通过ready接口处理成功验证
wx.ready(function() {
	//alert("接口配置成功");
	// config信息验证后会执行ready方法，所有接口调用都必须在config接口获得结果之后，config是一个客户端的异步操作，所以如果需要在页面加载时就调用相关接口，则须把相关接口放在ready函数中调用来确保正确执行。对于用户触发时才调用的接口，则可以直接调用，不需要放在ready函数中。
});

//通过error接口处理失败验证
wx.error(function(res) {
	alert("接口配置失败" + JSON.stringify(res));
	// config信息验证失败会执行error函数，如签名过期导致验证失败，具体错误信息可以打开config的debug模式查看，也可以在返回的res参数中查看，对于SPA可以在这里更新签名。

});

//获取JSSDK配置参数
function wxConfigInit() {
	//alert(window.location.pathname+window.location.search);
	$.ajax({
		url : "/wechart/getJSConfig.do",
		data : {
			url : window.location.pathname+window.location.search
		},
		type : "POST",
		cache : false,
		success : function(response) {
			//alert(JSON.stringify(response));
			//通过config接口注入权限验证配置
			wx.config({
				debug : false, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
				appId : response.appId, // 必填，公众号的唯一标识
				timestamp : response.timestamp, // 必填，生成签名的时间戳
				nonceStr : response.nonceStr, // 必填，生成签名的随机串
				signature : response.signature,// 必填，签名，见附录1
				jsApiList : [ 'chooseImage', 'uploadImage', 'downloadImage' ]
			// 必填，需要使用的JS接口列表，所有JS接口列表见附录2
			});
		},
		error : function() {
			//alert("error");
		}
	});
}

//拍照或从手机相册中选图接口
var localIds = "";
var imgObj;
var callback = "";
function wxChooseImage(obj) {
	imgObj = obj;
	callback = uploadCallback
	//alert('选择图片');
	wx.chooseImage({
		count : 1,
		needResult : 1,
		sizeType : [ 'original', 'compressed' ], // 可以指定是原图还是压缩图，默认二者都有  
		sourceType : [ 'album', 'camera' ], // 可以指定来源是相册还是相机，默认二者都有  
		success : function(data) {
			//console.info("return");
			//alert("选定图片返回数据是:"+JSON.stringify(data));
			localIds = data.localIds[0].toString(); // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			//上传图片到微信服务器
			wxuploadImage(localIds);
		},
		fail : function(res) {
			alert("error");
			//alterShowMessage("操作提示", JSON.stringify(res), "1", "确定", "", "", "");  
		}
	});
}

//上传图片到微信服务器接口 
var serverId = "";
function wxuploadImage(e) {
	//alert("上传的图片是:"+e);
	wx.uploadImage({
		localId : e, // 需要上传的图片的本地ID，由chooseImage接口获得  
		isShowProgressTips : 1, // 默认为1，显示进度提示  
		success : function(res) {
			mediaId = res.serverId; // 返回图片的服务器端ID
			serverId = mediaId;
			console.info("serverId:" + serverId);
			//上传到微信服务器后再下载下来上传到WEB服务器
			downAndUploadImg(mediaId);
		},
		fail : function(error) {
			picPath = '';
			localIds = '';
			//alert(Json.stringify(error));
		}

	});
}

//把上传到微信服务器上的图片下载下来上传到WEB服务器
function downAndUploadImg(mediaId) {
	$.ajax({
		//url : "/wechart/download.do",
		url : "/wechart/getPhoto.do",
		type : "POST",
		data : {
			media_id : mediaId
		},
		cache : false,
		success : function(response) {
			//反显图片
			//alert(response.imageServer);
			//alert(response.imgPath);
			if(callback){
				callback(response);
			}
			//$(imgObj).attr("src", response.imageSrc);
			//$(imgObj).attr("imgPath", response.imgPath);

		},
		error : function() {
			alert("error");
		}
	});
}

wxConfigInit();
