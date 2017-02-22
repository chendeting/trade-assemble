Date.prototype.pattern=function(fmt) {      
			 
		    var o = {         
		 
		    "M+" : this.getMonth()+1, //月份         
		 
		    "d+" : this.getDate(), //日         
		 
		    "h+" : this.getHours() == 0 ? 12 : this.getHours(), //小时         
		 
		    "H+" : this.getHours(), //小时         
		 
		    "m+" : this.getMinutes(), //分         
		 
		    "s+" : this.getSeconds(), //秒         
		 
		    "q+" : Math.floor((this.getMonth()+3)/3), //季度         
		 
		    "S" : this.getMilliseconds() //毫秒         
		 
		    };         
		 
		    var week = {         
		 
		    "0" : "\u65e5",         
		 
		    "1" : "\u4e00",         
		 
		    "2" : "\u4e8c",         
		 
		    "3" : "\u4e09",         
		 
		    "4" : "\u56db",         
		 
		    "5" : "\u4e94",         
		 
		    "6" : "\u516d"        
		 
		    };         
		 
		    if(/(y+)/.test(fmt)){         
		 
		        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));         
		 
		    }         
		 
		    if(/(E+)/.test(fmt)){         
		 
		        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "\u661f\u671f" : "\u5468") : "")+week[this.getDay()+""]);         
		 
		    }         
		 
		    for(var k in o){         
		 
		        if(new RegExp("("+ k +")").test(fmt)){         
		 
		            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));         
		 
		        }         
		 
		    }         
		 
		    return fmt;         
		 
		} 


		
		
			//格式化日期  yyyy.MM.dd hh:mm:ss
		function formatDateSimple(date) {
			var myyear = date.getFullYear();
			var mymonth = date.getMonth() + 1;
			var myweekday = date.getDate();
			var hour = date.getHours();
			var minute = date.getMinutes();
			var seconds = date.getSeconds();
		
			if (mymonth < 10) {
				mymonth = "0" + mymonth;
			}
			if (myweekday < 10) {
				myweekday = "0" + myweekday;
			}
			return (myyear + "." + mymonth + "." + myweekday + " " + hour + ":"
					+ minute + ":" + seconds);
		};
		
		//比较两个时间天数之差,并返回 天  小时  分钟  秒
		function compareDateLestDay(time1, time2) {
		
			try {
				var begintime_ms = Date.parse(new Date(time1.replace(/-/g, "/"))); //begintime 为开始时间
		
				var endtime_ms = Date.parse(new Date(time2.replace(/-/g, "/"))); // endtime 为结束时间
		
				var date3 = endtime_ms - begintime_ms;
		
				var days = Math.floor(date3 / (24 * 3600 * 1000));
		
				var leave1 = date3 % (24 * 3600 * 1000);
				var hours = Math.floor(leave1 / (3600 * 1000));
		
				var leave2 = leave1 % (3600 * 1000);
		
				var minutes = Math.floor(leave2 / (60 * 1000))
		
				var leave3 = leave2 % (60 * 1000)
		
				var seconds = Math.round(leave3 / 1000)
		
				return days + "天" + hours + "小时" + minutes + "分钟" + seconds + "秒";
		
			} catch (e) {
				return "";
			}
		}
		
		//比较两个时间天数之差分钟
		function compareDateLestMintue(time1, time2) {
		
			try {
				var begintime_ms = Date.parse(new Date(time1.replace(/-/g, "/"))); //begintime 为开始时间
		
				var endtime_ms = Date.parse(new Date(time2.replace(/-/g, "/"))); // endtime 为结束时间
		
				var date3 = endtime_ms - begintime_ms;
		
				return Math.floor(date3 / (60 * 1000));
		
			} catch (e) {
				return "";
			}
		}
		
		//比较两个时间天数之差天数
		function compareTime(time1, time2) {
		
			try {
				var begintime_ms = Date.parse(new Date(time1.replace(/-/g, "/"))); //begintime 为开始时间
		
				var endtime_ms = Date.parse(new Date(time2.replace(/-/g, "/"))); // endtime 为结束时间
		
				var date3 = endtime_ms - begintime_ms;
		
				return Math.floor(date3 / 1000 / 60 / 60 / 24);
		
			} catch (e) {
				return 0;
			}
		}
		
		//从分钟数转换成 得到一个时间的小时分钟
		function minutetoTime(time1) {
		
			try {
		
				return ((time1 / 60 >> 0) + "小时" + time1 % 60 + "分")
		
			} catch (e) {
				return "";
			}
       }
		
		
		
		 //得到查询开始时间
		function getBeginTime(BDate){
		      if(BDate==null || BDate==""){
		          alert("请输入开始时间");
		      }
		      var date = {
		          year   : "",
		          month  : "",
		          day    : "",
		          hour   : "00",
		          minute : "00",
		          second : "00"
		            
		      };
		      date.year  =  getYear(BDate);
		      date.month =  getMonth(BDate);
		      date.day   =  getDate(BDate);
		      return getFormatTime(date);
		}
		    //得到查询结束时间

		function getEndTime(EDate){
		      var date = {
		          year   :  "",
		          month  :  "",
		          day    :  "",
		          hour   :  "23",
		          minute :  "59",
		          second :  "59"
		            
		      };
		      date.year  =  getYear(EDate);
		      date.month =  getMonth(EDate);
		      var intday = parseInt(getDate(EDate),10);  // 结束时间比当前选择时间多了一天，因为没有时分秒，所以结束时间要加一天，不然数据有问题
		      if(intday > 9 ){
		          date.day   = intday;
		      }else{
		          date.day   =  "0".concat(intday);
		      }
		      
		      return getFormatTime(date);        
		        
		}
		    
		//得到日期的年
		function getYear(date){
		      var date = date.split("-");
		      return date[0];
		}
		    //得到日期的月
		function getMonth(date){
		      var date = date.split("-");
		      return date[1];
		}
		    //得到日期的日
		function getDate(date){
		      var date = date.split("-");
		      return date[2];
		}
		    
		    //得到格式化后的时间
		function getFormatTime(date){
		     return date.year.concat("-").concat(date.month).concat("-").concat(date.day).
		        concat(" ").concat(date.hour).concat(":").concat(date.minute).concat(":").concat(date.second);
		}
