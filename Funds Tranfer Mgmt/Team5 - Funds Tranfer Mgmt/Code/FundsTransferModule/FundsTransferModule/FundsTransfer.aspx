<%@ Page Title="Funds Transfer" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="FundsTransfer.aspx.cs" Inherits="FundsTransferModule.FundsTransfer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .style1
        {
            width: 571px;
        }
        .style2
        {
            width: 0px;
            height: 237px;
        }
        .style3
        {
            font-size: large;
        }
        .style4
        {
            width: 744px;
            height: 259px;
        }
    </style>

    <script  language="javascript" type="text/javascript">
document.onmousedown=disableclick;
status="Right Click Disabled";
    function disableclick(e)
    {
    if(event.button==2)
   {
     alert(status);
     return false;	
   }
}

function CheckRadioButton(rbtid) {
    var gv = document.getElementById("<%=GridView1.ClientID %>");
    var rid = gv.getElementsByTagName("input");
    for (i = 0; i < rid.length; i++) {
        if (rid[i].type == "radio" && rid[i] != rbtid) {
            rid[i].checked = false;
        }
    }
}

function CheckRadioButton1(rbtid) {
    var gv = document.getElementById("<%=GridView2.ClientID %>");
    var rid = gv.getElementsByTagName("input");
    for (i = 0; i < rid.length; i++) {
        if (rid[i].type == "radio" && rid[i] != rbtid) {
            rid[i].checked = false;
        }
    }
}
</script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <center>
<form id="form1" action="">
    <div>
    
        <img alt="" class="style2" src="images/img_fund_transfer.jpg" /><img alt="" 
            class="style4" src="images/img_fund_transfer.jpg" /><br />
        <strong><span class="style3"><em>
        <br />
        <asp:Label ID="lblTitle" runat="server" 
            Text="Transfer Money to anyone,anywhere with just a click of a button.."></asp:Label>
        <br />
        </em></span></strong>
    
        <asp:Label ID="lblcust" runat="server" Font-Bold="True" ForeColor="Blue" 
            style="font-size: large" Text="Select Your Account" Visible="False"></asp:Label>
    
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None" PageSize="4" Width="75%">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                          <asp:RadioButton ID="RadioButton1" runat="server" 
                              onClick="javascript:CheckRadioButton(this)" TabIndex="1" />
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
        GridLines="None" Width="75%">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                      <asp:RadioButton ID="RadioButton2" runat="server" 
                          onClick="javascript:CheckRadioButton1(this)" TabIndex="2" />
                        
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
    <asp:Button ID="btnRefresh" runat="server" onclick="buttonRefresh" 
        Text="Self / Own" Height="25px" />
    <asp:Button ID="btnSelfOthers" runat="server" onclick="btnSelfOthers_Click" 
        Text="Self / Others" />
    <asp:Button ID="btnThirdParty" runat="server" Text="Third Party" 
        onclick="btnThirdParty_Click" />
    <br />
    <br />
    <asp:Panel  ID="PanelSubmit" runat="server" DefaultButton="btnSubmit" >

    <asp:Label ID="lblAmt" runat="server" Text="Amount" Visible="False" 
            style="font-weight: 700"></asp:Label>
&nbsp;<asp:TextBox ID="TxtAmt" runat="server" Visible="False" TabIndex="3" 
            onPaste="return false" MaxLength="5" ToolTip="Please Enter Amount"></asp:TextBox>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label 
            ID="lblRmk" runat="server" Text="Remark" 
        Visible="False" style="font-weight: 700"></asp:Label>
    &nbsp; <asp:TextBox ID="TxtRmk" runat="server" Visible="False" TabIndex="4" 
            ToolTip="Please Enter Remark (Optional)"></asp:TextBox>
    <br />
&nbsp;
<asp:Button ID="btnSubmit" runat="server" onclick="btnSubmit_Click" 
        Text="Submit" ValidationGroup="SubmitTransfer" Visible="False" 
        TabIndex="5" />

    &nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnReset" runat="server" onclick="btnReset_Click" Text="Reset" 
        Visible="False" />
    <br />
    <asp:RequiredFieldValidator ID="revAmount" runat="server" 
        ControlToValidate="TxtAmt" ErrorMessage="Please Enter Amount" ForeColor="Red" 
        ValidationGroup="SubmitTransfer" Display="Dynamic"></asp:RequiredFieldValidator>
        &nbsp;<asp:Label ID="lblTxID" runat="server" ForeColor="Blue"></asp:Label>
&nbsp;
    <br />
    <asp:RegularExpressionValidator ID="revNumber" runat="server" 
        ControlToValidate="TxtAmt" Display="Dynamic" ErrorMessage="Enter in Numbers" 
        ForeColor="Red" ValidationExpression="[0-9]*\.?[0-9]*" 
        ValidationGroup="SubmitTransfer"></asp:RegularExpressionValidator>
        <asp:Label ID="lblrespond" runat="server" ForeColor="Blue"></asp:Label>
    <br />
    <asp:RegularExpressionValidator ID="revInteger" runat="server"
            ControlToValidate="TxtAmt" 
            ErrorMessage="Enter only integers" 
            ValidationExpression="[0-9]*" Display="Dynamic" ForeColor="Red" 
        ValidationGroup="SubmitTransfer" />
        <asp:Label ID="lblResult" runat="server" ForeColor="Blue"></asp:Label>
    <br />
    <asp:RangeValidator ID="revRange" runat="server" 
        ControlToValidate="TxtAmt" Display="Dynamic" 
        ErrorMessage="Amount should be between 0-50000" ForeColor="Red" 
        MaximumValue="50000" MinimumValue="0" ValidationGroup="SubmitTransfer" 
        Type="Integer"></asp:RangeValidator>
   </asp:Panel>

    <asp:Label ID="lblTxnPwd" runat="server" Text="Transaction Password" 
        Visible="False" style="font-weight: 700"></asp:Label>
    <asp:TextBox ID="txtTxnPwd" runat="server" TextMode="Password" Visible="False" 
        TabIndex="6" onPaste="return false" MaxLength="20" 
        ToolTip="Please Enter Transaction Password"></asp:TextBox>

        
      



    <asp:Button ID="btnTransfer" runat="server" onclick="btnTransfer_Click" 
        Text="Transfer" Visible="False" TabIndex="7" />

        

    <br />
    <asp:Label ID="Label1" runat="server" ForeColor="Red" 
        Text="3 Wrong Attempts Will Redirect you to Home Page" Visible="False"></asp:Label>
    <br />
    <br />
    <asp:Panel ID="Panel1" runat="server" DefaultButton="btnTransfer" 
        style="text-align: left">
        <asp:Label ID="lblExceptionStatus" runat="server"></asp:Label>

        

        </asp:Panel>
    </form>
    </center>
</asp:Content>
