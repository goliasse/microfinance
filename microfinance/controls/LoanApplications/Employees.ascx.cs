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

public partial class controls_Employees : System.Web.UI.UserControl
{

    protected void Page_Load(object sender, EventArgs e)
    {
        loadEmployees();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            LoanDSTableAdapters.NoOfEmployeesTableAdapter noOfEmployees = new LoanDSTableAdapters.NoOfEmployeesTableAdapter();
            noOfEmployees.InsertNoOfEmployees(MySessionManager.ClientID,
                                               MySessionManager.AppID,
                                               Convert.ToInt32(txtManagement.Value.Trim()),
                                               Convert.ToInt32(txtSkilled.Value.Trim()),
                                               Convert.ToInt32(txtunskilled.Value.Trim()),
                                               Convert.ToInt32(txtCasual.Value.Trim()),
                                               Convert.ToInt32(txtTotal.Value.Trim()),
                                               MySessionManager.CurrentUser.UserID
                                               );
        }
    }

    public void loadEmployees()
    {
        LoanDSTableAdapters.NoOfEmployeesTableAdapter noOfEmployees = new LoanDSTableAdapters.NoOfEmployeesTableAdapter();
        LoanDS.NoOfEmployeesDataTable tblnoOfEmployees = noOfEmployees.GetNoOfEmployees(MySessionManager.AppID, MySessionManager.ClientID);

        if (tblnoOfEmployees.Rows.Count > 0)
        {
            txtCasual.Value = tblnoOfEmployees[0].datCasual.ToString();
            txtManagement.Value = tblnoOfEmployees[0].datManagement.ToString();
            txtSkilled .Value = tblnoOfEmployees[0].datSkilled .ToString();
            txtunskilled.Value = tblnoOfEmployees[0].datUnskilled.ToString();
            txtTotal.Value = tblnoOfEmployees[0].datTotal.ToString();                   
        }
    }
    public void pageValidation(object source, ServerValidateEventArgs args)
    {

        args.IsValid = true;
        string ErrorMessage = "";
        try
        {
            int m;
            if (!(int.TryParse(txtCasual.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The number of casual employees  must be integer </p>"; }
            if (!(int.TryParse(txtManagement.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The number of management employees  must be integer </p>"; }
            if (!(int.TryParse(txtSkilled.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The number of skilled employee  must be integer </p>"; }
            if (!(int.TryParse(txtunskilled.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The number of unskilled  must be integer </p>"; }
            if (!(int.TryParse(txtTotal.Value, out m))) { args.IsValid = false; ErrorMessage += "<p> The number of total employees  must be integer </p>"; }
            this.ErrMsg.InnerHtml = ErrorMessage;
        }
        catch (Exception ex) { args.IsValid = false; }
    }
}
