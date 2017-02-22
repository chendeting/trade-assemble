//交割日期
$( "#jiaogeDate" ).calendar( {
	onChange: function( p, values, displayValues ) {

	}
} );

// 新增录入消息
// 页面初始化时候加一条数据
// var chooseaddNewphoto;
var imgId = "";
// 选中的照片
var selectImgDel;
var selectIndex;
$( function() {

	// 显示与隐藏当前的内容div
	$( ".addNewphoto1" ).on( "click", function() {
		imgId = $( this ).data( "contentid" );
		console.log( imgId );
		selectIndex = imgId;
		wxChooseImage( "uploadCallback" );

	} )

} )// 页面初始化完成

// 录入一条交割信息
var titleLength = "";
var thislistInfo = "";
$( "#addOneinfo" ).on( "click", function() {

	titleLength = $( "#listInfo>div" ).length;

	// 新增一条交割title
	var exitId = $( "#listInfo>div" ).eq( titleLength - 1 ).data( "titleid" );
	var dataTitle = {
		titleId: ( exitId + 1 ),
		page: ( exitId + 1 )
	};
	var html = template( "InfoTitle", dataTitle );
	$( "#listInfo" ).append( html );
	
	$( "#listInfo>div" ).each( function( index, item ) {
		$( this ).text( index + 1 );
	} )

	// 当前新增的 加active样式
	$( "#listInfo>div" ).each( function( index, item ) {
		var titleFlag = ( $( this ).data( "titleid" ) == ( exitId + 1 ) );
		if( titleFlag ) {
			$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
		}
	})

	// 拼接对应的content
	var dataInfo = {
		contentId: ( exitId + 1 )
	};
	var html = template( "InfoContent", dataInfo );
	$( ".allContent" ).append( html );
	//初始化数据验证
	initNumCheck();
	// 显示与隐藏当前的内容div
	$( ".allContent>div" ).each( function( index, item ) {
		var infoFlag = ( $( this ).data( "contentid" ) == ( exitId + 1 ) );
		if( infoFlag ) {
			$( this ).siblings().hide();
			// 点击新增按钮
			$( ".addNewphoto" + $( this ).data( "contentid" ) ).on( "click", function() {
				imgId = $( this ).data( "contentid" );
				console.log( imgId );
				selectIndex = imgId;

				// chooseaddNewphoto = imgId;
				wxChooseImage( "uploadCallback" );
			} )// 新增按钮

		}
	} )
	
	// 交割信息的tab切换
	$( "#listInfo>div" ).on( "click", function() {
		$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
		var current = $( this ).data( "titleid" );
		$( ".allContent>div" ).each( function( index, item ) {
			var infoFlag = ( $( this ).data( "contentid" ) == current );
			if( infoFlag ) {
				$( this ).show().siblings().hide();
			}
		} )
	} )

} )// add录入消息完成


// 交割信息的tab切换
	$( "#listInfo>div" ).on( "click", function() {
		$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
		var current = $( this ).data( "titleid" );
		$( ".allContent>div" ).each( function( index, item ) {
			var infoFlag = ( $( this ).data( "contentid" ) == current );
			if( infoFlag ) {
				$( this ).show().siblings().hide();
			}
		} )
	} )



// 删除一条交割信息
var thisFlag = "";
var thisInfo = "";
var thisContent = "";
var del_titleLength = "";
var del_titleid = ""
// 判断是不是第一个
var flag = "";
$( ".delOne" ).on( "click", function() {

	// 删除有btnInfoactive属性的那一条
	$( "#listInfo>div" ).each( function( index, item ) {

		del_titleLength = $( "#listInfo>div" ).length;
		if( del_titleLength == 1 ) {
			// 出现提示框
			$.toast( "无法删除该条录入信息，要求至少保留一条录入。", "text" );
		} else {
			thisFlag = ( $( this ).attr( "class" ) == "weui-col-20 btnInfoactive" );
			if( thisFlag ) {
				thisInfo = $( this );
				del_titleid = thisInfo.data( "titleid" );
				flag = ( del_titleid == $( "#listInfo>div" ).eq( 0 ).data( "titleid" ) );
			}
		}
	} )

	if( del_titleLength <= del_titleid ) {
		if( flag ) {
			thisInfo.next().addClass( "btnInfoactive" );
			console.log( flag );
			thisInfo.remove();
			$( ".allContent>div" ).each( function( index, item ) {
				var infoFlag = ( $( this ).data( "contentid" ) == del_titleid );
				if( infoFlag ) {
					thisContent = $( this );
					thisContent.next().show().siblings().hide();
					$( this ).remove();
				}
			} )
		} else {
			// console.log("不是第一个");
			// 给前一个加 active
			thisInfo.prev().addClass( "btnInfoactive" );
			thisInfo.remove();
			$( ".allContent>div" ).each( function( index, item ) {
				var infoFlag = ( $( this ).data( "contentid" ) == del_titleid );
				if( infoFlag ) {
					thisContent = $( this );
					thisContent.prev().show().siblings().hide();
					$( this ).remove();
				}
			} )
		}
	} else {
		// 给后一个
		thisInfo.next().addClass( "btnInfoactive" );
		thisInfo.remove();
		$( ".allContent>div" ).each( function( index, item ) {
			var infoFlag = ( $( this ).data( "contentid" ) == del_titleid );
			if( infoFlag ) {
				thisContent = $( this );
				thisContent.next().show().siblings().hide();
				$( this ).remove();
			}
		} )
	}
	$( "#listInfo>div" ).each( function( index, item ) {
		$( this ).text( index + 1 );
	} )

} );// click结束

