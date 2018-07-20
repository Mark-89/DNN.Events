<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EventMonth.ascx.cs" Inherits="DotNetNuke.Modules.Events.EventMonth" %>
<%@ Register TagPrefix="evt" Namespace="DotNetNuke.Modules.Events.ScheduleControl.MonthControl" Assembly="DotNetNuke.Modules.Events.ScheduleControl" %>
<%@ Register TagPrefix="evt" TagName="Category" Src="~/DesktopModules/Events/SubControls/SelectCategory.ascx" %>
<%@ Register TagPrefix="evt" TagName="Location" Src="~/DesktopModules/Events/SubControls/SelectLocation.ascx" %>
<%@ Register TagPrefix="evt" TagName="Icons" Src="~/DesktopModules/Events/SubControls/EventIcons.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web.Deprecated" Namespace="DotNetNuke.Web.UI.WebControls" %>

<%--<link rel="stylesheet" type="text/css" href="<%=Page.ResolveUrl("~/DesktopModules/Events/Scripts/Resources/jquery-ui.css") %>"/>--%>
<link type="text/css" href="<%=Page.ResolveUrl("~/DesktopModules/Events/Scripts/Resources/jquery-ui.css") %>" rel="Stylesheet" />
<script type="text/javascript" src="<%=Page.ResolveUrl("~/DesktopModules/Events/Scripts/Resources/jquery-ui.min.js") %>"></script>

<dnn:DnnToolTipManager
    ID="toolTipManager" runat="server" HideEvent="LeaveTargetAndToolTip" Modal="False" EnableShadow="True" CssClass="Eventtooltip" ShowCallout="False"/>
<div>
    <div class="EvtHdrLftCol"></div>
    <div class="EvtHdrMdlCol">
        <div>
           <%-- <p>Date: <input type="text" id="datepicker"></p>--%>
            <asp:TextBox ID="txtdate" runat="server" ></asp:TextBox>
            <asp:panel id="pnlDateControls" Runat="server" Visible="True" CssClass="EvtDateControls">
                <asp:LinkButton ID="lnkToday" runat="server" CssClass="CommandButton" OnClick="lnkToday_Click"> Today</asp:LinkButton>&nbsp;
                <dnn:DnnDatePicker id="dpGoToDate" AutoPostBack="true" runat="server" DateInput-CssClass="DateFormat" CssClass="DatePicker"></dnn:DnnDatePicker>
            </asp:panel>
        </div>
        <div style="text-align: center;">
            <evt:Category ID="SelectCategory" runat="server" OnCategorySelectedChanged="SelectCategoryChanged"></evt:Category>
            <evt:Location ID="SelectLocation" runat="server" OnLocationSelectedChanged="SelectLocationChanged"></evt:Location>
        </div>
    </div>
    <div class="TopIconBar EvtHdrRgtCol">
        <evt:Icons ID="EventIcons" runat="server"></evt:Icons>
    </div>
    <div style="clear: both; text-align: center;">
        <evt:DNNCalendar ID="EventCalendar" runat="server" CssClass="Event" CellPadding="0" NextPrevFormat="FullMonth" DayStyle-VerticalAlign="Top"
                         PrevMonthText=" " NextMonthText=" " ShowGridLines="False" SelectMonthText=" " SelectWeekText=" " OnDayRender="EventCalendar_DayRender" OnSelectionChanged="EventCalendar_SelectionChanged" OnVisibleMonthChanged="EventCalendar_VisibleMonthChanged">
            <TodayDayStyle HorizontalAlign="Center" CssClass="EventTodayDay" VerticalAlign="Top"></TodayDayStyle>
            <SelectorStyle HorizontalAlign="Center" CssClass="EventSelector" VerticalAlign="Top"></SelectorStyle>
            <DayStyle HorizontalAlign="Center" CssClass="EventDay" VerticalAlign="Top"></DayStyle>
            <NextPrevStyle HorizontalAlign="Center" CssClass="EventNextPrev" VerticalAlign="Top"></NextPrevStyle>
            <DayHeaderStyle HorizontalAlign="Center" CssClass="EventDayHeader" VerticalAlign="Top"></DayHeaderStyle>
            <SelectedDayStyle HorizontalAlign="Center" CssClass="EventSelectedDay" VerticalAlign="Top"></SelectedDayStyle>
            <TitleStyle HorizontalAlign="Center" CssClass="EventTitle" VerticalAlign="Middle"></TitleStyle>
            <WeekendDayStyle HorizontalAlign="Center" CssClass="EventWeekendDay" VerticalAlign="Top"></WeekendDayStyle>
            <OtherMonthDayStyle HorizontalAlign="Center" CssClass="EventOtherMonthDay" VerticalAlign="Top"></OtherMonthDayStyle>
        </evt:DNNCalendar>
    </div>
    <div class="BottomIconBar">
        <evt:Icons ID="EventIcons2" runat="server"></evt:Icons>
    </div>
</div>

<asp:HiddenField id="hdnDate" runat="server" />
<asp:HiddenField id="hdnFirstDay" runat="server" />

<script type="text/javascript">
    $(document).ready(function() {
        //var dtString = $("#<%=hdnDate.ClientID%>").val();
        //dtString = dtString.split(',');
        //var defaultDate = new Date(dtString[0], dtString[1], dtString[2]);
        var defaultDate = new Date($("#<%=hdnDate.ClientID%>").val());
        var firstDayValue = $("#<%=hdnFirstDay.ClientID%>").val();

        $("[id$=txtdate]").datepicker(
            {
                onSelect: function (value, date) {
                    $.ajax({
                        type: "POST",
                        url: "/DesktopModules/Events/AjaxBridge.aspx/Control_GetTest",
                        data: value,
                        cache: false,
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        beforeSend: function (data) {
                            alert("before");
                        },
                        success: function (data) {
                            alert("Page Load Time from Session " + data.d);
                        },
                        fail: function () {
                            alert("fail");
                        }
                    });

                    $("#<%=hdnDate.ClientID%>").val(new Date(value).toISOString());
                },
                firstDay: firstDayValue,
                showOn: "button",
                buttonImage: "/DesktopModules/Events/Installation/DNN_Events.png",
                buttonImageOnly: true,
                required: true,
                message: "This is a required field"
            }
        );

        $("[id$=txtdate]").datepicker('setDate', defaultDate);

    });
</script>