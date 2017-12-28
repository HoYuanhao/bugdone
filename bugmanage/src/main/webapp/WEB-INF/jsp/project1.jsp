<!DOCTYPE html>
<html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.qcit.model.ProjectVo" %>
<%@ page import="com.qcit.model.SimpleProblemVo"%>
<%@ page import="com.qcit.util.DateUtil"%>
<%@ page import="com.qcit.util.StringUtil"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

  <head>
   <meta charset="utf-8">
   	<title>工作台-项目概况</title>
	    <link rel="stylesheet" type="text/css" href="../css/iconfont.css"/>
		<link rel="stylesheet" type="text/css" href="../css/animate.css"/> 
		<link rel="stylesheet" type="text/css" href="../css/base.css"/>
		<link rel="stylesheet" href="../css/layer.css" type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/bugdone.css"/>
		<link rel="stylesheet" type="text/css" href="../css/animate.min.css"/>
		<link rel="stylesheet" type="text/css" href="../css/bugdone1.css"/>
		<link rel="stylesheet" type="text/css" href="../css/nprogress.css"/>
		<script src="../js/index.js" type="text/javascript"></script> 
		<script src="../js/index1.js" type="text/javascript"></script> 
	<script src="../js/extends.js" type="text/javascript"></script>
		<script src="../js/jquery-3.2.1.min.js" type="text/javascript"></script>
	 </head>
	<input type="hidden" id="hidtype" value="1" />
    <input type="hidden" id="txtProjectId" value="" />
    <input type="hidden" id="txtNeedRefesh" value="0" />
    <input type="hidden" id="hidCurrentUserId" value="" />
    <div class="header bg-white">
        <div class="logo f-l" style="cursor: pointer;" onclick="window.location.href='https://www.bugdone.cn/home'">
            <img src="../image/logo.png" alt="BUGDONE" />
        </div>
        <div class="head-nav f-l color-8">
            <span class="color-2 f-l p-relative cursorpointer" onclick="backToConsole();" >
               <i class="iconfont icon-arrow-right f-r"></i><i class="iconfont icon-liebiao" style="font-size: 1rem; margin-left: -1.4rem;"> </i> 项目        
            			</span>
            <span class="color-2 f-l p-relative" id="hoverShow1">
                <strong><i class="iconfont icon-arrow-copy p-absolute"></i><label></label></strong>
                <div class="show-box2 p-absolute bg-white bd-e2 b-radius4 d-none" id='showlist' style='max-height:400px;overflow:auto;'>
                </div>
            </span>
            <p class="search f-l p-relative">
                <input name="" id='seartxt' type="text" class="textbox" onkeypress="return check()"  value="根据编号、标题、模块搜索" onblur="this.value=(this.value=='')?'根据编号、标题、模块搜索':this.value" onfocus="this.value=(this.value=='根据编号、标题、模块搜索')?'':this.value">
                <input name="" type="button" class="iconfont search-btn p-absolute color-8" onclick='search()' value="">
            </p>
            <span style="color:red"></span>
        </div>

        <div class="user-info f-r p-relative" id="hoverShow2">
            <div class="avatar p-absolute loaduserdiv">
            
                            <i class="online-status" id="bugtalkStatus"></i>
                <img id="imgUser" src="../image/22.png" alt="" class='loaduser' />
                <style>
                    .loaduser{width:100% !important;height:100% !important;}
                    .loaduserdiv{top:5px !important;left:10px !important;}
                    .online-status{width: 8px;height: 8px;border-radius: 50%;border: 2px solid #fff;position: absolute;right: -10px; top: 0;background: #1ab064}
                    .online-status-off{background:#ababab}
                </style>
            </div>
             <style>
                    .filter li .box input[type=radio]{width:15px;height:15px;border:1px solid #c1ccda; -webkit-appearance:none; background:#fff url(/Templates/Default/images/check.png) no-repeat -13px 3px;margin:10px 10px 0px 0px;float:left;}
                    .filter li .box input[type=radio]:checked{ background:#fff url(../image/check.png) no-repeat 2px 3px;border:1px solid #0892e1;}
                    .filter li .box label:hover input[type=radio]{border:1px solid #0892e1;background:#fff url(../image/check.png) no-repeat 2px 3px;}
                </style>
                <script>
                    function recheck(name,obj){
                        $(obj).addClass('on');
                        $("input[name='"+name+"']").removeAttr("checked");
                        $("input[name='"+name+"']").parent('label').removeClass('on');
                        $(obj).closest('li').find('span').text("全部").css('color','#264d79');
                        if(name=="pro")
                        {
                            $("#modleli").find('label:first').addClass('on');
                            $("input[name='mod']").removeAttr("checked");
                            $("input[name='mod']").parent('label').removeClass('on');
                            $("#modleli").find('label:first').closest('li').find('span').text("全部").css('color','#264d79');
                            $(".moduleclass").html("");
                            $("#modleli").hide();
                            
                        }else
                        {
                            loaddate();
                        }
                    }
                
                    $('.filter').on('click', 'input[type=checkbox]', function () {
                        $(this).closest('li').find('span').text("全部").css('color','#264d79');
                        if ($(this).is(':checked')) {
                            $(this).parent('label').addClass('on');
                            $(this).parent('label').parent('div').find('label:first').removeClass('on');
                        } else {
                            $(this).parent('label').removeClass('on');
                        };
                        if($(this).attr("name")=="pro")
                        {
                            getselectmodule();
                            $("#modleli").show();
                        }
                        page=1;
                        loaddate();
                    });
                    $('.filter').on('click', 'input[type=radio]', function () {
                        if ($(this).is(':checked')) {
                            $(this).parent('label').siblings().removeClass('on');
                            $(this).parent('label').addClass('on');
                        } else {
                            $(this).parent('label').removeClass('on');
                        };
                        var showtext=$(this).parent('label').text();
                        if(showtext!="全部")
                            $(this).closest('li').find('span').text(showtext).css('color','#f34949');
                        else
                            $(this).closest('li').find('span').text(showtext).css('color','#264d79');
                        page=1;
                        loaddate();
                    });
                    $('.filter').on('click', '.btn', function () {
                        $(this).siblings('.box').toggleClass('show');
                        $(this).parents('li').siblings('li').find('.box').removeClass('show');
                    });
                    $('.filter').on('click', function (e) {
                        e.stopPropagation();
                    });
                    $(document).on('click', function () {
                        $('.filter').find('.box').removeClass('show');
                    });
                    
                    function loadBugList(sortey,obj)
                    {    
                        sortKey=sortey;
                        if(sortValue=="asc")
                            sortValue="desc";
                        else
                            sortValue="asc";
                		$(".tr-head a").removeClass("top-on");
            			$(".tr-head a").removeClass("bottom-on");
            
            			if(obj!=null)
            			{
            				if(sortValue=="asc")
            				{
                                $(obj).find("a").addClass("top-on");
            				}else{
            					$(obj).find("a").addClass("bottom-on");
            				}
            			}
                        loaddate();
            		}
                </script>
                
            <div class="name fz-14 fw-bold p-relative">
                <i class="iconfont icon-arrow-copy p-absolute"></i>
                <div id="lblUser" style='min-width:44px;min-height:10px'>${user.username}</div>
                <div id="userinfo" class="show-box p-absolute bg-white bd-e2 b-radius4 d-none fz-14">
                    <div class="avatar1 p-absolute" onclick="changePhoto();">
                        <img id="imgUserEdit" src="../image/22.png" alt="" />
                       
                        <span class="changeBj" style="display: none;"></span>
                        <span class="changeTxt" style="display: none;">修改头像</span>
                    </div>
                    <br>
                    <a href="javascript:void(0)" onclick="changeUserEmail();" class="logout"><i class="iconfont icon-youxiang"></i>修改邮箱</a>
                    <a href="javascript:void(0)" onclick="changeUserName();"><i class="iconfont icon-name"></i>修改姓名</a>
                    <a href="javascript:void(0)" onclick="changeUserPassword();"><i class="iconfont icon-lock"></i>修改密码</a>
                    <a href="javascript:void(0)" onclick="openlogin();" class="logout"><i class="iconfont icon-shouji"></i>手机登陆</a>
                    <a href="javascript:void(0)" onclick="logout();"><i class="iconfont icon-tuichu"></i>退出</a>
                </div>
            </div>
        </div>
        <div class="f-r notice p-relative" style='display:none'>
            <span class="num textbg-1 ta-center p-absolute">2</span>
            <a href="#" title="消息"><i class="iconfont icon-tongzhi"></i></a>
            </div>
            <!--关于-->
            <div class="f-r">
            	<i class="iconfont icon-banben" onClick="aboutClick()" style="margin: -0.2rem 1.5rem;"  title="关于BugDone"></i>
            </div>
            <div class="f-r">
                <i class="iconfont icon-huiyuanquanyi" id="userPackage" onClick="packageClick()" title="了解付费版本"></i>
            </div>
            <!--二维码-->
            <div class="f-r shouji">
                <i class="iconfont icon-shouji" style="margin: -0.2rem 1.9rem 0 .5rem;font-size: 24px;line-height:64px;cursor:pointer;" onclick='opencode()' title="扫一扫"></i>
            </div>
                        <!--新消息-->
            <div class="f-r chardiv">
                <i class="iconfont icon-chat1" style="margin: -0.2rem 1rem 0 .5rem;font-size: 24px;line-height:65px;cursor:pointer;" onclick='getchat()' title="暂无新消息"></i>
            </div>
                    <!--二维码弹出窗-->
        <style>
            .code-grag-bg{width:100%;height:100%; position:fixed; background:url(../image/rgba0_25.png);left:0;top:0; z-index:90;}
            .code-system{width:410px; position:absolute;top:50%;height:13rem; overflow:hidden;margin-top:-160px;left:50%;margin-left:-305px; background:#fff; z-index:99;border-radius:6px;padding:3rem 0 0 3rem}
            .code-system .icon-guanbi1{ font-size:24px; position:absolute;right:10px;top:20px; cursor:pointer;}
            .code-system .icon-guanbi1:hover{color:#264d79;}
            .imgdiv{float:left}
            
            .filter li .box label{overflow:hidden;text-overflow:ellipsis;white-space: nowrap; }
        </style>
        <div class="code-grag-bg d-none" onClick="closecode()"></div>
        <div class="code-system d-none" style='width:580px'>
            <i class="iconfont icon-guanbi1 color-8" onclick="closecode()" style="margin-right: 20px;"></i>
            <div class='imgdiv'><img src='../image/phonebugdone.png' style='width:10rem'><span style='position: absolute;top: 13.5rem;left: 5rem;'>bugdone手机端</span></div>
            <div style="float:left;border: 1px solid #0c8bb5;height: 11rem;margin: 0 1rem;"></div>
            <div class='imgdiv'><img src='../image/wechat.jpg' style='width:10rem'><span style='position: absolute;top: 13.5rem;left: 17.6rem;'>bugdone公众号</span></div>
            <div style="float:left;border: 1px solid #0c8bb5;height: 11rem;margin: 0 1rem;"></div>
            <div class='imgdiv'><img src='../image/xiaochengxu.jpg' style='width:10rem'><span style='position: absolute;top: 13.5rem;right: 4.1rem;'>bugdone小程序</span></div>
        </div>
        <!--手机登录弹出窗-->
        <style>
            .login-grag-bg{width:100%;height:100%; position:fixed; background:url(../image/rgba0_25.png);left:0;top:0; z-index:90;}
            .login-system{width:200px; position:absolute;top:50%;height:12rem; overflow:hidden;margin-top:-160px;left:60%;margin-left:-305px; background:#fff; z-index:99;border-radius:6px;padding:3rem 0 .5rem 2.2rem}
            .login-system .icon-guanbi1{ font-size:24px; position:absolute;right:10px;top:20px; cursor:pointer;}
            .login-system .icon-guanbi1:hover{color:#264d79;}
        </style>
        <div class="login-grag-bg d-none" onClick="closelogin()"></div>
        <div class="login-system d-none">
            <i class="iconfont icon-guanbi1 color-8" onclick="closelogin()" style="margin-right: 20px;"></i>
            <div class='imgdiv'><img id='logincodeimg' src='' style='width:10rem'><span style="position: absolute;top: 13.5rem;padding: 0 1.5rem;left: .7rem;">该登录二维码含有您的个人信息，请勿转发给其它用户。</span></div>
        </div>
        <!--关于弹出窗-->
        <style>
            .about-grag-bg,.package-grag-bg{width:100%;height:100%; position:fixed; background:url(../image/rgba0_25.png);left:0;top:0; z-index:90;}
        </style>
        <div class="about-grag-bg d-none" onClick="closeAbout()"></div>
        <div class="about-system d-none">
            <div class="logo"><img src="../image/logo.png" style="display: initial;" /></div>
            <div class="info">
            	<i class="iconfont icon-guanbi1 color-8" onClick="closeAbout()" style="margin-right: 20px;"></i>
            	<h1>BUGDONE，bug管理系统</h1>
                <p>版本号：V1.0.0.1.BETA</p>
                <p><a href="/newslist/" class="button">版本更新日志</a></p>
                <p class="copyright">奇创科技创新团队所有<br />bugdone.cn</p>
            </div>
        </div>     
        <div class="package-grag-bg d-none" onClick="closePackage()"></div>
        <div class="package-system d-none">
            <div class="logo"><img src="../images/logo.png" style="display: initial;" /></div>
            <div class="info">
                <i class="iconfont icon-guanbi1 color-8" onClick="closePackage()" style="margin-right: 20px;"></i>
            	<h1>BugDone现已永久免费</h1>         
                <p style="height: 40px;line-height: 40px;margin: 15px 0px 50px 0px;color:#264d79">无限项目数、无限成员数，无限bug数</p>
                <p class="copyright">如有疑问欢迎联系BugDone团队<br />Email：support@bugdone.cn</p>
            </div>
        </div>
        <!--        
        <div class="f-r notice p-relative">
            <span class="num textbg-1 ta-center p-absolute">2</span>
            <a href="#" title="消息"><i class="iconfont icon-tongzhi"></i></a>
        </div>
        -->
    </div>
    <input type="hidden" value="currentPage" id="bugtalkOnlinePage"/>
    <!--header-->
    
 
  
    <div class="projectIndex p-relative of-hidden">
        

    <style>
        #project-left{height:100% !important}
    </style>
    <div class="left p-absolute bg-white" id="project-left" style='border-right:none;overflow: auto;'>
            <div class="project-logo p-relative" style='min-height:54px'>
                <a  href="javascript:void(0)" onclick="changeSetting();" class="setup p-absolute color-8" title="设置"><i class="iconfont icon-iconshezhi01"></i></a>
                <img id="imgProjectImg" src="../image/logoshort0.png" class="d-block of-hidden projectpics" />
                <style>
                    .projectpics{width: 30%;height: 30% !important;margin-top: 16px !important;}
                     .screen1{line-height:300% !important;height:300% !important;}
                    .screen2{margin-top:6% !important}
                    .screen3{margin:7% 15px 0px 0px !important}
                    .rightshow{padding:0 20px}
                </style>
               <label id="itemsid" style="display:none;" >${itemsid}</label>
            </div>
            <div class="menu fz-14">
                <ul>
                    <li class="on">
                    	<a href="project1?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<i class="icon-gk"></i>项目概况
                    	</a>
                    
                    </li>
                    <li>
                    	<a href="javascript:void(0)"  onclick="active_Problem()" id="active_Problem">
                    		<span class="num f-r n-bg1" id="lblUnsolvedProblemNum">${actionnumber}</span>
                    		<i class="icon-wt"></i>活动问题
                    	</a>
                    </li>
                    <li>
                    	<a href="javascript:void(0)"  onclick="all_Problem()" id="all_Problem">
                    		<i class="icon-all"></i>所有问题
                    	</a>
                    </li>
                    <li>
                    	<a href="javascript:void(0)"  onclick="stat_Problem()" id="stat_Problem">
                    		<i class="icon-tongji"></i>问题统计
                    	</a>
                    </li>
                </ul>
                <ul>
                    <li>
                    	<a href="javascript:void(0)"  onclick="my_Problem()" id="my_Problem">
                    		<span class="num f-r n-bg2" id="lblMyToDoProblemNum">${problemnumber}</span>
                    		<i class="icon-daiban"></i>我的待办
                    	</a>
                    </li>
                    <li>
                     <a href="javascript:void(0)"  onclick="handler_me()" id="handler_me">
                    		<i class="icon-fenpei"></i>分配给我
                    	</a>
                    </li>
                    <li>
                    	  <a href="javascript:void(0)"  onclick="my_handler()" id="my_handler">
                    		<i class="icon-myfp"></i>我的分配
                    	</a>
                    </li>
                </ul>
                <ul>
                     <li>
                     	  <a href="javascript:void(0)"  onclick="edition_manage()" id="edition_manage">
                     		<i class="icon-fb"></i>版本管理
                     	</a>
                     </li>
                    <li>
                    	  <a href="javascript:void(0)"  onclick="application_center()" id="application_center">
                    		<i class="icon-yingyong"></i>应用中心
                    	</a>
                    </li>                                                         
                </ul>
            </div>
        </div>






<div id="projectright">
        <div class="right" id="project-right" style="height: 750px;overflow:auto;">

            <div class="mw-900 rightshow">
                <div class="head-tit">
                    <div id ="fz" class="fz-22 f-l">项目概况</div>
                   
                    <div class="head-btn f-r fz-14">
                        <div   style='display:none'   class="button bg-1 animated bounceIn" onclick="changeSetting();">
                        	<i class="iconfont icon-iconshezhi01"></i>项目配置
                        </div>
                        <!--<div class="button bg-2 animated bounceIn"><i class="iconfont icon-tongzhi"></i>发布通知</div>-->
                        <div class="button bg-3 animated bounceIn"  onclick="addNewVersion()">
                        	<i class="iconfont icon-banben"></i>发布版本
                        </div>
                        <div class="button animated bounceIn bg-white submit" onclick="addNewProblem()" id="newProblem">
                        	<i class="iconfont icon-bianji"></i>提交问题
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>

                <div class="data-info bg-white b-radius4 bs-08 of-hidden animated flipInX">
                    <ul class="ta-center clearfix">
                        <li>
                        	<a href="/allbug_6f917cc1f60d4cad85909737e5644eb9">
                        	<strong id="lblTotProblemNum">
                        	<c:if test="${empty project.sumproblem}">0</c:if>
                        	<c:if test="${not empty project.sumproblem}">${project.sumproblem }</c:if></strong>
                        	<span class="color-a">问题总数</span>
                            </a>
                        </li>
                        <li>
                        	<a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/4/0">
                        		<i class="line"></i>
                        		<strong style="color: #2dc26c;" id="lblSolvedProblemNum"><c:if test="${empty project.resolved}">0</c:if>
                        	<c:if test="${not empty project.resolved}">${project.resolved }</c:if></strong>
                        		<span class="color-a">已解决</span>
                        	</a>
                        </li>
                        <li>
                        	<a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/1/0">
                        		<i class="line"></i>
                        		<strong style="color: red;" id="lblOpenProblemNum"><c:if test="${empty project.unsolved}">0</c:if>
                        	<c:if test="${not empty project.unsolved}">${project.unsolved }</c:if></strong>
                        		<span class="color-a">未解决</span>
                        	</a>
                        </li>
                        <li>
                        	<a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/2/0">
                        		<i class="line"></i>
                        		<strong style="color: #f6981d;" id="lblToApproveProblemNum"><c:if test="${empty project.audit}">0</c:if>
                        	<c:if test="${not empty project.audit}">${project.audit }</c:if></strong>
                        		<span class="color-a">待审核</span>
                        	</a>
                        </li>
                        <li>
                        	<a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/3/0">
                        		<i class="line"></i>
                        		<strong id="lblReOpenProblemNum"><c:if test="${empty project.rejected}">0</c:if>
                        	<c:if test="${not empty project.rejected}">${project.rejected }</c:if></strong>
                        		<span class="color-a">已拒绝</span>
                        	</a>
                        </li>
                        <li>
                        	<a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/5/0">
                        	<i class="line"></i>
                        	<strong class="color-8" id="lblClosedProblemNum"><c:if test="${empty project.closed}">0</c:if>
                        	<c:if test="${not empty project.closed}">${project.closed }</c:if></strong>
                        	<span class="color-a">已关闭</span>
                        	</a>
                        </li>
                        <li>
                        	<a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/6/0">
                        		<i class="line"></i>
                        		<strong class="color-8" id="lblPostponeProblemNum"><c:if test="${empty project.postponed}">0</c:if>
                        	<c:if test="${not empty project.postponed}">${project.postponed }</c:if></strong>
                        		<span class="color-a">已延期</span>
                        	</a>
                        </li>
                    </ul>
                </div>
               
                <div class="chart-bar">
                      <span>
                      	<i class="iconfont icon-baobiaozhongxin" style="font-size: 20px;"></i>
                      	<i class="iconfont icon-arrow-copy" style="font-size: 20px;top: 25%;"></i></span>
                </div>
                
                <div class="chart-list bs-08 b-radius4 d-none" style="margin-top: 20px;">
              		<div class="chart-box">
                    	<div class="chart-tab" style="z-index:1">
                        	<ul>
                            	<li class="active" onclick="LoadUnsoleRF('人员',this)">按人员</li>
                            	<li onclick="LoadUnsoleRF('产品',this)">按产品</li>
                            </ul>
                        </div>               
                        <div class="mtitle">未解决问题</div>
                        <div class="chart-info" style='height:245px;padding: 0 0 0 10%;' id="UnsolveBug">
                        </div>
                    </div>
              		<div class="chart-box">
                    	<div class="chart-tab" style="z-index:1">
                        	<ul>
                            	<li class="active" onclick="LoadReviewRF('人员',this)">按人员</li>
                            	<li onclick="LoadReviewRF('产品',this)">按产品</li>
                            </ul>
                        </div>
                        <div class="mtitle">待审核问题</div>
                        <div class="chart-info" style='height:245px;padding: 0 0 0 10%;' id="ReviewBug">
                        </div>
                    </div>
              		<div class="chart-box">
                    	<div class="chart-tab" style="z-index:1">
                        	<ul>
                            	<li class="active" onclick="LoadSoledRF('人员',this)">按人员</li>
                            	<li onclick="LoadSoledRF('产品',this)">按产品</li>
                            </ul>
                        </div>
                        <div class="mtitle">已解决问题</div>
                        <div class="chart-info" style='height:245px;padding: 0 0 0 10%;' id="SolvedBug">
                        </div>
                    </div>
              		<div class="chart-box">
                        <div class="mtitle">问题状态比例</div>
                        <div class="chart-info" style='height:245px;padding: 0 0 0 10%;' id="BugStatus">
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <style>
                    .mtitle{ font-size:14px; color:#333;font-weight:bold; height:44px; line-height:44px; overflow:hidden; padding-left:15px;}
                    .chart-list .chart-info{padding:0}
                    .highcharts-credits { display: none; }
                    .chart-bar .icon-rotate-animate{top:17% !important}
                </style>
                <div class="problem-list bg-white bs-08 b-radius4 of-hidden animated bounceInUp" style="margin-top: 20px;">
                    <div class="title fz-16">最新问题<span class="fz-12 color-8">共<label id="lblNums"></label>${fn:length(project.list)}条记录</span></div>
                    <table width="100%" cellpadding="0" cellspacing="0" class="ta-center color-8">
                         <tr class="tr-head">
                            <!--bottom-on选中降序  top-on选中升序-->
                            <td class="td-first" nowrap style="width: 65px;"><a href="../items/itemssort?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}&&type=1&&action=p1&&order=${order}" class="top-on"><span class="icon"><i class="iconfont icon-top" onclick="loaddate('BugCode',this);"></i><i class="iconfont icon-bottom" onclick="loaddate('BugCode',this);"></i></span>编号</a></td>
                            <td nowrap style="width: 55px;"><a href="../items/itemssort?id=${itemsid }&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}&&type=2&&action=p1&&order=${order}" class="bottom-on"><span class="icon"><i class="iconfont icon-top" onclick="loaddate('BugType',this);"></i><i class="iconfont icon-bottom" onclick="loaddate('BugType',this);"></i></span>类型</a></td>
                            <td class="ta-left" style="width: 750px;"><a href="#" class="top-on">标题</a></td>
                            <td nowrap style="width: 55px;"><a href="../items/itemssort?id=${itemsid }&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}&&type=3&&action=p1&&order=${order}" class="top-on"><span class="icon"><i class="iconfont icon-top" onclick="loaddate('BugStatus',this);"></i><i class="iconfont icon-bottom" onclick="loaddate('BugStatus',this);"></i></span>状态</a></td>
                            <td nowrap style="width: 65px;"><a href="../items/itemssort?id=${itemsid }&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}&&type=4&&action=p1&&order=${order}"><span class="icon"><i class="iconfont icon-top" onclick="loaddate('Priority',this);"></i><i class="iconfont icon-bottom" onclick="loaddate('Priority',this);"></i></span>优先级</a></td>
                            <td nowrap style="width: 65px;"><a href="../items/itemssort?id=${itemsid }&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}&&type=5&&action=p1&&order=${order}" class="top-on"><span class="icon"><i class="iconfont icon-top" onclick="loaddate('ProcessingUserId',this);"></i><i class="iconfont icon-bottom" onclick="loaddate('ProcessingUserId',this);"></i></span></a>指派给</td>
                            <td nowrap style="width: 83px;"><a href="../items/itemssort?id=${itemsid }&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}&&type=6&&action=p1&&order=${order}"><span class="icon"><i class="iconfont icon-top" onclick="loaddate('CreateTime',this);"></i><i class="iconfont icon-bottom" onclick="loaddate('CreateTime',this);"></i></span>创建时间</a></td>
                            <td nowrap style="width: 94px;" class="td-last"><a href="../items/itemssort?id=${itemsid }&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}&&type=7&&action=p1&&order=${order}" class="bottom-on"><span class="icon"><i class="iconfont icon-top" onclick="loaddate('ModifyTime',this);"></i><i class="iconfont icon-bottom" onclick="loaddate('ModifyTime',this);"></i></span>修改时间</a></td>
                         </tr> 
                         <c:if test="${not empty project.list}">
                         <c:forEach items="${project.list }" var="problem">
                      
                         	<tr onclick="asideShow('dd4f672c4524414ab55352e7d39ee6ea',this);" class="tr-body">	
                         	<td class="td-first">${problem.id }</td>
                         	
                         	<td>
                         	<c:if test="${problem.type==1}"><span class="text-bg textbg-1">缺陷</span></c:if>
                         	<c:if test="${problem.type==2}"><span class="text-bg ">改进</span></c:if>
                         	<c:if test="${problem.type==3}"><span class="text-bg textbg-1">任务</span></c:if>
                         	<c:if test="${problem.type==4}"><span class="text-bg textbg-1">需求</span></c:if>
                    
                         	</td>	
                         	<td class="ta-left"><div class="td-tit color-2">  <i class="iconfont "> </i> <span>
                         	<c:if test="${empty problem.product}">默认产品</c:if>
                         	<c:if test="${not empty problem.product}">${problem.product }</c:if>
                         	</span><c:if test="${empty problem.headline}"> </c:if>
                         	<c:if test="${not empty problem.headline}">${problem.headline }</c:if>
                         	</div></td><td>
                         	<c:if test="${problem.state==1}"><span class="text-bg textbg-1">未解决</span></c:if>
                         	<c:if test="${problem.state==2}"><span class="text-bg ">待审核</span></c:if>
                         	<c:if test="${problem.state==3}"><span class="text-bg textbg-1">已拒绝</span></c:if>
                         	<c:if test="${problem.state==4}"><span class="text-bg textbg-2">已解决</span></c:if>
                         	<c:if test="${problem.state==5}"><span class="text-bg textbg-1">已关闭</span></c:if>
                         	<c:if test="${problem.state==6}"><span class="text-bg ">已延期</span></c:if>
                         	</td>	
                         	<td>
                         	<c:if test="${problem.priority==1}"><span class="text-bg textbg-1">急</span></c:if>
                         	<c:if test="${problem.priority==2}"><span class="text-bg textbg-2">高</span></c:if>
                         	<c:if test="${problem.priority==3}"><span class="text-bg textbg-3">中</span></c:if>
                         	<c:if test="${problem.priority==4}"><span class="text-bg textbg-4">低</span></c:if>
                         	</td>	<td>	<c:if test="${empty problem.handlerName}"></c:if>
                         	<c:if test="${not empty problem.handlerName}">${problem.handlerName }</c:if></td>
                         	<td><fmt:formatDate value="${problem.createtime }" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
                         	<td class="td-last"><fmt:formatDate value="${problem.updatetime }" pattern="yyyy年MM月dd日 HH:mm:ss"/></td>
                         	</tr>
                     </c:forEach>
                     
                         </c:if>
                    
                    </table>
                </div>
                <div class="clear blank40"  onclick="asideHide()"></div>
            </div>
        </div>
     </div>

    <!--projectIndex-->
 
     <style type="text/css">
 </style>

<style>
    #pImgs img{
        margin:10px
    }
    #pFiles img{
        margin:10px
    }
    #show-ul .fancybox img{
        margin:5px
    }
    .problem-info .problem-cont div .pFiles span{
        display:inline-block;
        font-size:27px;
        width:10%;
        height:35px;
        border:1px solid #ccc;
        text-align:center;
        padding:0px 7px;
        vertical-align:middle;
    }
    /*.problem-info .problem-cont div .pFiles .icons icon{
        display:none;
    }*/
    .problem-info .problem-cont div .pFiles{
        margin:0px;
        cursor:pointer;
        margin-top:5px;
        line-height:35px;
        height:35px;
    }
    .problem-info .problem-cont div .pFiles:hover{
        background:#f0f0f0;
    }
    .problem-info .problem-cont div .pFiles span.flist{
        width:50%;
        text-align:left;
        font-size:14px;
        border-left:none;
    }
    .problem-info .problem-cont div .pFiles span.fblist{
        width:17%;
        text-align:left;
        font-size:14px;
        border-left:none;
        border-right:none;
    }
    .problem-cont img{
        box-shadow: 0px 2px 10px rgba(0,0,0,0.08);
    }
    
    
        #imgDiv.line{
            border-color:#00aeef;
            box-shadow:0px 1px 8px 1px rgba(0, 174, 239,.4);
            -webkit-transition:border linear .1s,
            -webkit-box-shadow linear .1s;
        }
        #imgDiv .upload-container-lists{
            position:relative;
            min-height:120px;            
        }
        #imgDiv .uploadbg{
            background: url(../image/pastebg.png) center;
        }
</style>


<input type="hidden" id="txtCurrentBugId1" value="" />
<input type="hidden" id="txtCurrentBugId" value="" />
<input type="hidden" id="hidLastHandleUserId" value="" />
<input type="hidden" id="hidBtnType" value="" />
<input type="hidden" id="hidCurrentUrl" value="" />
<div class="aside-problem-topbg d-none" onclick="asideHide()"></div>
<div class="aside-problem-leftbg d-none" onclick="asideHide()"></div>

<div class="aside-problem p-absolute bg-white">
    <div class="aside-head bg-white">
        <div class="f-r" style="font-size:20px;">
                        <a href="javascript:void(0);" title="BugTalk" id="btnBugTalk" onclick="btnCreateTalk_Click()" class="color-8"></a>
                                    <a href="javascript:void(0);" title="编辑" id="btnEdit" class="color-8"></a>
                        <a href="javascript:void(0);" title="删除" id="btnDelete" class="color-8"></a>
        </div>
        <div class="btn f-l">
            <i class="iconfont icon-arrow-right f-l" onclick="asideHide()"></i>
            <a href="javascript:void(0);" onclick="chooseHandler()" id="btnChooseHandler" class="f-l btn1">指派</a>
            <a href="javascript:void(0);"  id="btnComplete" class="f-l btn2">完成</a>
            <a href="javascript:void(0);" class="f-l btn2" id="btnPass">通过</a>
            <a href="javascript:void(0);" class="f-l btn3" id="btnNoPass">不通过</a>
            <a href="javascript:void(0);" class="f-l color-8 btn4" id="btnClose">关闭</a>
            <a href="javascript:void(0);" class="f-l btn3" id="btnRefuse">拒绝</a>
            <a href="javascript:void(0);" class="f-l btn3" id="btnPostpone">延期</a>
            <a href="javascript:void(0);" class="f-l btn3" id="btnAgainOpen">再打开</a>
        </div>
    </div>
    <div id="aside-scroll">
        <div class="tips fz-14">
            <strong id="txtBugCode"></strong>
            <span class="text-bg textbg-1" id="txtBugType"></span>
			<label id="txtBugTitle"></label>
        </div>
        <div class="status b-radius4 fz-14 color-8" id="txtCurrentDone">
        </div>         
        <div class="status b-radius4 fz-14 color-8" style="border-top: 1px solid #ebebeb;padding: 10px 30px 15px 30px;margin-top:10px" id="txtRelevanceUsers">
        
        </div>
        <div class="problem-info" id="problem-info">
            <div class="clear blank10"></div>
            <ul class="clearfix">
                <li><strong class="tit">项目</strong><label id="txtProjectName"></label></li>
                <li><strong class="tit">产品</strong><label id="txtProductName"></label></li>                
                <li><strong class="tit">模块</strong><label id="txtModuleName"></label></li>            
            </ul>
            <div class="problem-cont fz-14">
                <p id="txtDescription" style="margin-top:5px"></p>                
                <p id="pImgs">
                    
                </p>                
                <p id="pFiles" style="margin-top: 5px">
                </p>
                <div id="divfile">
                    
                </div>
            </div>
                        <ul class="clearfix">
                <li><strong class="tit">状态</strong><span class="text-bg textbg-3" id="txtBugStatus"></span></li>
                <li><strong class="tit">优先级</strong><span class="text-bg" id="txtPriority"></span></li>
                <li><strong class="tit">分配人</strong><label id="txtCreateUserName"></label></li>
                <li><strong class="tit">处理人</strong><label id="txtProcessingUserName"></label></li>
                                                                            </ul>
        </div>
        
        
        
         </div>
         <style>
        .proAalysis .reportbox{ height:250px; overflow:hidden; border:#E0E0E0 solid 1px; background: #fff;}
        .clear{ clear:both;height:0px; overflow:hidden;}
        .blank10{ clear:both;height:10px; overflow:hidden;}
        .c_blank20{ clear:both;height:20px; overflow:hidden;}
        .blank15{ clear:both;height:15px; overflow:hidden;}
        .blank25{ clear:both;height:25px; overflow:hidden;}
        
        .mydataBar{ background:#fff;box-shadow:0 1px 1px rgba(0,0,0,0.06);}
        .mydataBar ul{ overflow:hidden;}
        .mydataBar li{ float:left; width:16.6%; text-align:center; font-size:12px; color:#999; line-height:22px;}
        .xiao li:hover{ float:left; width:16.6%; text-align:center; font-size:12px; color:#999; line-height:22px;background-color: #9dd6ee;}
        .xiao li.on{ float:left; width:16.6%; text-align:center; font-size:12px; color:#999; line-height:22px;background-color: #9dd6ee;}
        .xiao li{cursor:pointer;}
        .mydataBar li .inner{padding:23px 0px 15px 0px}
        .mydataBar li .num{ display:block; font-size:27px; color:#333; font-family:Arial, Helvetica, sans-serif; line-height:31px; overflow:hidden;}
        .mydataBar li .stress{ color:#df013c; font-weight:bold}
        
        .dataArea .mtitle{ font-size:14px; color:#333;font-weight:bold; height:44px; line-height:44px; overflow:hidden; padding-left:15px;}
        .dataArea .divdata{ border:#eee solid 1px; float:left; width:49%; min-height:300px; background:#fff; box-shadow:0 1px 1px rgba(0,0,0,0.06);}
        .dataArea .weekDeal{ float:right}
        .dataArea .monthVisit{ width:auto; float:none}
        .shuxian{width: 2px;float: right;height: 22px;background-color: #f0f0f0;top: 0;margin-top: -22px;}
        .highcharts-credits { display: none; }
    </style>
    <!--projectIndex-->
     <style type="text/css">
 </style>

<style>
    #pImgs img{
        margin:10px
    }
    #pFiles img{
        margin:10px
    }
    #show-ul .fancybox img{
        margin:5px
    }
    .problem-info .problem-cont div .pFiles span{
        display:inline-block;
        font-size:27px;
        width:10%;
        height:35px;
        border:1px solid #ccc;
        text-align:center;
        padding:0px 7px;
        vertical-align:middle;
    }
    /*.problem-info .problem-cont div .pFiles .icons icon{
        display:none;
    }*/
    .problem-info .problem-cont div .pFiles{
        margin:0px;
        cursor:pointer;
        margin-top:5px;
        line-height:35px;
        height:35px;
    }
    .problem-info .problem-cont div .pFiles:hover{
        background:#f0f0f0;
    }
    .problem-info .problem-cont div .pFiles span.flist{
        width:50%;
        text-align:left;
        font-size:14px;
        border-left:none;
    }
    .problem-info .problem-cont div .pFiles span.fblist{
        width:17%;
        text-align:left;
        font-size:14px;
        border-left:none;
        border-right:none;
    }
    .problem-cont img{
        box-shadow: 0px 2px 10px rgba(0,0,0,0.08);
    }
</style>

        <div class="problem-log">
            <div class="title"><span class="color-0" onclick="showBox(this,'show-ul')" data-flag="0">隐藏修改日志</span><font class="fz-16">日志</font></div>
            <ul id="show-ul">
            </ul>
        </div>
    </div>
</div>
               
                
<div id="layui-layer-shade5" class="layui-layer-shade" times="5" style="z-index: 19891018; background-color:#000 ; opacity: 0.6; filter: alpha(opacity=60);display: none;"></div>
<div id="layui-layer5" class="layui-layer " 
	style="z-index: 19891019; width: 55%; height: 95%; top: 9.5px; left: 307.5px; display: none;">
	<div class="layui-layer-title" style="cursor: move;">添加问题</div>
	<div id="" class="layui-layer-content">
		<div class="newProblem window-box bg-white b-radius4">
      <div class="fromBox p-relative" id="fromBox" style="padding-left:0">
            
        	<div class="from-left" id="fromLeftBox" style="display: none; height: 256px; overflow: hidden;" tabindex="5004">
            	<ul id="EABox" class="from-style" style="height: 256px; overflow: hidden;" tabindex="5005"></ul>
            	<div class="clear blank20"></div>
            <div id="ascrail2005" class="nicescroll-rails" style="width: 6px; z-index: auto; cursor: default; position: absolute; top: 0px; left: -6px; height: 256px; display: none;"><div style="position: relative; top: 0px; float: right; width: 6px; height: 0px; background-color: rgb(194, 194, 194); border: 0px none; background-clip: padding-box; border-radius: 6px;"></div></div><div id="ascrail2005-hr" class="nicescroll-rails" style="height: 6px; z-index: auto; top: 250px; left: 0px; position: absolute; cursor: default; display: none;"><div style="position: relative; top: 0px; height: 6px; width: 0px; background-color: rgb(194, 194, 194); border: 0px none; background-clip: padding-box; border-radius: 6px;"></div></div></div>
        
            <div class="from-style" style="height: 500px; overflow: scroll;" tabindex="5003">
                <ul>
                    <li class="block-2 f-l">
                        <div class="box select-box">
                            <span class="tit">相关模块</span>
                            <div class="btn-select"  id="moduleInfo" onclick="moduleSelect()" style="position:relative;">
                                           选择                        <span class="handle-person"><strong>默认产品（产品）</strong></span>
                                <span class="clearModuleInfo layui-layer-ico layui-layer-close layui-layer-close1 iconfont-bugdone icon-guanbi" style="opacity:0.3;position:absolute;right:10px;width:16px;height:16px;font-size:14px;background-position: 0px -40px;top:2px;"></span>
                            </div>
                            <input id="selModule" type="hidden" value="06db3ab1-cb47-494d-9d1a-65c5e5314524">
                            <input id="selProduct" type="hidden" value="a79737ed-8e00-49a7-b032-0a067e4aaec1">
                        </div>
                    </li>
                    <li class="block-2 f-l">
                        <div class="box select-box" style="padding-right: 50px;">
                            <span class="tit">处理人</span>
                            <div class="btn-select" onclick="handleSelect()" id="userInfo" style="position:relative;">
                             	选择
                            </div>
                            <input id="selUser" type="hidden">
                            <div class="btn-at" style="line-height: 40px;font-size: 27px;background:url(../image/icon-add.png) 50%" onclick="showAtBox(1)"><i id="ru_count" style="display:none">0</i></div>
                            <div class="at-box" id="atbox1">
                                <div class="at-head clearfix">
                                    <span class="at-close" onclick="hideAtBox(1)"><i class="iconfont icon-guanbi1"></i></span>
                                    <span onclick="addRelevanceUser()" class="green-button mini-btn">添加</span>
                                    <span onclick="clearRU_UI()" class="gray-button mini-btn">清空</span>
                                </div>
                                <div class="at-list" id="RU-Box">
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="block-2 f-l">
                        <div class="box select-box">
                            <span class="tit">问题类型</span>
                            <div class="selects">
                                <div class="text ">
                                  <span class="txtName"><span class="bg"></span> <span class="txt"></span></span>
                                  <input value="" class="hidVal" id="selBugType" type="hidden">
                                  <a href="#"><span class="iconfont icon-bottom"></span></a>
                                </div>
                                <style>
                                	
        .from-style li .box .selects{
           position:relative;
        }
        .from-style li .box .selects .text{
            height:40px;
            line-height:40px;
            border: 1px solid #ebebeb;
            font-size: 14px;   
            padding-left: 10px;
        }
        .from-style li .box .selects .text .txtName{                
            text-align: left;               
        }
        .from-style li .box .selects .text .txtName span.bg{
            display:inline-block;
            width:15px;
            height:15px;
            vertical-align:middle;
            border-radius:2px;
            margin-top:-2px;
        }
        .from-style li .box .selects .text a{
            padding:0px 8px;
            border-left:1px solid #ebebeb;
            height:100%;
            font-size:22px;
            display:inline-block;
            float:right;
        }
        .from-style li .box .selects .optbox{
            -webkit-border-radius:0 0 3px 3px;
            position:absolute;
            top:41px;
            left:-1px;
            width:100%;
            background:#fff;
            z-index:10;
            box-shadow:0px 2px 13px -5px rgba(0,0,0,.3);
            border:1px solid #ebebeb;
            display:none;
        }
        .from-style li .box .selects .optbox .option{
            width:98%;
            margin:0 auto;
        }
        .from-style li .box .selects .optbox .option p{
            height:35px; 
            -webkit-border-radius:3px;
            line-height:35px;
            cursor:pointer;
            padding-left:5px;
            font-size: 14px;
            color:#333;
            margin:5px 0px;
        }
        .from-style li .box .selects .optbox .option p span{
            display:inline-block;
            width:15px;
            height:15px;
            vertical-align:middle;
            margin-top:-2px;
            border-radius:2px;
        }
        .from-style li .box .selects .optbox .option p:hover{
            background:#f0f0f0;
            color:#333;
        }
        .from-style li .box .selects .optbox .option p.active{
            background:#f0f0f0;
            color:#333;
        }
                                </style>
                                <div class="optbox" style="display: none;">
                                    <div class="option" id="optBugTypes">
                                        <p val="1" class="active"><span style="background:#f34949" val="#f34949"></span> 缺陷</p>
                                        <p val="4"><span style="background:#f6981d" val="#f6981d"></span> 改进</p> 
                                        <p val="2"><span style="background:#109bd6" val="#109bd6"></span> 任务</p>
                                        <p val="3"><span style="background:#2dc26c" val="#2dc26c"></span> 需求</p>                                            
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="block-2 f-l">
                        <div class="box select-box">
                            <span class="tit">优先级</span>
                            <div class="selects">
                                <div class="text ">
                                  <span class="txtName"><span class="bg"></span> <span class="txt"></span></span>
                                  <input value="" class="hidVal" id="selPriority" type="hidden">
                                  <a href="#"><span class="iconfont icon-bottom"></span></a>
                                </div>
                                <div class="optbox" style="display: none;">
                                    <div class="option" id="optPrioritys">
                                        <p val="1" class="active"><span style="background:#f34949;" val="#f34949"></span> 急</p>
                                        <p val="2"><span style="background:#f6981d;" val="#f6981d"></span> 高</p>
                                        <p val="3"><span style="background:#109bd6;" val="#109bd6"></span> 中</p>
                                        <p val="4"><span style="background:#2dc26c;" val="#2dc26c"></span> 低</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <div class="clear"></div>
                    <li>
                        <div class="box">
                            <span class="tit">标题</span>
                            <input name="" id="txtBugTitle" class="textbox" placeholder="请输入问题的标题。" type="text">
                        </div>
                    </li>
                    <li>
                        <div class="box">
                            <span class="tit">描述</span>
                            <textarea name="" id="txtDescription" cols="" rows="" placeholder="请输入问题的详细描述。"></textarea>
                        </div>
                    </li>
                    <li>
                        <div class="box">
                            <span class="tit">文件</span>
                            <div class="fileTab fz-14">
                            	<div class="tabname active" id="descImgTab">图片 <span id="descImgCount"></span></div>
                                <div class="tabname" id="accessoryTab">附件<span id="accessoryCount"></span></div>
                            </div>
                            <div class="clear blank10"></div>
                            <div id="descImgTabBox">
                                <div class="upload-container clearfix" id="imgDiv">                               
                                    <div class="upload-container-lists uploadbg ui-sortable" id="imgBox">
                                    
                                    </div>                     
                                    <!--
                                    <div class="tips-text color-c ta-center">
                                        <i class="iconfont icon-tupian d-block"></i>
                                        支持图片直接粘贴、拖拽、排序
                                    </div>
                                    -->
                                </div>      
                                <div class="upload-staus ta-right color-8 fileUploadHintTxt">暂未上传文件</div>
                                <div class="clear blank20"></div>
                         		<div style="margin-left:-15px;">
                                    <div class="button" onclick="getPhoneUploadQRCode('1')"><i class="iconfont icon-shouji"></i>手机上传</div>
                                    <div class="button" onclick="selectDescImg()"><i class="iconfont icon-tupian"></i>选择图片</div>
                                </div>
                                <div class="clear"></div>
                                <span id="descImgFilePicker" style="display:none" class="webuploader-container"><div class="webuploader-pick"></div><div id="rt_rt_1c1rs37qkbgd19vq1qo21gbll341" style="position: absolute; top: 0px; left: 0px; width: 30px; height: 20px; overflow: hidden; bottom: auto; right: auto;"><input name="file" class="webuploader-element-invisible" multiple="multiple" accept="image/*" type="file"><label style="opacity: 0; width: 100%; height: 100%; display: block; cursor: pointer; background: rgb(255, 255, 255) none repeat scroll 0% 0%;"></label></div></span>
                            </div>
                            <div id="accessoryTabBox" style="display:none">
                                <div class="upload-container clearfix fujianbg" id="accessoryParentBox">                               
                                    <ul class="accessorybox" id="accessoryBox">
                              
                                    </ul>
                                </div>     
                                <style>
                                    .box .accessorybox{
                                        padding: 5px 0 0 15px;font-size:15px;                                        
                                    }
                                    
                                    .box .accessorybox .progress{
                                        float: right;                               
                                        width:100px;                                
                                        text-align: right;
                                        border-radius: 5px
                                    }
                                    .box .accessorybox span{
                                        float: right;color: red;
                                        display:none;
                                        font-size:20px
                                    }
                                    .box .fujianbg{
                                        background: url("../image/fujianbg.png") center;
                                    }
                                </style>
                                <div class="upload-staus ta-right color-8 fileUploadHintTxt">暂未上传文件</div>
                                <div class="clear blank20"></div>
                             	<div style="margin-left:-15px;">
                                    <div class="button" onclick="getPhoneUploadQRCode('2')"><i class="iconfont icon-shouji"></i>手机上传</div>
                                    <div class="button" onclick="selectAccessory()"><i class="iconfont icon-tupian"></i>选择附件</div>
                                </div>
                                <div class="clear"></div>
                                <span id="accessoryFilePicker" style="display:none" class="webuploader-container"><div class="webuploader-pick"></div><div id="rt_rt_1c1rs37qu1o5k183c17553301mnr6" style="position: absolute; top: 0px; left: 0px; width: 30px; height: 20px; overflow: hidden; bottom: auto; right: auto;"><input name="file" class="webuploader-element-invisible" multiple="multiple" type="file"><label style="opacity: 0; width: 100%; height: 100%; display: block; cursor: pointer; background: rgb(255, 255, 255) none repeat scroll 0% 0%;"></label></div></span>
                            </div>          
                        </div>
                    </li>
                    
                   
                    <div class="clear blank30"></div>
                </ul>
    
            </div>
             <div class="foot-btn ta-center">
        <span>
            <input name="" onclick="btnSave_Click();" value="提交" class="button" type="button">
            <input name="" onclick="btnClose_Click('1');" class="button button2" value="取消" type="button">              
        </span>              
      </div>
      </div>      
     
    </div>
     <div class="wrap-grag-bg d-none " style="z-index: 990; display: none;" onclick="boxClose()"></div>
           <div class="box-select d-none box-select1" id="box-module" style="overflow: hidden ;display:none;outline: none;" tabindex="5000">
           <div class="name productNameBox" pid="a79737ed-8e00-49a7-b032-0a067e4aaec1">
           <i class="iconfont icon-arrow"></i><label>默认产品</label></div><div class="box"><ul>
           <li class="productLi"><div class="li-tit" pid="a79737ed-8e00-49a7-b032-0a067e4aaec1" style="color:#7fb80e">默认产品（产品）</div></li>
           <li class="moduleLi"><div class="li-tit" mid="06db3ab1-cb47-494d-9d1a-65c5e5314524">默认模块</div></li></ul></div></div>
           <div class="box-select d-none box-select1" id="box-handle" style="overflow: hidden; display: none;" tabindex="5001">
         
       <div class="box-select d-none"  style="display: none;">
            <div id="box-relevanceuser" style="height: 92%; overflow: hidden;" tabindex="5002"><div class="name userNameBox"><i class="iconfont icon-arrow"></i><label>默认分组</label></div><div class="box"><ul><li class="userLi"><div class="li-user" uid="57eda926-a45e-4ae6-8f3e-43ccc3b94735"><img src="../image/22.png">何元浩</div></li><li class="userLi"><div class="li-user" uid="ef40bbfb-b680-44e0-b32a-178797962c0d"><img src="../image/22.png">zock</div></li><li class="userLi"><div class="li-user" uid="8b1f8d2f-394c-4793-bc7c-e1466b57df7a"><img src="../image/22.png">杨恩来</div></li><li class="userLi"><div class="li-user" uid="471051bd-2d56-447d-88d2-a9f61a8a7647"><img src="../image/22.png">罗文</div></li><li class="userLi"><div class="li-user" uid="86003427-20ca-491f-a01a-1f433f352edc"><img src="../image/22.png">邹书仪</div></li></ul></div></div>
              <div class="foot-btn ta-center" style=" position: absolute;
                                                bottom: 0;                                                
                                                width: 100%;                                                  
                                                padding: 7px 0;
                                                background: #f2f2f2;
                                                ">
            <span>
                <input style="  padding: 0px 30px;
                                cursor: pointer;
                                height: 30px;                           
                                line-height: 30px;
                                font-size: 14px;
                                -webkit-transition: .3s;
                                transition: .3s;
                                border: 1px solid #0892e1;
                                color: #fff;
                                background: #0892e1;
                                text-align: center;
                                border-radius: 4px;
                                margin: 0px 10px;" name="" onclick="bindRU_UI()" value="确认" class="button" type="button">
                <input style="  padding: 0px 30px;
                                cursor: pointer;
                                height: 30px;                           
                                line-height: 30px;
                                font-size: 14px;
                                -webkit-transition: .3s;
                                transition: .3s;
                                border: 1px solid #0892e1;
                                color: #0892e1;
                                background: #fff;
                                text-align: center;
                                border-radius: 4px;
                                margin: 0px 10px;" name="" onclick="hideRelevanceUserBox()" class="button button2" value="取消" type="button">              
            </span>              
        </div>
    </div>
    
	</div>
	
	<span class="layui-layer-setwin">
                      		<a class="layui-layer-ico layui-layer-close layui-layer-close1 iconfont-bugdone icon-guanbi "href="javascript:;"></a>
                      	</span>
                      	<span class="layui-layer-resize"></span>
	</div>
		
</body>
</html>
