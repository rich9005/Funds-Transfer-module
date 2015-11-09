using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Master
{
    public partial class home : System.Web.UI.Page
    {
        /// <summary>
        /// Assigning values for the session
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Username"] = "";
            Session["UserID"] = "";
            Session["Status"] = "Logged Out";            
        }
    }
}