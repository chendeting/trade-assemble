<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head lang="en">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimum-scale=1.0, maximum-scale=1.0">
    <meta charset="utf-8">
    <title>我买到的</title>
    <link type="text/css" rel="stylesheet" href="/static/newhope/html/css/index.css">

    <script type="text/javascript" charset="utf-8" src="/static/newhope/html/js/htmlsize.js"></script>
    <script style="text/javascript" charset="UTF-8" src="/static/newhope/html/js/jquery-1.8.3.min.js"></script>

</head>
<body>
<input type="button" value="aaaaaaa">
    <div class="date">2016-09-13</div>
    <div id="myDeal">
	    <div class="massage">
	        <div class="massage_body_buy" >
	              <div class="massage_body_picdiv">
	                  <img src="/static/newhope/html//images/pig1.jpg" class="massage_body_pic"/>
	              </div>
	              <div class="massage_body_text">
	                   <div class="massage_body_text_head">绵阳山台希望猪场</div>
	                  <div class="massage_body_text_body"><span>地址:&nbsp;</span><span>四川德阳山台</span></div>
	                  <div class="massage_body_text_body"><span>交通:&nbsp;</span><span>限1.5米内的车辆通过</span></div>
	                  <div class="massage_body_text_body"><span>价格:&nbsp;</span><span>¥</span><span>18.86</span><span>kg/元</span></div>
	                  <div class="massage_body_text_foot"><span>已买到:&nbsp;</span><span style="font-size: 1rem;color: #f02b2b;">600</span><span style="color: #f02b2b">&nbsp;头</span></div>
	              </div>
	        </div>
	        <div class="wall">
	
	
	        </div>
	    </div>
	    <div class="massage">
	        <div class="massage_body_buy" >
	            <div class="massage_body_picdiv">
	                <img src="/static/newhope/html/images/pig.jpg" class="massage_body_pic"/>
	            </div>
	            <div class="massage_body_text">
	                <div class="massage_body_text_head">绵阳芦溪希望猪场</div>
	                <div class="massage_body_text_body"><span>地址:&nbsp;</span><span>四川绵阳芦溪</span></div>
	                <div class="massage_body_text_body"><span>交通:&nbsp;</span><span>限1.5米内的车辆通过</span></div>
	                <div class="massage_body_text_body"><span>价格:&nbsp;</span><span>¥</span><span>18.86</span><span>kg/元</span></div>
	                <div class="massage_body_text_foot"><span>已买到:&nbsp;</span><span style="font-size: 1rem;color: #f02b2b;">300</span><span style="color: #f02b2b">&nbsp;头</span></div>
	            </div>
	        </div>
	        <div class="wall">
	
	
	        </div>
	    </div>
	    <div class="date">2016-09-12</div>
	    
	    <div class="massage">
	        <div class="massage_body_buy" >
	            <div class="massage_body_picdiv">
	                <img src="/static/newhope/html//images/pig1.jpg" class="massage_body_pic"/>
	            </div>
	            <div class="massage_body_text">
	                <div class="massage_body_text_head">绵阳山台希望猪场</div>
	                <div class="massage_body_text_body"><span>地址:&nbsp;</span><span>四川德阳山台</span></div>
	                <div class="massage_body_text_body"><span>交通:&nbsp;</span><span>限1.5米内的车辆通过</span></div>
	                <div class="massage_body_text_body"><span>价格:&nbsp;</span><span>¥</span><span>18.86</span><span>kg/元</span></div>
	                <div class="massage_body_text_foot"><span>已买到:&nbsp;</span><span style="font-size: 1rem;color: #f02b2b;">600</span><span style="color: #f02b2b">&nbsp;头</span></div>
	            </div>
	        </div>
	        <div class="wall">
	
	
	        </div>
	    </div>
	    
	    <div class="massage">
	        <div class="massage_body_buy" >
	            <div class="massage_body_picdiv">
	                <img src="/static/newhope/html//images/pig.jpg" class="massage_body_pic"/>
	            </div>
	            <div class="massage_body_text">
	                <div class="massage_body_text_head">绵阳芦溪希望猪场</div>
	                <div class="massage_body_text_body"><span>地址:&nbsp;</span><span>四川绵阳芦溪</span></div>
	                <div class="massage_body_text_body"><span>交通:&nbsp;</span><span>限1.5米内的车辆通过</span></div>
	                <div class="massage_body_text_body"><span>价格:&nbsp;</span><span>¥</span><span>18.86</span><span>kg/元</span></div>
	                <div class="massage_body_text_foot"><span>已买到:&nbsp;</span><span style="font-size: 1rem;color: #f02b2b;">300</span><span style="color: #f02b2b">&nbsp;头</span></div>
	            </div>
	        </div>
	        <div class="wall">
	
	
	        </div>
	    </div>
	</div>
	<!-- 友盟统计插件 -->
	<%@ include file="/cs.jsp" %>
	<%CS cs = new CS(1261288276);cs.setHttpServlet(request,response);String imgurl = cs.trackPageView();%> 
	<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script type="text/javascript">
$('#xxx').scroll(function(e) {
    if ($(this).scrollTop()) {
        if(xxx > ccc ){
           //查询
           testDemo();
        }
    }
});

function testDemo(){
	$.ajax({
		url : "/xx/getPage.do",
		type : "POST",
		data:{
			page : page,
			pageSize :  pageSize,
			xxx : xxx
		},
		cache : false,
		success : function(response) {
			alert(JSON.stringify(response));
			if(data.record && data.record.length > 0){
				var tempStr = getxxx(response.data);
				$('#myDeal').append(tempStr);
        	}
		},
		error : function() {
		}
	});
}

function getxxx(data){
	var str = '';
	for(var i=0; i<data.record.length; i++){
		var notice = data.record[i];
		str +="<div class=\"accordion-item-content\">";
    	str +="<div class=\"content-block fonts27\">";
        str +="<p>"+ notice.content +"</p>";
        str +="</div>";
      	str +="</div>";
	}
	return str;
}
</script>
</html>









