<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.qcit.model.ItemsListVo"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="renderer" content="webkit" />
<link type="image/x-icon" rel="icon" href="/favic.ico" />
<title>我的项目</title>
<meta name="Keywords" content="" />
<meta name="Description" content="" />
<link rel="stylesheet" href="../css/base.css" type="text/css">
<link rel="stylesheet" href="../css/iconfont.css" type="text/css">
<link rel="stylesheet" href="../css/bugdone.css" type="text/css">
<link rel="stylesheet" href="../css/jquery-ui.css" type="text/css">
<link rel="stylesheet" href="../css/project.info.css" type="text/css">
<link rel="stylesheet" href="../css/animate.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/animate.min.css" />
<link rel="stylesheet" type="text/css" href="../css/layer.css" />
<link rel="stylesheet" type="text/css"
	href="../css/jquery.layer.min.css">
<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/jquery.layer.min.js"></script>
<style>
.projectList .p-cont ul:after {
	display: block;
	content: "";
	clear: both;
}

.ui-state-highlight {
	background: white;
	border: 1px dashed #ccc;
}
</style>

</head>
<body class="of-hidden">
	<div class="header bg-white">
		<div class="logo f-l" style="cursor: pointer;"
			onclick="window.location.href='https://www.bugdone.cn/home'">
			<img src="../image/logo.png" alt="BUGDONE" />
		</div>
		<div class="m-p fz-14 fw-bold f-l p-relative" id="hoverShow1">
			<input type="hidden" id="hidtype" /> <i
				class="iconfont icon-arrow-copy p-absolute"></i> <label id="type0">我参与的项目</label>
			<div id="types"
				class="show-box p-absolute bg-white bd-e2 b-radius4 d-none">
				<a id="type1" href="javascript:void(0)" class="on"
					onclick="GetProjects(1);">我参与的项目</a> <a id="type2"
					href="javascript:void(0)" onclick="GetProjects(2);">我拥有的项目</a> <a
					id="type3" href="javascript:void(0)" onclick="GetProjects(3);">隐藏的项目</a>
				<a id="type4" href="javascript:void(0)" onclick="GetProjects(4);">关闭的项目</a>
			</div>
		</div>
		<div class="user-info f-r p-relative" id="hoverShow2">
			<div class="avatar p-absolute loaduserdiv">
				<i class="online-status" id="bugtalkStatus"></i> <img id="imgUser"
					src="../image/22.png" alt="" class='loaduser' />
				<style>
.loaduser {
	width: 100% !important;
	height: 100% !important;
}

.loaduserdiv {
	top: 5px !important;
	left: 10px !important;
}

.online-status {
	width: 8px;
	height: 8px;
	border-radius: 50%;
	border: 2px solid #fff;
	position: absolute;
	right: -10px;
	top: 0;
	background: #1ab064
}

.online-status-off {
	background: #ababab
}


