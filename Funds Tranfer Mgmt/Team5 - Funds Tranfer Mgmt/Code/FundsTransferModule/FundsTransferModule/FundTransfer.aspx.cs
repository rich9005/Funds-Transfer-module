using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using FTBLL;
using FTContract;
using FTFactory;
using Factory;
using Contract;
using BLL;

namespace Module5
{
    public partial class FundTransfer : System.Web.UI.Page
    {
      
       static string CustAcc = null;
        static string Payee = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void RadioSingleSelect(object sender, EventArgs e)
        {
            RadioButton selectButton = (RadioButton)sender;
            GridViewRow row = (GridViewRow)selectButton.Parent.Parent;
            int a = row.RowIndex;
            foreach (GridViewRow rw in GridView1.Rows)
            {
                if (selectButton.Checked)
                {
                    if (rw.RowIndex != a)
                    {
                        RadioButton rd1 = rw.FindControl("rdBtn1") as RadioButton;
                        rd1.Checked = false;
                    }
                }
            }


        }

        protected void RadioSingleSelect1(object sender, EventArgs e)
        {
            RadioButton selectButton = (RadioButton)sender;
            GridViewRow row = (GridViewRow)selectButton.Parent.Parent;
            int a = row.RowIndex;
            foreach (GridViewRow rw in GridView2.Rows)
            {
                if (selectButton.Checked)
                {
                    if (rw.RowIndex != a)
                    {
                        RadioButton rd2 = rw.FindControl("rdBtn2") as RadioButton;
                        rd2.Checked = false;
                    }
                }
            }
        }

        protected void ButtonRefresh(object sender, EventArgs e)
        {
            DataSet ds = BLL.UBll.get();
            GridView1.DataSource = ds;
            GridView1.DataBind();

            DataSet ds1 = BLL.UBll.PayeeGet();
            GridView2.DataSource = ds1;
            GridView2.DataBind();

            TxtAmt.Visible = true;
            TxtRmk.Visible = true;
            BtnSubmit.Visible = true;
            btnReset.Visible = true;
            lblAmt.Visible = true;
            lblRmk.Visible = true;
            lblcust.Visible = true;
            lblPayee.Visible = true;

        }

        protected void BtnSubmit_Click(object sender, EventArgs e)
        {
           // ITBO ubo = TFactory.CreateInstance();

            
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                RadioButton rb = (GridView1.Rows[i].FindControl("rdBtn1")) as RadioButton;
                if (rb.Checked == true)
                {
                    CustAcc = GridView1.Rows[i].Cells[1].Text;

                }
            }

            

            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                RadioButton rb1 = (GridView2.Rows[i].FindControl("rdBtn2")) as RadioButton;
                if (rb1.Checked == true)
                {
                    Payee = GridView2.Rows[i].Cells[2].Text;

                }
            }

        //    ubo.CustAcc = CustAcc;
          //  ubo.Payee = Payee;
          //  ubo.Amt = Convert.ToInt32(TxtAmt.Text);
           // ubo.Rmk = TxtRmk.Text;




            if (CustAcc != null && Payee != null)
            {
                lblTxnPwd.Visible = true;
                txtTxnPwd.Visible = true;
                btnTransfer.Visible = true;
              

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

        protected  void btnTransfer_Click(object sender, EventArgs e)
        {
            string test;

            BtnSubmit.Enabled = false;
            TxtAmt.Enabled = false;
            TxtRmk.Enabled = false;

            ICBO checkBO = CFactory.CreateInstance();
            checkBO.CustID = "101";
            checkBO.Pwd = txtTxnPwd.Text;
            test = UBll.CheckPassword(checkBO);

                       
           
            if (test =="right")
            {
                ITBO ubo1 = TFactory.CreateInstance();
                ubo1.CustAcc = CustAcc;
                ubo1.Amt =Convert.ToInt32( TxtAmt.Text);
                ubo1.Payee = Payee;
                ubo1.Rmk = TxtRmk.Text;
                
                IUBO updateBo = UFactory.CreateInstance();
                updateBo.Accno = CustAcc;
                updateBo.Balance = Convert.ToInt32(TxtAmt.Text);
                string respond = BLL.UBll.Update(updateBo);
                lblrespond.Text = respond;

                IUpBO updateBOp = UPFactory.CreateInstance();
                updateBOp.PAccno = Payee;
                updateBOp.Amt1 = Convert.ToInt32(TxtAmt.Text);


                if (respond != "Insufficient Funds")
                {
                    string message = BLL.UBll.Transfer(ubo1);
                    lblTxID.Text = "Your Transcation ID is " + message;
                    string result = BLL.UBll.UpdatePayee1(updateBOp);
                    lblResult.Text = result;

                }

            }

            else if(test=="wrong")
            {
                
                ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + "Incorrect password" + "');", true);
            }


        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            
            TxtAmt.Enabled = true;
            TxtRmk.Enabled = true;
            BtnSubmit.Enabled = true;
            lblTxID.Visible = false;
            lblrespond.Visible = false;
            lblResult.Visible = false;
            txtTxnPwd.Visible = false;
            lblTxnPwd.Visible = false;
            btnTransfer.Visible = false;
        }

        
   }
}