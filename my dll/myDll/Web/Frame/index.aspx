﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="RM.Web.Frame.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>中泰欣隆业务管理系统</title>
    <link href="../Themes/Styles/header.css" rel="stylesheet" type="text/css" />
   
    <link href="../jquery-easyui-1.4.5/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="../jquery-easyui-1.4.5/themes/default/easyui.css" rel="stylesheet" type="text/css" />
     <link href="../Themes/Styles/default.css" rel="stylesheet" type="text/css" />
    <script src="../jquery-easyui-1.4.5/jquery.min.js" type="text/javascript"></script>
    <script src="../jquery-easyui-1.4.5/jquery.easyui.min.js" type="text/javascript"></script>
    <script src="../jquery-easyui-1.4.5/locale/easyui-lang-zh_CN.js" type="text/javascript"></script>

	<script type="text/javascript" src='/Themes/Scripts/index.js'> </script>
    <script type="text/javascript" src='/Themes/Scripts/outlook.js'> </script>

    <link href="/Themes/Scripts/ShowMsg/msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/ShowMsg/msgbox.js" type="text/javascript"></script>
    <link href="/Themes/Scripts/artDialog/skins/blue.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/artDialog/artDialog.source.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/FunctionJS.js" type="text/javascript"></script>
    <script type="text/javascript">
        var templateJson = "";
        var _menus = { "menus": [] };
        //设置登录窗口
        function openPwd() {
            $('#w').window({
                title: '修改密码',
                width: 300,
                modal: true,
                shadow: true,
                closed: true,
                height: 160,
                resizable: false
            });
        }
        //关闭登录窗口
        function closePwd() {
            $('#w').window('close');
        }
        //easyui 页面自动填充
        function loadData(url) {
            $.post(url, function (msg) {
                var result = JSON.parse(msg);
                $.each(result, function (name, value) {
                    var object = document.getElementsByName(name);
                    if (object.length > 0) {
                        var type = object[0].parentElement.className;
                        if ("textbox combo datebox" == type) {
                            //时间框处理
                            if (value != '&nbsp;') {
                                var value_ = value.replace(/\//g, '-');
                                $("#" + name).datetimebox('setValue', value_);
                            }
                        } else {
                            var type = $("input[name='" + name + "']").attr('type');
                            if ("radio" == type) {
                                //单选按钮处理
                                $("input[name='" + name + "']").each(function () {
                                    if ($(this).attr("value") == value) {
                                        $(this).attr("checked", "checked");
                                    }
                                });
                            } else {
                                if (value != '&nbsp;') {
                                    $("input[name=\"" + name + "\"]").val(value);
                                    $("textarea[name=\"" + name + "\"]").val(value);
                                    $("select[name=\"" + name + "\"]").val(value);
                                }
                            }
                        }
                    }
                });
            });
        }
        //关闭当前tab，打开指定tab界面
        function closeAddTabs(title) {
            $('#tabs').tabs("select", title);
            var currTab = $('#tabs').tabs('getSelected');
            var ssrc = $(currTab.panel('options').content)[0].src;
            for (i = 0; i < window.frames.length; i++) {
                var aa = window.frames[i].location.href;
                if (ssrc == aa || (ssrc + '#') == (aa)) {

                    window.frames[i].RefreshUI();
                }
            }
        }
        //定制方法
        function addNewTab(subtitle, url, icon) {
            if (!$('#tabs').tabs('exists', subtitle)) {

                $('#tabs').tabs('add', {
                    title: subtitle,
                    content: createFrame(url),
                    closable: true,
                    icon: icon
                });
            } else {
                $('#tabs').tabs('close', subtitle)
                $('#tabs').tabs('add', {
                    title: subtitle,
                    content: createFrame(url),
                    closable: true,
                    icon: icon
                });
            }
            tabClose();
        }
        //定制方法2 
        function addNewTab(subtitle, url, icon) {
            if (!$('#tabs').tabs('exists', subtitle)) {

                $('#tabs').tabs('add', {
                    title: subtitle,
                    content: createFrame(url),
                    closable: true,
                    icon: icon
                });
            } else {
                $('#tabs').tabs('close', subtitle)
                $('#tabs').tabs('add', {
                    title: subtitle,
                    content: createFrame(url),
                    closable: true,
                    icon: icon
                });
            }
            tabClose();
        }
        //定制方法：
        function ProtocalHandler(flags, msg) {
            if (flags == "outsession") {
                $.messager.alert("提示", "登陆超时!", 'info', function () {
                    window.top.location.href = "/login.html"; return;
                })

            } else {

                $.messager.show({ "title": "提示", "msg": msg });
            }
        }

        existss = function (flags, msg) {
            if (flags == "outsession") {
                $.messager.alert("提示", "登陆超时!", 'info', function () {
                    window.top.location.href = "/login.html"; return;
                })

            } else {

                $.messager.show({ "title": "提示", "msg": msg });
            }
        }

        getTabIndex = function () {
            var index = $('#tabs').tabs('getTabIndex', $('#tabs').tabs('getSelected'));
            return index;
        }

        refreshTab = function () {
            //            alert('Hello1');
            //            var index = $('#tabs').tabs('getTabIndex', $('#tabs').tabs('getSelected'));
            //            alert(index);
            //            alert($('#tabs').tabs('getTab', index));
            //            $('#tabs').tabs('getTab', index).panel('refresh');
            var currTab = $('#tabs').tabs('getSelected');
            var url = $(currTab.panel('options').content).attr('src');
            $('#tabs').tabs('update', {
                tab: currTab,
                options: {
                    content: createFrame(url)
                }
            })
        }

        selectTab = function (title) {
            closeTab();
            $('#tabs').tabs("select", title);
            var currTab = $('#tabs').tabs('getSelected');
            var ssrc = $(currTab.panel('options').content)[0].src;
            for (i = 0; i < window.frames.length; i++) {
                var aa=window.frames[i].location.href;
                if (ssrc == aa || (ssrc+'#') == (aa)) {
                    
                    window.frames[i].RefreshUI();
                }
            }
        }
        //关闭当前，选中title页面并刷新
        selectAndRefreshTab = function (title) {
            closeTab();
            $('#tabs').tabs("select", title);
            refreshTab();
        }

        refreshLastTab = function (index) {
            var tabslist = $('#tabs').tabs("tabs");
            for (var i = 0; i < tabslist.length; i++) {
                var tab = tabslist[i];
                if (i == index) {
                    tab.panel('refresh');
                    break;
                }
            }

        }

        closeTab = function () {
            var index = $('#tabs').tabs('getTabIndex', $('#tabs').tabs('getSelected'));
            if (index != 0) {
                $('#tabs').tabs('close', index);
            }

        }
        //关闭当前tab，打开新的tab界面
        function closeAddTab(subtitle, url, icon) {
            //先关闭当前tab
            var index = $('#tabs').tabs('getTabIndex', $('#tabs').tabs('getSelected'));
            if (index != 0) {
                $('#tabs').tabs('close', index);
            }
            //打开一个新的tab
            if (!$('#tabs').tabs('exists', subtitle)) {

                $('#tabs').tabs('add', {
                    title: subtitle,
                    content: createFrame(url),
                    closable: true,
                    icon: icon
                });
            } else {
                $('#tabs').tabs('close', subtitle)
                $('#tabs').tabs('add', {
                    title: subtitle,
                    content: createFrame(url),
                    closable: true,
                    icon: icon
                });
            }
            tabClose();
        }

        //修改密码
        function serverLogin() {
            var $newpass = $('#txtNewPass');
            var $rePass = $('#txtRePass');

            if ($newpass.val() == '') {
                msgShow('系统提示', '请输入密码！', 'warning');
                return false;
            }
            if ($rePass.val() == '') {
                msgShow('系统提示', '请在一次输入密码！', 'warning');
                return false;
            }

            if ($newpass.val() != $rePass.val()) {
                msgShow('系统提示', '两次密码不一至！请重新输入', 'warning');
                return false;
            }

            $.post('/ashx/editpassword.ashx?newpass=' + $newpass.val(), function (msg) {
                if (msg == 'true') {
                    $('#w').window('close');
                    msgShow('系统提示', '恭喜，密码修改成功！<br>您的新密码为：' + $newpass.val(), 'info');
                } else {
                    msgShow('系统提示', '密码修改失败，请稍后重试！', 'error');
                }
                $newpass.val('');
                $rePass.val('');
                close();
            })

        }

        //修改密码
        function editPass() {
            $('#w').window('open');
        }
        //退出系统
        function loginOut() {
            $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function (r) {
                if (r) {
                    location.href = '/ashx/loginout.ashx';
                }
            });
        }

        $(function () {
            $('#tabs').tabs('add', {
                title: '欢迎使用',
                content: '<iframe scrolling="auto" frameborder="0" src="Welcome.aspx" style="width:100%;height:100%;"></iframe>',
                closable: false
            });
            openPwd();

            $('#btnEp').click(function () {
                serverLogin();
            })

            $('#btnCancel').click(function () { closePwd(); })

            $('#loginOut2').click(function () {
                alert("aaaa");
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function (r) {
                    if (r) {
                        location.href = '../ashx/loginout.ashx';
                    }
                });
            })
        });
      
    </script>

