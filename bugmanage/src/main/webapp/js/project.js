
        var priopage=0;
        var mtimepage=0;
        function asideProjectShow(){
            GetFixeddata();
            GetPdate();
            $('.aside-project-click').fadeOut(300);
            $('.aside-project-info').animate({right:0},300);
            $('#ascrail2001').css({left:'inherit'}).show();
        };
        function asideProjectHide(){
            $('.aside-project-info').animate({right:-460},300);
            setTimeout(function(){
                $('.aside-project-click').fadeIn(300);
            },300);
            $('#ascrail2001').hide();
            priopage=0;
            mtimepage=0;
        };
         
        function GetFixeddata(){//开头的数据统计和报表
            var datas = "method=getcount";
            jQuery.ajax({
                type:"POST",
                url:"/Service/ProductControlService.ashx",
                data:datas,
                success:function(msg){
                    if(msg!="-1")
                    {
                        var obj=jQuery.parseJSON(msg);
                        $("#cpcount").html(obj.count.CreatePCount);
                        $("#pccount").html(obj.count.PartakeCount);
                        $("#tdcount").html(obj.count.TodoCount);
                        $("#sdcount").html(obj.count.SolvedCount);
                        $("#ctcount").html(obj.count.CreateBCount);
                        BindChart1(obj.rv.rv1);
                    }else
                    {
                        window.location.href = "/login";
                    }
                }
            })
        }
        function GetPdate(){
            var datas = "method=getprojectbug";
            jQuery.ajax({
                type:"POST",
                url:"/Service/ProductControlService.ashx",
                data:datas,
                success:function(msg){
                    if(msg!="-1")
                    {
                        msg=jQuery.parseJSON(msg);
                        BindPBug(msg);
                    }else
                    {
                        window.location.href = "/login";
                    }
                }
            })
        }
//关于
    	function aboutClick(){
			$('.about-grag-bg,.about-system').fadeIn(300);
		};        
		function closeAbout(){
			$('.about-grag-bg,.about-system').fadeOut(300);
		};
        function openPackages(){
            showDialogWH("用户套餐", "/packages", iPWidth, iPHeight);
    	};
    	 //套餐
        function packageClick(){           
        	$('.package-grag-bg,.package-system').fadeIn(300);
		};
        //关闭套餐
        function closePackage(){
    		$('.package-grag-bg,.package-system').fadeOut(300);
		};
		  function opencode(){
            $('.code-grag-bg,.code-system').fadeIn(300);
       };
        function closecode(){
            $('.code-grag-bg,.code-system').fadeOut(300);
        };
    //切换大小图标
        $('#tabShow').on('click', 'li', function () {
            var i = $(this).attr('data-id') - 1;
            iconType = i;
            changetbl(i+1);
            jQuery.cookie('bugdone_tabchange', i, { expires: 100 }); 
            $(this).addClass('on').siblings().removeClass('on');
            $('#tabBox').find('.p-cont').eq(i).fadeIn(300).siblings().removeClass('animated bounceInUp').hide();
             apiGetUserInfo();
        });
        
        hoverShow('#hoverShow1', '.show-box');
        hoverShow('#hoverShow2', '.show-box');

        //经过显示方法封装5
        function hoverShow(t, object) {
            $(t).hover(function () {
                $(this).find(object).fadeIn(300);
                $(this).find('.icon-arrow-copy').addClass('rotate180');
            }, function () {
                $(this).find(object).stop().fadeOut(300);
                $(this).find('.icon-arrow-copy').removeClass(' rotate180');
            });
        };
        
        var loginfrom=1;
        var canaddproject="0";
        $(function () {
                        loginfrom="";
            apiGetUserInfo();
            getcanaddproject();
            var screenHeight = window.screen.height;
            if(screenHeight <= 864){
                iPWidth = "55%";
                iPHeight = "90%";
                projectWidth = "70%";
                projectHeight = "90%"
                bugTalkW = "50%"
                bugTalkH = "90%"
            }
        });
        
        function getcanaddproject(){
            var datas = "method=CanCreateProject";
            jQuery.ajax({
                type:"POST",
                url:"/Service/UserPackageService.ashx",
                data:datas,
                success:function(msg){
                    var obj=jQuery.parseJSON(msg);
                    if(obj.result>0)
                        canaddproject=0;
                    else if(obj.result==0){
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
                    else
                        canaddproject=obj.count;
                }
            })
        }
