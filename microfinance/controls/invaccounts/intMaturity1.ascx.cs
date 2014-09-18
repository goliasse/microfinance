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

public partial class controls_invaccounts_intMaturity1 : System.Web.UI.UserControl
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        int schID = 0;
        decimal val = 0;
        if(Request.QueryString["schID"]!= null){ schID = Convert.ToInt32(Request.QueryString["schID"]);}
        
        try
        {
            InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter InvAcc_ = new InvestmentAccountDSTableAdapters.GetInvAccountTableAdapter();
            DateTime dt = DateTime.Parse(InvAcc_.GetValueDate(MySessionManager.InvAccID).ToString());
            dt = util.addDaysElapsed(dt,schID);

            InvestmentAccountDSTableAdapters.GetHistoricAccountTableAdapter InvAcc = new InvestmentAccountDSTableAdapters.GetHistoricAccountTableAdapter();
            InvestmentAccountDS.GetHistoricAccountDataTable tblInvAcc = InvAcc.GetHistoryByDate(MySessionManager.InvAccID,dt);

            if (tblInvAcc.Rows.Count > 0)
            {
                if (Request.QueryString["val"].Length > 0) { val = Convert.ToDecimal(Request.QueryString["val"]); }
                if (tblInvAcc[0].IsdatIDNull()==false) { datID.Value = tblInvAcc[0].datID.ToString(); }
                if (tblInvAcc[0].IsdatIntAccruedNull() == false)
                {
                    lblaccruedInt.InnerText = tblInvAcc[0].datIntAccrued.ToString("c").Replace("$", "");
                    dataccint.Value = tblInvAcc[0].datIntAccrued.ToString();
                }
                else { dataccint.Value = "0"; }
                if (tblInvAcc[0].IsdatInvestmentAmountNull() == false)
                {
                    lblInvAmt.InnerText = tblInvAcc[0].datInvestmentAmount.ToString("c").Replace("$", "");
                    datprincipal.Value = tblInvAcc[0].datInvestmentAmount.ToString();
                }
                if (tblInvAcc[0].IsdatPenaltyNull() == false) 
                {
                    datAmount.Value = tblInvAcc[0].datPenalty.ToString();
                }
                else { datprincipal.Value = "0"; }
                if (tblInvAcc[0].IsdatValueDateNull() == false)
                {lblValueDate.InnerText = tblInvAcc[0].datValueDate.ToString("dd-MM-yyyy");}
                if (tblInvAcc[0].IsdatInvestmentNameNull() == false)
                { lblInvName.InnerText = tblInvAcc[0].datInvestmentName.ToString(); }
                
            }
        }
        catch (Exception ex) { }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            InvestmentAccountDSTableAdapters.GetHistoricAccountTableAdapter InvHist = new InvestmentAccountDSTableAdapters.GetHistoricAccountTableAdapter();
            InvHist.UpdatePenaltyHistory2(Convert.ToDecimal(dataccint.Value),
                                          Convert.ToDecimal(datAmount.Value),
                                          Convert.ToInt32(datID.Value),
                                          MySessionManager.InvAccID);


        }
        catch (Exception ex) { }
    }


    public decimal  getValue(string schID)
    {
        decimal result=0;

        try { }
        catch (Exception ex) { }

        return result;
    
    }
}
