<%@ Page Title="" Language="C#" MasterPageFile="~/AdminMaster.Master" AutoEventWireup="true" CodeBehind="FundsTransferReport.aspx.cs" Inherits="FundsTransferModule.FundsTransferReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
<table>
<tr>
<td>
    Select:
 </td>
 <td><asp:DropDownList ID="ddlList" runat="server" 
        AutoPostBack="True" Width="140px">
    <asp:ListItem>View by</asp:ListItem>
    <asp:ListItem>Year</asp:ListItem>
    <asp:ListItem>Month</asp:ListItem>
    <asp:ListItem>Date</asp:ListItem>
    </asp:DropDownList>    
</td>
</tr>
<tr>
<td>
    Sort according to Date
    </td>
    <td>
     <asp:DropDownList ID="ddlDate" 
        runat="server" AutoPostBack="True" Width="144px" 
            onselectedindexchanged="ddlDate_SelectedIndexChanged">
    <asp:ListItem>--Select--</asp:ListItem>

    </asp:DropDownList>
    </td>
    <td>  
    Sort according to Month
    </td>
 
    <td>

        <asp:DropDownList ID="ddlMonth" runat="server" Width="144px" >
       <asp:ListItem>Jan</asp:ListItem>
    <asp:ListItem>Feb</asp:ListItem>
    <asp:ListItem>March</asp:ListItem>
        <asp:ListItem>April</asp:ListItem>
    <asp:ListItem>May</asp:ListItem>
    <asp:ListItem>June</asp:ListItem>
        <asp:ListItem>July</asp:ListItem>
    <asp:ListItem>August</asp:ListItem>
    <asp:ListItem>September</asp:ListItem>
        <asp:ListItem>October</asp:ListItem>
    <asp:ListItem>November</asp:ListItem>
    <asp:ListItem>December</asp:ListItem>
        </asp:DropDownList>

    </td>
       <td>  
    Sort according to Year
    </td>
    <td>

        <asp:DropDownList ID="ddlYear" runat="server" Width="144px">
            <asp:ListItem>2013</asp:ListItem>
    <asp:ListItem>2012</asp:ListItem>
        </asp:DropDownList>

    </td>
</tr>

      </table>
</asp:Content>
