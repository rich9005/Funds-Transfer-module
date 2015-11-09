using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using FTBLL;
using FTFactory;
using FTContract;
using FTEncryptEngine;

namespace FundsTransferModule
{
    public partial class FundsTransfer : System.Web.UI.Page
    {
        static string CustAcc= null ;
        static string Payee= null;
        static int count = 0;
        FundsTransferBLL ftbll = new FundsTransferBLL();
        IFundsTransferBO ftbo = BoFactory.CreateTransferInstance();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
       
        /// <summary>
        /// to display the gridview
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void buttonRefresh(object sender, EventArgs e)
        {
            try
            {
                lblTitle.Visible = false;
                ftbo.CustID = Session["UserID"].ToString();

                DataSet ds = null;
                ds = ftbll.Get(ftbo);
                GridView1.DataSource = ds;
                GridView1.DataBind();

                DataSet ds1 = null;
                ds1 = ftbll.Get(ftbo);
                GridView2.DataSource = ds1;
                GridView2.DataBind();

                TxtAmt.Visible = true;
                TxtRmk.Visible = true;
                btnSubmit.Visible = true;
                btnReset.Visible = true;
                lblAmt.Visible = true;
                lblRmk.Visible = true;
                lblcust.Visible = true;
                lblPayee.Visible = true;
                btnRefresh.Visible = false;
            }
            catch (Exception f3)
            {
                lblExceptionStatus.Text = f3.Message;
            }
        }

        /// <summary>
        /// to validate the fields and display transaction password field 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSubmit_Click(object sender, EventArgs e)
        {

            try
            {
                for (int i = 0; i < GridView1.Rows.Count; i++)
                {
                    RadioButton rb = (GridView1.Rows[i].FindControl("RadioButton1")) as RadioButton;
                    if (rb.Checked == true)
                    {
                        CustAcc = GridView1.Rows[i].Cells[1].Text;
                    }
                }
                for (int i = 0; i < GridView2.Rows.Count; i++)
                {
                    RadioButton rb1 = (GridView2.Rows[i].FindControl("RadioButton2")) as RadioButton;
                    if (rb1.Checked == true)
                    {
                        Payee = GridView2.Rows[i].Cells[1].Text;
                    }
                }
                if (CustAcc != null && Payee != null)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Please Enter Transaction Password!" + "');", true);
                    lblTxnPwd.Visible = true;
                    txtTxnPwd.Visible = true;
                    btnTransfer.Visible = true;
                    Label1.Visible = true;
                }
                else
                    if (CustAcc == null)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Please Select Your Account" + "');", true);
                    }
                    else if (Payee == null)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Please Select Payee Account" + "');", true);
                    }
            }
            catch (Exception val)
            {
                lblExceptionStatus.Text = val.Message;
            }

        }
        
        /// <summary>
        /// To validate transaction password and transfer money
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnTransfer_Click(object sender, EventArgs e)
        {
            
            string test="";           
            btnSubmit.Enabled = false;
            TxtAmt.Enabled = false;
            TxtRmk.Enabled = false;
            GridView1.Enabled = false;
            GridView2.Enabled = false;
        
            ftbo.CustID = Session["UserID"].ToString();
            ftbo.Pwd = FTEncryptEngine.Md5Logic.Encrypt(txtTxnPwd.Text, true);
            test = ftbll.CheckPassword(ftbo);
            if (test == "right")
            {
                txtTxnPwd.Enabled = false;
                btnTransfer.Enabled = false;
                ftbo.CustAcc = CustAcc;
                ftbo.Amt = Convert.ToInt32(TxtAmt.Text);
                ftbo.Payee = Payee;
                ftbo.Rmk = TxtRmk.Text;


                ftbo.Accno = CustAcc;
                ftbo.Balance = Convert.ToInt32(TxtAmt.Text);
                string respond = ftbll.Update(ftbo);
                if (respond == "Insufficient Funds")
                {
                    lblrespond.ForeColor = System.Drawing.Color.Red;

                    lblrespond.Text = respond;
                }
                ftbo.PAccno = Payee;
                ftbo.Amt1 = Convert.ToInt32(TxtAmt.Text);
                if (respond != "Insufficient Funds")
                {
                    CustAcc = null;
                    Payee = null;
                    Response.Redirect("final.aspx?value="+respond);
                }   
            }

            else if (test == "wrong")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Incorrect password" + "');", true);
                count++;
                if (count == 3)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum Attempt (3) reached.Redirecting to home page.....');", true); 
                    Response.Redirect("Fundstransferhomepage.aspx"); 
                }
             }
            else if (test == "error")
            {
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Error in DataBase" + "');", true);
            }
       }
       
        /// <summary>
        /// to reset all the fields
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnReset_Click(object sender, EventArgs e)
        {
            //To reset the fields
            TxtAmt.Enabled = true;
            TxtAmt.Text = "";
            TxtRmk.Enabled = true;
            TxtRmk.Text = "";
            btnSubmit.Enabled = true;
            lblTxID.Text =" ";
            lblrespond.Text = " ";
            lblResult.Text = " ";
            txtTxnPwd.Visible = false;
            lblTxnPwd.Visible = false;
            btnTransfer.Visible = false;
            txtTxnPwd.Enabled = true;
            btnTransfer.Enabled = true;
            GridView1.Enabled = true;
            GridView2.Enabled = true;
            Label1.Visible = false;
            buttonRefresh(sender, e);
        }

        protected void btnSelfOthers_Click(object sender, EventArgs e)
        {
            try
            {
                lblTitle.Visible = false;
                ftbo.CustID = Session["UserID"].ToString();

                DataSet ds = null;
                ds = ftbll.Get(ftbo);
                GridView1.DataSource = ds;
                GridView1.DataBind();

                DataSet ds1 = null;
                ds1 = ftbll.GetSelfOthers(ftbo);
                GridView2.DataSource = ds1;
                GridView2.DataBind();

                TxtAmt.Visible = true;
                TxtRmk.Visible = true;
                btnSubmit.Visible = true;
                btnReset.Visible = true;
                lblAmt.Visible = true;
                lblRmk.Visible = true;
                lblcust.Visible = true;
                lblPayee.Visible = true;
                btnRefresh.Visible = false;
            }
            catch (Exception f3)
            {
                lblExceptionStatus.Text = f3.Message;
            }
        }

        protected void btnThirdParty_Click(object sender, EventArgs e)
        {
            try
            {
                lblTitle.Visible = false;
                ftbo.CustID = Session["UserID"].ToString();

                DataSet ds = null;
                ds = ftbll.Get(ftbo);
                GridView1.DataSource = ds;
                GridView1.DataBind();

                DataSet ds1 = null;
                ds1 = ftbll.GetThirdParty(ftbo);
                GridView2.DataSource = ds1;
                GridView2.DataBind();

                TxtAmt.Visible = true;
                TxtRmk.Visible = true;
                btnSubmit.Visible = true;
                btnReset.Visible = true;
                lblAmt.Visible = true;
                lblRmk.Visible = true;
                lblcust.Visible = true;
                lblPayee.Visible = true;
                btnRefresh.Visible = false;
            }
            catch (Exception f3)
            {
                lblExceptionStatus.Text = f3.Message;
            }
        }
    }
}
