using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FTContract
{
    public interface IFundsTransferBO
    {
        string CustAcc { get; set; }
        string Payee { get; set; }
        int Amt { get; set; }
        string Rmk { get; set; }
        string Accno { get; set; }
        int Balance { get; set; }
        string PAccno { get; set; }
        int Amt1 { get; set; }
        string CustID { get; set; }
        string Pwd { get; set; }
    }
}
