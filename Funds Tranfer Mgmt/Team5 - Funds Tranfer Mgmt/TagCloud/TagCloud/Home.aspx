<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="TagCloud.Home" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
   <%-- <script type="text/javascript" language="javascript">
        var one = 1;
        function County() 
        {
            
          one++;
                document.getElementById('<%= Hidden1.ClientID %>').value = one;
            }

            function County1() 
            {
                var two = 1;
                two++;
                document.getElementById('<%= Hidden2.ClientID %>').value = two;
            }

    </script>--%>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <table class="style1">
            <tr>
                <td>
                   
                    <asp:LinkButton ID="lb1"  runat="server"  PostBackUrl="~/Home.aspx"      
                        xmlns:asp="#unknown"  onClick="County">  Audi</asp:LinkButton>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lb2" runat="server" PostBackUrl="~/Home.aspx"  onClick="County" >BMW</asp:LinkButton>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lb3" runat="server" PostBackUrl="~/Home.aspx"   onClick="County">Jag</asp:LinkButton>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:LinkButton ID="lb4" runat="server" PostBackUrl="~/Home.aspx"  onClick="County" >Merc</asp:LinkButton>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <br />
                    <asp:LinkButton ID="LinkButton2" runat="server" Font-Bold="True" 
                        Font-Size="15pt" ForeColor="#663300" Font-Names="Papyrus"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" Font-Names="Bauhaus 93" 
                        Font-Size="25pt" ForeColor="#006600"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" 
                        Font-Size="45pt" ForeColor="Red" Font-Names="Freestyle Script"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton4" runat="server" Font-Bold="True" 
                        Font-Names="Magneto" Font-Size="20pt" ForeColor="Blue"></asp:LinkButton>
                </td>
                <td>
                    &nbsp;</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>

</html>