</head>
<body class="easyui-layout" style="overflow-y: hidden"  scroll="no">
    <noscript>
    <div style=" position:absolute; z-index:100000; height:2046px;top:0px;left:0px; width:100%; background:white; text-align:center;">
        <img src="/Themes/images/index/noscript.gif" alt='抱歉，请开启脚本支持！' />
    </div>
    </noscript>

    <div region="north" split="true" border="false" style="overflow: hidden; height: 80px;
        background: url(../Themes/images/logo_left.png) no-repeat;
        line-height: 20px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
     <div >
            <div id="HeaderLogo">
            </div>
            <div id="Headermenu" >
            <div id="conten_title">
                <img src="/Themes/Images/index/sun_2.png" alt="" width="20" height="20" /><label id="BeautifulGreetings"> </label>
                <font color="#00CCFF"><%=username %></font>
            </div>
             <div id="toolbar" style="text-align: center; padding-right: 3px;">
                    <img src="/Themes/Images/index/4963_home.png" title="主页" alt="" onclick="rePage()"
                        width="20" height="20" style="padding-bottom: 1px; cursor: pointer; vertical-align: middle;" />
                    &nbsp;&nbsp;&nbsp;<img src="/Themes/Images/32/233.png" title="修改密码" alt=""
                        onclick="editPass();" width="20" height="20" style="padding-bottom: 1px; cursor: pointer;
                        vertical-align: middle;" />
                    &nbsp; &nbsp;<img src="/Themes/Images/index/button-white-stop.png" title="安全退出" alt=""
                        onclick="loginOut()" width="20" height="20" style="padding-bottom: 1px; cursor: pointer;
                        vertical-align: middle;" />
                </div>
        </div>
    </div>
    </div>
    <div region="west" hide="true" split="true" title="导航菜单" style="width:180px;" id="west">
       <%-- <div id="nav" class="easyui-accordion" fit="true" border="false">
		        <!--  导航内容 -->			
		</div>--%>
       <ul id="tt"></ul>  
    </div>

    <div data-options="region:'south',split:true" style="height:20px;"></div>

    <div id="mainPanle" region="center" style="background: #eee; overflow-y:hidden">
        <div id="tabs" class="easyui-tabs"  fit="true" border="false" data-options="
                    tools:[{iconCls : 'icon-reload',handler:refreshTab},
                    {iconCls : 'icon-cancel',handler:closeTab}]  ">
			 
		</div>
    </div>
    
    
    <!--修改密码窗口-->
    <div id="w" class="easyui-window" title="修改密码" collapsible="false" minimizable="false"
        maximizable="false" icon="icon-save"  style="width: 300px; height: 150px; padding: 5px;
        background: #fafafa;">
        <div class="easyui-layout" fit="true">
            <div region="center" border="false" style="padding: 10px; background: #fff; border: 1px solid #ccc;">
                <table cellpadding=3>
                    <tr>
                        <td>新密码：</td>
                        <td><input id="txtNewPass" type="Password" class="txt01" /></td>
                    </tr>
                    <tr>
                        <td>确认密码：</td>
                        <td><input id="txtRePass" type="Password" class="txt01" /></td>
                    </tr>
                </table>
            </div>
            <div region="south" border="false" style="text-align: right; height: 30px; line-height: 30px;">
                <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:void(0)" >
                    确定</a> <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:void(0)">取消</a>
            </div>
        </div>
    </div>

	<div id="mm" class="easyui-menu" style="width:150px;">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseall">全部关闭</div>
		<div id="mm-tabcloseother">除此之外全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-tabcloseright">当前页右侧全部关闭</div>
		<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		<div class="menu-sep"></div>
		<div id="mm-exit">退出</div>
	</div>


</body>
</html>
