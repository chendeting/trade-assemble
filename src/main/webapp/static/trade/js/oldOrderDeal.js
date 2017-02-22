//交割日期
$( "#jiaogeDate" ).calendar( {
	onChange: function( p, values, displayValues ) {

	}
} );

// 上传照片后的回调
function uploadCallback( obj ) {
	uploadCallbackSetValue( obj );
}

// 上传照片后的回调
// 选中的照片
var selectImgDel;
var selectIndex;
function uploadCallbackSetValue( obj ) {
	// alert(JSON.stringify(obj));
	// 上传的真的地址
	var data = {
		photoSrc: obj.imageSrc,
		imgPath: obj.imgPath
	};

	var html = template( 'uploadingImg', data );
	// 将新的图片加入到photoList中
	$( ".photoList" + selectIndex ).append( html );
	// 判断上传的照片的数量 >4 ,就不允许上传
	$( ".photoList" + selectIndex + ">div" ).each( function( index, item ) {
		if( index == 3 ) {
			// 最大上传限度 隐藏上传按钮
			$( "#" + chooseaddNewphoto ).hide();
		}
	} )
	// 图片点击事件
	$( ".btn_del" ).each( function( index, item ) {
		$( this ).click( function() {
			$( ".mengceng" ).show();
			$( "header,section" ).hide();
			// alert($(this).children("img").attr('src'));
			$( "#preview" ).attr( 'src', $( this ).children( "img" ).attr( 'src' ) );
			// 把当前选中的小图标赋值给全局对象
			selectImgDel = $( this );
		} )
	} )
}
// 图片点击事件
$( ".btn_del" ).each( function( index, item ) {
	$( this ).click( function() {
		$( ".mengceng" ).show();
		$( "header,section" ).hide();
		// alert($(this).children("img").attr('src'));
		$( "#preview" ).attr( 'src', $( this ).children( "img" ).attr( 'src' ) );
		// 把当前选中的小图标赋值给全局对象
		selectImgDel = $( this );
	} )
} )