</style>
			</div>
			<div class="name fz-14 fw-bold p-relative">
				<i class="iconfont icon-arrow-copy p-absolute"></i>
				<div id="lblUser" style='min-width:44px;min-height:10px'>${user.username}</div>
				<div id="userinfo"
					class="show-box p-absolute bg-white bd-e2 b-radius4 d-none fz-14">
					<div class="avatar1 p-absolute" onclick="changePhoto();">
						<img id="imgUserEdit" src="../image/22.png" alt="" /> <span
							class="changeBj" style="display: none;"></span> <span
							class="changeTxt" style="display: none;">修改头像</span>
					</div>
					<br> <a href="javascript:void(0)" onclick="changeUserEmail();"
						class="logout"><i class="iconfont icon-youxiang"></i>修改邮箱</a> <a
						href="javascript:void(0)" onclick="changeUserName();"><i
						class="iconfont icon-name"></i>修改姓名</a> <a href="javascript:void(0)"
						onclick="changeUserPassword();"><i class="iconfont icon-lock"></i>修改密码</a>
					<a href="javascript:void(0)" onclick="openlogin();" class="logout"><i
						class="iconfont icon-shouji"></i>手机登陆</a> <a href="javascript:void(0)"
						onclick="logout();"><i class="iconfont icon-tuichu"></i>退出</a>
				</div>
			</div>
		</div>
		<div class="f-r notice p-relative" style='display:none'>
			<span class="num textbg-1 ta-center p-absolute">2</span> <a href="#"
				title="消息"><i class="iconfont icon-tongzhi"></i></a>
		</div>
		<!--关于-->
		<div class="f-r">
			<i class="iconfont icon-banben" onClick="aboutClick()"
				style="margin: -0.2rem 1.5rem;" title="关于BugDone"></i>
		</div>
		<div class="f-r">
			<i class="iconfont icon-huiyuanquanyi" id="userPackage"
				onClick="packageClick()" title="了解付费版本"></i>
		</div>
		<!--二维码-->
		<div class="f-r shouji">
			<i class="iconfont icon-shouji"
				style="margin: -0.2rem 1.9rem 0 .5rem;font-size: 24px;line-height:64px;cursor:pointer;"
				onclick='opencode()' title="扫一扫"></i>
		</div>
		<!--消息-->
		<div class="f-r">
			<i class="iconfont icon-chat1"
				style="margin: -0.2rem 1rem 0 .5rem;font-size: 24px;line-height:65px;cursor:pointer;"
				onclick='getchat()' title="暂无新消息"></i>
		</div>
		<!--二维码弹出窗-->
		<style>
.code-grag-bg {
	width: 100%;
	height: 100%;
	position: fixed;
	background: url(../image/rgba0_25.png);
	left: 0;
	top: 0;
	z-index: 90;
}

.code-system {
	width: 410px;
	position: absolute;
	top: 50%;
	height: 12rem;
	overflow: hidden;
	margin-top: -160px;
	left: 50%;
	margin-left: -305px;
	background: #fff;
	z-index: 99;
	border-radius: 6px;
	padding: 3rem 0 0 3rem
}

.code-system .icon-guanbi1 {
	font-size: 24px;
	position: absolute;
	right: 10px;
	top: 20px;
	cursor: pointer;
}

.code-system .icon-guanbi1:hover {
	color: #264d79;
}

.imgdiv {
	float: left
}
</style>
		<div class="code-grag-bg d-none" onClick="closecode()"></div>
		<div class="code-system d-none" style='width:580px'>
			<i class="iconfont icon-guanbi1 color-8" onclick="closecode()"
				style="margin-right: 20px;"></i>
			<div class='imgdiv'>
				<img src='../image/phonebugdone.png' style='width:10rem'><span
					style='position: absolute;top: 13.5rem;left: 5rem;'>bugdone手机端</span>
			</div>
			<div
				style="float:left;border: 1px solid #0c8bb5;height: 11rem;margin: 0 1rem;"></div>
			<div class='imgdiv'>
				<img src='../image/wechat.jpg' style='width:10rem'><span
					style='position: absolute;top: 13.5rem;left: 17.6rem;'>bugdone公众号</span>
			</div>
			<div
				style="float:left;border: 1px solid #0c8bb5;height: 11rem;margin: 0 1rem;"></div>
			<div class='imgdiv'>
				<img src='../image/xiaochengxu.jpg' style='width:10rem'><span
					style='position: absolute;top: 13.5rem;right: 4.1rem;'>bugdone小程序</span>
			</div>
		</div>
		<!--手机登录弹出窗-->
		<style>
.login-grag-bg, .package-grag-bg {
	width: 100%;
	height: 100%;
	position: fixed;
	background: url(../image/rgba0_25.png);
	left: 0;
	top: 0;
	z-index: 90;
}

