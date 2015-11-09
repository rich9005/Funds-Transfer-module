using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace FTContract
{
    public interface IFundsTransferDAL
    {
        DataSet GetData(IFundsTransferBO ubo);
        DataSet GetSelfOthers(IFundsTransferBO ubo);
        DataSet GetThridParty(IFundsTransferBO ubo);
        DataSet GetPayee(IFundsTransferBO ubo);
        string Transfer(IFundsTransferBO ubo);
        string Update(IFundsTransferBO updateBo);
        string UpdatePayee(IFundsTransferBO updateBoP);
        string CheckPassword(IFundsTransferBO checkBO);
        string CheckAnswer(string UserID, string Answer);
        string DisplaySecQ(string UserID);
        int CheckUserID(string UserID);
        int UpdatePwd(string UserID, string oldPwd, string newPwd);
    }
}
