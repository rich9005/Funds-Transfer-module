using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace TagCloud
{
    public partial class Home : System.Web.UI.Page
    {
         int countOne=0;
          int countTwo=0;
         int countThree=0;
          int countFour=0;
        int [] tag = new int[4];
        int[] mid = new int[3];
        int midV=0;
        int max,min;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            
        }

        protected void County(object sender, EventArgs e)
        {                
            if (sender.Equals(lb1))
            {
                countOne++;
            }

            if (sender.Equals(lb2))
            {
                countTwo++;
                
                //Label2.Font.Size = countTwo;
                //Label2.Text = Convert.ToString(countTwo);
                //Label2.Text = "BMW";
            }
            if (sender.Equals(lb3))
            {
                countThree++;
                //Label3.Font.Size = countThree;
                //Label3.Text = Convert.ToString(countThree);
                //Label3.Text = "Jaguar";
            }
            if (sender.Equals(lb4))
            {
                countFour++;
                //Label4.Font.Size = countFour;
                //Label4.Text = Convert.ToString(countFour);
                //Label4.Text = "Mercedes-Benz";
            }


            updateTG(countOne, countTwo, countThree, countFour);
        }

        protected void updateTG(int i, int j, int k, int l)
        {
            string cnstr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnstr);
            cn.Open();

            SqlCommand cmd = new SqlCommand("usp_TGSRInsert", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@link","Audi" ));
            cmd.Parameters.Add(new SqlParameter("@tag",i));
            cmd.ExecuteNonQuery();

            SqlCommand cmd1 = new SqlCommand("usp_TGSRInsert", cn);
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.Add(new SqlParameter("@link", "BWM"));
            cmd1.Parameters.Add(new SqlParameter("@tag", j));
            cmd1.ExecuteNonQuery();

            SqlCommand cmd2 = new SqlCommand("usp_TGSRInsert", cn);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@link", "Jag"));
            cmd2.Parameters.Add(new SqlParameter("@tag", k));
            cmd2.ExecuteNonQuery();

            SqlCommand cmd3 = new SqlCommand("usp_TGSRInsert", cn);
            cmd3.CommandType = CommandType.StoredProcedure;
            cmd3.Parameters.Add(new SqlParameter("@link", "Merc"));
            cmd3.Parameters.Add(new SqlParameter("@tag", l));
            cmd3.ExecuteNonQuery();

            cn.Close();
            RefreshTG();
        }

        protected void RefreshTG()
        {
            string cnstr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            SqlConnection cn = new SqlConnection(cnstr);
            cn.Open();
            SqlCommand cmd = new SqlCommand("usp_GetTagWeight", cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@link1", SqlDbType.VarChar, 500);
            cmd.Parameters["@link1"].Direction = ParameterDirection.Output;
            
            cmd.Parameters.Add("@link2", SqlDbType.VarChar, 500);
            cmd.Parameters["@link2"].Direction = ParameterDirection.Output;
            
            cmd.Parameters.Add("@link3", SqlDbType.VarChar, 500);
            cmd.Parameters["@link3"].Direction = ParameterDirection.Output;
            
            cmd.Parameters.Add("@link4", SqlDbType.VarChar, 500);
            cmd.Parameters["@link4"].Direction = ParameterDirection.Output;

            cmd.ExecuteNonQuery();
            
            tag[0] = Convert.ToInt32( cmd.Parameters["@link1"].Value);
            tag[1]=Convert.ToInt32(cmd.Parameters["@link2"].Value);
            tag[2] = Convert.ToInt32(cmd.Parameters["@link3"].Value);
            tag[3] = Convert.ToInt32(cmd.Parameters["@link4"].Value);

             max = tag.ToList().IndexOf(tag.Max());
             min = tag.ToList().IndexOf(tag.Min());


             ResizeTag(max, min);
        }

        protected void ResizeTag(int max, int min)
        {
            string [] Cars = {"Audi" , "BMW" , "Jag" , "Merc" };

            for (int i = 0; i < 4; i++)
            {
                if (i == max)
                {
                    LinkButton1.Text = Cars[i];
                    LinkButton1.PostBackUrl = Cars[i]+".aspx";
                }
                if (i == min)
                {
                    LinkButton2.Text = Cars[i];
                    LinkButton2.PostBackUrl = Cars[i] + ".aspx";
                }
                else if(i!=max && i!=min)
                {
                    mid[midV] = i;
                    midV++;
                }

                LinkButton3.Text = Cars[mid[0]];
                LinkButton3.PostBackUrl = Cars[mid[0]] + ".aspx";
                LinkButton4.Text= Cars[mid[1]];
                LinkButton4.PostBackUrl = Cars[mid[1]] + ".aspx";


            }
            
        
        
        }


           
      
        
    }
}