// 上传照片后的回调
function uploadCallback( obj ) {
	uploadCallbackSetValue( obj );
}

// 上传照片后的回调

function uploadCallbackSetValue( obj ) {
	// alert(JSON.stringify(obj));
	// 上传的真的地址
	var data = {
		photoSrc: obj.imageSrc,
		imgPath: obj.imgPath,
		titleId: imgId
	};

	var html = template( 'uploadingImg', data );
	// 将新的图片加入到photoList中
	$( ".photoList" + selectIndex ).append( html );
	// 判断上传的照片的数量 >4 ,就不允许上传
	var unloadNumImg = 0;
	$( ".photoList" + selectIndex + ">div" ).each( function( index, item ) {
		unloadNumImg++;
	} )
	// alert("unloadNumImg",unloadNumImg);
	if( unloadNumImg == 5 ) {
		// 最大上传限度 隐藏上传按钮
		$( ".addNewphoto" + imgId ).hide();
	}

	$( ".photoList" + selectIndex + ">div" ).on( "click", function() {
		// 显示蒙层
		$( ".mengceng" ).show();
		$( "header,section" ).hide();
		selectImgDel = $( this );
		// alert($(this).children("img").attr('src'));
		$( "#preview" ).attr( 'src', $( this ).children( "img" ).attr( 'src' ) );

		// 图片删除事件
		$( document ).on( "click", "#btnDelete", function() {
			$( ".confirmDialog" ).show();
		} );
		// 删除照片取消
		$( '.btnphotocancel' ).on( "click", function() {
			$( ".confirmDialog" ).hide();
			$( ".mengceng" ).hide();
			$( "header,section" ).show();
		} )
		// 删除图片确认
		$( '.btnphotodel' ).on( "click", function() {
			$( ".confirmDialog" ).hide();
			$( ".mengceng" ).hide();
			$( "header,section" ).show();

			selectImgDel.remove();
			// 判断上传的照片的数量 >4 ,就不允许上传
			var unloadNumImg = 0;
			$( ".photoList" + selectIndex + ">div" ).each( function( index, item ) {
				unloadNumImg++;
			} )
			if( unloadNumImg < 5 ) {
				// 最大上传限度 隐藏上传按钮
				// alert(imgId);
				// alert("最大的图片上传限制失效");
				$( ".addNewphoto" + imgId ).show();
			}
		} ) // 确认删除按钮
	} )
}

// 跑单和交割
$( ".weui_btn_plain_primary" ).click( function() {

	$( this ).addClass( "jiaogeActive" );
	$( this ).siblings().removeClass( "jiaogeActive" );

	if( $( this ).attr( "id" ) == "jiaoge" ) {
		$( ".liTwo" ).hide();
		$( ".liThree" ).show();
		$( "#deliveryType" ).val( "JIAOGE" );

	} else if( $( this ).attr( "id" ) == "paodan" ) {
		$( ".liTwo" ).show();
		$( ".liThree" ).hide();
		$( "#deliveryType" ).val( "PAODAN" );
	} else if( $( this ).attr( "id" ) == "transfer" ) {
		$( "#payType" ).val( "transfer" );
	} else if( $( this ).attr( "id" ) == "card" ) {
		$( "#payType" ).val( "card" );
	}
} );

initNumCheck();

//初始化数据输入验证
function initNumCheck(){
	// 只能填入最多两位小数
	$( ".decimalNum" ).on( "blur", function() {
		var inputVal = $(this).val();
	   	inputVal = inputVal.replace(/[^\d.]/g,""); //清除"数字"和"."以外的字符
	   	inputVal = inputVal.replace(/^\./g,""); //验证第一个字符是数字而不是.
	   	inputVal = inputVal.replace(/\.{2,}/g,"."); //只保留第一个. 清除多余的
	   	inputVal = inputVal.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
	   	inputVal = inputVal.replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'); //只能输入两个小数
	   	$(this).val("");
	   	$(this).val(inputVal);
	} );
	
	// 只能填入正整数
	$( ".wholeNum" ).keyup( function() {
		wholeNumCheck( this );
	} ).on( "paste", function() { // CTR+V事件处理
		wholeNumCheck( this );
	} );
}

//是否显示异常输入li
function punishLiShow(thisObj){
	var punishAmount = $(thisObj).val();
	var liTag=$(thisObj).closest("li").next();
	if (checkEmpty(punishAmount) || parseInt(punishAmount) == 0){
		liTag.find(".photoList").empty();
		liTag.find("input[name='orderTradeDetailImgList']").val("");
		liTag.find("textarea[name='punishReson']").val("");
		liTag.hide();
	} else {
		liTag.show()
	}
}