.login-system {
	width: 200px;
	position: absolute;
	top: 50%;
	height: 12rem;
	overflow: hidden;
	margin-top: -160px;
	left: 60%;
	margin-left: -305px;
	background: #fff;
	z-index: 99;
	border-radius: 6px;
	padding: 3rem 0 .5rem 2.2rem
}

.login-system .icon-guanbi1 {
	font-size: 24px;
	position: absolute;
	right: 10px;
	top: 20px;
	cursor: pointer;
}

.login-system .icon-guanbi1:hover {
	color: #264d79;
}
</style>
		<div class="login-grag-bg d-none" onClick="closelogin()"></div>
		<div class="login-system d-none">
			<i class="iconfont icon-guanbi1 color-8" onclick="closelogin()"
				style="margin-right: 20px;"></i>
			<div class='imgdiv'>
				<img id='logincodeimg' src='' style='width:10rem'><span
					style="position: absolute;top: 13.5rem;padding: 0 1.5rem;left: .7rem;">该登录二维码含有您的个人信息，请勿转发给其它用户。</span>
			</div>
		</div>
		<!--关于弹出窗-->
		<style>
.about-grag-bg {
	width: 100%;
	height: 100%;
	position: fixed;
	background: url(../image/rgba0_25.png);
	left: 0;
	top: 0;
	z-index: 90;
}
</style>
		<div class="about-grag-bg d-none" onClick="closeAbout()"></div>
		<div class="about-system d-none">
			<div class="logo">
				<img src="../image/logo.png" style="display: initial;" />
			</div>
			<div class="info">
				<i class="iconfont icon-guanbi1 color-8" onClick="closeAbout()"
					style="margin-right: 20px;"></i>
				<h1>BUGDONE，bug管理系统</h1>
				<p>版本号：V1.0.0.BETA</p>
				<p>
					<a href="/newslist/" class="button">版本更新日志</a>
				</p>
				<p class="copyright">
					奇创科技创新团队版权所有<br />bugdone.cn
				</p>
			</div>
		</div>
		<div class="package-grag-bg d-none" onClick="closePackage()"></div>
		<div class="package-system d-none">
			<div class="logo">
				<img src="../image/logo.png" style="display: initial;" />
			</div>
			<div class="info">
				<i class="iconfont icon-guanbi1 color-8" onClick="closePackage()"
					style="margin-right: 20px;"></i>
				<h1>BugDone现已永久免费</h1>
				<p
					style="height: 40px;line-height: 40px;margin: 15px 0px 50px 0px;color:#264d79">无限项目数、无限成员数，无限bug数</p>
				<p class="copyright">
					如有疑问欢迎联系BugDone团队<br />Email：xxxx@xxx.com
				</p>
			</div>
		</div>
		<!--        <div class="f-r notice p-relative">
            <span class="num textbg-1 ta-center p-absolute">2</span>
            <a href="#" title="消息"><i class="iconfont icon-tongzhi"></i></a>
        </div>-->
	</div>
	<!--header-->
	<div id="scrollCont" style="height: 600px;overflow:auto;">
		<div class="projectList mainbox">
			<div class="p-head p-relative">
				<a href="javascript:void(0)" id="addproject"
					class="button p-absolute fz-14 bg-white color-0 b-radius4 bd-08 animated tada"
					onclick="addProject();"> <img src="../image/icon-add.png"
					class="f-l" />添加项目

				</a>


				<div class="tab bd-e2 b-radius4 p-relative of-hidden">
					<ul class="ta-center color-a" id="tabShow">
						<i class="line p-absolute"></i>
						<li class="f-l on" data-id="1"><i class="icon icon-b"></i>大图标
						</li>
						<li class="f-l" data-id="2"><i class="icon icon-s"></i>小图标</li>
					</ul>
				</div>
			</div>

			<div id="tabBox">
				<div class="p-cont p-cont1 animated bounceInUp">
					<ul id="ulb">
						<c:if test="${not empty items}">
							<c:forEach items="${items}" var="item">


								<li class="bs-08 ui-state-default ui-sortable-handle"
									projectid="6f917cc1f60d4cad85909737e5644eb9"
									style="position:relative;"><span
									style="color:white;padding:5px;position:absolute;right:0px;top:0px;background:green;border-radius:2px;">${item.creater}的创建</span>
									<div class="name">
										<a href="/ProjectConsole-6f917cc1f60d4cad85909737e5644eb9"
											title="bug管理系统"><label id="itemname">${item.name }</label></a>
									</div>
									<div class="image bd-e2 b-radius4">
										<a
											href="../items/project1?id=${item.id }&&actionnumber=${item.actionnumber }&&problemnumber=${item.problemnumber}">
											<img src="..${item.pic }" alt="bug管理系统" width="100"
											align="middle">
										</a>
									</div>
									<div class="info info-1" style="overflow: visible;">
										<span class="f-l"> <font class="f-l color-8">活动问题</font>
											<i class="num n-bg1 f-l">${item.actionnumber}</i></span> <span
											class="f-l"> <font class="f-l color-8">我的待办</font> <i
											class="num n-bg2 f-l">${item.problemnumber}</i>
										</span>
									</div>
									<div class="btn">
										<a href="javascript:void(0)"
											onclick="changeSetting('6f917cc1f60d4cad85909737e5644eb9');"><i
											class="iconfont icon-iconshezhi01"></i>配置</a> <a
											href="javascript:void(0)"
											onclick="copyProject('6f917cc1f60d4cad85909737e5644eb9');"><i
											class="iconfont icon-fuzhi"></i>复制</a> <a
											href="javascript:void(0)"
											onclick="out('6f917cc1f60d4cad85909737e5644eb9');"><i
											class="iconfont icon-tuichu1"></i>退出</a>
									</div></li>

								<!--tabBox-->
							</c:forEach>
						</c:if>
					</ul>
				
				</div>
				<div class="clear"></div>
				<div class="p-cont p-cont2 d-none">
					<ul id="uls">
					</ul>
					
				</div>
					
			</div>
		
		</div>
	
		<!--projectList-->

		<div class="clear blank40"></div>
	</div>
	<!--项目总览-->

	<style>
