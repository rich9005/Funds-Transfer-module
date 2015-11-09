<%@ Page Title="Transfer Funds" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="~/FundTransfer.aspx.cs" Inherits="FundsTransferModule.FundTransfer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<%--
  <%--  <script type = "text/javascript" runat="server">
        function changeHashOnLoad() {
            window.location.href += "#";
            setTimeout("changeHashAgain()", "50");
        }

        function changeHashAgain() {
            window.location.href += "1";
        }

        var storedHash = window.location.hash;
        window.setInterval(function () {
            if (window.location.hash != storedHash) {
                window.location.hash = storedHash;
            }
        }, 50);


</script>--%>
</asp:Content>
 <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server" >
<%--<body onload="changeHashOnLoad(); " style="height: 728px"> --%>

    <div>
    
        <asp:Label ID="lblcust" runat="server" Font-Bold="True" ForeColor="Blue" 
            style="font-size: large" Text="Select Your Account" Visible="False"></asp:Label>
    
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:RadioButton ID="rdBtn1" runat="server"  AutoPostBack="true" 
                            oncheckedchanged="RadioSingleSelect" ValidationGroup="SubmitTransfer" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <strong><span class="style1">
        <br />
        </span>
        <asp:Label ID="lblPayee" runat="server" Font-Bold="True" ForeColor="Blue" 
            style="font-size: large" Text="Select Payee" Visible="False"></asp:Label>
        </strong>
        <br />
    
    </div>
    <asp:GridView ID="GridView2" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:RadioButton ID="rdBtn2" runat="server" AutoPostBack="true" 
                        oncheckedchanged="RadioSingleSelect1" />
                        
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <br />
    <asp:Button ID="BtnRefresh" runat="server" onclick="ButtonRefresh" 
        Text="Refresh" Height="25px" />
    <br />
    <asp:Label ID="lblAmt" runat="server" Text="Amount" Visible="False"></asp:Label>
&nbsp;<asp:TextBox ID="TxtAmt" runat="server" Visible="False"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblRmk" runat="server" Text="Remark" 
        Visible="False"></asp:Label>
    &nbsp; <asp:TextBox ID="TxtRmk" runat="server" Visible="False"></asp:TextBox>
    <br />
    <asp:Button ID="BtnSubmit" runat="server" onclick="BtnSubmit_Click" 
        Text="Submit" ValidationGroup="SubmitTransfer" Visible="False" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnReset" runat="server" onclick="btnReset_Click" Text="Reset" 
        Visible="False" />
    <br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        ControlToValidate="TxtAmt" ErrorMessage="Please Enter Amount" ForeColor="Red" 
        ValidationGroup="SubmitTransfer"></asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
        ControlToValidate="TxtAmt" Display="Dynamic" ErrorMessage="Enter in Numbers" 
        ForeColor="Red" ValidationExpression="[0-9]*\.?[0-9]*" 
        ValidationGroup="SubmitTransfer"></asp:RegularExpressionValidator>
    <br />
    <br />
    <asp:Label ID="lblTxID" runat="server" ForeColor="Blue"></asp:Label>
    <br />
    <asp:Label ID="lblrespond" runat="server" ForeColor="Blue"></asp:Label>
    <br />
    <asp:Label ID="lblResult" runat="server" ForeColor="Blue"></asp:Label>
    <br />
    <br />
    <asp:Label ID="lblTxnPwd" runat="server" Text="Transaction Password" 
        Visible="False"></asp:Label>
    <asp:TextBox ID="txtTxnPwd" runat="server" TextMode="Password" Visible="False"></asp:TextBox>
    <asp:Button ID="btnTransfer" runat="server" onclick="btnTransfer_Click" 
        Text="Transfer" Visible="False" />
   
   </asp:Content>