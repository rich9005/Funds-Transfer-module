using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FTFactory;
using FTContract;
using System.Data;
using FTDAL;
using System.Data.SqlClient;

namespace FTBLL
{
   public class PayeeValidation
    {
       IPayeeDal payeeDAL = DALFactory.CreateInstance();
        /// <summary>
        ///this method is used to call AddPayee method of the DAL
        /// </summary>
        /// <param name="pbo"></param>
        /// <returns></returns>
        public bool ValidatePayee(IPayeeBo pbo)
        {
           return payeeDAL.AddPayee(pbo);
        }

        /// <summary>
        /// this method calls Update Payee method of PayeeDAL
        /// </summary>
        /// <param name="ipbo"></param>
        /// <returns></returns>
        public bool UpdateValidationBLL(IPayeeBo ipbo)
        {
           return payeeDAL.UpdatePayee(ipbo);
        }

        /// <summary>
        /// To display the Details Of a payee added by the Customer BLL connects grid view  to the DAL. 
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        public DataTable ViewDetails(string customerId)
        {
           DataTable dt = null;           
           dt = payeeDAL.ViewPayee(customerId);
           return dt;
        }

        /// <summary>
        /// To display all the Details Of a payee added by the Customer BLL connects grid view  to the DAL. 
        /// </summary>
        /// <param name="customerId"></param>
        /// <returns></returns>
        public DataTable ViewAllDetails(string customerId)
        {
            DataTable dt = null;
            dt = payeeDAL.ViewAllPayee(customerId);
            return dt;
        }
        /// <summary>
        /// to delete the detail of a payee 
        /// </summary>
        /// <param name="ipbo"></param>
        /// <returns></returns>
        public bool DeleteValidation(IPayeeBo ipbo)
        {
           return payeeDAL.DeletePayee(ipbo);
        }
              
        /// <summary>
        ///Here for the display of table of payee information in the form of gridview BLL connects it to DAL layer for dataa access.
        /// </summary>
        /// <returns></returns>
        public DataTable ViewRequests()
        {
           DataTable dt=null;           
           dt = payeeDAL.ViewRequestDB();
           return dt;
        }

        /// <summary>
        /// to validate user while on log in
        /// </summary>
        /// <param name="logbo"></param>
        /// <returns></returns>
        public int ValidateUser(ILoginBO logbo)
        {
           return payeeDAL.LoginUser(logbo);
        }

        /// <summary>
        ///This method is to update status and reason values in the request table which were edited by the admin by connecting it to DAL
        /// </summary>
        /// <param name="approve_Obj"></param>
        public void ApprovePayee1(IPayeeBo approveObj)
        {
           payeeDAL.ApprovePayee(approveObj);
        }

        /// <summary>
        /// This method is for verification of payee account so as to check whether payee account is active/inactive
        ///not registered with multibanking system by connecting it to DAL
        /// </summary>
        /// <param name="account_no"></param>
        /// <returns></returns>
        public int VerifyPayee(long acntNo)
        {
           int AcntState = 0;
           AcntState = payeeDAL.VerifyPayee(acntNo);
           return AcntState;
        }

        /// <summary>
        /// calling method ViewHistoryDetails of data access layer class HistoryDAL
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns></returns>
        public DataTable ValidateUser(IHistoryBO ubo)
        {
           return payeeDAL.ViewHistoryDetails(ubo);
        }
    }
}