.proinfo-problem .list strong {
	width: 28px
}

.proinfo-problem .list li {
	cursor: pointer
}
</style>
	<div class="aside-project-info" style="right:-460">
		<div class="proinfo-title">
			<span class="on"><i style="display:none"
				class="iconfont icon-biaoji"></i></span><i
				class="iconfont icon-arrow-right f-l" onclick="asideProjectHide()"></i>项目总览
		</div>
		<div id="proinfo-cont">
			<div class="proinfo-data">
				<ul class="clearfix">
					<li><strong id="cpcount"><c:if test="${not empty indexNumber.createProjectNumber}">${indexNumber.createProjectNumber}</c:if>
					<c:if test="${  empty indexNumber.createProjectNumber}">0</c:if></strong>
					<p class="color-a">创建项目数</p></li>
					<li><strong id="pccount"><c:if test="${not empty indexNumber.joinProjectNumber}">${indexNumber.joinProjectNumber}</c:if>
					<c:if test="${empty indexNumber.joinProjectNumber}">0</c:if>
					</strong>
					<p class="color-a">参与项目数</p></li>
					<li><strong id="tdcount" class="color-red"><c:if test="${not empty indexNumber.waitToSolveProblemNumber}">${indexNumber.waitToSolveProblemNumber}</c:if> 
					<c:if test="${empty indexNumber.waitToSolveProblemNumber}">0</c:if>
					</strong>
					<p class="color-a">待办问题数</p></li>
					<li><strong id="sdcount"><c:if test="${not empty indexNumber.solveProblemNumber}">${indexNumber.solveProblemNumber}</c:if> 
					<c:if test="${empty indexNumber.solveProblemNumber}">0</c:if></strong>
					<p class="color-a">解决问题数</p></li>
					<li><strong id="ctcount"><c:if test="${not empty indexNumber.createProblemNumber}">${indexNumber.createProblemNumber}</c:if> 
					<c:if test="${empty indexNumber.createProblemNumber}">0</c:if></strong>
					<p class="color-a">创建问题数</p></li>
				</ul>
			</div>
			<div class="proinfo-chart">
				<div class="name">创建问题与解决报表（近7天）</div>
				<div class="reportbox" id="bugcount" style="height: 180px"></div>
			</div>
			<div class="proinfo-problem">
				<div class="title">
					待办问题
					<div class="tabs">
						<ul>
							<li class="active" onclick="ChangeLi(1,this)">按项目</li>
							<li onclick="ChangeLi(2,this)">按优先级</li>
							<li onclick="ChangeLi(3,this)">按时间</li>
						</ul>
					</div>
				</div>
				<div id="bindate"></div>
			</div>
			<!--//proinfo-problem-->
		</div>
		<!--//proinfo-cont-->
	</div>