// 录入信息按钮的提交事件
$( ".btn_submit" ).on( "click", function() {
	var isOK = true;
	// 验证不能为空
	$( "#listInfo" ).children().each( function() {
		var titleid = $( this ).data( "titleid" );
		$(".infoContent[data-contentId='"+titleid+"']").find( ".weui-col-75>input[name!='punishAmount']" ).each( function( index, item ) {
			if( $( this ).val().length == 0 ) {
				$( this ).addClass( "errMes" );
				isOK = false;
			}
		} );
	} );

	if( isOK ) {
		submitForm();
	} else {
		$.toast( "红色边框为必填项！", "text" );
	}
} )

// 跑单提交事件
$( ".submit-reason" ).on("click",function() {
	if( checkEmpty( $( "#remark" ).val() ) ) {
		$.toast( "跑单原因不能为空！", "text" );
	} else {
		var orderDealJson = {
			orderId: $( "#orderId" ).val(),
			deliveryType: $( "#deliveryType" ).val(),
			deliveryDate: $( "#jiaogeDate" ).val(),
			payType: $( "#payType" ).val(),
			remark: $( "#remark" ).val()
		};
		$(".submit-reason").attr("disabled","disabled");
		$.ajax( {
			type: "POST",
			url: "/trade/orderDeal/deal.do",
			data: JSON.stringify( orderDealJson ),
			contentType: "application/json",
			dataType: "json",
			success: function( result ) {
				if( result.success ) {
					location.href = "/mine/saledProduct/selectSaledProductDetail?productId="+$("#productId").val()+"&v="
							+ Math.random();
				} else {
					$.toast( result.msg, "text" );
					$(".submit-reason").removeAttr("disabled");
				}
			},
			error: function() {
				$.toast( "操作异常，请联系管理员！", "text" );
				$(".submit-reason").removeAttr("disabled");
			}
		} );
	}
} );

$( ".weui-col-75>input" ).on( "click", function() {
	$( this ).removeClass( "errMes" );
} )

// 提交表单
function submitForm() {
	imgToJson();
	var orderDealJson = {
		orderId: $( "#orderId" ).val(),
		deliveryType: $( "#deliveryType" ).val(),
		remark: $( "#remark" ).val(),
		deliveryDate: $( "#jiaogeDate" ).val(),
		payType: $( "#payType" ).val()
	};
	if( $( "#deliveryType" ).val() == 'JIAOGE' ) {
		var orderTradeDetailArr = [];
		$( "#listInfo" ).children().each( function() {
			var titleid = $( this ).data( "titleid" );
			$(".infoContent[data-contentId='"+titleid+"']")
			var orderTradeDetailJson = formatFormToJson( $(".infoContent[data-contentId='"+titleid+"']") );
			// 因为图片已经被用json格式化成了字符串，如果后面传递参数时，再json化一次会出问题，所以在这将json字符串转为json对象
			orderTradeDetailJson.orderTradeDetailImgList = eval( orderTradeDetailJson.orderTradeDetailImgList );
			orderTradeDetailArr.push( orderTradeDetailJson );
		} );
		orderDealJson.orderTradeDetailExModelList = orderTradeDetailArr;
	}
	$(".btn_submit").attr("disabled","disabled");
	$.ajax( {
		type: "POST",
		url: "/trade/orderDeal/deal.do",
		data: JSON.stringify( orderDealJson ),
		contentType: "application/json",
		dataType: "json",
		success: function( result ) {
			if( result.success ) {
				location.href = "/mine/saledProduct/selectSaledProductDetail?productId="+$("#productId").val()+"&v="
						+ Math.random();
			} else {
				$.toast( result.msg, "text" );
				$(".btn_submit").removeAttr("disabled");
			}
		},
		error: function() {
			$.toast( "操作异常，请联系管理员！", "text" );
			$(".btn_submit").removeAttr("disabled");
		}
	} );
}

// 将图片转成json
function imgToJson() {
	$( ".photoList" ).each( function() {
		if( $( this ).find( "img" ).length > 0 ) {
			var photoListJson = [];
			$( this ).find( "img" ).each( function( i ) {
				if( $.trim( $( this ).attr( "imgPath" ) ) != "" ) {
					var data = {
						url: $( this ).attr( "imgPath" )
					};
					if( i == 0 ) {
						data.isTop = true;
					}
					photoListJson.push( data );
				}
			} );
			$( this ).prev().val( JSON.stringify( photoListJson ) );
		}
	} );
}

// 将给定容器里的输入框根据输入框name、value转成json
function formatFormToJson( containerObj ) {
	var objJson = {};
	containerObj.find( "input,textarea" ).each( function() {
		var name = $( this ).attr( "name" );
		var value = $( this ).val();
		if( !checkEmpty( name ) && !checkEmpty( value ) ) {
			objJson[ name ] = value;
		}
	} );
	return objJson;
}
