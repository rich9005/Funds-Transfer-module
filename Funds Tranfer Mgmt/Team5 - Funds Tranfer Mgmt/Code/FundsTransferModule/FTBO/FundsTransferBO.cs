using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FTContract;

namespace FTBO
{
    public class FundsTransferBO:IFundsTransferBO
    {
        public string CustAcc { get; set; }
        public string Payee { get; set; }
        public int Amt { get; set; }
        public string Rmk { get; set; }
        public string Accno { get; set; }
        public int Balance { get; set; }
        public string PAccno { get; set; }
        public int Amt1 { get; set; }
        public string CustID { get; set; }
        public string Pwd { get; set; }
    }
}