<div id="tianjia">
	<!--//aside-project-info-->
	<div class="aside-project-click" onClick="asideProjectShow()"></div>

	<div id="tianjiaxiangmu" style="display: none;">
		<div id="layui-layer-iframe2" class="layui-layer-shade" times="2"
			style="z-index: 19891015; background-color:#000 ; opacity: 0.6; filter: alpha(opacity=60);"></div>
		<div id="layui-layer2"
			class="layui-layer layui-layer-iframe layer-anim" type="iframe"
			times="2" showtime="0" copytype="string"
			style="z-index: 19891016;width: 70%;height: 60%; top: 100px;left: 205px;">
			<div class="layui-layer-title" style="cursor: move;">添加项目</div>
			<div id="" class="layui-layer-content">
		
				<div class="window-box bg-white b-radius4">
					<div class="projectSetup p-relative of-hidden">
						<div class="tab-left" style="height: 339px;" tabindex="5006">
							<i class="line"></i>
							<ul id="lefttable">
								<li class="active">基本信息</li>
								<li id="pUmanage" class="">成员管理</li>
								<li id="pPmanage" class="">产品管理</li>
								<li>扩展属性</li>
								<li id="pFmanage" class="">功能设置</li>
								<li id="pPmanage" class="">个人设置</li>
							</ul>
						</div>
						<div class="tabBox-right" style="height: 339px; overflow: scroll;"
							tabindex="5007">
							<div class="tabBox"
								style="min-height: 530px; height: 530px; overflow: hidden;display: block;"
								tabindex="5000">
								<div id="projectcount" class="drag-tips" style="">您的版本为免费版，创建项目的数量不受限制</div>
								<br>
								<div class="basic-info p-relative">
									<div class="logo project-logo">
										<img id="imgProjectImg" src="../image/logoshort0.png" /> <span
											class="projectHeadImageGray"
											style="cursor: pointer; display:none;"></span> <span
											class="projectHeadImageGray projectHeadImageGray-text"
											style="cursor: pointer; color: white; display: none;"
											id="btnChangePhoto">设置项目图片</span>
									</div>

									<div class="clear"></div>
									<div class="version">免费版</div>
									<div class="input-text">
										<span>项目名称</span> <input id="txtProjectName" class="main-text"
											name="" type="text" />
									</div>
									<div class="input-text">
										<span>项目描述</span>
										<textarea id="txtDescription" class="main-text"
											placeholder="最多输入500个字符" maxlength="500" cols="" rows=""></textarea>
									</div>
									<div id="aftersuccess1">
									<div class="info fz-14" id="createInfoBox"
										style="display: none;">
										<p>
											<span class="color-8">创建时间</span><label
												id="txtProjectCreateTime"></label>
										</p>
										<p>
											<span class="color-8">创建人</span><label
												id="txtProjectCreateUser"></label>
										</p>
									</div></div>
									<input id="bodySaveBtn" class="button" name=""
										onclick="btnSave_Click()" value="创建" type="button" />
										<div id="aftersuccess">
									<div class="gray-button" id="btnClose"
										onclick="btnClose_Click();" style="display: none;">关闭项目</div>
									<div class="gray-button" id="btnChangeUser"
										onclick="btnChangeUser_Click();" style="display: none;">变更拥有者</div>
									<div class="gray-button" id="btndeleteproject"
										onclick="deleteProject();" style="display: none;">删除项目</div>
								</div></div>
								<div class="clear"></div>
							</div>
							
							
							<!--成员管理-->
							<div class="tabBox d-none "
								style="min-height: 530px; height: 530px; overflow: hidden; display: none;"
								tabindex="5001">
								<div class="drag-tips">可拖动角色标签、人员标签重新排列顺序</div>
								<div class="member dragBox1">
									<div id="divUsers">
										<div class="drag-box">
											<div class="name">
												默认分组
												<div class="btn">
													<a href="#"
														onclick="editRole('bc8efc15-9012-4f2e-b6ba-9eef45a4a9f9','默认分组')">编辑</a>
													<a href="#"
														onclick="btnRemoveRole_Click('bc8efc15-9012-4f2e-b6ba-9eef45a4a9f9')">删除</a>
												</div>
											</div>

											<div class="box" rid="bc8efc15-9012-4f2e-b6ba-9eef45a4a9f9">

				                   
