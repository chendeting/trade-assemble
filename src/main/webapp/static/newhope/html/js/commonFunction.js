

//一些公共方法


//1）下拉刷新方法
    /**
     * 传2个参数
     * 1.整个可以滑动区域的id
     * 2.json数据的名字
     * 3.将数据加载到哪个ul
     * 4.模板名字
     * 注:loadUpFn暂时未使用
     * */
    function dropload(selectorID,datajsonName,ulIdname,templateId){
    // 页数
    var page = -1;
    // 每页展示5个
    var size = 5;
    // dropload
    $(selectorID).dropload({
        scrollArea : window,
        domUp : {
            domClass   : 'dropload-up',
            domRefresh : '<div class="dropload-refresh">↓下拉刷新</div>',
            domUpdate  : '<div class="dropload-update">↑释放更新</div>',
            domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>'
        },
        domDown : {
            domClass   : 'dropload-down',
            domRefresh : '<div class="dropload-refresh">↑上拉加载更多</div>',
            domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
            domNoData  : '<div class="dropload-noData">暂无更多数据</div>'
        },
        loadUpFn : function(me){
            $.ajax({
                type: 'GET',
                url: 'data/'+datajsonName+'.json',
                dataType: 'json',
                success: function(data){
                    var data = data.results.day01;
                    console.log(data);
                    var result = '';
                    // page = 0;
                    //下拉刷新的时候，一次性加载最新的5条数据
                    //假设新的数据是最开始的5条数据

                    //这里有两种情况 实际data.length>5 && data/length>5
                    if(data.length > 5){
                        console.log(data.length,"大于5");
                        for(var i = 0;i < size;i++){
                            result += template(templateId,data[i]);
                        }
                    }else{
                        for(var i = 0;i < data.length;i++){
                            result += template(templateId,data[i]);
                        }
                    }

                    // 为了测试，延迟1秒加载
                    setTimeout(function(){
                        $(ulIdname).html(result);
                        // 每次数据加载完，必须重置
                        me.resetload();
                        // 重置页数，重新获取loadDownFn的数据
                        page = 0;
                        // 解锁loadDownFn里锁定的情况
                        me.unlock();
                        me.noData(false);
                    },1000);
                },
                error: function(xhr, type){
                    alert('Ajax error!');
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        },
        loadDownFn : function(me){
            page++;
            // 拼接HTML
            var result = '';
            $.ajax({
                type: 'GET',
                url: 'data/'+datajsonName+'.json',
                dataType: 'json',
                success: function(data){
                    //总的数据长度
                    var arrLen = data.results.day01.length;
                    //所有数据
                    var data = data.results.day01;
                    //计算总的页数
                    var totalPage = Math.ceil(arrLen/size);
                    if(page <= (totalPage-1)){
                        //如果有数据
                        //动态加载数据
                        //每次返回1个page的数据(数据从0开始算)

                        // page=0,取i=0-4的数据  (page)*5 --- +4(插件默认第一次加载制定的size的数据)
                        // page=1,取i=5-9的数据 (page)*5 --- +4
                        // page=2,取i=10-14的数据（totalPage -1 为最后一页），加载最后一页的数据，单独处理
                        // else:显示没有更多数据了
                        // console.log("page的值",page);
                        if(page == (totalPage-1)){
                            for(var i = page*size;i < arrLen;i++){
                                result += template(templateId,data[i]);
                            }
                        }else{
                            for(var i = page*size ; i < (page+1)*size;i++){
                                result += template(templateId,data[i]);
                            }
                        }
                    }else{
                        // 锁定
                        me.lock();
                        // 无数据
                        me.noData();
                    }
                    // 为了测试，延迟1秒加载
                    setTimeout(function(){
                        // 插入数据到页面，放到最后面
                        $(ulIdname).append(result);
                        // 每次数据插入，必须重置
                        me.resetload();
                    },1000);
                },
                error: function(xhr, type){
                    alert('Ajax error!');
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        },
        threshold : 50
    });
}

//城市选择插件
// <input  id="start" type="text" >
//     var city1 = "湖北省";
//     var city2 = "武汉市";
//     var city3 = "武昌区";
//     $("#start").val(city1+" "+city2+" "+city3);
//     $("#start").cityPicker({
//         title: "选择所在区域",
//         onChange: function (picker, values, displayValues) {
//             //do something
//         }
//     });
