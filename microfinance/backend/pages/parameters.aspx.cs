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

public partial class backend_pages_parameters : System.Web.UI.Page
{
    Utility util = new Utility();
    public int currentTab { set; get; }
    public string ops { set; get; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MySessionManager.CurrentUser == null)
        { Response.Redirect("~/logout.aspx"); }
        setPanelsOff();
        setUrls();

        #region QueryString
        if (!(Request.QueryString["ops"] == null))
        {
            if (!(Request.QueryString["tab"] == null))
            {
                if (!(Request.QueryString["tab"] == ""))
                    currentTab = int.Parse(Request.QueryString["tab"]);
                else
                    currentTab = Convert.ToInt32(MySessionManager.CurrentTab);
                ops = Request.QueryString["ops"].ToString();
                setPanels(currentTab);
                MySessionManager.CurrentTab = currentTab.ToString();
                MySessionManager.OpsTab = "load";

                string urlpath = util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "tab");
                urlpath = util.RemoveQueryStringByKey(urlpath, "ops");
                Response.Redirect(urlpath);
            }
            else
            {
                if (!(Request.QueryString["tab"] == ""))
                    currentTab = int.Parse(Request.QueryString["tab"]);
                ops = "load";
                setPanels(currentTab);

                MySessionManager.CurrentTab = currentTab.ToString();
                MySessionManager.OpsTab = "load";
                util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "tab");
                util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "ops");
            }
        }
        else
        {
            ops = MySessionManager.OpsTab.ToString();

            //For handling the tabs
            if (!(MySessionManager.CurrentTab == ""))

                currentTab = int.Parse(MySessionManager.CurrentTab);
            else
                currentTab = 0;
            setPanels(currentTab);
        }
     
        #endregion
    }

    public void setPanels(int id)
    {
        if (id == 1)
        {
            setPanelsOff();
            this.area1.Visible = true;
        }
        else if (id == 2)
        {
            setPanelsOff();
            this.assettype1.Visible = true;
        }
        else if (id == 3)
        {
            setPanelsOff();
            this.branch1.Visible = true;
        }
        else if (id == 4)
        {
            setPanelsOff();
            this.bulletinboard1.Visible = true;
        }
        else if (id == 5)
        {
            this.checklistItems1.Visible = true;
        }
        else if (id == 6)
        {
            setPanelsOff();
            this.collateraltypes1.Visible = true;
        }
        else if (id == 7)
        {
            setPanelsOff();
            this.creditteams1.Visible = true;
        }
        else if (id == 8)
        {
            setPanelsOff();
            this.feepayment1.Visible = true;
        }
        else if (id == 9)
        {
            setPanelsOff();
            this.finacctypes1.Visible = true;
        }
        else if (id == 12)
        {
            setPanelsOff();
            this.identificationtypes1.Visible = true;
        }
        else if (id == 13)
        {
            setPanelsOff();
            this.industry1.Visible = true;
        }
        else if (id == 14)
        {
            this.institutes1.Visible = true;
        }
        else if (id == 15)
        {
            setPanelsOff();
            this.interestratetypes1.Visible = true;
        }
        else if (id == 16)
        {
            this.investmentcategory1.Visible = true;
        }
        else if (id == 17)
        {
            setPanelsOff();
            this.ledgers1.Visible = true;
        }
        else if (id == 18)
        {
            setPanelsOff();
            this.loancategories1.Visible = true;
        }
        else if (id == 19)
        {
            setPanelsOff();
            this.loanpurpose1.Visible = true;
        }
        else if (id == 20)
        {
            setPanelsOff();
            this.loantypes1.Visible = true;
        }
        else if (id == 21)
        {
            setPanelsOff();
            this.maritalstatuses1.Visible = true;
        }
        else if (id == 22)
        {
            setPanelsOff();
            this.premisesstatutes1.Visible = true;
        }
        else if (id == 23)
        {
            setPanelsOff();
            this.regions1.Visible = true;
        }
        else if (id == 24)
        {
            setPanelsOff();
            this.repaymentthreshold1.Visible = true;
        }
        else if (id == 25)
        {
            setPanelsOff();
            this.roles1.Visible = true;
        }
        else if (id == 26)
        {
            setPanelsOff();
            this.titles1.Visible = true;
        }
        else if (id == 27)
        {
            setPanelsOff();
            this.feetype1.Visible = true;
        }
        else if (id == 0)
        {
            setPanelsOff();
            this.area1.Visible = true;
        
        }
    }

    public void setPanelsOff()
    {
        this.area1.Visible = false;
        this.assettype1.Visible = false;
        this.branch1.Visible = false;
        this.bulletinboard1.Visible = false;
        this.checklistItems1.Visible = false;
        this.collateraltypes1.Visible = false;
        this.creditteams1.Visible = false;
        this.feepayment1.Visible = false;
        this.feetype1.Visible = false;
        this.finacctypes1.Visible = false;
        this.identificationtypes1.Visible = false;
        this.industry1.Visible = false;
        this.institutes1.Visible = false;
        this.interestratetypes1.Visible = false;
        this.investmentcategory1.Visible = false;
        this.ledgers1.Visible = false;
        this.loancategories1.Visible = false;
        this.loanpurpose1.Visible = false;
        this.loantypes1.Visible = false;
        this.maritalstatuses1.Visible = false;
        this.regions1.Visible = false;
        this.premisesstatutes1.Visible = false;
        this.repaymentthreshold1.Visible = false;
        this.roles1.Visible = false;
        this.titles1.Visible = false;
        this.nationalities1.Visible = false;
        this.checklistcat1.Visible = false;
    
    
    }
    public void setUrls()
    {
        this.areas.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=1&ops=load";
        this.assetTypes.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=2&ops=load";
        this.branch.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=3&ops=load";
        this.bulletin.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=4&ops=load";
        this.chklist.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=5&ops=load";
        this.btnChklistCat.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=26&ops=load";
        this.btnColl.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=6&ops=load";
        this.btnCT.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=7&ops=load";
        this.btnPayment.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=8&ops=load";
        this.btnFeeTypes.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=27&ops=load";
        this.btnFinAcTypes.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=9&ops=load";
      //  this.btnFrequencies.PostBackUrl = "";
        this.btnHearAbt.PostBackUrl = "";
        this.btnIDTypes.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=12&ops=load";
        this.btnIndustry.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=13&ops=load";
        this.btnInstitutes.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=14&ops=load";
        this.btnIntRate.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=15&ops=load";
        this.btnInvCat.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=16&ops=load";
        this.btnLedgers.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=17&ops=load";
        this.btnLoanCat.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=18&ops=load";
        this.btnLoanPurpose.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=19&ops=load";
        this.btnLoanTypes.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=20&ops=load";
        this.btnMaritalStatuses.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=21&ops=load";
        
        this.btnPremStatuses.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=22&ops=load";
        this.btnRegion.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=23&ops=load";
        this.btnRepayment.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=24&ops=load";
        this.btnRoles.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=25&ops=load";
        this.btnTitles.PostBackUrl = HttpContext.Current.Request.Url.AbsoluteUri + "?tab=26&ops=load";
    
    }
}
