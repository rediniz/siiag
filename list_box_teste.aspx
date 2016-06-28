<%@ Page Language="C#" ContentType="text/html" ResponseEncoding="utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>
<body>
<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="MultiSelect.aspx.cs"
    Inherits="ASPxListBox_MultiSelect" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentHolder" runat="Server">
    <table style="margin-bottom: 32px">
        <tr>
            <td>
                Selection mode:
            </td>
            <td>
                &nbsp;
            </td>
            <td>
                <dx:ASPxComboBox ID="lbSelectionMode" runat="server" AutoPostBack="True" OnSelectedIndexChanged="lbSelectionMode_SelectedIndexChanged"
                    SelectedIndex="2">
                    <Items>
                        <dx:ListEditItem Text="Single" Value="0" />
                        <dx:ListEditItem Text="Multiple" Value="1" />
                        <dx:ListEditItem Text="CheckColumn" Value="2" />
                    </Items>
                </dx:ASPxComboBox>
            </td>
        </tr>
    </table>
    <div style="float: left">
        <div class="BottomPadding">
            Phone features:</div>
        <dx:ASPxListBox ID="lbFeatures" runat="server" SelectionMode="CheckColumn" Width="250" Height="210"
            DataSourceID="Features" ValueField="ID" ValueType="System.String" TextField="Name">
            <ClientSideEvents SelectedIndexChanged="function(s, e) {lbModels.PerformCallback('1');}" />
        </dx:ASPxListBox>
    </div>
    <div style="float: left; padding-left: 2%">
        <div class="BottomPadding">
            Accepted models:</div>
        <dx:ASPxListBox ID="lbModels" runat="server" SelectionMode="CheckColumn" Width="300" Height="210px"
            ClientInstanceName="lbModels" DataSourceID="PhoneModels" ValueField="ID"
            ValueType="System.String" OnCallback="lbModels_Callback">
            <Columns>
                <dx:ListBoxColumn FieldName="Name" Caption="Model" Width="100%" />
                <dx:ListBoxColumn FieldName="Price" Width="50px" />
            </Columns>
        </dx:ASPxListBox>
    </div>
    <asp:XmlDataSource ID="Features" DataFile="~/App_Data/PhoneModels.xml" XPath="//Feature"
        runat="server" />
    <asp:XmlDataSource ID="PhoneModels" DataFile="~/App_Data/PhoneModels.xml" XPath="//Model"
        runat="server" />
</asp:Content>
</body>
</html>
