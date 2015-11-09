using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using FTContract;
using FTEncryptEngine;

namespace FTDAL
{
    public class FundsTransferDAL:IFundsTransferDAL
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns></returns>
        public DataSet GetData(IFundsTransferBO ubo)
        {
            
                string cnstr = ConfigurationManager.ConnectionStrings["DB08H98ConnectionString"].ConnectionString;
                SqlConnection cn = new SqlConnection(cnstr);
                SqlCommand cmd = new SqlCommand("usp_GetNameFTn", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@custID", ubo.CustID));

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet dataset = new DataSet();
                adapter.Fill(dataset);
                adapter.Dispose();

                return dataset;
            

        }


        public DataSet GetSelfOthers(IFundsTransferBO ubo)
        {
            string cnstr = ConfigurationManager.ConnectionStrings["DB08H98ConnectionString"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnstr);
            SqlCommand cmd = new SqlCommand("usp_GetSelfOthers", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@custID", ubo.CustID));

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dataset = new DataSet();
            adapter.Fill(dataset);
            adapter.Dispose();
            return dataset;
        }

        public DataSet GetThridParty(IFundsTransferBO ubo)
        {
            string cnstr = ConfigurationManager.ConnectionStrings["DB08H98ConnectionString"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnstr);
            SqlCommand cmd = new SqlCommand("usp_GetThridPartyFT", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@custID", ubo.CustID));

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dataset = new DataSet();
            adapter.Fill(dataset);
            adapter.Dispose();
            return dataset;
        }




        /// <summary>
        /// Get Payee details from the database
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns></returns>

        public DataSet GetPayee(IFundsTransferBO ubo)
        {
            string cnstr = ConfigurationManager.ConnectionStrings["DB08H98ConnectionString"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnstr);
            SqlCommand cmd = new SqlCommand("usp_GetPayeeFT", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@custID", ubo.CustID));

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataSet dataset = new DataSet();
            adapter.Fill(dataset);
            adapter.Dispose();
            return dataset;
        }
        /// <summary>
        /// actual transfer fund operation
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns></returns>

        public string Transfer(IFundsTransferBO ubo)
        {
            try
            {
                string cnstr = ConfigurationManager.ConnectionStrings["FTConfig"].ConnectionString;
                SqlConnection cn = new SqlConnection(cnstr);
                cn.Open();
                SqlCommand cmd = new SqlCommand("usp_InsertTransfer", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@custID", ubo.CustID));
                cmd.Parameters.Add(new SqlParameter("@CustAccno", Convert.ToDouble(ubo.CustAcc)));
                cmd.Parameters.Add(new SqlParameter("@PayeeAccno", Convert.ToDouble(ubo.Payee)));
                cmd.Parameters.Add(new SqlParameter("@Amt", Convert.ToDouble(ubo.Amt)));
                cmd.Parameters.Add(new SqlParameter("@rmk", ubo.Rmk));

                cmd.Parameters.Add("@txn", SqlDbType.VarChar, 10);

                cmd.Parameters["@txn"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                string message = cmd.Parameters["@txn"].Value.ToString();

                return message;
            }
            catch (DataException de)
            {
                return de.Message;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }

        /// <summary>
        /// update customer account balance
        /// </summary>
        /// <param name="updateBo"></param>
        /// <returns></returns>
        public string Update(IFundsTransferBO updateBo)
        {
            try
            {

                string cnstr = ConfigurationManager.ConnectionStrings["FTConfig"].ConnectionString;
                SqlConnection cn = new SqlConnection(cnstr);
                cn.Open();
                SqlCommand cmd = new SqlCommand("usp_UpdateCAcc", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CustAcc", Convert.ToDouble(updateBo.Accno)));
                cmd.Parameters.Add(new SqlParameter("@Balance", Convert.ToDouble(updateBo.Balance)));
                cmd.Parameters.Add("@Avail", SqlDbType.VarChar, 500);
                cmd.Parameters["@Avail"].Direction = ParameterDirection.Output;
                int i = cmd.ExecuteNonQuery();
                string Available = cmd.Parameters["@Avail"].Value.ToString();
                cn.Close();
                if (i > 0)
                    return " Transaction done Successfully  in your account " + updateBo.Accno + " " + "and your balance is Rs." + Available+".00";
                else
                    return "Insufficient Funds";
            }

            catch (DataException de)
            {
                return de.Message;
            }
            catch (Exception e)
            {
                return e.Message;
            }
        }
        /// <summary>
        /// Update the Payee  balance if account exists in accounts table
        /// </summary>
        /// <param name="updateBoP"></param>
        /// <returns></returns>

        public string UpdatePayee(IFundsTransferBO updateBoP)
        {
            try
            {

                string cnstr = ConfigurationManager.ConnectionStrings["FTConfig"].ConnectionString;
                SqlConnection cn = new SqlConnection(cnstr);
                cn.Open();
                SqlCommand cmd = new SqlCommand("usp_UpdatePAcc", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@PayeeAcc", updateBoP.PAccno));
                cmd.Parameters.Add(new SqlParameter("@Balance", Convert.ToDouble(updateBoP.Amt1)));


                int j = cmd.ExecuteNonQuery();

                cn.Close();

                if (j > 0)

                    return " Money Transfered  Successfully  to Payee account   " + updateBoP.PAccno;
                else
                    return " Money Transfered  Successfully  to Payee account  " + updateBoP.PAccno + " But Payee Not Registered  ";

            }

            catch (DataException de)
            {
                return de.Message;
            }

            catch (Exception e)
            {
                return e.Message;
            }
        }
        /// <summary>
        /// to check transaction password
        /// </summary>
        /// <param name="checkBO"></param>
        /// <returns></returns>

        public string CheckPassword(IFundsTransferBO checkBO)
        {

            try
            {
                //Check transaction password
                string cnstr = ConfigurationManager.ConnectionStrings["FTConfig"].ConnectionString;
                SqlConnection cn = new SqlConnection(cnstr);
                cn.Open();
                SqlCommand cmd = new SqlCommand("usp_CheckTxnPwd", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@CustID", checkBO.CustID));
                cmd.Parameters.Add(new SqlParameter("@TxnPwd",FTEncryptEngine.Md5Logic.Decrypt( checkBO.Pwd,true)));

                cmd.Parameters.Add("@Check", SqlDbType.VarChar, 500);

                cmd.Parameters["@Check"].Direction = ParameterDirection.Output;

                cmd.ExecuteNonQuery();

                string Check = (string)cmd.Parameters["@Check"].Value;

                cn.Close();

                if (Check == "right")
                    return "right";
                else
                    return "wrong";
            }

            catch (Exception)
            {
                return "error";
            }
        }

        //methods in dal
       public string DisplaySecQ(string UserID)
        {
            string constr = ConfigurationManager.ConnectionStrings["CRConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);

            con.Open();
            SqlCommand cmd = new SqlCommand("usp_getSecurityQ", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", UserID);

            SqlParameter secQ = new SqlParameter("@SecurityQuestion", SqlDbType.VarChar);
            secQ.Size = 50;
            secQ.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(secQ);

            cmd.ExecuteNonQuery();

            string question = secQ.Value.ToString();
            return question;


        }

        public string CheckAnswer(string UserID, string Answer)
        {
            string constr = ConfigurationManager.ConnectionStrings["CRConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);

            con.Open();
            SqlCommand cmd = new SqlCommand("usp_chkAns", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", UserID);
            cmd.Parameters.AddWithValue("@Answer", Answer);

            SqlParameter password = new SqlParameter("@Password", SqlDbType.VarChar);
            password.Size = 20;
            password.Direction = ParameterDirection.Output;
            cmd.Parameters.Add(password);

            cmd.ExecuteNonQuery();

            string pass = password.Value.ToString();
            return pass;


        }

        public int CheckUserID(string UserID)
        {
            string constr = ConfigurationManager.ConnectionStrings["CRConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);

            con.Open();
            SqlCommand cmd = new SqlCommand("usp_chkUserID", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", UserID);
            

            SqlParameter val = new SqlParameter("@val", SqlDbType.Int);
           
            val.Direction = ParameterDirection.ReturnValue;
            cmd.Parameters.Add(val);

            cmd.ExecuteNonQuery();

            int value = Convert.ToInt32(val.Value);
            return value;


        }


      public int UpdatePwd(string UserID, string oldPwd, string newPwd)
        {
            string strcon = "Data source=172.25.192.72;initial catalog=db08h98;uid=pj08h98;pwd=tcshyd";
            SqlConnection con = new SqlConnection(strcon);

            con.Open();
            SqlCommand cmd = new SqlCommand("usp_chngPwd", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@UserID", UserID);
            cmd.Parameters.AddWithValue("@UserPassword", oldPwd);
            cmd.Parameters.AddWithValue("@NewPassword", newPwd);

            return cmd.ExecuteNonQuery();


        }
    }
}