<label id="itemsid" style="display:none;" ></label>
    <div id="numbersuccess">
												<ul id="numberlist">
												    
												
													<li class="li-drag pUserLi"
														puserid="e179f360-5299-477d-ae5e-d2b12e56a66a"><span
														class="status color-success">正常</span> <img
														src="../image/22.png" ondragstart="return false">
														<p>
														
															<label id="txtCreater"></label> <font class="color-red">
																<label id="txtAdmin"></label>
															</font>
														</p>
														<p>
															<label id="txtCreaterEmail"></label>
														</p>
														</li>
														
													
												</ul>
												</div>
											</div>
											<div id="toaddbox">
											<li class="li-drag add-member" drag="no"
														onclick="addMember('bc8efc15-9012-4f2e-b6ba-9eef45a4a9f9')">+添加成员</li></div>
										</div>
									</div>
									<div class="add-role" onclick="addRole()">+添加角色</div>
									<div class="add-role" onclick="copyUsers()">从其他项目复制成员</div>
								</div>
								<!--member-->

							</div>
							<!--产品管理-->
							<div class="tabBox d-none "
								style="min-height: 530px; height: 530px; overflow: hidden; display: none;"
								tabindex="5002">
								<div class="drag-tips">可拖动产品标签、模块标签重新排列顺序</div>
								<div class="member module dragBox2">
									<div id="productBox">
										<div class="drag-box">
											<div class="name">
												<div class="btn">
													<a href="#"
														onclick="editProduct('f97d4b56-db09-405b-971b-52c7eb9f70e0','默认产品','0');">编辑</a><a
														href="#"
														onclick="btnRemoveProduct_Click('f97d4b56-db09-405b-971b-52c7eb9f70e0');">删除</a>
												</div>
												默认产品
											</div>
											<div class="box" pid="f97d4b56-db09-405b-971b-52c7eb9f70e0">
												<ul>
													<li class="li-drag moduleLi"
														mid="2e4742a6-06cc-42ea-9dd1-d1ce9460ce53"><div
															class="btn" drag="no">
															<a href="#"
																onclick="editModule(this,'f97d4b56-db09-405b-971b-52c7eb9f70e0')">编辑</a><a
																href="#"
																onclick="btnRemoveModule_Click('2e4742a6-06cc-42ea-9dd1-d1ce9460ce53')">删除</a>
														</div>
														<div class="li-tit">默认模块</div></li>
													<li class="li-drag add-member" drag="no"
														onclick="addModule('f97d4b56-db09-405b-971b-52c7eb9f70e0')">+添加模块</li>
												</ul>
											</div>
										</div>
									</div>
									<div class="add-role" onclick="addProduct()" id="btnAddProduct">+添加产品</div>

								</div>
								<!--member-->

							</div>
							<input id="txtCurrentProductId" value="" style="display: none;"
								type="hidden">
							<!--拓展属性-->
							<div class="tabBox d-none"
								style="min-height: 530px; height: 530px; overflow: hidden; outline: none; display: none;"
								tabindex="5003">
								<div class="drag-tips" style="margin-bottom:0">拖动已开启属性标签重新排列顺序</div>
								<div class="setUp">
									<div class="class-name">扩展属性</div>
									<div class="list dragBox3">
										<ul class="clearfix" id="EABox">
											<li class="li-drag"><div class="inner">
													<input type="checkbox" drag="no" siname="版本"
														siid="EnableVersion" onchange="ea_Change(this)" value=""
														class="checkbox">
													<div class="checkbox-style checkbox-click" data-flag="0">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" style="position: relative;"
														alt="提交bug时启用版本"></i>启用版本
												</div></li>
											<li class="li-drag"><div class="inner">
													<input type="checkbox" drag="no" siname="环境"
														siid="EnableEnvironment" onchange="ea_Change(this)"
														value="" class="checkbox">
													<div class="checkbox-style checkbox-click" data-flag="0">
														<i></i>
													</div>
													<div class="set" id="btnEnvironment"
														style="position: relative;" drag="no"
														onclick="btnEnvironment_Click();">
														<a href="#" class="color-8"><i
															class="iconfont icon-iconshezhi01"></i></a>
													</div>
													<i class="iconfont icon-wenhao" style="position: relative;"
														alt="提交bug时启用环境"></i>启用环境
												</div></li>
											<li class="li-drag"><div class="inner">
													<input type="checkbox" drag="no" siname="标签"
														siid="EnableTag" onchange="ea_Change(this)" value=""
														class="checkbox">
													<div class="checkbox-style checkbox-click" data-flag="0">
														<i></i>
													</div>
													<div class="set" id="btnTag" style="position: relative;"
														drag="no" onclick="btnTag_Click();">
														<a href="#" class="color-8"><i
															class="iconfont icon-iconshezhi01"></i></a>
													</div>
													<i class="iconfont icon-wenhao" style="position: relative;"
														alt="提交bug时启用标签"></i>启用标签
												</div></li>
											<li class="li-drag"><div class="inner">
													<input type="checkbox" drag="no" siname="评估"
														siid="EnableEvaluation" onchange="ea_Change(this)"
														value="" class="checkbox">
													<div class="checkbox-style checkbox-click" data-flag="0">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" style="position: relative;"
														alt="提交bug时启用评估"></i>启用评估
												</div></li>
											<li class="li-drag"><div class="inner">
													<input type="checkbox" drag="no" siname="计划时间"
														siid="EnablePlanTime" onchange="ea_Change(this)" value=""
														class="checkbox">
													<div class="checkbox-style checkbox-click" data-flag="0">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" style="position: relative;"
														alt="提交bug时启用计划时间"></i>启用计划时间
												</div></li>
											<li class="li-drag"><div class="inner">
													<input type="checkbox" drag="no" siname="计划版本"
														siid="EnablePlanVersion" onchange="ea_Change(this)"
														value="" class="checkbox">
													<div class="checkbox-style checkbox-click" data-flag="0">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" style="position: relative;"
														alt="提交bug时启用计划版本"></i>启用计划版本
												</div></li>
										</ul>
									</div>
								</div>
							</div>
							<!--项目设置-->
							<div class="tabBox d-none"
								style="min-height: 530px; height: 530px; overflow: hidden; outline: none; display: none;"
								tabindex="5004">
								<div class="setUp">
									<div class="class-name">项目设置</div>
									<div class="list">
										<ul class="clearfix">
											<li>
												<div class="inner">
													<input name="" id="SetEditOnlyByCreator" type="checkbox"
														value="" class="checkbox">
													<div class="checkbox-style" data-flag="0">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" alt="只有创建人才能修改BUG介绍"></i>只有创建人才能修改BUG
												</div>
											</li>
											<li>
												<div class="inner">
													<div class="f-r">
														<label><input name="SetWeekBegins" type="radio"
															value="1" checked="checked">周一</label> <label><input
															name="SetWeekBegins" type="radio" value="7">周日</label>
													</div>
													<i class="iconfont icon-wenhao" alt="每周开始的第一天"></i>周开始日
												</div>
											</li>
											<li>
												<div class="inner">
													<input name="" id="SetEnableTemplate" type="checkbox"
														value="" class="checkbox">
													<div class="checkbox-style" data-flag="0">
														<i></i>
													</div>
													<div class="set" id="btnTemplates"
														onclick="btnTemplates_Click();">
														<a href="#" class="color-8"><i
															class="iconfont icon-iconshezhi01"></i></a>
													</div>
													<i class="iconfont icon-wenhao" alt="提交bug时，bug描述自动填充"></i>自定义模板
												</div>
											</li>

											<li>
												<div class="inner">
													<input name="" id="SetEnableAttention" type="checkbox"
														value="" class="checkbox">
													<div class="checkbox-style" data-flag="0">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" alt="关注自己需要跟进了解的bug"></i>启用关注
												</div>
											</li>
											<li>
												<div class="inner">
													<input name="" id="SetEnableTestCases" type="checkbox"
														value="" class="checkbox">
													<div class="checkbox-style" data-flag="0">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" alt="测试用例"></i>启用测试用例
												</div>
											</li>

										</ul>
									</div>

								</div>

							</div>
							<!--个人-->
							<div class="tabBox d-none"
								style="min-height: 530px; height: 530px; overflow: hidden; outline: none; display: none;"
								tabindex="5005">
								<div class="setUp">
									<div class="class-name">消息订阅</div>
									<div class="list">
										<ul class="clearfix">
											<li>
												<div class="inner">
													<input name="" id="SetEnableEmail" type="checkbox" value=""
														class="checkbox" checked="checked">
													<div class="checkboxe-style checked-style" data-flag="1">
														<i></i>
													</div>
													<i class="iconfont icon-wenhao" alt="是否启用问题变更时的邮件通知"></i>启用邮件通知
												</div>
											</li>
										</ul>
									</div>
								</div>
							</div>

							<div class="wrap-grag-bg d-none first_wrap-grag-bg"
								onclick="closeAddBox()" style="display: none;"></div>
							<div id="addMember" class="set-addBox d-none"
								style="margin-top: -79px; display: none; ">
								<div class="textbox">
									<input name="" type="text" id="txtAddEmail" class="main-text"
										placeholder="输入成员邮箱">
								</div>
								<input type="hidden" id="txtCurrentRoleId"
									value="42d966da-a144-426b-9a6f-ec195accb49e">
								<div class="clear blank20"></div>
								<div class="button">
									<input name="memberName" type="button"
										onclick="btnAddEmail_Click();" value="保存" class="main-button">
										<input name="" type="button" value="取消" class="vice-button"
										onclick="closeAddBox()">
								</div>
							</div>

						</div>
					</div>
				</div>

			</div>

			<span class="layui-layer-setwin" id="close"> <a
				class="layui-layer-ico layui-layer-close layui-layer-close1 iconfont-bugdone icon-guanbi "
				href="javascript:void(0)" onclick="clear_Click()" id="clear_Click"></a>
			</span> <span class="layui-layer-resize"></span>
		</div>

	</div>
	</div>
	
	
	<input name="closecache" id="closecache" type="hidden" value=""></input>
<script  type="text/javascript" src="../js/jquery.pagination.js"></script>
	<script type="text/javascript" src="../js/index.js"></script>
</body>
</html>