$( function() {
	var thisImg = '';

	var chooseaddNewphoto;
	// 页面3
	$( ".addNewphoto3" ).on( "click", function() {
		selectIndex = 3;
		chooseaddNewphoto = "addNewphoto3";
		wxChooseImage( "uploadCallback" );
	} )
	// 页面2
	$( ".addNewphoto2" ).on( "click", function() {
		selectIndex = 2;
		chooseaddNewphoto = "addNewphoto2";
		wxChooseImage( "uploadCallback" );
	} )
	// 页面1
	$( ".addNewphoto1" ).on( "click", function() {
		selectIndex = 1;
		chooseaddNewphoto = "addNewphoto1";
		wxChooseImage( "uploadCallback" );
	} )

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

		$( ".photoList>div" ).each( function( index, item ) {
			if( index <= 4 ) {
				// 最大上传限度 隐藏上传按钮
				$( "#addNewphoto" ).show();
			}
		} )

	} )

	var count = 0;
	// 点击 新加入 一条数据
	$( "#addOneinfo" ).on( "click", function() {

		var currentCount = -1;
		$( "#listInfo>div" ).each( function( index, item ) {
			count++;
		} )
		var divLength = $( "#listInfo>div" ).length;

		if( divLength == 1 ) {
			$( "#listInfo>div" ).each( function( index, item ) {
				var num = $( this ).data( "info" );
				if( num == 3 ) {
					var html = '<div class="weui-col-33" data-info=' + ( num - 2 ) + '>录入信息</div>';
					$( "#listInfo" ).append( html );
				} else {
					var html = '<div class="weui-col-33" data-info=' + ( num + 1 ) + '>录入信息</div>';
					$( "#listInfo" ).append( html );
				}
				if( ( num + 1 ) == 2 ) {
					// 显示第2个盒子
					$( ".infoContent2" ).show();
					$( ".infoContent1" ).hide();
					$( ".infoContent3" ).hide();
				} else if( ( num + 1 ) == 3 ) {
					// 显示第3个盒子
					$( ".infoContent3" ).show();
					$( ".infoContent1" ).hide();
					$( ".infoContent2" ).hide();
				} else if( ( num - 2 ) == 1 ) {
					// 显示第1个盒子
					$( ".infoContent1" ).show();
					$( ".infoContent2" ).hide();
					$( ".infoContent3" ).hide();
				}
			} )
		} else if( divLength == 2 ) {
			var num = ( $( "#listInfo>div" ).eq( 1 ) ).data( "info" );
			if( num == 1 ) {
				var html = '<div class="weui-col-33" data-info=' + ( num + 1 ) + '>录入信息</div>';
				$( "#listInfo" ).append( html );
			} else if( num == 3 ) {
				var html = '<div class="weui-col-33" data-info=' + ( num - 2 ) + '>录入信息</div>';
				$( "#listInfo" ).append( html );
			} else if( num == 2 ) {
				var html = '<div class="weui-col-33" data-info=' + ( num + 1 ) + '>录入信息</div>';
				$( "#listInfo" ).append( html );
			}

			if( ( num + 1 ) == 2 ) {
				// 显示第2个盒子
				$( ".infoContent2" ).show();
				$( ".infoContent1" ).hide();
				$( ".infoContent3" ).hide();
			} else if( ( num + 1 ) == 3 ) {
				// 显示第3个盒子
				$( ".infoContent3" ).show();
				$( ".infoContent1" ).hide();
				$( ".infoContent2" ).hide();
			} else if( ( num - 2 ) == 1 ) {
				// 显示第1个盒子
				$( ".infoContent1" ).show();
				$( ".infoContent2" ).hide();
				$( ".infoContent3" ).hide();
			}
		}

		$( "#listInfo>div" ).each( function( index, item ) {
			currentCount++;
		} );
		console.log( currentCount );
		$( "#listInfo>div" ).eq( currentCount ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );

		$( "#listInfo>div" ).each( function( index, item ) {

			// 当前div的点击事件
			$( this ).on( "click", function() {
				$( ".weui-col-75>input" ).each( function( index, item ) {
					if( !checkEmpty( $( this ).val() ) ) {
						$( this ).removeClass( "errMes" );
					}
				} )
				if( index == 0 ) {
					$( ".infoContent1" ).show();
					$( ".infoContent2" ).hide();
					$( ".infoContent3" ).hide();
					$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
				} else if( index == 1 ) {
					$( ".infoContent2" ).show();
					$( ".infoContent1" ).hide();
					$( ".infoContent3" ).hide();
					$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );

				} else if( index == 2 ) {
					$( ".infoContent3" ).show();
					$( ".infoContent1" ).hide();
					$( ".infoContent2" ).hide();
					$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );

				}
			} )
		} )
	} )

	$( "#listInfo>div" ).each( function( index, item ) {

		// 当前div的点击事件
		$( this ).on( "click", function() {

			if( index == 0 ) {
				$( ".infoContent1" ).show();
				$( ".infoContent2" ).hide();
				$( ".infoContent3" ).hide();
				$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
			} else if( index == 1 ) {
				$( ".infoContent2" ).show();
				$( ".infoContent1" ).hide();
				$( ".infoContent3" ).hide();
				$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );

			} else if( index == 2 ) {
				$( ".infoContent3" ).show();
				$( ".infoContent1" ).hide();
				$( ".infoContent2" ).hide();
				$( this ).addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );

			}
		} )
	} )
	// 删除一条录入信息
	var thislistInfo = "";
	var thisFlag = false;
	var thisIndex = "";
	var prevlist = "";
	var nextlist = "";
	var nextlist2 = "";

	var thisIndex1 = "";
	var thisIndexInfo = "";
	$( "#del" ).on( "click", function() {
		var num = $( "#listInfo>div" ).length;
		if( num == 1 ) {
			// 出现提示框
			$.toast( "无法删除该条录入信息，要求至少保留一条录入。", "text" );
		} else if( num == 2 ) {
			var nextcount = 0;
			$( "#listInfo>div" ).each( function( index, item ) {
				// true false
				thisFlag = ( $( this ).attr( "class" ) == "weui-col-33 btnInfoactive" );
				if( thisFlag ) {
					thislistInfo = $( this );
					nextcount = thislistInfo.siblings().data( "info" );
					nextlist2 = thislistInfo.siblings();
					thislistInfo.remove();
				}
				if( nextcount == 1 ) {
					$( ".infoContent1" ).show();
					$( ".infoContent3" ).hide();
					$( ".infoContent2" ).hide();
				} else if( nextcount == 2 ) {
					$( ".infoContent2" ).show();
					$( ".infoContent3" ).hide();
					$( ".infoContent1" ).hide();
				} else if( nextcount == 3 ) {
					$( ".infoContent3" ).show();
					$( ".infoContent2" ).hide();
					$( ".infoContent1" ).hide();
				}
			} )
			nextlist2.addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
		} else if( num == 3 ) {
			var nextcount = 0;
			var currentcount = 0;
			$( "#listInfo>div" ).each( function( index, item ) {
				// true false
				thisFlag = ( $( this ).attr( "class" ) == "weui-col-33 btnInfoactive" );
				if( thisFlag ) {
					thislistInfo = $( this );
					currentcount = thislistInfo.data( "info" );
					if( currentcount == 3 ) {
						console.log( "a" );
						nextcount = thislistInfo.prev().data( "info" );
						prevlist = thislistInfo.prev();
						console.log( nextcount );
					} else {
						console.log( "b" );
						nextcount = thislistInfo.next().data( "info" );
						nextlist = thislistInfo.next();
						console.log( nextcount );
					}
					thislistInfo.remove();
				}
				if( nextcount == 1 ) {
					$( ".infoContent1" ).show();
					$( ".infoContent3" ).hide();
					$( ".infoContent2" ).hide();
				} else if( nextcount == 2 ) {
					$( ".infoContent2" ).show();
					$( ".infoContent3" ).hide();
					$( ".infoContent1" ).hide();
				} else if( nextcount == 3 ) {
					$( ".infoContent3" ).show();
					$( ".infoContent2" ).hide();
					$( ".infoContent1" ).hide();
				}
			} )
			if( currentcount == 3 ) {
				prevlist.addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
			} else {
				nextlist.addClass( "btnInfoactive" ).siblings().removeClass( "btnInfoactive" );
			}
		}
	} )

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

	// 只能填入最多两位小数
	$( ".decimalNum" ).keyup( function() {
		decimalNumCheck( this );
	} ).on( "paste", function() { // CTR+V事件处理
		decimalNumCheck( this );
	} ).on( "blur", function() {
		// 取消掉结尾的.
		$( this ).val( $( this ).val().replace( /[^\d]$/g, "" ) );
	} );

	// 只能填入正整数
	$( ".wholeNum" ).keyup( function() {
		wholeNumCheck( this );
	} ).on( "paste", function() { // CTR+V事件处理
		wholeNumCheck( this );
	} );
} )

