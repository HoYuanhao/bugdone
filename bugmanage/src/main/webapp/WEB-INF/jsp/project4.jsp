<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
   <meta charset="utf-8">
		<link rel="stylesheet" type="text/css" href="../css/iconfont.css"/>
		<link rel="stylesheet" type="text/css" href="../css/animate.css"/>
		<link rel="stylesheet" type="text/css" href="../css/base.css"/>
		<link rel="stylesheet" href="../css/layer.css" type="text/css">
		<link rel="stylesheet" type="text/css" href="../css/bugdone.css"/>
		<link rel="stylesheet" type="text/css" href="../css/animate.min.css"/>
		<link rel="stylesheet" type="text/css" href="../css/bugdone1.css"/>
		<link rel="stylesheet" type="text/css" href="../css/nprogress.css"/>
		<script src="../js/jquery-3.2.1.min.js"></script>
		<title>工作台-项目概况</title>
</head>
<body class="of-hidden">
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
            <div class="name fz-14 fw-bold p-relative">
                <i class="iconfont icon-arrow-copy p-absolute"></i>
                <div id="lblUser" style='min-width:44px;min-height:10px'></div>
                <div id="userinfo" class="show-box p-absolute bg-white bd-e2 b-radius4 d-none fz-14">
                    <div class="avatar1 p-absolute" onclick="changePhoto();">
                        <img id="imgUserEdit" src="" alt="" />
                       
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
            .code-grag-bg{width:100%;height:100%; position:fixed; background:url(../首页image/rgba0_25.png);left:0;top:0; z-index:90;}
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
            <div class='imgdiv'><img src='../image/weichatcode.png' style='width:10rem'><span style='position: absolute;top: 13.5rem;left: 17.6rem;'>bugdone公众号</span></div>
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
            <div class="logo"><img src="../首页image/logo.png" style="display: initial;" /></div>
            <div class="info">
            	<i class="iconfont icon-guanbi1 color-8" onClick="closeAbout()" style="margin-right: 20px;"></i>
            	<h1>BUGDONE，bug管理系统</h1>
                <p>版本号：V1.0.0.BATE</p>
                <p><a href="/newslist/" class="button">版本更新日志</a></p>
                <p class="copyright">奇创科技创新团队版权所有<br />xxx@xx.com</p>
            </div>
        </div>     
        <div class="package-grag-bg d-none" onClick="closePackage()"></div>
        <div class="package-system d-none">
            <div class="logo"><img src="../image/logo.png" style="display: initial;" /></div>
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
            </div>
            <div class="menu fz-14">
                <ul>
                    <li class="on">
                    	<a href="project1?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<i class="icon-gk"></i>项目概况
                    	</a>
                    </li>
                    <li>
                    	<a href="project2?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<span class="num f-r n-bg1" id="lblUnsolvedProblemNum">${problemnumber }</span>
                    		<i class="icon-wt"></i>活动问题
                    	</a>
                    </li>
                    <li>
                    	<a href="project3?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<i class="icon-all"></i>所有问题
                    	</a>
                    </li>
                    <li>
                    	<a href="project4?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<i class="icon-tongji"></i>问题统计
                    	</a>
                    </li>
                </ul>
                <ul>
                    <li>
                    	<a href="project5?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<span class="num f-r n-bg2" id="lblMyToDoProblemNum">${actionnumber }</span>
                    		<i class="icon-daiban"></i>我的待办
                    	</a>
                    </li>
                    <li>
                    	<a href="project6?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<i class="icon-fenpei"></i>分配给我
                    	</a>
                    </li>
                    <li>
                    	<a href="project7?id=${itemsid}&&actionnumber=${actionnumber }&&problemnumber=${problemnumber}">
                    		<i class="icon-myfp"></i>我的分配
                    	</a>
                    </li>
                </ul>
                <ul>
                     <li>
                     	<a href="project8.html">
                     		<i class="icon-fb"></i>版本管理
                     	</a>
                     </li>
                    <li>
                    	<a href="project9.html">
                    		<i class="icon-yingyong"></i>应用中心
                    	</a>
                    </li>                                                         
                </ul>
            </div>
        </div>
        
        <div class="right" id="project-right" style="height: 600px; overflow: scroll;" tabindex="5002">
            <div class="mw-900 rightshow">
                <div class="head-tit">
                    <div class="fz-22 f-l">问题统计</div>
                    <div class="clear"></div>
                </div>
                
                <div class="proAalysis">
                    <div class="data-info bg-white b-radius4 bs-08 of-hidden animated flipInX">
                        <ul class="ta-center clearfix">
                                                    <li style="width:16.5%"><a><strong id="lblworkdays">${runningtime}</strong><span class="color-a">项目运行(天)</span></a></li>
                            <li style="width:16.5%"><a><i class="line"></i><strong class="color-0" id="lblusercount">5</strong><span class="color-a">项目成员</span></a></li>
                            <li style="width:16.5%"><a><i class="line"></i><strong id="lblproductcount">1</strong><span class="color-a">产品数量</span></a></li>
                            <li style="width:16.5%"><a href="/allbug_6f917cc1f60d4cad85909737e5644eb9"><i class="line"></i><strong id="lblbugcount">5</strong><span class="color-a">问题总数</span></a></li>
                            <li style="width:16.5%"><a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/4/0"><i class="line"></i><strong id="lblsolvedcount">2</strong><span class="color-a">已解决</span></a></li>
                            <li style="width:16.5%"><a href="/allbug_6f917cc1f60d4cad85909737e5644eb9/q1/1/0"><i class="line"></i><strong class="color-8" id="lblnotsolvedcount">3</strong><span class="color-a">待解决</span></a></li>
                        </ul>
                    </div>
                    
                    
                    <div class="clear blank25"></div>
                    <div class="reportbox" id="bugcount" style="height: 300px" data-highcharts-chart="1"><div id="highcharts-2" style="position: relative; overflow: hidden; width: 1083px; height: 300px; text-align: left; line-height: normal; z-index: 0; font-family: Signika, serif; left: 0px; top: 0px;" class="highcharts-container "><svg version="1.1" class="highcharts-root" style="font-family:Signika, serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="1083" viewBox="0 0 1083 300" height="300"><desc>Created with Highcharts 5.0.2</desc><defs><clipPath id="highcharts-3"><rect x="0" y="0" width="748" height="192" fill="none"></rect></clipPath></defs><rect fill="none" class="highcharts-background" x="0" y="0" width="1083" height="300" rx="0" ry="0"></rect><rect fill="none" class="highcharts-plot-background" x="54" y="38" width="748" height="192"></rect><g class="highcharts-plot-lines-0"><path fill="none" stroke="#808080" stroke-width="1" d="M 54 230.5 L 802 230.5"></path></g><g class="highcharts-grid highcharts-xaxis-grid "><path fill="none" class="highcharts-grid-line" d="M 77.5 38 L 77.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 101.5 38 L 101.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 125.5 38 L 125.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 150.5 38 L 150.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 174.5 38 L 174.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 198.5 38 L 198.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 222.5 38 L 222.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 246.5 38 L 246.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 270.5 38 L 270.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 294.5 38 L 294.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 318.5 38 L 318.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 343.5 38 L 343.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 367.5 38 L 367.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 391.5 38 L 391.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 415.5 38 L 415.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 439.5 38 L 439.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 463.5 38 L 463.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 487.5 38 L 487.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 511.5 38 L 511.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 536.5 38 L 536.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 560.5 38 L 560.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 584.5 38 L 584.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 608.5 38 L 608.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 632.5 38 L 632.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 656.5 38 L 656.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 680.5 38 L 680.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 704.5 38 L 704.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 729.5 38 L 729.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 753.5 38 L 753.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 777.5 38 L 777.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 801.5 38 L 801.5 230" opacity="1"></path><path fill="none" class="highcharts-grid-line" d="M 53.5 38 L 53.5 230" opacity="1"></path></g><g class="highcharts-grid highcharts-yaxis-grid "><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 54 230.5 L 802 230.5" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 54 166.5 L 802 166.5" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 54 102.5 L 802 102.5" opacity="1"></path><path fill="none" stroke="#e6e6e6" stroke-width="1" class="highcharts-grid-line" d="M 54 37.5 L 802 37.5" opacity="1"></path></g><rect fill="none" class="highcharts-plot-border" x="54" y="38" width="748" height="192"></rect><g class="highcharts-axis highcharts-xaxis "><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 77.5 230 L 77.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 101.5 230 L 101.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 125.5 230 L 125.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 150.5 230 L 150.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 174.5 230 L 174.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 198.5 230 L 198.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 222.5 230 L 222.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 246.5 230 L 246.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 270.5 230 L 270.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 294.5 230 L 294.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 318.5 230 L 318.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 343.5 230 L 343.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 367.5 230 L 367.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 391.5 230 L 391.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 415.5 230 L 415.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 439.5 230 L 439.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 463.5 230 L 463.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 487.5 230 L 487.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 511.5 230 L 511.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 536.5 230 L 536.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 560.5 230 L 560.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 584.5 230 L 584.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 608.5 230 L 608.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 632.5 230 L 632.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 656.5 230 L 656.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 680.5 230 L 680.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 704.5 230 L 704.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 729.5 230 L 729.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 753.5 230 L 753.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 777.5 230 L 777.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 802.5 230 L 802.5 240" opacity="1"></path><path fill="none" class="highcharts-tick" stroke="#ccd6eb" stroke-width="1" d="M 53.5 230 L 53.5 240" opacity="1"></path><path fill="none" class="highcharts-axis-line" stroke="#ccd6eb" stroke-width="1" d="M 54 230.5 L 802 230.5"></path></g><g class="highcharts-axis highcharts-yaxis "><text x="23.5" text-anchor="middle" transform="translate(0,0) rotate(270 23.5 134)" class="highcharts-axis-title" style="color:#666666;fill:#666666;" y="134">数量</text><path fill="none" class="highcharts-axis-line" d="M 54 38 L 54 230"></path></g><g class="highcharts-series-group "><g class="highcharts-series highcharts-series-0 highcharts-line-series highcharts-color-0 " transform="translate(54,38) scale(1 1)" clip-path="url(#highcharts-3)" width="192" height="748"><path fill="none" d="M 12.064516129032 192 L 36.193548387097 192 L 60.322580645161 192 L 84.451612903226 192 L 108.58064516129 192 L 132.70967741935 64 L 156.83870967742 192 L 180.96774193548 192 L 205.09677419355 192 L 229.22580645161 192 L 253.35483870968 192 L 277.48387096774 192 L 301.61290322581 192 L 325.74193548387 192 L 349.87096774194 192 L 374 64 L 398.12903225806 192 L 422.25806451613 192 L 446.38709677419 192 L 470.51612903226 192 L 494.64516129032 128 L 518.77419354839 192 L 542.90322580645 192 L 567.03225806452 192 L 591.16129032258 192 L 615.29032258065 192 L 639.41935483871 192 L 663.54838709677 192 L 687.67741935484 192 L 711.8064516129 192 L 735.93548387097 192" class="highcharts-graph" stroke="#7bbfea" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path><path fill="none" d="M 2.0645161290320004 192 L 12.064516129032 192 L 36.193548387097 192 L 60.322580645161 192 L 84.451612903226 192 L 108.58064516129 192 L 132.70967741935 64 L 156.83870967742 192 L 180.96774193548 192 L 205.09677419355 192 L 229.22580645161 192 L 253.35483870968 192 L 277.48387096774 192 L 301.61290322581 192 L 325.74193548387 192 L 349.87096774194 192 L 374 64 L 398.12903225806 192 L 422.25806451613 192 L 446.38709677419 192 L 470.51612903226 192 L 494.64516129032 128 L 518.77419354839 192 L 542.90322580645 192 L 567.03225806452 192 L 591.16129032258 192 L 615.29032258065 192 L 639.41935483871 192 L 663.54838709677 192 L 687.67741935484 192 L 711.8064516129 192 L 735.93548387097 192 L 745.93548387097 192" stroke-linejoin="round" visibility="visible" stroke="rgba(192,192,192,0.0001)" stroke-width="22" class="highcharts-tracker"></path></g><g class="highcharts-markers highcharts-series-0 highcharts-line-series highcharts-color-0 highcharts-tracker " transform="translate(54,38) scale(1 1)" clip-path="url(#highcharts-4)" width="192" height="748"><path fill="#7bbfea" d="M 735 188 C 740.328 188 740.328 196 735 196 C 729.672 196 729.672 188 735 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 711 188 C 716.328 188 716.328 196 711 196 C 705.672 196 705.672 188 711 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 687 188 C 692.328 188 692.328 196 687 196 C 681.672 196 681.672 188 687 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 663 188 C 668.328 188 668.328 196 663 196 C 657.672 196 657.672 188 663 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 639 188 C 644.328 188 644.328 196 639 196 C 633.672 196 633.672 188 639 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 615 188 C 620.328 188 620.328 196 615 196 C 609.672 196 609.672 188 615 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 591 188 C 596.328 188 596.328 196 591 196 C 585.672 196 585.672 188 591 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 567 188 C 572.328 188 572.328 196 567 196 C 561.672 196 561.672 188 567 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 542 188 C 547.328 188 547.328 196 542 196 C 536.672 196 536.672 188 542 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 518 188 C 523.328 188 523.328 196 518 196 C 512.672 196 512.672 188 518 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 494 124 C 499.328 124 499.328 132 494 132 C 488.672 132 488.672 124 494 124 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 470 188 C 475.328 188 475.328 196 470 196 C 464.672 196 464.672 188 470 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 446 188 C 451.328 188 451.328 196 446 196 C 440.672 196 440.672 188 446 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 422 188 C 427.328 188 427.328 196 422 196 C 416.672 196 416.672 188 422 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 398 188 C 403.328 188 403.328 196 398 196 C 392.672 196 392.672 188 398 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 374 60 C 379.328 60 379.328 68 374 68 C 368.672 68 368.672 60 374 60 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 349 188 C 354.328 188 354.328 196 349 196 C 343.672 196 343.672 188 349 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 325 188 C 330.328 188 330.328 196 325 196 C 319.672 196 319.672 188 325 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 301 188 C 306.328 188 306.328 196 301 196 C 295.672 196 295.672 188 301 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 277 188 C 282.328 188 282.328 196 277 196 C 271.672 196 271.672 188 277 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 253 188 C 258.328 188 258.328 196 253 196 C 247.672 196 247.672 188 253 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 229 188 C 234.328 188 234.328 196 229 196 C 223.672 196 223.672 188 229 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 205 188 C 210.328 188 210.328 196 205 196 C 199.672 196 199.672 188 205 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 180 188 C 185.328 188 185.328 196 180 196 C 174.672 196 174.672 188 180 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 156 188 C 161.328 188 161.328 196 156 196 C 150.672 196 150.672 188 156 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 132 60 C 137.328 60 137.328 68 132 68 C 126.672 68 126.672 60 132 60 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 108 188 C 113.328 188 113.328 196 108 196 C 102.672 196 102.672 188 108 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 84 188 C 89.328 188 89.328 196 84 196 C 78.672 196 78.672 188 84 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 60 188 C 65.328 188 65.328 196 60 196 C 54.672 196 54.672 188 60 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 36 188 C 41.328 188 41.328 196 36 196 C 30.672 196 30.672 188 36 188 Z" class="highcharts-point highcharts-color-0"></path><path fill="#7bbfea" d="M 12 188 C 17.328 188 17.328 196 12 196 C 6.672 196 6.672 188 12 188 Z" class="highcharts-point highcharts-color-0"></path></g><g class="highcharts-series highcharts-series-1 highcharts-line-series highcharts-color-1 " transform="translate(54,38) scale(1 1)" clip-path="url(#highcharts-3)" width="192" height="748"><path fill="none" d="M 12.064516129032 192 L 36.193548387097 192 L 60.322580645161 192 L 84.451612903226 192 L 108.58064516129 192 L 132.70967741935 192 L 156.83870967742 192 L 180.96774193548 192 L 205.09677419355 192 L 229.22580645161 192 L 253.35483870968 192 L 277.48387096774 192 L 301.61290322581 192 L 325.74193548387 192 L 349.87096774194 192 L 374 128 L 398.12903225806 192 L 422.25806451613 192 L 446.38709677419 192 L 470.51612903226 192 L 494.64516129032 192 L 518.77419354839 192 L 542.90322580645 192 L 567.03225806452 128 L 591.16129032258 192 L 615.29032258065 192 L 639.41935483871 192 L 663.54838709677 192 L 687.67741935484 192 L 711.8064516129 192 L 735.93548387097 192" class="highcharts-graph" stroke="#d93a49" stroke-width="2" stroke-linejoin="round" stroke-linecap="round"></path><path fill="none" d="M 2.0645161290320004 192 L 12.064516129032 192 L 36.193548387097 192 L 60.322580645161 192 L 84.451612903226 192 L 108.58064516129 192 L 132.70967741935 192 L 156.83870967742 192 L 180.96774193548 192 L 205.09677419355 192 L 229.22580645161 192 L 253.35483870968 192 L 277.48387096774 192 L 301.61290322581 192 L 325.74193548387 192 L 349.87096774194 192 L 374 128 L 398.12903225806 192 L 422.25806451613 192 L 446.38709677419 192 L 470.51612903226 192 L 494.64516129032 192 L 518.77419354839 192 L 542.90322580645 192 L 567.03225806452 128 L 591.16129032258 192 L 615.29032258065 192 L 639.41935483871 192 L 663.54838709677 192 L 687.67741935484 192 L 711.8064516129 192 L 735.93548387097 192 L 745.93548387097 192" stroke-linejoin="round" visibility="visible" stroke="rgba(192,192,192,0.0001)" stroke-width="22" class="highcharts-tracker"></path></g><g class="highcharts-markers highcharts-series-1 highcharts-line-series highcharts-color-1 highcharts-tracker " transform="translate(54,38) scale(1 1)" clip-path="url(#highcharts-4)" width="192" height="748"><path fill="#d93a49" d="M 349 192 C 349 192 349 192 349 192 C 349 192 349 192 349 192 Z" class="highcharts-halo highcharts-color-1" fill-opacity="0.25"></path><path fill="#d93a49" d="M 735 188 L 739 192 735 196 731 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 711 188 L 715 192 711 196 707 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 687 188 L 691 192 687 196 683 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 663 188 L 667 192 663 196 659 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 639 188 L 643 192 639 196 635 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 615 188 L 619 192 615 196 611 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 591 188 L 595 192 591 196 587 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 567 124 L 571 128 567 132 563 128 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 542 188 L 546 192 542 196 538 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 518 188 L 522 192 518 196 514 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 494 188 L 498 192 494 196 490 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 470 188 L 474 192 470 196 466 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 446 188 L 450 192 446 196 442 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 422 188 L 426 192 422 196 418 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 398 188 L 402 192 398 196 394 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 374 124 L 378 128 374 132 370 128 Z" class="highcharts-point highcharts-color-1 " stroke-width="1"></path><path fill="#d93a49" d="M 349 188 L 353 192 349 196 345 192 Z" class="highcharts-point highcharts-color-1 " stroke-width="1"></path><path fill="#d93a49" d="M 325 188 L 329 192 325 196 321 192 Z" class="highcharts-point highcharts-color-1 " stroke-width="1"></path><path fill="#d93a49" d="M 301 188 L 305 192 301 196 297 192 Z" class="highcharts-point highcharts-color-1 " stroke-width="1"></path><path fill="#d93a49" d="M 277 188 L 281 192 277 196 273 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 253 188 L 257 192 253 196 249 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 229 188 L 233 192 229 196 225 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 205 188 L 209 192 205 196 201 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 180 188 L 184 192 180 196 176 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 156 188 L 160 192 156 196 152 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 132 188 L 136 192 132 196 128 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 108 188 L 112 192 108 196 104 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 84 188 L 88 192 84 196 80 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 60 188 L 64 192 60 196 56 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 36 188 L 40 192 36 196 32 192 Z" class="highcharts-point highcharts-color-1"></path><path fill="#d93a49" d="M 12 188 L 16 192 12 196 8 192 Z" class="highcharts-point highcharts-color-1"></path></g></g><text x="522" text-anchor="middle" class="highcharts-subtitle" style="color:black;fill:black;width:1019px;" y="24"><tspan>--Bug概况统计--</tspan></text><g class="highcharts-legend" transform="translate(814,128)"><rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="259" height="39" visibility="visible"></rect><g><g><g class="highcharts-legend-item highcharts-line-series highcharts-color-0 highcharts-series-0" transform="translate(8,3)"><path fill="none" d="M 0 12 L 16 12" class="highcharts-graph" stroke="#7bbfea" stroke-width="2"></path><path fill="#7bbfea" d="M 8 8 C 13.328 8 13.328 16 8 16 C 2.6719999999999997 16 2.6719999999999997 8 8 8 Z" class="highcharts-point"></path><text x="21" style="color:#333333;font-size:13px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start" y="16">近30天内的bug创建数量趋势（个）</text></g><g class="highcharts-legend-item highcharts-line-series highcharts-color-1 highcharts-series-1" transform="translate(8,17)"><path fill="none" d="M 0 12 L 16 12" class="highcharts-graph" stroke="#d93a49" stroke-width="2"></path><path fill="#d93a49" d="M 8 8 L 12 12 8 16 4 12 Z" class="highcharts-point"></path><text x="21" y="16" style="color:#333333;font-size:13px;font-weight:bold;cursor:pointer;fill:#333333;" text-anchor="start">近30天内的bug解决数量趋势（个）</text></g></g></g></g><g class="highcharts-axis-labels highcharts-xaxis-labels "><text x="68.65724099338293" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 68.65724099338293 246)" y="246" opacity="1"><tspan>2017/10/21</tspan></text><text x="92.78627325144744" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 92.78627325144744 246)" y="246" opacity="1"><tspan>2017/10/22</tspan></text><text x="116.91530550951197" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 116.91530550951197 246)" y="246" opacity="1"><tspan>2017/10/23</tspan></text><text x="141.04433776757648" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 141.04433776757648 246)" y="246" opacity="1"><tspan>2017/10/24</tspan></text><text x="165.173370025641" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 165.173370025641 246)" y="246" opacity="1"><tspan>2017/10/25</tspan></text><text x="189.30240228370553" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 189.30240228370553 246)" y="246" opacity="1"><tspan>2017/10/26</tspan></text><text x="213.43143454177005" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 213.43143454177005 246)" y="246" opacity="1"><tspan>2017/10/27</tspan></text><text x="237.56046679983456" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 237.56046679983456 246)" y="246" opacity="1"><tspan>2017/10/28</tspan></text><text x="261.689499057899" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 261.689499057899 246)" y="246" opacity="1"><tspan>2017/10/29</tspan></text><text x="285.8185313159635" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 285.8185313159635 246)" y="246" opacity="1"><tspan>2017/10/30</tspan></text><text x="309.9475635740281" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 309.9475635740281 246)" y="246" opacity="1"><tspan>2017/10/31</tspan></text><text x="334.0765958320926" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 334.0765958320926 246)" y="246" opacity="1"><tspan>2017/11/01</tspan></text><text x="358.2056280901571" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 358.2056280901571 246)" y="246" opacity="1"><tspan>2017/11/02</tspan></text><text x="382.33466034822163" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 382.33466034822163 246)" y="246" opacity="1"><tspan>2017/11/03</tspan></text><text x="406.46369260628614" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 406.46369260628614 246)" y="246" opacity="1"><tspan>2017/11/04</tspan></text><text x="430.59272486435066" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 430.59272486435066 246)" y="246" opacity="1"><tspan>2017/11/05</tspan></text><text x="454.72175712241517" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 454.72175712241517 246)" y="246" opacity="1"><tspan>2017/11/06</tspan></text><text x="478.8507893804797" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 478.8507893804797 246)" y="246" opacity="1"><tspan>2017/11/07</tspan></text><text x="502.97982163854425" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 502.97982163854425 246)" y="246" opacity="1"><tspan>2017/11/08</tspan></text><text x="527.1088538966086" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 527.1088538966086 246)" y="246" opacity="1"><tspan>2017/11/09</tspan></text><text x="551.2378861546732" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 551.2378861546732 246)" y="246" opacity="1"><tspan>2017/11/10</tspan></text><text x="575.3669184127377" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 575.3669184127377 246)" y="246" opacity="1"><tspan>2017/11/11</tspan></text><text x="599.4959506708022" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 599.4959506708022 246)" y="246" opacity="1"><tspan>2017/11/12</tspan></text><text x="623.6249829288668" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 623.6249829288668 246)" y="246" opacity="1"><tspan>2017/11/13</tspan></text><text x="647.7540151869313" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 647.7540151869313 246)" y="246" opacity="1"><tspan>2017/11/14</tspan></text><text x="671.8830474449958" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 671.8830474449958 246)" y="246" opacity="1"><tspan>2017/11/15</tspan></text><text x="696.0120797030603" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 696.0120797030603 246)" y="246" opacity="1"><tspan>2017/11/16</tspan></text><text x="720.1411119611248" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 720.1411119611248 246)" y="246" opacity="1"><tspan>2017/11/17</tspan></text><text x="744.2701442191893" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 744.2701442191893 246)" y="246" opacity="1"><tspan>2017/11/18</tspan></text><text x="768.3991764772538" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 768.3991764772538 246)" y="246" opacity="1"><tspan>2017/11/19</tspan></text><text x="792.5282087353183" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:300px;text-overflow:ellipsis;" text-anchor="end" transform="translate(0,0) rotate(-45 792.5282087353183 246)" y="246" opacity="1"><tspan>2017/11/20</tspan></text></g><g class="highcharts-axis-labels highcharts-yaxis-labels "><text x="39" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:347px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="235" opacity="1"><tspan>0</tspan></text><text x="39" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:347px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="171" opacity="1"><tspan>1</tspan></text><text x="39" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:347px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="107" opacity="1"><tspan>2</tspan></text><text x="39" style="color:#6e6e70;cursor:default;font-size:11px;fill:#6e6e70;width:347px;text-overflow:clip;" text-anchor="end" transform="translate(0,0)" y="43" opacity="1"><tspan>3</tspan></text></g><text x="1073" class="highcharts-credits" text-anchor="end" style="cursor:pointer;color:#999999;font-size:9px;fill:#999999;" y="295">Highcharts.com</text><g class="highcharts-label highcharts-tooltip highcharts-color-1" style="cursor:default;pointer-events:none;white-space:nowrap;" transform="translate(278,-9999)" opacity="0" visibility="visible"><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 249 0 C 252 0 252 0 252 3 L 252 39 C 252 42 252 42 249 42 L 132 42 126 48 120 42 3 42 C 0 42 0 42 0 39 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.049999999999999996" stroke-width="5" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 249 0 C 252 0 252 0 252 3 L 252 39 C 252 42 252 42 249 42 L 132 42 126 48 120 42 3 42 C 0 42 0 42 0 39 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.09999999999999999" stroke-width="3" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 249 0 C 252 0 252 0 252 3 L 252 39 C 252 42 252 42 249 42 L 132 42 126 48 120 42 3 42 C 0 42 0 42 0 39 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.15" stroke-width="1" transform="translate(1, 1)"></path><path fill="rgba(247,247,247,0.85)" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 249 0 C 252 0 252 0 252 3 L 252 39 C 252 42 252 42 249 42 L 132 42 126 48 120 42 3 42 C 0 42 0 42 0 39 L 0 3 C 0 0 0 0 3 0"></path><text x="8" style="font-size:12px;color:#333333;fill:#333333;" y="20"><tspan style="font-size: 10px">2017/11/04</tspan><tspan style="fill:#d93a49" x="8" dy="15">●</tspan><tspan dx="0"> 近30天内的bug解决数量趋势（个）: </tspan><tspan style="font-weight:bold" dx="0">0个</tspan></text></g></svg></div></div>
                    <div class="clear blank25"></div>
                    <!--reportbox end-->
                    <div class="mydataBar borderLine xiao" style="width:330px;height: 20px;">
                        <ul>
                            <li style="width:45px" onclick="changedate(0,this)" class="on">
                                <div>
                                    全部
                                </div>
                                <div class="shuxian"></div>
                            </li>
                            <li style="width:45px" onclick="changedate(1,this)">
                                <div>
                                    今天
                                </div>
                                <div class="shuxian"></div>
                            </li>
                             <li style="width:45px" onclick="changedate(2,this)">
                                <div>
                                    昨天
                                </div>
                                <div class="shuxian"></div>
                            </li>
                            <li style="width:45px" onclick="changedate(3,this)">
                                <div>
                                    一周内
                                </div>
                                <div class="shuxian"></div>
                            </li>
                           <li style="width:45px" onclick="changedate(4,this)">
                                <div>
                                    两周内
                                </div>
                                <div class="shuxian"></div>
                            </li>
                            <li style="width: 60px;" onclick="changedate(5,this)">
                                <div>
                                    一个月内
                                </div>
                                <div class="shuxian"></div>
                            </li>
                            <li style="width:45px" onclick="changedate(6,this)">
                                <div>
                                    半年内
                                </div>
                                <div class="shuxian"></div>
                            </li>
                        </ul>
                    </div>
                    <div class="clear blank25"></div>
                    <div class="dataArea" style="clear:both">
                        <div class="weekOrder divdata">
                            <div class="mtitle">问题状态比例</div>
                            <div class="box" id="bugstatus" style="height: 300px" data-highcharts-chart="2"><div id="highcharts-6" style="position: relative; overflow: hidden; width: 532px; height: 300px; text-align: left; line-height: normal; z-index: 0; font-family: Signika, serif; left: 0px; top: 0px;" class="highcharts-container  highcharts-3d-chart"><svg version="1.1" class="highcharts-root" style="font-family:Signika, serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="532" viewBox="0 0 532 300" height="300"><desc>Created with Highcharts 5.0.2</desc><defs><clipPath id="highcharts-7"><rect x="0" y="0" width="532" height="300" fill="none"></rect></clipPath></defs><rect fill="none" class="highcharts-background" x="0" y="0" width="532" height="300" rx="0" ry="0"></rect><rect fill="none" class="highcharts-plot-background" x="10" y="10" width="512" height="275"></rect><rect fill="none" class="highcharts-plot-border" x="10" y="10" width="512" height="275"></rect><g class="highcharts-series-group"><g class="highcharts-series highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker " transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="rgb(98,166,209)" d="M 188.71015499387534 203.00697199173428 L 188.71015499387534 221.56852499788116 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 188.70922858875764 203.00649617740186 L 188.70922858875764 221.56804918354874 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 255.95431674716505 56.53627999825969 L 255.95431674716505 75.09783300440657 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 255.9766794181769 56.53627523344031 L 255.9766794181769 75.09782823958719 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 188.70922858875764 203.00649617740186 C 158.0072338363303 187.23736615738213 141.5 164.332288431614 141.5 137.5 L 141.5 156.06155300614688 C 141.5 111.35787916502053 192.73377994503272 75.11566889291953 255.95431674716505 75.09783300440657 L 255.95431674716505 56.53627999825969 C 192.73377994503272 56.554115886772664 141.5 92.79632615887367 141.5 137.5 L 141.5 156.06155300614688 C 141.5 182.89384143776087 158.0072338363303 205.798919163529 188.70922858875764 221.56804918354874 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 L 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 370.5 137.5 C 370.5 182.21503140552042 319.23660385562584 218.4637264458597 256 218.4637264458597 C 230.71038493059285 218.4637264458597 209.17173919653914 213.51621083848443 188.71015499387534 203.00697199173428 L 188.71015499387534 221.56852499788116 C 239.87428267755996 247.84684406095073 311.47769300534463 239.82116035359715 348.6408482207051 203.64265871496937 C 363.5031563279973 189.17413377144626 370.5 173.94401131532217 370.5 156.06155300614688 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 L 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><g class="highcharts-point highcharts-color-0 " stroke="#7bbfea" stroke-width="1" stroke-linejoin="round"><path fill="#7bbfea" d="M 255.9766794181769 56.53627523344031 C 319.21328196218786 56.52716797974061 370.4871180234131 92.76847938038301 370.4999976251112 137.48350985845167 C 370.5128772268093 182.19854033652032 319.25992312583406 218.45461751285998 256.0233205818231 218.4637247665597 C 230.72550662796982 218.46736812500174 209.17837325958976 213.5196181481254 188.71015499387534 203.00697199173428 L 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 Z" visibility="visible"></path></g><g class="highcharts-point highcharts-color-1 " stroke="#d93a49" stroke-width="1" stroke-linejoin="round"><path fill="#d93a49" d="M 188.70922858875764 203.00649617740186 C 137.54547253918338 176.72781533062982 126.19615782759789 126.09647807746487 163.359824682377 89.91823922383665 C 185.65130269666648 68.2178397677572 218.0237955782633 56.54698102329092 255.95431674716505 56.53627999825969 L 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 Z" visibility="visible"></path></g></g><g class="highcharts-markers highcharts-series-0 highcharts-pie-series highcharts-color-undefined " transform="translate(10,10) scale(1 1)"><path fill="#d93a49" d="M 0 0" class="highcharts-halo highcharts-color-1" fill-opacity="0.25"></path></g></g><g class="highcharts-data-labels highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker" transform="translate(10,10) scale(1 1)" opacity="1" style="cursor:pointer;"><path fill="none" class="highcharts-data-label-connector highcharts-color-0" stroke="#000000" stroke-width="1" d="M 401.37136329932935 171.7947571137003 C 396.37136329932935 171.7947571137003 376.3086493113369 166.23245121495125 370.602310213566 164.37834924870157 L 364.8959711157951 162.52424728245188"></path><path fill="none" class="highcharts-data-label-connector highcharts-color-1" stroke="#000000" stroke-width="1" d="M 110.62935877419835 103.20228751276152 C 115.62935877419835 103.20228751276152 135.69135068866308 108.76459341151056 141.397689786434 110.61869537776025 L 147.10402888420492 112.47279734400993"></path><g class="highcharts-label highcharts-data-label highcharts-data-label-color-0 " style="cursor:pointer;" transform="translate(406,162)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>未解决</tspan><tspan style="font-weight:bold" dx="0">3</tspan><tspan dx="0">个: 60.0 %</tspan></text></g><g class="highcharts-label highcharts-data-label highcharts-data-label-color-1 " style="cursor:pointer;" transform="translate(0,93)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>已解决</tspan><tspan style="font-weight:bold" dx="0">2</tspan><tspan dx="0">个: 40.0 %</tspan></text></g></g><g class="highcharts-legend"><rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="8" height="8" visibility="hidden"></rect><g><g></g></g></g><text x="522" class="highcharts-credits" text-anchor="end" style="cursor:pointer;color:#999999;font-size:9px;fill:#999999;" y="295">Highcharts.com</text><g class="highcharts-label highcharts-tooltip highcharts-color-1" style="cursor:default;pointer-events:none;white-space:nowrap;" transform="translate(129,-9999)" opacity="0" visibility="visible"><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.049999999999999996" stroke-width="5" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.09999999999999999" stroke-width="3" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.15" stroke-width="1" transform="translate(1, 1)"></path><path fill="rgba(247,247,247,0.85)" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0"></path><text x="8" style="font-size:12px;color:#333333;fill:#333333;" y="20"><tspan style="font-size: 10px">已解决</tspan><tspan style="font-weight:bold" dx="0">2</tspan><tspan dx="0">个</tspan><tspan x="8" dy="15">所占比率: 40.0%</tspan></text></g></svg></div></div>
                        </div>
                        <div class="weekDeal divdata">
                            <div class="mtitle">
                            <div class="mydataBar borderLine xiao" style="width:300px;margin-top: 1rem;height: 20px;margin-right: 1rem;float: right;">
                                <ul>
                                    <li style="width:42px" onclick="changesta(0,this)" class="on">
                                        <div>
                                            全部
                                        </div>
                                        <div class="shuxian"></div>
                                    </li>
                                    <li style="width:43px" onclick="changesta(1,this)">
                                        <div>
                                            未解决
                                        </div>
                                        <div class="shuxian"></div>
                                    </li>
                                     <li style="width:43px" onclick="changesta(2,this)">
                                        <div>
                                            待审核
                                        </div>
                                        <div class="shuxian"></div>
                                    </li>
                                    <li style="width:43px" onclick="changesta(3,this)">
                                        <div>
                                            已拒绝
                                        </div>
                                        <div class="shuxian"></div>
                                    </li>
                                    <li style="width:43px" onclick="changesta(4,this)">
                                        <div>
                                            已解决
                                        </div>
                                        <div class="shuxian"></div>
                                    </li>
                                    <li style="width:43px" onclick="changesta(5,this)">
                                        <div>
                                            已关闭
                                        </div>
                                        <div class="shuxian"></div>
                                    </li>
                                    <li style="width:43px" onclick="changesta(6,this)">
                                        <div>
                                            已延期
                                        </div>
                                        <div class="shuxian" style="background-color:white"></div>
                                    </li>
                                </ul>
                            </div>
                            <span>人员相关问题数量比例</span>
                            </div>
                            <div class="box" id="userbug" style="height: 300px" data-highcharts-chart="0"><div id="highcharts-0" style="position: relative; overflow: hidden; width: 532px; height: 300px; text-align: left; line-height: normal; z-index: 0; font-family: Signika, serif; left: 0.650024px; top: 0px;" class="highcharts-container  highcharts-3d-chart"><svg version="1.1" class="highcharts-root" style="font-family:Signika, serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="532" viewBox="0 0 532 300" height="300"><desc>Created with Highcharts 5.0.2</desc><defs><clipPath id="highcharts-1"><rect x="0" y="0" width="532" height="300" fill="none"></rect></clipPath></defs><rect fill="none" class="highcharts-background" x="0" y="0" width="532" height="300" rx="0" ry="0"></rect><rect fill="none" class="highcharts-plot-background" x="10" y="10" width="512" height="275"></rect><rect fill="none" class="highcharts-plot-border" x="10" y="10" width="512" height="275"></rect><g class="highcharts-series-group"><g class="highcharts-series highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker" transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="rgb(98,166,209)" d="M 326.0815781195086 206.12303122917154 L 326.0815781195086 224.68458423531843 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(0,149,132)" d="M 141.3824209077058 111.25901924361462 L 141.3824209077058 129.82057224976148 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-3 highcharts-3d-side" visibility="visible"></path><path fill="rgb(0,149,132)" d="M 255.45212235510746 52.64719301127653 L 255.45212235510746 71.20874601742341 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-3 highcharts-3d-side" visibility="visible"></path><path fill="rgb(219,96,7)" d="M 184.97692079171105 206.1530964304648 L 184.97692079171105 224.7146494366117 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-2 highcharts-3d-side" visibility="visible"></path><path fill="rgb(0,149,132)" d="M 141.3824209077058 111.25901924361462 C 157.7703628407499 75.62482787961596 202.46009104741233 52.66214321591396 255.45212235510746 52.64719301127653 L 255.45212235510746 71.20874601742341 C 202.46009104741233 71.22369622206082 157.7703628407499 94.18638088576284 141.3824209077058 129.82057224976148 Z" class="highcharts-point highcharts-color-3 highcharts-3d-side" visibility="visible"></path><path fill="rgb(0,149,132)" d="M 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 L 255.5 156.06155300614688 C 255.5 156.06155300614688 255.5 156.06155300614688 255.5 156.06155300614688 Z" class="highcharts-point highcharts-color-3 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 255.4755592155566 52.64718801757935 L 255.4755592155566 71.20874102372622 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 184.9778916966379 206.15359510050754 L 184.9778916966379 224.71514810665442 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(219,96,7)" d="M 141.38204980990292 111.25982617806694 L 141.38204980990292 129.8213791842138 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-2 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 326.080607639765 206.1235303128655 L 326.080607639765 224.6850833190124 L 255.5 156.06155300614688 L 255.5 137.5 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 375.5 137.5 C 375.5 165.6031961670595 358.2236865897029 189.593298431895 326.0815781195086 206.12303122917154 L 326.0815781195086 224.68458423531843 C 358.2236865897029 208.15485143804187 375.5 184.1647491732064 375.5 156.06155300614688 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 L 255.5 156.06155300614688 C 255.5 156.06155300614688 255.5 156.06155300614688 255.5 156.06155300614688 C 255.5 156.06155300614688 255.5 156.06155300614688 255.5 156.06155300614688 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(219,96,7)" d="M 184.97692079171105 206.1530964304648 C 152.80015773239856 189.6264972828459 135.5 165.6211756488531 135.5 137.5 L 135.5 156.06155300614688 C 135.5 146.68186712777344 137.27997334584208 138.7413002331053 141.38204980990292 129.8213791842138 L 141.38204980990292 111.25982617806694 C 137.27997334584208 120.17974722695843 135.5 128.12031412162656 135.5 137.5 L 135.5 156.06155300614688 C 135.5 184.18272865499998 152.80015773239856 208.18805028899277 184.97692079171105 224.7146494366117 Z" class="highcharts-point highcharts-color-2 highcharts-3d-side" visibility="visible"></path><path fill="rgb(219,96,7)" d="M 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 L 255.5 156.06155300614688 C 255.5 156.06155300614688 255.5 156.06155300614688 255.5 156.06155300614688 Z" class="highcharts-point highcharts-color-2 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 326.080607639765 206.1235303128655 C 283.1899158435616 228.18047692625163 227.8873744168114 228.192260251278 184.9778916966379 206.15359510050754 L 184.9778916966379 224.71514810665442 C 227.8873744168114 246.75381325742487 283.1899158435616 246.7420299323985 326.080607639765 224.6850833190124 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 L 255.5 156.06155300614688 C 255.5 156.06155300614688 255.5 156.06155300614688 255.5 156.06155300614688 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><g class="highcharts-point highcharts-color-0" stroke="#7bbfea" stroke-width="1" stroke-linejoin="round"><path fill="#7bbfea" d="M 255.4755592155566 52.64718801757935 C 321.7497278206336 52.63764329754474 375.48649923851156 90.61980371743199 375.49999751103354 137.48271775558254 C 375.508094033003 165.5919896971545 358.2306362242541 189.5897244410264 326.0815781195086 206.12303122917154 L 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 Z" visibility="visible"></path></g><g class="highcharts-point highcharts-color-1" stroke="#d93a49" stroke-width="1" stroke-linejoin="round"><path fill="#d93a49" d="M 326.080607639765 206.1235303128655 C 283.1899158435616 228.18047692625163 227.8873744168114 228.192260251278 184.9778916966379 206.15359510050754 L 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 Z" visibility="visible"></path></g><g class="highcharts-point highcharts-color-2" stroke="#f47920" stroke-width="1" stroke-linejoin="round"><path fill="#f47920" d="M 184.97692079171105 206.1530964304648 C 142.06774974747455 184.1141278649342 124.98156439412516 146.92250491014832 141.38204980990292 111.25982617806694 L 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 Z" visibility="visible"></path></g><g class="highcharts-point highcharts-color-3" stroke="#00ae9d" stroke-width="1" stroke-linejoin="round"><path fill="#00ae9d" d="M 141.3824209077058 111.25901924361462 C 157.7703628407499 75.62482787961596 202.46009104741233 52.66214321591396 255.45212235510746 52.64719301127653 L 255.5 137.5 C 255.5 137.5 255.5 137.5 255.5 137.5 Z" visibility="visible"></path></g></g><g class="highcharts-markers highcharts-series-0 highcharts-pie-series highcharts-color-undefined " transform="translate(10,10) scale(1 1)"></g></g><g class="highcharts-data-labels highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker" transform="translate(10,10) scale(1 1)" opacity="1" style="cursor:pointer;" visibility="visible"><path fill="none" class="highcharts-data-label-connector highcharts-color-0" stroke="#000000" stroke-width="1" d="M 406.2434861895776 102.01991779450896 C 401.2434861895776 102.01991779450896 381.0394601509603 107.582223693258 375.33312105318936 109.43632565950769 L 369.62678195541844 111.29042762575737"></path><path fill="none" class="highcharts-data-label-connector highcharts-color-1" stroke="#000000" stroke-width="1" d="M 154.01771757990338 252.35281528551536 C 159.01771757990338 252.35281528551536 255.49999999999997 234.35281528551533 255.49999999999997 228.35281528551533 L 255.49999999999997 222.35281528551533"></path><path fill="none" class="highcharts-data-label-connector highcharts-color-2" stroke="#000000" stroke-width="1" d="M 104.75982912818657 172.99369795125077 C 109.75982912818657 172.99369795125077 129.96053984903972 167.4313920525017 135.66687894681064 165.57729008625202 L 141.37321804458156 163.72318812000233"></path><path fill="none" class="highcharts-data-label-connector highcharts-color-3" stroke="#000000" stroke-width="1" d="M 132.746030078447 44.580666340561905 C 137.746030078447 44.580666340561905 177.91234669739356 59.14297223931095 181.4390582111484 63.99707420556064 L 184.96576972490323 68.85117617181032"></path><g class="highcharts-label highcharts-data-label highcharts-data-label-color-0 " style="cursor:pointer;" transform="translate(411,92)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>zock </tspan><tspan style="font-weight:bold" dx="0">2</tspan><tspan dx="0">个: 40.0 %</tspan></text></g><g class="highcharts-label highcharts-data-label highcharts-data-label-color-1 " style="cursor:pointer;" transform="translate(38,242)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>何元浩 </tspan><tspan style="font-weight:bold" dx="0">1</tspan><tspan dx="0">个: 20.0 %</tspan></text></g><g class="highcharts-label highcharts-data-label highcharts-data-label-color-2 " style="cursor:pointer;" transform="translate(0,163)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>罗文 </tspan><tspan style="font-weight:bold" dx="0">1</tspan><tspan dx="0">个: 20.0 %</tspan></text></g><g class="highcharts-label highcharts-data-label highcharts-data-label-color-3 " style="cursor:pointer;" transform="translate(16,35)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>杨恩来 </tspan><tspan style="font-weight:bold" dx="0">1</tspan><tspan dx="0">个: 20.0 %</tspan></text></g></g><g class="highcharts-legend"><rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="8" height="8" visibility="hidden"></rect><g><g></g></g></g><text x="522" class="highcharts-credits" text-anchor="end" style="cursor:pointer;color:#999999;font-size:9px;fill:#999999;" y="295">Highcharts.com</text></svg></div></div>
                        </div>
                        <div class="clear blank25"></div>
                        <div class="weekOrder divdata">
                            <div class="mtitle">产品问题比例</div>
                            <div class="box" id="productbug" style="height: 300px" data-highcharts-chart="3"><div id="highcharts-8" style="position: relative; overflow: hidden; width: 532px; height: 300px; text-align: left; line-height: normal; z-index: 0; font-family: Signika, serif; left: 0px; top: 0px;" class="highcharts-container  highcharts-3d-chart"><svg version="1.1" class="highcharts-root" style="font-family:Signika, serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="532" viewBox="0 0 532 300" height="300"><desc>Created with Highcharts 5.0.2</desc><defs><clipPath id="highcharts-9"><rect x="0" y="0" width="532" height="300" fill="none"></rect></clipPath></defs><rect fill="none" class="highcharts-background" x="0" y="0" width="532" height="300" rx="0" ry="0"></rect><rect fill="none" class="highcharts-plot-background" x="10" y="10" width="512" height="275"></rect><rect fill="none" class="highcharts-plot-border" x="10" y="10" width="512" height="275"></rect><g class="highcharts-series-group"><g class="highcharts-series highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker " transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="rgb(98,166,209)" d="M 255.94913000230167 47.3438925744813 L 255.94913000230167 65.90544558062817 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 255.97403166652887 47.34388726867806 L 255.97403166652887 65.90544027482494 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 383.5 137.5 C 383.5 187.29184719828694 326.41630560342617 227.6561146012848 256 227.6561146012848 C 185.58369439657383 227.6561146012848 128.5 187.29184719828694 128.5 137.5 L 128.5 156.06155300614688 C 128.5 106.28235287738175 185.5507156593159 65.92530650451818 255.94913000230167 65.90544558062817 L 255.94913000230167 47.3438925744813 C 185.5507156593159 47.363753498371295 128.5 87.72079987123487 128.5 137.5 L 128.5 156.06155300614688 C 128.5 205.85340020443383 185.58369439657383 246.21766760743168 256 246.21766760743168 C 326.41630560342617 246.21766760743168 383.5 205.85340020443383 383.5 156.06155300614688 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 L 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><g class="highcharts-point highcharts-color-0 " stroke="#7bbfea" stroke-width="1" stroke-linejoin="round"><path fill="#7bbfea" d="M 255.97403166652887 47.34388726867806 C 326.39033580942316 47.33374600364128 383.48565544091855 87.68979144977149 383.49999735547317 137.48163761530645 C 383.5143392700278 187.27348378084142 326.4422724763655 227.64597146628515 256.02596833347116 227.65611273132194 C 185.60966419057684 227.66625399635873 128.51434455908148 187.3102085502285 128.50000264452686 137.51836238469355 C 128.48566251319443 87.73270715866812 185.54158531360042 47.36375607424041 255.94913000230167 47.3438925744813 L 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 Z" visibility="visible"></path></g></g><g class="highcharts-markers highcharts-series-0 highcharts-pie-series highcharts-color-undefined " transform="translate(10,10) scale(1 1)"><path fill="#7bbfea" d="M 0 0" class="highcharts-halo highcharts-color-0" fill-opacity="0.25"></path></g></g><g class="highcharts-data-labels highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker" transform="translate(10,10) scale(1 1)" opacity="1" style="cursor:pointer;"><path fill="none" class="highcharts-data-label-connector highcharts-color-0" stroke="#000000" stroke-width="1" d="M 362.8270972281589 257.65611624086006 C 357.8270972281589 257.65611624086006 256 239.65611624086006 256 233.65611624086006 L 256 227.65611624086006"></path><g class="highcharts-label highcharts-data-label highcharts-data-label-color-0 " style="cursor:pointer;" transform="translate(368,248)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>默认产品</tspan><tspan style="font-weight:bold" dx="0">5</tspan><tspan dx="0">个: 100.0 %</tspan></text></g></g><g class="highcharts-legend"><rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="8" height="8" visibility="hidden"></rect><g><g></g></g></g><text x="522" class="highcharts-credits" text-anchor="end" style="cursor:pointer;color:#999999;font-size:9px;fill:#999999;" y="295">Highcharts.com</text><g class="highcharts-label highcharts-tooltip highcharts-color-0" style="cursor:default;pointer-events:none;white-space:nowrap;" transform="translate(191,-9999)" opacity="0" visibility="visible"><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 109 0 C 112 0 112 0 112 3 L 112 41 C 112 44 112 44 109 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.049999999999999996" stroke-width="5" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 109 0 C 112 0 112 0 112 3 L 112 41 C 112 44 112 44 109 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.09999999999999999" stroke-width="3" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 109 0 C 112 0 112 0 112 3 L 112 41 C 112 44 112 44 109 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.15" stroke-width="1" transform="translate(1, 1)"></path><path fill="rgba(247,247,247,0.85)" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 109 0 C 112 0 112 0 112 3 L 112 41 C 112 44 112 44 109 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0"></path><text x="8" style="font-size:12px;color:#333333;fill:#333333;" y="20"><tspan style="font-size: 10px">默认产品</tspan><tspan style="font-weight:bold" dx="0">5</tspan><tspan dx="0">个</tspan><tspan x="8" dy="15">所占比率: 100.0%</tspan></text></g></svg></div></div>
                        </div>
                        <div class="weekDeal divdata">
                            <div class="mtitle">优先级比例</div>
                            <div class="box" id="bugpriority" style="height: 300px" data-highcharts-chart="4"><div id="highcharts-10" style="position: relative; overflow: hidden; width: 532px; height: 300px; text-align: left; line-height: normal; z-index: 0; font-family: Signika, serif; left: 0.650024px; top: 0px;" class="highcharts-container  highcharts-3d-chart"><svg version="1.1" class="highcharts-root" style="font-family:Signika, serif;font-size:12px;" xmlns="http://www.w3.org/2000/svg" width="532" viewBox="0 0 532 300" height="300"><desc>Created with Highcharts 5.0.2</desc><defs><clipPath id="highcharts-11"><rect x="0" y="0" width="532" height="300" fill="none"></rect></clipPath></defs><rect fill="none" class="highcharts-background" x="0" y="0" width="532" height="300" rx="0" ry="0"></rect><rect fill="none" class="highcharts-plot-background" x="10" y="10" width="512" height="275"></rect><rect fill="none" class="highcharts-plot-border" x="10" y="10" width="512" height="275"></rect><g class="highcharts-series-group"><g class="highcharts-series highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker " transform="translate(10,10) scale(1 1)" style="cursor:pointer;"><path fill="rgb(98,166,209)" d="M 377.2655854821742 109.6530272950047 L 377.2655854821742 128.21458030115159 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 377.2659792917756 109.65388477357524 L 377.2659792917756 128.21543777972212 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 255.97403166652887 47.34388726867806 L 255.97403166652887 65.90544027482494 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 255.94913000230167 47.3438925744813 L 255.94913000230167 65.90544558062817 L 256 156.06155300614688 L 256 137.5 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 255.97403166652887 47.34388726867806 C 312.32289665603435 47.335771978031445 359.86082769279943 71.75666121846248 377.2655854821742 109.6530272950047 L 377.2655854821742 128.21458030115159 C 359.86082769279943 90.31821422460936 312.32289665603435 65.89732498417831 255.97403166652887 65.90544027482494 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(98,166,209)" d="M 256 137.5 C 256 137.5 256 137.5 256 137.5 L 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 Z" class="highcharts-point highcharts-color-0 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 383.5 137.5 C 383.5 187.29184719828694 326.41630560342617 227.6561146012848 256 227.6561146012848 C 185.58369439657383 227.6561146012848 128.5 187.29184719828694 128.5 137.5 L 128.5 156.06155300614688 C 128.5 106.28235287738175 185.5507156593159 65.92530650451818 255.94913000230167 65.90544558062817 L 255.94913000230167 47.3438925744813 C 185.5507156593159 47.363753498371295 128.5 87.72079987123487 128.5 137.5 L 128.5 156.06155300614688 C 128.5 205.85340020443383 185.58369439657383 246.21766760743168 256 246.21766760743168 C 326.41630560342617 246.21766760743168 383.5 205.85340020443383 383.5 156.06155300614688 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><path fill="rgb(192,33,48)" d="M 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 L 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 C 256 156.06155300614688 256 156.06155300614688 256 156.06155300614688 Z" class="highcharts-point highcharts-color-1 highcharts-3d-side" visibility="visible"></path><g class="highcharts-point highcharts-color-0 " stroke="#7bbfea" stroke-width="1" stroke-linejoin="round"><path fill="#7bbfea" d="M 255.97403166652887 47.34388726867806 C 312.32289665603435 47.335771978031445 359.86082769279943 71.75666121846248 377.2655854821742 109.6530272950047 L 256 137.5 C 256 137.5 256 137.5 256 137.5 Z" visibility="visible"></path></g><g class="highcharts-point highcharts-color-1 " stroke="#d93a49" stroke-width="1" stroke-linejoin="round"><path fill="#d93a49" d="M 377.2659792917756 109.65388477357524 C 399.01514814542315 157.0111954500201 362.35370484875835 207.8690115028565 295.38035381261386 223.24799628444197 C 228.40700277646937 238.62698106602744 156.483189561872 212.70342590286964 134.73402070822442 165.34611522642479 C 112.98485185457683 117.98880454997993 149.64629515124165 67.13098849714349 216.61964618738614 51.75200371555803 C 229.99051471675432 48.68167230092182 241.89089527099142 47.347858708273264 255.94913000230167 47.3438925744813 L 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 C 256 137.5 256 137.5 256 137.5 Z" visibility="visible"></path></g></g><g class="highcharts-markers highcharts-series-0 highcharts-pie-series highcharts-color-undefined " transform="translate(10,10) scale(1 1)"><path fill="#d93a49" d="M 0 0" class="highcharts-halo highcharts-color-1" fill-opacity="0.25"></path></g></g><g class="highcharts-data-labels highcharts-series-0 highcharts-pie-series highcharts-color-undefined highcharts-tracker" transform="translate(10,10) scale(1 1)" opacity="1" style="cursor:pointer;"><path fill="none" class="highcharts-data-label-connector highcharts-color-0" stroke="#000000" stroke-width="1" d="M 384.9228939388933 40.29214868227052 C 379.9228939388933 40.29214868227052 337.9960426948 54.85445458101957 334.46933118104516 59.70855654726926 L 330.94261966729033 64.56265851351895"></path><path fill="none" class="highcharts-data-label-connector highcharts-color-1" stroke="#000000" stroke-width="1" d="M 127.07551090963642 234.7058177461224 C 132.07551090963642 234.7058177461224 174.0039573052 220.14351184737333 177.53066881895484 215.28940988112365 L 181.05738033270967 210.43530791487396"></path><g class="highcharts-label highcharts-data-label highcharts-data-label-color-0 " style="cursor:pointer;" transform="translate(390,30)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>急</tspan><tspan style="font-weight:bold" dx="0">1</tspan><tspan dx="0">个: 20.0 %</tspan></text></g><g class="highcharts-label highcharts-data-label highcharts-data-label-color-1 " style="cursor:pointer;" transform="translate(39,225)"><text x="5" style="font-size: 11px; font-weight: bold; color: rgb(0, 0, 0); fill: rgb(0, 0, 0); text-shadow: rgb(255, 255, 255) 1px 1px, rgb(255, 255, 255) -1px -1px, rgb(255, 255, 255) -1px 1px, rgb(255, 255, 255) 1px -1px;" y="16"><tspan>高</tspan><tspan style="font-weight:bold" dx="0">4</tspan><tspan dx="0">个: 80.0 %</tspan></text></g></g><g class="highcharts-legend"><rect fill="none" class="highcharts-legend-box" rx="0" ry="0" x="0" y="0" width="8" height="8" visibility="hidden"></rect><g><g></g></g></g><text x="522" class="highcharts-credits" text-anchor="end" style="cursor:pointer;color:#999999;font-size:9px;fill:#999999;" y="295">Highcharts.com</text><g class="highcharts-label highcharts-tooltip highcharts-color-1" style="cursor:default;pointer-events:none;white-space:nowrap;" transform="translate(225,-9999)" opacity="0" visibility="visible"><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.049999999999999996" stroke-width="5" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.09999999999999999" stroke-width="3" transform="translate(1, 1)"></path><path fill="none" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0" isShadow="true" stroke="#000000" stroke-opacity="0.15" stroke-width="1" transform="translate(1, 1)"></path><path fill="rgba(247,247,247,0.85)" class="highcharts-label-box highcharts-tooltip-box" d="M 3 0 L 103 0 C 106 0 106 0 106 3 L 106 41 C 106 44 106 44 103 44 L 3 44 C 0 44 0 44 0 41 L 0 3 C 0 0 0 0 3 0"></path><text x="8" style="font-size:12px;color:#333333;fill:#333333;" y="20"><tspan style="font-size: 10px">高</tspan><tspan style="font-weight:bold" dx="0">4</tspan><tspan dx="0">个</tspan><tspan x="8" dy="15">所占比率: 80.0%</tspan></text></g></svg></div></div>
                        </div>
                    </div>
                    <div class="clear blank25"></div>
                </div>
                <!--proAalysis end-->
                <div class="clear blank25"></div>
            </div>
                
                <!--paging-->
                <div class="clear blank40"></div>
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
        <div class="problem-info">
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
        

        <div class="problem-log">
            <div class="title"><span class="color-0" onclick="showBox(this,'show-ul')" data-flag="0">隐藏修改日志</span><font class="fz-16">日志</font></div>
            <ul id="show-ul">
            </ul>
        </div>
    </div>
</div>

	<script src="../js/index1.js"></script>
</body>
</html>

