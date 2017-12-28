$(function () { $('.search').find('.textbox').focus(function () { $(this).siblings('.search-btn').removeClass('color-8').addClass('color-0'); }); $('.search').find('.textbox').blur(function () { $(this).siblings('.search-btn').addClass('color-8').removeClass('color-0'); }); });


        var canaddbug=1;
        var pid = "6f917cc1f60d4cad85909737e5644eb9";
        var loginfrom=1;
        $(function () {
            loginfrom="";
            GetProjectInfoAll(pid);
            $("#txtProjectId").val(pid);
    		apiGetUserInfo();
            //apiGetProjectConfig(pid);
            var screenHeight = window.screen.height;
            if(screenHeight <= 864){
                iPWidth = "55%";
                iPHeight = "90%";
                projectWidth = "70%";
                projectHeight = "90%";   
                bugWidth = "75%";
                bugHeight = "95%"; 
                bugTalkW = "50%"
                bugTalkH = "90%"
            }
            else if(screenHeight <= 1024){                
                bugWidth = "75%";
                bugHeight = "95%";                
            } 
            
                                        
                        var screenHeight = window.screen.height;
            bugWidth = "800px";
            bugHeight = "855px";
            if(screenHeight <= 1024){                
                bugWidth = "55%";
                bugHeight = "95%";                
            }     
                    
        });
        
        function bindProjectConfig(datas) {
            if(!datas.EnableVersion && !datas.EnableEnvironment && !datas.EnableTag && !datas.EnableEvaluation && !datas.EnablePlanTime && !datas.EnablePlanVersion){                
                var screenHeight = window.screen.height;
                bugWidth = "800px";
                bugHeight = "855px";
                if(screenHeight <= 1024){                
                    bugWidth = "55%";
                    bugHeight = "95%";                
                }     
            }
        }
        
        var iPWidth = "828px";
        var iPHeight = "644px"
        var projectWidth = "888px";
        var projectHeight = "633px";
        var bugWidth = "1011px";
        var bugHeight = "855px";
        var bugTalkW = "864px",bugTalkH="682px";
        
        //关于
    	function aboutClick(){
			$('.about-grag-bg,.about-system').fadeIn(300);
		};        
		function closeAbout(){
			$('.about-grag-bg,.about-system').fadeOut(300);
		};
        //套餐
        function packageClick(){           
    		$('.package-grag-bg,.package-system').fadeIn(300);
		};
        //套餐
        function closePackage(){
    		$('.package-grag-bg,.package-system').fadeOut(300);
		};
        function opencode(){
            $('.code-grag-bg,.code-system').fadeIn(300);
        }
        function closecode(){
            $('.code-grag-bg,.code-system').fadeOut(300);
        }
        function openlogin(){
            var datas = "method=GetLoginCode";
            jQuery.ajax({
                type:"POST",
                url:"/Service/BugListService.ashx",
                data:datas,
                success:function(msg){
                    if(msg!="-1")
                    {
                        $("#logincodeimg").attr('src',msg); 
                        $('.login-grag-bg,.login-system').fadeIn(300);
                    }else
                    {
                        layer.msg('您还未登陆');
                        setTimeout(function () {
                            if(loginfrom==2)
                            {
                                window.location.href = "/login?from=1";
                                //调用客户端方法
                            }else
                            {
                                window.location.href = "/login";
                            }
                        }, 500);
                    }
                }
            })
        }
        function closelogin(){
            $('.login-grag-bg,.login-system').fadeOut(300);
        }
        
        //关于
        function openPackages(){
		    showDialogWH("用户套餐", "/packages", iPWidth, iPHeight);
		};
        
        //判断当前用户是否属于这个项目
        function IsUserProject(){
            jQuery.get("/Service/UserService.ashx?time=" + new Date().toString(),
                {
                    Method: 'IsUserProject',
                    pid: pid
                }, function (data, textStatus) {
                    if (textStatus == "success") {
                        var result = JSON.parse(data);
                        if (result.Result == "1") {
                            //成功后的处理
                        }
                        else {
                            //失败后的处理
                            layer.msg(result.Message);
                            window.location.href = "/projects";
                        }
                    }
                    else {
                        layer.msg('Failed to connect!');
                    }
                });
            }
            
        function bindBugList(obj,chuli,fenpei,createuser,pctime){
                var date=obj.ItemList;
                var html =""
                $("#count").html("共"+obj.TotCount+"条记录")
                for(var i = 0;i<date.length;i++){
                    html+='<tr onclick="asideShow(\''+date[i].BugId+'\',this);">';
                    html+='<td class="td-first">'+date[i].BugCode+'</td><td>';
                    if(date[i].BugType==1)
                        html+='<span class="text-bg textbg-1">';
                    else if(date[i].BugType==2)
                        html+='<span class="text-bg">';
                    else if(date[i].BugType==3)
                        html+='<span class="text-bg textbg-3">';
                    else
                        html+='<span class="text-bg textbg-2">';
                    html+=date[i].StrBugType+'</span></td>';
                    if(date[i].PicCount>0&&date[i].AttachmentCount>0){
                        if(date[i].ProductName!=null)
                            html+='<td class="ta-left"><div class="td-tit color-2"><i class="iconfont '+date[i].IconProdPlat+'"> </i> <span> '+date[i].ProductName+' '+date[i].ModuleName+'</span><i class="iconfont icon-tupian" ></i><i class="iconfont icon-fujian"></i>  ';
                        else
                            html+='<td class="ta-left"><div class="td-tit color-2"><span> 未指定</span><i class="iconfont icon-tupian" style="float: left;"></i><i class="iconfont icon-fujian" ></i>  ';
                    }else if(date[i].PicCount>0)
                    {
                        if(date[i].ProductName!=null)
                            html+='<td class="ta-left"><div class="td-tit color-2"><i class="iconfont '+date[i].IconProdPlat+'"> </i> <span> '+date[i].ProductName+' '+date[i].ModuleName+'</span> <i class="iconfont icon-tupian"></i> ';
                        else
                            html+='<td class="ta-left"><div class="td-tit color-2"><span> 未指定</span> <i class="iconfont icon-tupian"></i> ';
                    }else if(date[i].AttachmentCount>0)
                    {
                        if(date[i].ProductName!=null)
                            html+='<td class="ta-left"><div class="td-tit color-2"<i class="iconfont '+date[i].IconProdPlat+'"> </i> <span> '+date[i].ProductName+' '+date[i].ModuleName+'</span> <i class="iconfont icon-fujian"></i> ';
                        else
                            html+='<td class="ta-left"><div class="td-tit color-2"><span> 未指定</span> <i class="iconfont icon-fujian"></i> ';
                    }else
                    {
                        if(date[i].ProductName!=null)
                            html+='<td class="ta-left"><div class="td-tit color-2"><i class="iconfont '+date[i].IconProdPlat+'"> </i> <span>'+date[i].ProductName+' '+date[i].ModuleName+'</span> ';
                        else
                            html+='<td class="ta-left"><div class="td-tit color-2"><span>未指定</span> ';
                    }
                    if(date[i].IsAT>0)
                                                html+='<span class="atclass" style="color: red;"><i class="iconfont icon-at" style="font-size: 20px;position: relative;top: 3px;"></i></span>';
                    html+=' '+date[i].BugTitle+'';
                                        html+='</div></td>';
                    if(date[i].BugStatus==1)
                        html+='<td><span class="text-bg textbg-1">';
                    else if(date[i].BugStatus==2)
                        html+='<td><span class="text-bg textbg-2">';
                    else if(date[i].BugStatus==4)
                        html+='<td><span class="text-bg textbg-3">';
                    else
                        html+='<td><span class="text-bg">';
                    html+=date[i].StrBugStatus+'</span></td>';
                    if (date[i].Priority == 1) {
                        html += '    <td><span class="text-bg textbg-1">急</span></td>';
                    } else if (date[i].Priority == 2) {
                        html += '    <td><span class="text-bg textbg-2">高</span></td>';
                    } else if (date[i].Priority == 3) {
                        html += '    <td><span class="text-bg">中</span></td>';
                    } else {
                        html += '    <td><span class="text-bg textbg-3">低</span></td>';
                    }
                    if(createuser==1)
                    {
                        if(date[i].CreateUserName!=null)
                            html+='<td>'+date[i].CreateUserName+'</td>';
                        else
                            html+='<td>不存在</td>';
                    }
                    if(chuli==1)
                    {
                        if(date[i].ProcessingUserName!=null)
                            html+='<td>'+date[i].ProcessingUserName+'</td>';
                        else
                            html+='<td>未指定</td>';
                    }
                    if(fenpei==1)
                    {
                        if(date[i].AssignUserName!=null)
                            html+='<td>'+date[i].AssignUserName+'</td>';
                        else
                            html+='<td>未指定</td>';
                    }
                    html+='<td>'+date[i].StrCreateTime+'</td>';
                    html+='<td class="td-last">'+date[i].StrModifyTime+'</td>';
                                        html+='</tr>';
                }
                $("#bugcontent").html(html)
                var pagehtml="";
                if(obj.Pages>0){
                    if(page>1)
                        pagehtml+='<li class="perv"><a href="javascript:void(0)" onclick="lastpage()"><</a></li>';
                    else
                        pagehtml+='<li class="perv"><a href="javascript:void(0)"><</a></li>';
                    if(obj.Pages>0)
                    {
                        for(var i=obj.MinPage;i<=obj.MaxPage;i++)
                        {
                            if(page==i)
                                pagehtml+='<li class="on"><a href="javascript:void(0)">'+i+'</a></li>';
                            else
                                pagehtml+='<li><a href="javascript:void(0)" onclick="gopage('+i+')">'+i+'</a></li>';
                        }
                    }
                    if(page<obj.Pages)
                        pagehtml+='<li class="perv"><a href="javascript:void(0)" onclick="nextpage()">></a></li>';
                    else
                        pagehtml+='<li class="perv"><a href="javascript:void(0)">></a></li>';
                }
                if(page==1&&date.length<pagesize)
                {
                    $("#paging").hide();
                }else
                {
                    $("#paging").show();
                }
                $("#pagingUl").html(pagehtml);
            }       
        
        function bindProjectInfo(datas)
        {
            $("#hoverShow1 label").text(datas.ProjectName);
			bindProjectImg(datas.ProjectImg);
			$("#txtNeedRefesh").val("0");
			
			$("#lblTotProblemNum").text(datas.TotProblemNum);
			$("#lblOpenProblemNum").text(datas.OpenProblemNum);
			$("#lblReOpenProblemNum").text(datas.ReOpenProblemNum);
			$("#lblToApproveProblemNum").text(datas.ToApproveProblemNum);
			$("#lblSolvedProblemNum").text(datas.SolvedProblemNum);
			$("#lblClosedProblemNum").text(datas.ClosedProblemNum);
            $("#lblPostponeProblemNum").text(datas.PostponeProblemNum);
			$("#lblMyToDoProblemNum").text(datas.MyToDoProblemNum);
			$("#lblUnsolvedProblemNum").text(datas.UnsolvedProblemNum);
            
            $("#lblbugcount").text(datas.TotProblemNum);
        	$("#lblsolvedcount").text(datas.SolvedProblemNum);
			$("#lblnotsolvedcount").text(datas.OpenProblemNum);            
		}
        
                function bindUserInfo(datas) {
            var defaultPId = "438880d3-a0fd-4bc3-ac27-13f849194545"
            if(datas.PackageId != "" && datas.PackageId != null && datas.PackageId != defaultPId)
                $("#userPackage").css("color","green")
            $("#imgUser").attr("src", datas.HeadImgUrl);
            $("#imgUser").removeClass("loaduser");
            $(".loaduserdiv").removeClass("loaduserdiv");
            $("#imgUser").attr("alt", datas.RealName);
            $("#imgUserEdit").attr("src", datas.HeadImgUrl);
            $("#imgUserEdit").attr("alt", datas.RealName);
            $("#lblUser").text(datas.RealName);
            $("#hidCurrentUserId").val(datas.UserId);
            IsUserProject();
        }
    
        function bindProjects(datas) {
            var pid = $("#txtProjectId").val();
            var phtml = "";
            for (var i = 0; i < datas.length; i++) {
                if (datas[i].ProjectImg == null || datas[i].ProjectImg == "") {
                    datas[i].ProjectImg = "/images/logo/logoshort0.png";
                }
            
    			if(pid==datas[i].ProjectId)
				{
                    if(datas[i].OpenProblemNum>0)
                        phtml += '<a href="/projectConsole-'+datas[i].ProjectId+'" class="on"><span class="num textbg-2">'+datas[i].OpenProblemNum+'</span><img src="'+datas[i].ProjectImg+'" style="width:50px" />' + datas[i].ProjectName + '</a>';
                    else
                        phtml += '<a href="/projectConsole-'+datas[i].ProjectId+'" class="on"><span class="num textbg-2" style="display:none">'+datas[i].OpenProblemNum+'</span><img src="'+datas[i].ProjectImg+'" style="width:50px" />' + datas[i].ProjectName + '</a>';
				}else{
                    if(datas[i].OpenProblemNum>0)
                        phtml += '<a href="/projectConsole-'+datas[i].ProjectId+'"><span class="num textbg-2">'+datas[i].OpenProblemNum+'</span><img src="'+datas[i].ProjectImg+'" style="width:50px" />' + datas[i].ProjectName + '</a>';
				    else
                        phtml += '<a href="/projectConsole-'+datas[i].ProjectId+'"><span class="num textbg-2" style="display:none">'+datas[i].OpenProblemNum+'</span><img src="'+datas[i].ProjectImg+'" style="width:50px"/>' + datas[i].ProjectName + '</a>';
                }
            }
            $("#hoverShow1 div").html(phtml);

			var needRefesh = $("#txtNeedRefesh").val();
			if(needRefesh=="1")
			{     
				GetProjectInfoAll(pid);
			}
        }
        
        function getcanaddbug(){
            var datas = "method=CanAddBug&pid=6f917cc1f60d4cad85909737e5644eb9";
            jQuery.ajax({
                type:"POST",
                url:"/Service/UserPackageService.ashx",
                data:datas,
                success:function(msg){
                    if(msg=="1")
                        canaddbug=1;
                    else
                        canaddbug=0;
                }
            })
        }
        
        function addNewVersion() {
            if(screen.width<=1366)
                showDialogWH("发布版本", "/addversion_6f917cc1f60d4cad85909737e5644eb9", "50%", "75%");
            else
                showDialogWH("发布版本", "/addversion_6f917cc1f60d4cad85909737e5644eb9", "30%", "60%");
        };
        
        function getcanaddbugn(){
            var datas = "method=CanAddBug&pid=6f917cc1f60d4cad85909737e5644eb9";
            jQuery.ajax({
                type:"POST",
                url:"/Service/UserPackageService.ashx",
                data:datas,
                success:function(msg){
                    if(msg=="1")
                        canaddbug=1;
                    else
                        canaddbug=0;
                    if(canaddbug==1)
                    showDialogWH("添加问题", "/dialogaddbuginfo", bugWidth, bugHeight);
                    else
                    {
                        layer.msg("此项目问题提交数量已到上限");
                    }
                }
            })
        }
        
        
    
        //新问题
        function addNewProblem() {
            getcanaddbugn();
        };
    	function backToConsole()
		{
			window.location.href = "/projects";
		}
        function changeUserEmail() {
            showDialogWH("修改邮箱", "/Templates/Default/dialogUserEmail.html", "400px", "250px");
        }
        function changeUserName() {
            showDialogWH("修改姓名", "/Templates/Default/dialogUserName.html", "400px", "200px");
        }
        function changeUserPassword() {
            showDialogWH("修改密码", "/Templates/Default/dialogUserPassword.html", "400px", "320px");
        }
        function changePhoto() {            
            showDialogWH("修改头像", "/uploaduserphoto","562px","527px");           
        }
        function changeSetting() {
			$("#txtNeedRefesh").val("1");
            var pid = $("#txtProjectId").val();
            showDialogWH("编辑项目", "/projectinfo-"+pid,projectWidth,projectHeight);
        }
        function logout() {
            layer.confirm('是否确认退出？', {
                btn: ['确认', '取消'] //按钮
            }, function () {
                //确认时的处理
                apiUserLogout();
            }, function () {
                //取消时的处理 
            });
        }
    
        $(function () {
            heightAuto();
            
            //自定义滚动条
            $('#project-left').niceScroll({
                cursorcolor: "#ddddeb",
                cursoropacitymax: 1,
                touchbehavior: false,
                cursorwidth: "5px",
                cursorborder: "0",
                cursorborderradius: "6px"
            });
            
            $('#showlist').niceScroll({
                cursorcolor: "#ddddeb",
                cursoropacitymax: 1,
                touchbehavior: false,
                cursorwidth: "5px",
                cursorborder: "0",
                cursorborderradius: "6px"
            });

            $('#project-right').niceScroll({
                cursorcolor: "#c2c2c2",
                cursoropacitymax: 1,
                touchbehavior: false,
                cursorwidth: "5px",
                cursorborder: "0",
                cursorborderradius: "6px"
            });
            $('#aside-scroll').niceScroll({
                cursorcolor: "#c2c2c2",
                cursoropacitymax: 1,
                touchbehavior: false,
                cursorwidth: "5px",
                cursorborder: "0",
                cursorborderradius: "6px"
            });
            $('#tab').on('click', 'li', function () {
                $(this).addClass('on').siblings().removeClass('on');
            });
        });
        $(window).resize(function () {
            heightAuto();
        });
        function heightAuto() {
            var height = $(window).height() - $('.header').outerHeight();
                        $('#project-right').height(height);
            $('#aside-scroll').height(height);

        };

        hoverShow('#hoverShow1', '.show-box2');
        hoverShow('#hoverShow2', '.show-box');

        //经过显示方法封装
        function hoverShow(t, object) {
            $(t).hover(function () {
                if(t=='#hoverShow1')
                    apiGetProjects();
                $(this).find(object).fadeIn(300);
                $(this).find('.icon-arrow-copy').addClass('rotate180');
            }, function () {
                $(this).find(object).stop().fadeOut(300);
                $(this).find('.icon-arrow-copy').removeClass('rotate180');
            });
        };

        
        //修改头像
        $(".avatar1").hover(function () {
            $(".changeBj").show();
            $(".changeTxt").show();
        }, function () {
            $(".changeBj").hide();
            $(".changeTxt").hide();
        });
        
        String.prototype.endWith=function(str){     
    	  var reg=new RegExp(str+"$");     
		  return reg.test(this);        
		}
        
        function check() {
            var key = event.keyCode;
            if (key == 13)
                search();       
            }
        
        function search(){
            var keyword=$("#seartxt").val();
            if(keyword!='根据编号、标题、模块搜索'&&keyword!="q1"&&keyword!="")
            {
                keyword=keyword.trim().replace(" ","|nbsp;");
                window.location.href='/allbug_6f917cc1f60d4cad85909737e5644eb9/'+keyword+"/0/0";
            }
            else
                window.location.href='/allbug_6f917cc1f60d4cad85909737e5644eb9/ ';
        }
 

    var messageindex=0;
        $(function(){  
            apiGetToken();    
            var i=jQuery.cookie('bugdone_havechat');
            if(i!=""&&i!=null&&i==1)
            {
                $(".icon-chat1").attr("title","你有新消息").css("color","green");
                $(".icon-chat1").parent(".chardiv").addClass("animated tada");
            }
        })
        var closechatlog;
        function getchat(){
            jQuery.cookie('bugdone_havechat', 0, { expires: 1 });
            $(".icon-chat1").attr("title","没有新消息").css("color","#264d79");
                        layer.open({
                type: 2 //Page层类型
                , area: [bugTalkW, bugTalkH]
                , title: "BugTalk"
                , shade: 0.6 //遮罩透明度
                , maxmin: false //允许全屏最小化
                , content: "/bugtalk"
                ,cancel: function(){ 
                    //右上角关闭回调
                    bugTalkConnect();
                    $("#bugtalkOnlinePage").val("currentPage")
                    layer.close(closechatlog);
                }
            });
        }
        var appKey = "", token = "";
        function bugTalkConnect()
        {
            RongIMClient.init(appKey);
            RongIMClient.setConnectionStatusListener({
                onChanged: function (status) {
                    switch (status) {
                        case RongIMLib.ConnectionStatus.CONNECTED:
                            console.log("<b>连接成功</b>");
                            $("#bugtalkStatus").removeClass("online-status-off")
                            break;
                        case RongIMLib.ConnectionStatus.CONNECTING:
                            console.log("<b>正在连接</b>");
                            var page = $("#bugtalkOnlinePage").val();                          
                            if(page !="bugTalkPage")
                                $("#bugtalkStatus").addClass("online-status-off")                            
                            break;
                        case RongIMLib.ConnectionStatus.DISCONNECTED:
                            console.log("<b>断开连接</b>");
                            $("#bugtalkStatus").addClass("online-status-off")
                            break;
                        case RongIMLib.ConnectionStatus.KICKED_OFFLINE_BY_OTHER_CLIENT:
                            console.log("<b>其他设备登录</b>");
                            var page = $("#bugtalkOnlinePage").val();                        
                            if(page !="bugTalkPage")
                                $("#bugtalkStatus").addClass("online-status-off")
                            break;
                        case RongIMLib.ConnectionStatus.NETWORK_UNAVAILABLE:
                            console.log("<b>网络不可用</b>");
                            $("#bugtalkStatus").addClass("online-status-off")
                            break;
                    }
                }
            });
        
            //var mydiv = document.getElementById("mydiv");
            RongIMClient.setOnReceiveMessageListener({
                onReceived: function (message) {
                    if(loginfrom==2)
                    {
                        WinJSLib.flashTaskBar();
                    }
                    switch (message.messageType) {
                        case RongIMClient.MessageType.TextMessage:
                            if(message.senderUserId=="system_10000")
                            {
                                var obj=jQuery.parseJSON(message.content.content);
                                if(obj.type==1)
                                {
                                    layer.close(messageindex)
                                    messageindex=layer.open({
                                        type: 1
                                        ,offset: 'rb' //具体配置参考：offset参数项
                                        ,content: '<div style="width: 250px;padding: 20px 28px;">'+obj.msg+'</div>'
                                        ,btnAlign: 'c' //按钮居中
                                        ,shade: 0 //不显示遮罩
                                        ,btn: '查看详情'
                                        ,yes: function(){
                                            window.location.href="/allbug_"+obj.projectId+"/q1/0/"+obj.bugId;
                                         }
                                    });
                                }else if(obj.type==2)
                                {
                                    layer.close(messageindex)
                                    messageindex=layer.open({
                                        title: '系统通知:'+obj.title
                                        ,type: 1
                                        ,content: '<div style="color: black;padding: 25px 25px;">'+obj.msg+'</div>'
                                        ,btnAlign: 'c' //按钮居中
                                        ,shade: 0 //不显示遮罩
                                        ,area: ['850px', '50%']
                                        ,btn: ['相关链接', '知道了']
                                        ,yes: function(){
                                            window.open(obj.linkurl);
                                        }
                                        ,btn2: function(index, layero){
                                            layer.close(index)
                                        }
                                    });
                                }
                            }
                            else{
                                $(".icon-chat1").attr("title","你有新消息").css("color","green");
                                $(".icon-chat1").parent(".f-r").addClass("animated tada");
                                jQuery.cookie('bugdone_havechat', 1, { expires: 7 }); 
                                apiGetNewBugTalk(message.targetId);
                            }
                            //message.content.content => 消息内容  
                            break;                   
                        case RongIMClient.MessageType.ImageMessage:  
                            $(".icon-chat1").attr("title","你有新消息").css("color","green");
                            $(".icon-chat1").parent(".f-r").addClass("animated tada");
                            jQuery.cookie('bugdone_havechat', 1, { expires: 7 });
                            apiGetNewBugTalk(message.targetId);
                            break;
                        case RongIMClient.MessageType.DiscussionNotificationMessage:
                            // message.content.extension => 讨论组中的人员。
                            $(".icon-chat1").attr("title","你有新消息").css("color","green");
                            $(".icon-chat1").parent(".f-r").addClass("animated tada");
                            jQuery.cookie('bugdone_havechat', 1, { expires: 7 });
                            break;
                    }
                }
            });
            RongIMClient.connect(token, {
                onSuccess: function (userId) {                   
                },
                onTokenIncorrect: function () {
                    console.log('token无效');
                },
                onError: function (errorCode) {
                    var info = '';
                    switch (errorCode) {
                        case RongIMLib.ErrorCode.TIMEOUT:
                            info = '超时';
                            break;
                        case RongIMLib.ErrorCode.UNKNOWN_ERROR:
                            info = '未知错误';
                            break;
                        case RongIMLib.ErrorCode.UNACCEPTABLE_PaROTOCOL_VERSION:
                            info = '不可接受的协议版本';
                            break;
                        case RongIMLib.ErrorCode.IDENTIFIER_REJECTED:
                            info = 'appkey不正确';
                            break;
                        case RongIMLib.ErrorCode.SERVER_UNAVAILABLE:
                            info = '服务器不可用';
                            break;
                    }
                    console.log(errorCode);
                }
            });
        }
        
        function onCompleteGetNewBugTalk(){
            
        }
 
     
                
        var sortValue="desc";
        $(function () {
    		loaddate("CreateTime",null);
        });
		function loaddate(sortKey,obj)
		{	
            if(obj != null){
                if(sortValue=="asc")
                    sortValue="desc";
                else
                    sortValue="asc";
            }
			$(".tr-head a").removeClass("top-on");
			$(".tr-head a").removeClass("bottom-on");

			if(obj!=null)
			{
				if(sortValue=="asc")
				{
					$(obj).parent().parent().addClass("top-on");
				}else{
					$(obj).parent().parent().addClass("bottom-on");
				}
			}
            var pid = $("#txtProjectId").val();
			apiGetNewBug(pid,sortKey,sortValue);
		}
        function bindProjectImg(pProjectImg) {
            if (pProjectImg != "") {
                $("#imgProjectImg").attr("src", pProjectImg);
            }else{
                $("#imgProjectImg").attr("src", "/images/logo/logoshort0.png");
			}
        }
        


        function bindProjectImg(pProjectImg) {           
            if (pProjectImg != ""&&pProjectImg !=null) {
                $("#imgProjectImg").attr("src", pProjectImg);
            }else{
                $("#imgProjectImg").attr("src", "/images/logo/logoshort0.png");
    		}
            $("#imgProjectImg").removeClass("projectpics");
            if(screen.width<=1366)
            {
                $(".menu li").addClass("screen1")
                $(".projectIndex .left .menu .num").addClass("screen2");
                $(".projectIndex .left .menu li i").addClass("screen3");
                $(".mw-900").addClass("rightshow");
            }else
            {
                $(".menu li").removeClass("screen1")
                $(".projectIndex .left .menu .num").removeClass("screen2");
                $(".projectIndex .left .menu li i").removeClass("screen3");
                $(".mw-900").removeClass("rightshow");
            }
        }
        


                                                        var openreport=0;
                    $(function () {
                        $('.chart-bar').click(function(){
                            if(openreport==0)
                            {
                                openreport=1
                                LoadUnsoleRF("人员",'');
                                LoadReviewRF("人员",'');
                                LoadSoledRF("人员",'');
                                LoadStatusRF();
                            }
                            else
                                openreport=0
                        	$(this).find('.icon-arrow-copy').toggleClass('icon-rotate-animate');
                			$('.chart-list').slideToggle(400);
                            heightAuto();
                		});
                    });
                    
            		function heightAuto(){
            			var height = $(window).height()-$('.header').outerHeight();
            			$('#project-left').height(height)
            			$('#project-right').height(height);
            			$('#aside-scroll').height(height);
            			
            			var fromHeight = $('.newProblem').height()-159;
            			$('#fromBox').height(fromHeight);	
            		};
                    
                    function LoadUnsoleRF(type,e){
                        $(e).siblings().removeClass("active");
                        $(e).addClass("active");
                        var datas = "pid=6f917cc1f60d4cad85909737e5644eb9&type="+type+"&Method=getconsolereport&name=unsoled";
                        NProgress.start();
                        jQuery.ajax({
                            type:"POST",
                            url:"/Service/ReportService.ashx",
                            data:datas,
                            success:function(msg){
                                var obj=jQuery.parseJSON(msg);
                                BindChart1(obj);
                                NProgress.done();
                            }
                        })
                    }
                    function LoadReviewRF(type,e){
                        $(e).siblings().removeClass("active");
                        $(e).addClass("active");
                        var datas = "pid=6f917cc1f60d4cad85909737e5644eb9&type="+type+"&Method=getconsolereport&name=review";
                        NProgress.start();
                        jQuery.ajax({
                            type:"POST",
                            url:"/Service/ReportService.ashx",
                            data:datas,
                            success:function(msg){
                                var obj=jQuery.parseJSON(msg);
                                BindChart2(obj);
                                NProgress.done();
                            }
                        })
                    }
                    function LoadSoledRF(type,e){
                        $(e).siblings().removeClass("active");
                        $(e).addClass("active");
                        var datas = "pid=6f917cc1f60d4cad85909737e5644eb9&type="+type+"&Method=getconsolereport&name=soled";
                        NProgress.start();
                        jQuery.ajax({
                            type:"POST",
                            url:"/Service/ReportService.ashx",
                            data:datas,
                            success:function(msg){
                                var obj=jQuery.parseJSON(msg);
                                BindChart3(obj);
                                NProgress.done();
                            }
                        })
                    }
                    function LoadStatusRF(){
                        var datas = "pid=6f917cc1f60d4cad85909737e5644eb9&type=1&Method=getconsolereport&name=status";
                        NProgress.start();
                        jQuery.ajax({
                            type:"POST",
                            url:"/Service/ReportService.ashx",
                            data:datas,
                            success:function(msg){
                                var obj=jQuery.parseJSON(msg);
                                BindChart4(obj);
                                NProgress.done();
                            }
                        })
                    }
                    function BindChart1(datas) {
                        $("#UnsolveBug").highcharts({
                            chart: {
                                type: 'pie',
                                plotBackgroundColor: null,
                                plotBorderWidth: null,
                                plotShadow: false,
                                options3d: {
                                    enabled: true,
                                    alpha: 45,
                                    beta: 0
                                }
                            },
                            title: {
                                text: ''
                            },
                            tooltip: {
                                pointFormat: '{series.name}: {point.percentage:.1f}%</b>'
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    depth:35,
                                    dataLabels: {
                                        enabled: true,
                                        color: '#000000',
                                        connectorColor: '#000000',
                                        format: '{point.name}: {point.percentage:.1f} %'
                                    }
                                }
                            },
                            series: [{
                                name: '所占比率',
                                data: eval(datas.series)
                            }]
                        })
                    }
                    function BindChart2(datas) {
                        $("#ReviewBug").highcharts({
                            chart: {
                                type: 'pie',
                                plotBackgroundColor: null,
                                plotBorderWidth: null,
                                plotShadow: false,
                                options3d: {
                                    enabled: true,
                                    alpha: 45,
                                    beta: 0
                                }
                            },
                            title: {
                                text: ''
                            },
                            tooltip: {
                                pointFormat: '{series.name}: {point.percentage:.1f}%</b>'
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    depth:35,
                                    dataLabels: {
                                        enabled: true,
                                        color: '#000000',
                                        connectorColor: '#000000',
                                        format: '{point.name}: {point.percentage:.1f} %'
                                    }
                                }
                            },
                            series: [{
                                name: '所占比率',
                                data: eval(datas.series)
                            }]
                        })
                    }
                    function BindChart3(datas) {
                        $("#SolvedBug").highcharts({
                            chart: {
                                type: 'pie',
                                plotBackgroundColor: null,
                                plotBorderWidth: null,
                                plotShadow: false,
                                options3d: {
                                    enabled: true,
                                    alpha: 45,
                                    beta: 0
                                }
                            },
                            title: {
                                text: ''
                            },
                            tooltip: {
                                pointFormat: '{series.name}: {point.percentage:.1f}%</b>'
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    depth:35,
                                    dataLabels: {
                                        enabled: true,
                                        color: '#000000',
                                        connectorColor: '#000000',
                                        format: '{point.name}: {point.percentage:.1f} %'
                                    }
                                }
                            },
                            series: [{
                                name: '所占比率',
                                data: eval(datas.series)
                            }]
                        })
                    }
                    function BindChart4(datas) {
                        $("#BugStatus").highcharts({
                            chart: {
                                type: 'pie',
                                plotBackgroundColor: null,
                                plotBorderWidth: null,
                                plotShadow: false,
                                options3d: {
                                    enabled: true,
                                    alpha: 45,
                                    beta: 0
                                }
                            },
                            title: {
                                text: ''
                            },
                            tooltip: {
                                pointFormat: '{series.name}: {point.percentage:.1f}%</b>'
                            },
                            plotOptions: {
                                pie: {
                                    allowPointSelect: true,
                                    cursor: 'pointer',
                                    depth:35,
                                    dataLabels: {
                                        enabled: true,
                                        color: '#000000',
                                        connectorColor: '#000000',
                                        format: '{point.name}: {point.percentage:.1f} %'
                                    }
                                }
                            },
                            series: [{
                                name: '所占比率',
                                data: eval(datas.series)
                            }]
                        })
                    }
                    
                    Highcharts.theme = {
                        colors: ["#7bbfea", "#d93a49", "#f47920", "#00ae9d", "#426ab3", "#eeaaee",
                            "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
                        chart: {
                            backgroundColor: null,
                            style: {
                                fontFamily: "Signika, serif"
                            }
                        },
                        title: {
                            style: {
                                color: 'black',
                                fontSize: '16px',
                                fontWeight: 'bold'
                            }
                        },
                        subtitle: {
                            style: {
                                color: 'black'
                            }
                        },
                        tooltip: {
                            borderWidth: 0
                        },
                        legend: {
                            itemStyle: {
                                fontWeight: 'bold',
                                fontSize: '13px'
                            }
                        },
                        xAxis: {
                            labels: {
                                style: {
                                    color: '#6e6e70'
                                }
                            }
                        },
                        yAxis: {
                            labels: {
                                style: {
                                    color: '#6e6e70'
                                }
                            }
                        },
                        plotOptions: {
            
                            candlestick: {
                                lineColor: '#404048'
                            },
                            map: {
                                shadow: false
                            }
                        },
            
                        // Highstock specific
                        navigator: {
                            xAxis: {
                                gridLineColor: '#D0D0D8'
                            }
                        },
                        rangeSelector: {
                            buttonTheme: {
                                fill: 'white',
                                stroke: '#C0C0C8',
                                'stroke-width': 1,
                                states: {
                                    select: {
                                        fill: '#D0D0D8'
                                    }
                                }
                            }
                        },
                        scrollbar: {
                            trackBorderColor: '#C0C0C8'
                        },
            
                        // General
                        background2: '#E0E0E8'
            
                    };
                    Highcharts.setOptions(Highcharts.theme);
                    
                    

    var pUserId1 = "";
    var cUserId1 = "";
    function bindBugInfo(datas){
        pUserId1 = datas.ProcessingUserId;
        cUserId1 = datas.CreateUserId;        
		$("#txtBugCode").text("#"+datas.BugCode);
		$("#txtBugTitle").text(datas.BugTitle);
		$("#txtProjectName").text(datas.ProjectName);
		$("#txtProductName").text(datas.ProductName);
		$("#txtModuleName").text(datas.ModuleName);			
		$("#txtCreateUserName").text(datas.CreateUserName);
		$("#txtProcessingUserName").text(datas.ProcessingUserName);
		$("#txtCutOffDate").text(datas.StrCutOffDate);
		$("#txtPlanFixDate").text(datas.StrPlanFixDate);
		$("#txtPlanFixVersion").text(datas.PlanFixVersionName);
        var str = datas.Description.replace(/\n/g,"<br/>");   
		$("#txtDescription").html(str);
		$("#txtVersionId").text(datas.VersionName);
		//$("#txtCheckedVersionId").text(datas.CheckedVersionId);
		$("#txtEnvironment").text(datas.Environment);
        $("#txtWorkload").text(datas.Workload+"小时");
        $("#txtBugValue").text(datas.BugValue);
        
        if(datas.IsAttention){
            $("#btnCollect").hide();
            $("#btnCollectAfter").show();
        }
        else{
            $("#btnCollect").show();
            $("#btnCollectAfter").hide();
        }
        
		if (datas.BugType == 2) {
			$("#txtBugType").text("任务");
			$("#txtBugType").attr("class","text-bg");
        } else if (datas.BugType == 1) {
			$("#txtBugType").text("缺陷");
			$("#txtBugType").attr("class","text-bg textbg-1");
        } else if (datas.BugType == 3) {
			$("#txtBugType").text("需求");
			$("#txtBugType").attr("class","text-bg textbg-3");
        }
        else{
    		$("#txtBugType").text("改进");
			$("#txtBugType").attr("class","text-bg textbg-2");
        }
		
        var cUserId = parent.$("#hidCurrentUserId").val();      
        $("#hidLastHandleUserId").val(datas.ProcessingUserId);
        btnShowOrHide(datas.BugStatus,datas.CreateUserId,cUserId,datas.ProcessingUserId)
         
		if (datas.BugStatus == 1) {            
			$("#txtBugStatus").text("未解决");
			$("#txtBugStatus").attr("class","text-bg textbg-1");			
		} else if (datas.BugStatus == 2) {
			$("#txtBugStatus").text("待审核");
			$("#txtBugStatus").attr("class","text-bg textbg-2");	
		} else if (datas.BugStatus == 3) {
			$("#txtBugStatus").text("已拒绝");
			$("#txtBugStatus").attr("class","text-bg");
		} else if (datas.BugStatus == 4) {
			$("#txtBugStatus").text("已解决");
			$("#txtBugStatus").attr("class","text-bg textbg-3");
		} else if (datas.BugStatus == 5) {
			$("#txtBugStatus").text("已关闭");
			$("#txtBugStatus").attr("class","text-bg");
		} else if (datas.BugStatus == 6) {
			$("#txtBugStatus").text("已延期");
			$("#txtBugStatus").attr("class","text-bg");
		}

        if (datas.Priority == 1) {
			$("#txtPriority").text("急");
			$("#txtPriority").attr("class","text-bg textbg-1");
        } else if (datas.Priority == 2) {
			$("#txtPriority").text("高");
			$("#txtPriority").attr("class","text-bg textbg-2");
        } else if (datas.Priority == 3) {
			$("#txtPriority").text("中");
			$("#txtPriority").attr("class","text-bg");
        } else {
			$("#txtPriority").text("低");
			$("#txtPriority").attr("class","text-bg textbg-3");
        }
        
        var phtml = "";
        for(var i = 0; i< datas.TagList.length; i++)
        {                    
            phtml += "<em style='color:" + datas.TagList[i].TagColor + ";border: 1px solid " + datas.TagList[i].TagColor + ";    margin: 5px;'>" + datas.TagList[i].TagName + "</em>";
            
        }
        $("#tagBox").html(phtml);
        
        if(datas.RelevanceUsersList.length > 0){
            var ru_html = "";
            for(var i = 0; i< datas.RelevanceUsersList.length; i++)
            {                    
                ru_html += "<strong style='color:#264d79;font-weight: bold;margin-right:10px'>@"+datas.RelevanceUsersList[i].RealName+"</strong>";            
            }
            $("#txtRelevanceUsers").html(ru_html)
            $("#txtRelevanceUsers").show()
        }
        else
            $("#txtRelevanceUsers").hide()
         
		
		var phtmlimg = "";
		var phtmlfile = "";
        var ahtmlImg = "";
        for (var i = 0; i < datas.BugAccessoryList.length; i++) {
			var purl = datas.BugAccessoryList[i].FullFileUrl;
            if(datas.BugAccessoryList[i].AccessoryType == 1){
                phtmlimg += "<a class='fancybox' data-fancybox-group=\"gallery\"  href='" + purl + "'>"
    			phtmlimg += '<img  src="'+datas.BugAccessoryList[i].FullFileUrlThumb+'" /></a>';
            }
            else if(datas.BugAccessoryList[i].AccessoryType == 2){
    			if(datas.BugAccessoryList[i].FileType==1)
    			{
                    ahtmlImg += "<a class='fancybox'  data-fancybox-group=\"gallery\" href='" + purl + "'>"
    				ahtmlImg += '<img src="'+datas.BugAccessoryList[i].FullFileUrlThumb+'" /></a>';
    			}else{
                    var fileOldName = datas.BugAccessoryList[i].FileName;
                    if(fileOldName == null || fileOldName == "")
                        fileOldName = datas.BugAccessoryList[i].FileUrl;
                    if(phtmlfile == "")
                        phtmlfile = '<p style="margin-bottom:5px;"><span class="iconfont icon-fujian"></span> 附件 </p>'
    				if(purl.endWith('.mp3')){
                        phtmlfile += '<p  class="pFiles"><span class="icons"><svg class="icon" aria-hidden="true"style="width: 1em; height: 1em;vertical-align: -0.15em;fill: currentColor; overflow: hidden;"><use xlink:href="#icon-file-audio"></use></svg></span>'
                        phtmlfile += '<span class="flist">'+fileOldName+'</span>'
                        phtmlfile += '<span class="fblist">'+datas.BugAccessoryList[i].FileSize+'KB</span>'
                        phtmlfile += '<span class="iconfont iconf icon-play" onclick="playMedia(\''+purl+'\')"></span></p>';
    					//phtmlfile+= '<strong>附件：</strong><a href="'+purl+'" target="_blank" title="附件"><strong>'+datas.BugAccessoryList[i].FileUrl+'</strong></a><br>';
    				}else if(purl.endWith('.mp4')){
                        phtmlfile += '<p  class="pFiles"><span class="icons"><svg class="icon" aria-hidden="true"style="width: 1em; height: 1em;vertical-align: -0.15em;fill: currentColor; overflow: hidden;"><use xlink:href="#icon-file-video"></use></svg></span>'
                        phtmlfile += '<span class="flist">'+fileOldName+'</span>'
                        phtmlfile += '<span class="fblist">'+datas.BugAccessoryList[i].FileSize+'KB</span>'
                        phtmlfile += '<span class="iconfont iconf icon-play" onclick="playMedia(\''+purl+'\')"></span></p>';
    					//phtmlfile+= '<strong>附件：</strong><a href="'+purl+'" target="_blank" title="附件"><strong>'+datas.BugAccessoryList[i].FileUrl+'</strong></a><br>';
    				}else if(purl.endWith('.docx') || purl.endWith('.doc')){
                        phtmlfile += '<p  class="pFiles"><span class="icons"><svg class="icon" aria-hidden="true"style="width: 1em; height: 1em;vertical-align: -0.15em;fill: currentColor; overflow: hidden;"><use xlink:href="#icon-file-doc"></use></svg></span>'
                        phtmlfile += '<span class="flist">'+fileOldName+'</span>'
                        phtmlfile += '<span class="fblist">'+datas.BugAccessoryList[i].FileSize+'KB</span>'
                        phtmlfile += '<a href="'+purl+'" title="附件"><span class="iconfont iconf icon-xiazai"></span></a></p>';
        				//phtmlfile+= '<strong>附件：</strong><a href="'+purl+'" target="_blank" title="附件"><strong>'+datas.BugAccessoryList[i].FileUrl+'</strong></a><br>';
    				}else if(purl.endWith('.psd')){
                        phtmlfile += '<p  class="pFiles"><span class="icons"><svg class="icon" aria-hidden="true"style="width: 1em; height: 1em;vertical-align: -0.15em;fill: currentColor; overflow: hidden;"><use xlink:href="#icon-file-psd"></use></svg></span>'
                        phtmlfile += '<span class="flist">'+fileOldName+'</span>'
                        phtmlfile += '<span class="fblist">'+datas.BugAccessoryList[i].FileSize+'KB</span>'
                        phtmlfile += '<a href="'+purl+'" title="附件"><span class="iconfont iconf icon-xiazai"></span></a></p>';
                    	//phtmlfile+= '<strong>附件：</strong><a href="'+purl+'" target="_blank" title="附件"><strong>'+datas.BugAccessoryList[i].FileUrl+'</strong></a><br>';
    				}else if(purl.endWith('.pptx') || purl.endWith('.ppt')){
                        phtmlfile += '<p  class="pFiles"><span class="icons"><svg class="icon" aria-hidden="true"style="width: 1em; height: 1em;vertical-align: -0.15em;fill: currentColor; overflow: hidden;"><use xlink:href="#icon-file-ppt"></use></svg></span>'
                        phtmlfile += '<span class="flist">'+fileOldName+'</span>'
                        phtmlfile += '<span class="fblist">'+datas.BugAccessoryList[i].FileSize+'KB</span>'
                        phtmlfile += '<a href="'+purl+'" title="附件"><span class="iconfont iconf icon-xiazai"></span></a></p>';
                    	//phtmlfile+= '<strong>附件：</strong><a href="'+purl+'" target="_blank" title="附件"><strong>'+datas.BugAccessoryList[i].FileUrl+'</strong></a><br>';
    				}else if(purl.endWith('.xls') || purl.endWith('.xlsx')){
                        phtmlfile += '<p  class="pFiles"><span class="icons"><svg class="icon" aria-hidden="true"style="width: 1em; height: 1em;vertical-align: -0.15em;fill: currentColor; overflow: hidden;"><use xlink:href="#icon-file-xls"></use></svg></span>'
                        phtmlfile += '<span class="flist">'+fileOldName+'</span>'
                        phtmlfile += '<span class="fblist">'+datas.BugAccessoryList[i].FileSize+'KB</span>'
                        phtmlfile += '<a href="'+purl+'" title="附件"><span class="iconfont iconf icon-xiazai"></span></a></p>';
                    	//phtmlfile+= '<strong>附件：</strong><a href="'+purl+'" target="_blank" title="附件"><strong>'+datas.BugAccessoryList[i].FileUrl+'</strong></a><br>';
    				}else{
                        phtmlfile += '<p  class="pFiles"><span class="icons"><svg class="icon" aria-hidden="true"style="width: 1em; height: 1em;vertical-align: -0.15em;fill: currentColor; overflow: hidden;"><use xlink:href="#icon-file-zip"></use></svg></span>'
                        phtmlfile += '<span class="flist">'+fileOldName+'</span>'
                        phtmlfile += '<span class="fblist">'+datas.BugAccessoryList[i].FileSize+'KB</span>'
                        phtmlfile += '<a href="'+purl+'" title="附件"><span class="iconfont iconf icon-xiazai"></span></a></p>';
    					//phtmlfile+= '<strong>附件：</strong><a href="'+purl+'" target="_blank" title="附件"><strong>'+datas.BugAccessoryList[i].FileUrl+'</strong></a><br>';
    				}
    			}
            }
		}
        
        
        
        if(str == "" && phtmlimg == "" && ahtmlImg == "" && phtmlfile == ""){
            phtmlimg = "暂无描述及附件";
            $("#loadImg").remove()
        }        
        else if(phtmlimg == "" && ahtmlImg == "")
            $("#loadImg").remove()
        
        $("#pImgs").html(phtmlimg);
        $("#pFiles").html(ahtmlImg);
        $("#divfile").html(phtmlfile);		
        $(".fancybox").fancybox();
        var imgNum=$('#pImgs img').length;        
        $('#pImgs img').load(function(){           
            if(!--imgNum){
                // 加载完成
                $("#loadImg").remove()
            }
        });
		var phtml = "";
        for (var i = 0; i < datas.BugAssignList.length; i++) {                
			phtml+= '<li>';
            phtml+= '	<div class="avatar">';
            phtml+= '		<img src="' + datas.BugAssignList[i].OriginalHeadImgUrl + '" />';
            phtml+= '	</div>';
            phtml+= '	<div class="name">';
            phtml+= '		<span>' + datas.BugAssignList[i].strCreateTime + '</span>';
            phtml+= '		<strong>' + datas.BugAssignList[i].OriginalUserName + '  '+ datas.BugAssignList[i].StrStatus +'</strong>';
            if(datas.BugAssignList[i].Status == 6)
                phtml+= '(' + datas.RefuseReason + ')';
			if(datas.BugAssignList[i].NewUserName!="")
			{
				phtml+= '      指派给      <strong>' + datas.BugAssignList[i].NewUserName + '</strong>   ';
			}
            phtml+=	'   <br/>    ' + datas.BugAssignList[i].AssignReason;
            for (var j = 0; j < datas.BugAccessoryList.length; j++) {
                if(datas.BugAssignList[i].AssignId == datas.BugAccessoryList[j].RemarkId && datas.BugAccessoryList[j].AccessoryType == 3){
                    if(datas.BugAccessoryList[j].FileType == 1){
                        phtml += "<a class='fancybox'  data-fancybox-group=\"gallery\" href='" + datas.BugAccessoryList[j].FullFileUrl + "'>"
                		phtml += '<img src="'+datas.BugAccessoryList[j].FullFileUrlThumb+'" /></a><br>';
                    }
                    else{
                        var fileOldName = datas.BugAccessoryList[j].FileName;
                        if(fileOldName == null || fileOldName == "")
                            fileOldName = datas.BugAccessoryList[j].FileUrl;
                        phtml += '<strong>附件：</strong><a href="'+datas.BugAccessoryList[j].FullFileUrl+'" title="附件"><strong>'+fileOldName+'</strong></a><br>'
                    }
                }
            }
            phtml+= '	</div>';
            phtml+= '</li>';
		}
        $("#show-ul").html(phtml);
				
        if(datas.BugAssignList.length > 0){
			var phtml = "";
			    phtml+= '<span class="fz-12">' + datas.BugAssignList[0].strCreateTime + '</span>';
                phtml+= '		<strong  class="color-0">' + datas.BugAssignList[0].OriginalUserName + '   '+ datas.BugAssignList[0].StrStatus +'</strong>';
                if(datas.BugAssignList[0].Status == 6)
                    phtml+= '(' + datas.RefuseReason + ')';
				if(datas.BugAssignList[0].NewUserName!="")
				{
					phtml+= '      指派给      <strong  class="color-0">' + datas.BugAssignList[0].NewUserName + '</strong> ';
				}
                phtml+=	"<br/>" + datas.BugAssignList[0].AssignReason;
            $("#txtCurrentDone").html(phtml);
        }

        $('.aside-problem-topbg').fadeIn(300);
        $('.aside-problem-leftbg').fadeIn(300);
        $('.aside-problem').animate({ right: '0px' }, 300)
        
        NProgress.done();
	}
    
    function playMedia(url)
    {
        layer.open({
            type: 2,
            title: false,
            area: ['630px', '360px'],
            shade: 0.8,              
            shadeClose: true,
            content: url
        });
    }

    $(function(){
        $("#btnComplete").click(btnComplete_Click);
        $("#btnPass").click(btnPass_Click);
        $("#btnNoPass").click(btnNoPass_Click);
        $("#btnClose").click(btnClose_Click);
        $("#btnRefuse").click(btnRefuse_Click);
        $("#btnPostpone").click(btnPostpone_Click);
        $("#btnDelete").click(btnDelete_Click);
        $("#btnEdit").click(btnEdit_Click);
        $("#btnAgainOpen").click(btnAgainOpen_Click);
        $("#btnCollect").click(btnCollect_Click);
        $("#btnCollectAfter").click(btnCollectAfter_Click);
        $("#btnCreateTalk").click(btnCreateTalk_Click)
    })
    //指派
    function chooseHandler() {
        $("#hidBtnType").val("choose");
        showDialogWH("指派新的处理人", "/choosehandler", "600px", "450px");
    };
    var completeH = "710px"
    //完成
    function btnComplete_Click(){
        $("#hidBtnType").val("complete");
        showDialogWH("完成", "/choosehandler", "600px", completeH);
    }
    
    //通过
    function btnPass_Click(){
        $("#hidBtnType").val("pass");
        showDialogWH("通过", "/choosehandler", "600px", "650px");
    }
    //未通过
    function btnNoPass_Click(){
        $("#hidBtnType").val("nopass");
        showDialogWH("未通过", "/choosehandler", "600px", "650px");
    }
    //关闭
    function btnClose_Click(){
        $("#hidBtnType").val("close");
        showDialogWH("关闭", "/choosehandler", "600px", "360px");
    }
    //拒绝
    function btnRefuse_Click(){
        $("#hidBtnType").val("refuse");
        showDialogWH("拒绝", "/choosehandler", "600px", "481px");
    }
    //延期
    function btnPostpone_Click(){
        $("#hidBtnType").val("postpone");
        showDialogWH("延期", "/choosehandler", "600px", "360px");
    }
                                
        var bugWidth1 = "800px";
    var bugHeight1 = "855px";   
        //再打开
    function btnAgainOpen_Click(){        
        showDialogWH("再打开", "/dialogagainopenbug", bugWidth1, bugHeight1);
    }
    //再打开
    function btnPlay_Click(url){    
        $("#hidCurrentUrl").val(url);
        showDialogWH("播放", "/videoplay", "700px", "500px");
    }
    var isown = "1";
    //状态，创建用户，当前用户，处理用户
    function btnShowOrHide(status,cUserId,nUserId,pUserId)
    {
        $("#btnClose").show();
        $("#btnRefuse").show();
        $("#btnComplete").show(); 
        $("#btnChooseHandler").show();
        $("#btnPass").show();
        $("#btnNoPass").show();
        $("#btnPostpone").show();
        $("#btnAgainOpen").show();
        $("#btnDelete").show();
        if(status == 1){         
            $("#btnPass").toggle();
            $("#btnNoPass").toggle();
            $("#btnAgainOpen").toggle();
            if(cUserId == nUserId){   
                if(nUserId != pUserId){
                    $("#btnComplete").toggle();
                    $("#btnRefuse").toggle();
                }
            }
            else if(nUserId == pUserId){
                if(isown != "0"){
                    $("#btnClose").toggle();      
                    $("#btnPostpone").toggle();
                    $("#btnDelete").toggle();
                }
            }
            else{
                if(isown != "0"){                   
                    $("#btnClose").toggle();  
                    $("#btnChooseHandler").toggle();
                    $("#btnDelete").toggle();
                    $("#btnPostpone").toggle();
                }               
                $("#btnComplete").toggle();                
                $("#btnRefuse").toggle();
            }
        }
        else if(status == 2){
            $("#btnComplete").toggle();
            $("#btnRefuse").toggle();
            $("#btnClose").toggle(); 
            $("#btnPostpone").toggle();
            $("#btnAgainOpen").toggle();
            if(cUserId != nUserId){ 
                $("#btnDelete").toggle();
            }
            if(pUserId != nUserId){ 
                $("#btnChooseHandler").toggle();
                $("#btnPass").toggle();
                $("#btnNoPass").toggle();
            }
            if(isown == "0"){    
                $("#btnChooseHandler").show();
                $("#btnPass").show();
                $("#btnNoPass").show();
                $("#btnPostpone").show();
                $("#btnClose").show(); 
                $("#btnDelete").show();
            }
        }
        else if(status == 3){
            $("#btnComplete").toggle();
            $("#btnRefuse").toggle();
            $("#btnPass").toggle();  
            $("#btnPostpone").toggle();
            $("#btnAgainOpen").toggle();
            if(pUserId != nUserId){ 
                $("#btnChooseHandler").toggle();
                $("#btnClose").toggle();
                $("#btnNoPass").toggle();
            }
            if(cUserId != nUserId){ 
                $("#btnDelete").toggle();
            }
            
            if(isown == "0"){    
                $("#btnChooseHandler").show();                
                $("#btnNoPass").show();
                $("#btnPostpone").show();
                $("#btnClose").show(); 
                $("#btnDelete").show();
            }
        }       
        else{
            $("#btnClose").toggle();
            $("#btnRefuse").toggle();
            $("#btnComplete").toggle(); 
            $("#btnChooseHandler").toggle();
            $("#btnPass").toggle();
            $("#btnNoPass").toggle();
            $("#btnPostpone").toggle();
            $("#btnAgainOpen").show();
            if(cUserId != nUserId){ 
                $("#btnDelete").toggle();
            }
        }
    }
    
    function btnDelete_Click() {
        var nUserId = parent.$("#hidCurrentUserId").val();  
        var type = "";
        if(isown != "0"){
            if(cUserId1 != nUserId){     
                layer.msg("您没有删除该bug权限");
                return;
            }
        }       
        layer.confirm('是否确认删除？', {
            btn: ['确认','取消'] //按钮
        }, function () {
            //确认时的处理
            var bugId = $("#txtCurrentBugId").val()
            apiDeleteBug(bugId)
            var pProjectId = parent.$("#txtProjectId").val();
            parent.parent.GetProjectInfoAll(pProjectId);
            parent.parent.loaddate("CreateTime",null);
            parent.parent.getcanaddbug();
        }, function () {
            //取消时的处理                
        });
    }
    
    //修改
    function btnEdit_Click(){        
        var nUserId = parent.$("#hidCurrentUserId").val();  
        var type = "";
        
        if(cUserId1 == nUserId){     
            type = "1";
        }       
        else{
            if(isown != "0"){
                                type = "2"
                            }
            else{
                type = "2"
            }
        }
       
        if(type == "1")
            showDialogWH("修改", "/dialogeditbuginfo_"+type, bugWidth1, bugHeight1);
        else
            showDialogWH("修改", "/dialogeditbuginfo_"+type, bugWidth1, bugHeight1);
    }
   
    function btnCollect_Click()
    {
        var pProjectId = parent.$("#txtProjectId").val();
        var bugId = $("#txtCurrentBugId").val();
        var nUserId = parent.$("#hidCurrentUserId").val();  
        
        apiAddBugAttention(nUserId,pProjectId,bugId);
    }
    
    function btnCollectAfter_Click()
    {        
        var bugId = $("#txtCurrentBugId").val();
        var nUserId = parent.$("#hidCurrentUserId").val();  
        
        apiRemoveBugAttention(nUserId,bugId);
    }
    
    function btnCreateTalk_Click(userIds)
    {            
        var bugId = $("#txtCurrentBugId").val();
        if(userIds == null){                          
            apiGetBugRelevantUser(bugId);
        }
        else{
            if(userIds.length <= 0){
                layer.msg("未获取bug相关人员");
                return;
            }
            var talkName = $("#txtBugCode").text() + " " + $("#txtBugTitle").text();
            
            var pProjectId = parent.$("#txtProjectId").val();            
            var strUserIds = JSON.stringify(userIds);
            apiCreateBugTalk(bugId,talkName,pProjectId,strUserIds)
              
        }
    }
    var closechatlog;
    var bugTalkW = "864px",bugTalkH="682px";
    function onBugTalkClickAfter(type,data){       
        if(type == "3"){
            var userIds = [];
            userIds.push(data.UserId);
            var strUserIds = JSON.stringify(userIds);
            apiAddBugTalkUser(data.TalkId,strUserIds);
        }
        else{          
            var bugId = $("#txtCurrentBugId").val();
            layer.open({
                type: 2 //Page层类型
                , area: [bugTalkW, bugTalkH]
                , title: "BugTalk"
                , shade: 0.6 //遮罩透明度
                , maxmin: false //允许全屏最小化
                , content: "/bugtalk_"+bugId
                ,cancel: function(){ 
                    //右上角关闭回调
                    bugTalkConnect();   
                    $("#bugtalkOnlinePage").val("currentPage")
                    layer.close(closechatlog);
                }
            });

        }
    }  
    

    function showBox(t, object) {
        var flag = $(t).attr('data-flag');
        if (flag == 0) {
            $('#' + object + '').stop().slideUp(300);
            $(t).html('显示修改日志')
            $(t).attr('data-flag', '1');
        } else {
            $('#' + object + '').stop().slideDown(300);
            $(t).html('隐藏修改日志')
            $(t).attr('data-flag', '0');
        };
    };
    var loadIndex = ""
    //侧栏触发
    var asideRight = $('.aside-problem').css('right');
    function asideShow(bid,event) {   
        $("#btnBugTalk").hide();
        $("#loadImg").remove()
        $("#pImgs").before('<img id="loadImg" src="/Templates/Default/images/wait.gif" style="margin: 0 0 0 200px;"/>')
        $("#txtCurrentBugId").val(bid);
        $(event).addClass('curr').siblings().removeClass('curr');
        NProgress.start();
    	apiGetBugInfo(bid);
        
                apiGetBugTalkIsExist(bid)
                
        $("#txtCurrentBugId1").val(bid); 
        var screenHeight = window.screen.height;
        var screenHeight = window.screen.height;
        if(screenHeight <= 864){         
            bugTalkW = "50%"
            bugTalkH = "90%"
            completeH = "90%"
        }
        if(screenHeight <= 1024){  
                        bugWidth1 = "55%";
            bugHeight1 = "95%";           
                    }
    };
    function asideHide(){
        $('.login-grag-bgv,.login-systemv').fadeOut(300);
        $("#txtCurrentTestCaseId").val("")
        $("#txtCurrentversionId").val("")
        
        $(".projectIndex .right table tr").siblings().removeClass('curr');
        $('.aside-problem-leftbg').fadeOut(300);
        $('.aside-problem-topbg').fadeOut(300);
        $('.aside-problem').animate({ right: asideRight }, 300);
    };     
    
    
    
  
	    function bindBugs(datas) {
            $(".tr-body").remove();
			$("#lblNums").text(datas.TotCount);

            var phtml = "";
            for (var i = 0; i < datas.TotCount; i++) {
                phtml += '<tr onclick="asideShow(\''+datas.ItemList[i].BugId+'\',this);" class="tr-body">';
                phtml += '	<td class="td-first">' + datas.ItemList[i].BugCode + '</td><td>';
                if(datas.ItemList[i].BugType == 1)
                    phtml+='<span class="text-bg textbg-1">';
                else if(datas.ItemList[i].BugType==2)
                    phtml+='<span class="text-bg">';
                else if(datas.ItemList[i].BugType==3)
                    phtml+='<span class="text-bg textbg-3">';
                else
                    phtml+='<span class="text-bg textbg-2">';
                phtml+=datas.ItemList[i].StrBugType+'</span></td>';
              
                phtml += '	<td class="ta-left">';
                phtml += '		<div class="td-tit color-2">';
                if(datas.ItemList[i].ProductName!=null)
                    phtml += '    		<i class="iconfont '+datas.ItemList[i].IconProdPlat+'"> </i> <span>' + datas.ItemList[i].ProductName + ' '+datas.ItemList[i].ModuleName+'</span> ';
                else
                    phtml += '        	<span>未指定</span> ';
                if(datas.ItemList[i].PicCount>0&&datas.ItemList[i].AttachmentCount>0){
                    phtml+='<i class="iconfont icon-tupian" ></i><i class="iconfont icon-fujian"></i>';
                }else if(datas.ItemList[i].PicCount>0)
                {
                    phtml+='<i class="iconfont icon-tupian" ></i>';
                }else if(datas.ItemList[i].AttachmentCount>0)
                {
                    phtml+='<i class="iconfont icon-fujian"></i>';
                }
                phtml += '			'+datas.ItemList[i].BugTitle;
                                phtml += '		</div>';
                phtml += '	</td>';
               
                if(datas.ItemList[i].BugStatus==1)
                    phtml+='<td><span class="text-bg textbg-1">';
                else if(datas.ItemList[i].BugStatus==2)
                    phtml+='<td><span class="text-bg textbg-2">';
                else if(datas.ItemList[i].BugStatus==4)
                    phtml+='<td><span class="text-bg textbg-3">';
                else
                    phtml+='<td><span class="text-bg">';
                phtml+=datas.ItemList[i].StrBugStatus+'</span></td>';

                if (datas.ItemList[i].Priority == 1) {
                    phtml += '	<td><span class="text-bg textbg-1">急</span></td>';
                } else if (datas.ItemList[i].Priority == 2) {
                    phtml += '	<td><span class="text-bg textbg-2">高</span></td>';
                } else if (datas.ItemList[i].Priority == 3) {
                    phtml += '	<td><span class="text-bg">中</span></td>';
                } else {
                    phtml += '	<td><span class="text-bg textbg-3">低</span></td>';
                }
                phtml += '	<td>' + datas.ItemList[i].ProcessingUserName + '</td>';
                phtml+='<td>'+datas.ItemList[i].StrCreateTime+'</td>';
                phtml+='<td class="td-last">'+datas.ItemList[i].StrModifyTime+'</td></tr>';
                                            }
            $(".tr-head").after(phtml);
        }
  
//提交问题

function addNewProblem(){
	$("#layui-layer-shade5").show();
	$("#layui-layer5").show();
	$(function(){
  $("#moduleInfo").click(function(){
  	$("#box-module").show();
  	$(".wrap-grag-bg.d-none").show();
	
})
  $(".box li").click(function(){
  	   $(this).addClass("active").siblings("li").removeClass("active");
  	   $("#box-module").hide();
  	   $(".wrap-grag-bg.d-none").hide();
  	   
  })
 $("#box-module").blur(function(){
 	$("#box-module").hide();
  $(".wrap-grag-bg.d-none").hide();
 })
 
  
$("#userInfo").click(function(){
	
	$.ajax({
		type : "get",
		url : "/bugmanage/user/getSimpleHandler?pid=" + $('#itemsid').text(),
		async : false,
		data : JSON,
		success : function(data) {
			var obj=data.list;
			var html="";
			html+="  <div class=\"name userNameBox\"><i class=\"iconfont icon-arrow\"></i><label>默认分组</label></div><div class=\"box\" id=\"handler-box\"></div><ul>";
			for(var i=0;i<obj.length;i++){
	           html+="<li class=\"userLi\"><div class=\"li-user\" uid=\""+obj[i].uid+"\"><img src=\"../"+obj[i].pic+"\">"+obj[i].username+"</div></li>";
			}
			html+="</ul></div>";
			$("#box-handle").html(html);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			alert("服务器繁忙！");
		},
	})
		$("#box-handle").show();
		$(".wrap-grag-bg.d-none").show();
		})
		$(".box li").click(function(){
  	   $(this).addClass("active").siblings("li").removeClass("active");
  	   $("#box-handle").hide();
  	   $(".wrap-grag-bg.d-none").hide();
  	   
  })

	})
	
	$("#box-handle").blur(function(){
 	$("#box-handle").hide();
  $(".wrap-grag-bg.d-none").hide();
 })
	$(".btn-at").click(function(){
		$("#box-handle").show();
		 $(".wrap-grag-bg.d-none").show();
	})
	$(".text").click(function(){
  var $this = $(this),
     index = $this.index();
     $(this).eq(index).siblings(".optbox").toggle();
     
  })
   }



//提交AJAX写在这  还有你之前写的都放这里 