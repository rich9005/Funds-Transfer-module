using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using FTContract;
using FTDAL;
using FTFactory;
using System.Security.Cryptography;
using System.Configuration;

namespace FTBLL
{
    public class FundsTransferBLL
    {
        IFundsTransferDAL ftDal = DALFactory.CreateTransferInstance();

        /// <summary>
        ///this method is used to call get method of the DAL
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns>Dataset</returns>
        public DataSet Get(IFundsTransferBO ubo)
        {
            return ftDal.GetData(ubo);
        }
        /// <summary>
        ///this method is used to call PayeeGet method of the DAL
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns>Dataset</returns>
        public DataSet PayeeGet(IFundsTransferBO ubo)
        {
            return ftDal.GetPayee(ubo);
        }

        public DataSet GetSelfOthers(IFundsTransferBO ubo)
        {
            return ftDal.GetSelfOthers(ubo);
        }

        public DataSet GetThirdParty(IFundsTransferBO ubo)
        {
            return ftDal.GetThridParty(ubo);
        }
        /// <summary>
        ///this method is used to call Transfer method of the DAL
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns>string</returns>
        public string Transfer(IFundsTransferBO ubo)
        {
            return ftDal.Transfer(ubo);
        }
        /// <summary>
        ///this method is used to call Update method of the DAL
        /// </summary>
        /// <param name="updateBo"></param>
        /// <returns>string</returns>
        public string Update(IFundsTransferBO updateBo)
        {
            return ftDal.Update(updateBo);
        }
        /// <summary>
        ///this method is used to call UpdatePayee method of the DAL
        /// </summary>
        /// <param name="updateBop"></param>
        /// <returns>string</returns>

        public string UpdatePayee(IFundsTransferBO updateBop)
        {
            return ftDal.UpdatePayee(updateBop);
        }
        /// <summary>
        ///this method is used to call CheckPassword method of the DAL
        /// </summary>
        /// <param name="ubo"></param>
        /// <returns>string</returns>
        public string CheckPassword(IFundsTransferBO checkBO)
        {
            return ftDal.CheckPassword(checkBO);
        }

        //methods in bll
       public string GetSecQ(string UserID)
        {
            return ftDal.DisplaySecQ(UserID);
        }

        public string ChkAns(string UserID, string Answer)
        {
            return ftDal.CheckAnswer(UserID, Answer);
        }

        public int ChkUID(string UserID)
        {
            return ftDal.CheckUserID( UserID);
        }

       public  int ChngPwd(string UserID, string oldPwd, string newPwd)
        {
            return ftDal.UpdatePwd(UserID, oldPwd, newPwd);
        }

    }
}
