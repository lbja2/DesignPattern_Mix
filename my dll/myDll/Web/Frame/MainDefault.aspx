﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainDefault.aspx.cs" Inherits="RM.Web.Frame.MainDefault" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>欢迎使用中泰进出口业务管理系统</title>
    <link href="/Themes/Styles/Site.css" rel="stylesheet" type="text/css" />
    <link href="/Themes/Styles/Menu.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/jquery-1.8.2.min.js" type="text/javascript"></script>
    <link href="/Themes/Scripts/ShowMsg/msgbox.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/ShowMsg/msgbox.js" type="text/javascript"></script>
    <link href="/Themes/Scripts/artDialog/skins/blue.css" rel="stylesheet" type="text/css" />
    <script src="/Themes/Scripts/artDialog/artDialog.source.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/artDialog/iframeTools.source.js" type="text/javascript"></script>
    <script src="/Themes/Scripts/FunctionJS.js" type="text/javascript"></script>
    <script src="MainFrame.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            GetMenu();
            iframeresize();
            readyIndex();
        })
        //菜单
        var V_JSON = "";
        function GetMenu() {
            var parm = 'action=Menu';
            $("#htmlMenuSelect").empty();
            getAjax('Frame.ashx', parm, function (rs) {
                try {
                    V_JSON = rs;
                    var j = 0;
                    var json = eval("(" + V_JSON + ")");
                    var css = "sel";
                    for (var i = 0; i < json.MENU.length; i++) {
                        var menu = json.MENU[i];
                        if (menu.PARENTID == 0) {
                            if (j == 0) {
                                css = "selected";
                                GetSeedMenu(this, menu.MENU_ID);
                            } else {
                                css = "";
                            }
                            $("#htmlMenuSelect").append("<div class=\"" + css + "\" onclick=\"GetSeedMenu(this,'" + menu.MENU_ID + "')\"><img src='/Themes/Images/MenuLike.gif' />" + menu.MENU_NAME + "</div>");
                            j++;
                        }
                    }
                } catch (e) {
                }
            });
        }
        //子菜单
        function GetSeedMenu(e, menu_id) {
            $("#htmlMenuPanel").empty();
            var j = 0;
            var json = eval("(" + V_JSON + ")");
            for (var i = 0; i < json.MENU.length; i++) {
                var menu = json.MENU[i];
                if (menu.PARENTID == menu_id) {
                    $("#htmlMenuPanel").append("<div onclick=\"NavMenu('" + menu.NAVIGATEURL + "','" + menu.MENU_NAME + "')\"><img src=\"/Themes/Images/32/" + menu.MENU_IMG + "\" />" + menu.MENU_NAME + "</div>");
                }
            }
            readyIndex();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="Container">
        <div id="Header">
            <div id="HeaderLogo">
            </div>
            
            <div id="Headermenu">
            </div>
        </div>
        <div id="Headerbotton">
            <div id="left_title">
                <img src="/Themes/Images/clock_32.png" alt="" width="20" height="20" style="vertical-align: middle;
                    padding-bottom: 1px;" />
                <span id="datetime"></span>
            </div>
            <div id="conten_title">
                <div style="float: left">
                    <img src="/Themes/Images/networking.png" alt="" width="20" height="20" style="vertical-align: middle;
                        padding-bottom: 1px;" />
                    <span>当前位置</span>&nbsp;&nbsp;>>&nbsp;<span style="cursor: pointer;" onclick="windowload()">系统首页</span>
                    <span id="titleInfo" style="cursor: pointer;"></span>
                </div>
                <div id="toolbar" style="text-align: right; padding-right: 3px;">
                    <img src="/Themes/Images/Max_arrow_left.png" title="后退" alt="" onclick="Loading(true);javascript:history.go(-1)"
                        width="20" height="20" style="padding-bottom: 1px; cursor: pointer; vertical-align: middle;" />
                    &nbsp;&nbsp;&nbsp;<img src="/Themes/Images/Max_arrow_right.png" title="前进" alt=""
                        onclick="Loading(true);javascript:history.go(1)" width="20" height="20" style="padding-bottom: 1px;
                        cursor: pointer; vertical-align: middle;" />
                    &nbsp;&nbsp;&nbsp;<img src="/Themes/Images/refresh.png" title="刷新业务窗口" alt="" onclick="Loading(true);main.window.location.reload();return false;"
                        width="20" height="20" style="padding-bottom: 1px; cursor: pointer; vertical-align: middle;" />
                    &nbsp;&nbsp;&nbsp;<img src="/Themes/Images/4963_home.png" title="主页" alt="" onclick="rePage()"
                        width="20" height="20" style="padding-bottom: 1px; cursor: pointer; vertical-align: middle;" />
                    &nbsp;&nbsp;&nbsp;<img src="/Themes/Images/window-resize.png" title="最大化" alt=""
                        onclick="Maximize();" width="20" height="20" style="padding-bottom: 1px; cursor: pointer;
                        vertical-align: middle;" />
                    &nbsp; &nbsp;<img src="/Themes/Images/button-white-stop.png" title="安全退出" alt=""
                        onclick="IndexOut()" width="20" height="20" style="padding-bottom: 1px; cursor: pointer;
                        vertical-align: middle;" />
                </div>
            </div>
        </div>
        <div id="MainContent">
            <div class="navigation" id="navigation" style="padding-top: 1px;">
                <div class="line">
                </div>
                <div class="box-title" style="font-weight: bold;">
                    导航菜单
                </div>
                <div id="htmlMenuPanel" runat="Server" class="navPanelMini">
                </div>
                <div id="htmlMenuSelect" runat="Server" class="navSelect topline">
                </div>
            </div>
            <div id="Content">
                <iframe id="main" name="main" scrolling="auto" frameborder="0" scrolling="yes" width="100%"
                    height="100%" src="HomeIndex.aspx"></iframe>
            </div>
        </div>
    </div>
    <div id="loading" onclick="Loading(false);">
        正在处理，请稍待。。。
    </div>
    <div id="Toploading">
    </div>
    <div id="fullreturn" title="还原" onclick="Fullrestore()">
    </div>
    </form>
</body>
</html>
