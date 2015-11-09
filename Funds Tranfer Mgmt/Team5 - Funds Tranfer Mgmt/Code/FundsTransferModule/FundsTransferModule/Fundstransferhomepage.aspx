<%@ Page Title="home" Language="C#" MasterPageFile="~/User.Master" AutoEventWireup="true" CodeBehind="~/Fundstransferhomepage.aspx.cs" Inherits="FundsTransferModule.Fundstransferhomepage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
     <table>
     <tr>
     <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
         &nbsp;</td>
     
     <td  align="right"><asp:LinkButton ID="lbChangePwd" runat="server" PostBackUrl="ChangePwd.aspx" Text="ChangePassword"></asp:LinkButton> </td>
     </tr>
     </table>
        <asp:Table width="100%" runat="server" >
        <asp:TableHeaderRow>
        </asp:TableHeaderRow>
         
        <asp:TableRow>
            <asp:TableCell HorizontalAlign="Center"><img alt="" class="style2" src="images/img_fund_transfer.jpg" /></asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>&nbsp;</asp:TableCell>
        </asp:TableRow>
        <asp:TableRow>
            <asp:TableCell>        
                <p>Welcome to Funds Transfer Home Page.<br />
                    In this section, you can transfer funds from your account to any another account. 
                    You just need to add payee details. 
                    With this service your transactions are easier, and, with fewer restrictions, they reach further than before.
                </p>
            </asp:TableCell>
        </asp:TableRow>
        </asp:Table>
</asp:Content>
    