var count1 = 0;
var count2 = 0;
var count3 = 0;

// 录入信息按钮的提交事件
$( ".btn_submit" ).on( "click", function() {
	$( "input[name='punishAmount']" ).each( function() {
		if( checkEmpty( $( this ).val() ) ) {
			$( this ).val( "0" );
		}
	} );
	var isOK = true;
	// 验证不能为空
	$( "#listInfo" ).children().each( function() {
		var contentDivClass = "infoContent" + $( this ).data( "info" );
		$( "." + contentDivClass ).find( ".weui-col-75>input" ).each( function( index, item ) {
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
$( ".submit-reason" ).on("click",
		function() {
			if( checkEmpty( $( "#remark" ).val() ) ) {
				$.toast( "跑单原因不能为空！", "text" );
			} else {
				var orderDealJson = {
					orderId: $( "#orderId" ).val(),
					deliveryType: $( "#deliveryType" ).val(),
					remark: $( "#remark" ).val(),
					deliveryDate: $( "#jiaogeDate" ).val(),
					payType: $( "#payType" ).val(),
					remark: $( "#remark" ).val()
				};
				$
						.ajax( {
							type: "POST",
							url: "/trade/orderDeal/deal.do",
							data: JSON.stringify( orderDealJson ),
							contentType: "application/json",
							dataType: "json",
							success: function( result ) {
								if( result.success ) {
									location.href = "/mine/saledProduct/selectSaledProductDetail?productId=${productOrderEx.productId}&v="
											+ Math.random();
								} else {
									$.toast( result.msg, "text" );
								}
							},
							error: function() {
								$.toast( "操作异常，请联系管理员！", "text" );
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
			var contentDivClass = "infoContent" + $( this ).data( "info" );
			var orderTradeDetailJson = formatFormToJson( $( "." + contentDivClass ) );
			// 因为图片已经被用json格式化成了字符串，如果后面传递参数时，再json化一次会出问题，所以在这将json字符串转为json对象
			orderTradeDetailJson.orderTradeDetailImgList = eval( orderTradeDetailJson.orderTradeDetailImgList );
			orderTradeDetailArr.push( orderTradeDetailJson );
		} );
		orderDealJson.orderTradeDetailExModelList = orderTradeDetailArr;
	}
	$.ajax( {
		type: "POST",
		url: "/trade/orderDeal/deal.do",
		data: JSON.stringify( orderDealJson ),
		contentType: "application/json",
		dataType: "json",
		success: function( result ) {
			if( result.success ) {
				location.href = "/mine/saledProduct/selectSaledProductDetail?productId=${productOrderEx.productId}&v="
						+ Math.random();
			} else {
				$.toast( result.msg, "text" );
			}
		},
		error: function() {
			$.toast( "操作异常，请联系管理员！", "text" );
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