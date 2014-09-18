using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class pages_rejectedapps : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["id"] != null)
            {
                int id=Convert.ToInt32(Request.QueryString["id"]);
                string val = Request.QueryString["action"];
                 LoanDSTableAdapters.LoanApplicationsTableAdapter loanApp = new LoanDSTableAdapters.LoanApplicationsTableAdapter();
                if (val=="reinstate")
                {
                   
                    LoanDS.LoanApplicationsRow rLoanApp = loanApp.GetLoanApplication(id.ToString())[0];
                    if (rLoanApp.IsdatReinstateIDNull() == false)
                    {
                        int reinstateid = rLoanApp.datReinstateID;
                        loanApp.UpdateAppReinstate(reinstateid, id);
                    }
                    
                }
                else if( val=="delete")
                {
                    loanApp.UpdateAppReinstate(null, id);
                
                }


            }

        }catch(Exception ex){}

    }
    protected void gvRejectedApps_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try 
            {
                HyperLink linkReinstate = (HyperLink)e.Row.FindControl("HyperReinstate");
                HyperLink linkDelete = (HyperLink) e.Row.FindControl("HyperDelete");

                linkDelete.NavigateUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?id=" + this.gvRejectedApps.DataKeys[e.Row.RowIndex].Value + "&action=delete";
                linkReinstate.NavigateUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?id=" + this.gvRejectedApps.DataKeys[e.Row.RowIndex].Value + "&action=reinstate";



            }
            catch (Exception ex) { }
        
        
        }
    }
}
