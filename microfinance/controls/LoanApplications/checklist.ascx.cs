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

public partial class controls_checklist : System.Web.UI.UserControl
{
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        populateCheckList();

        if (!(this.editskip.Value == "2"))
        {
            loadData();
        }
    }

    public void populateCheckList()
    {
       
        
        mainDSTableAdapters.CheckListItemsTableAdapter chkListItem = new mainDSTableAdapters.CheckListItemsTableAdapter();
        mainDS.CheckListItemsDataTable tblChkListItemHeader = chkListItem.GetCheckListHeaders();
        if (tblChkListItemHeader.Rows.Count > 0)
        {
           
            foreach (mainDS.CheckListItemsRow  r in tblChkListItemHeader)
            {
                try
                {
                    mainDS.CheckListItemsDataTable tblChkListItemChild = chkListItem.GetCheckListChilds(r.datID);

                    HtmlGenericControl myMainDiv = new HtmlGenericControl("div");
                    HtmlGenericControl mydiv = new HtmlGenericControl("div");
                    HtmlGenericControl mylabel = new HtmlGenericControl("label");
                    mydiv.Attributes.Add("class", "col-lg-12");
                    mydiv.Attributes.Add("id", "header" + (r.datID).ToString());
                    mylabel.Style["height"] = "23px";
                    mylabel.Attributes.Add("class", "col-lg-12 label label-success mylabels");
                    mylabel.InnerHtml = "<p style='font-size:14px'>" + r.datDescription.ToString() + "</p>";
                    mydiv.Controls.Add(mylabel);
                    myMainDiv.Controls.Add(mydiv);
                    
                    Table tbl = new Table();
                    tbl.CssClass = "col-md-12";
                    tbl.ID = "myTable" + (r.datID).ToString();
                    for (int j = 0; j < tblChkListItemChild.Rows.Count; j++)
                    {

                        Label mylabel1 = new Label();
                        DropDownList ddl2 = new DropDownList();
                        TextBox txt3 = new TextBox();

                        TableRow tr = new TableRow();
                        TableCell tc1 = new TableCell();
                        TableCell tc2 = new TableCell();
                        TableCell tc3 = new TableCell();
                        mylabel1.ID = "label"+tblChkListItemChild[j].datID.ToString();
                        mylabel1.Text = tblChkListItemChild[j].datDescription.ToString();
                        ddl2.ID = "cmb" + tblChkListItemChild[j].datID.ToString();
                        ddl2.AppendDataBoundItems = true;
                        ddl2.Items.Insert(0,new ListItem("--Select-","0"));
                        ddl2.DataSource = SqlDataSource1;
                        ddl2.DataTextField = "datDescription";
                        ddl2.DataValueField = "datID";
                        ddl2.DataBind();

                        txt3.ID = "txtComment" + (tblChkListItemChild[j].datID).ToString();
                        mylabel1.Attributes.Add("class", "");
                        ddl2.CssClass = "form-control";

                        tc1.CssClass = "col-md-5";
                        tc2.CssClass = "col-md-2";
                        tc3.CssClass = "col-md-4";
                        tc1.Controls.Add(mylabel1);
                        tc2.Controls.Add(ddl2);
                        tc3.Controls.Add(txt3);

                        tr.Cells.Add(tc1);
                        tr.Cells.Add(tc2);
                        tr.Cells.Add(tc3);

                        tbl.Rows.Add(tr);
                       
                    }
                    
                    myMainDiv.Controls.Add(tbl);
                    this.appForm.Controls.Add(myMainDiv);
                    
                }
                catch (Exception ex)
                { }
               
            }       
        }
       
}

    protected void btnSaveCheckList_Click(object sender, EventArgs e)
    {
        mainDSTableAdapters.CheckListItemsTableAdapter chklstItem = new mainDSTableAdapters.CheckListItemsTableAdapter();
        mainDS.CheckListItemsDataTable tblChklstItem = chklstItem.GetAllCheckListItems();
        LoanDSTableAdapters.CheckListItemsTableAdapter chkLst = new LoanDSTableAdapters.CheckListItemsTableAdapter();
        chkLst.DeleteCheckListItem(MySessionManager.AppID, MySessionManager.ClientID);
        
        if (tblChklstItem.Rows.Count > 0)
        {
            int i = 0;
            foreach(mainDS.CheckListItemsRow c in tblChklstItem  )
            {
                int? answer = null;
                int? question = null;
                string comment = "";
                string ddlname = "cmb" + c.datID.ToString();
                DropDownList ddl = (DropDownList)this.FindControl(ddlname);
                try { answer = Convert.ToInt32(ddl.SelectedValue); }
                catch (Exception ex) { }
                string txtname = "txtComment" + c.datID.ToString();
                TextBox txt3 = (TextBox)this.FindControl(txtname);
                try { comment = txt3.Text; }
                catch (Exception ex) { }
                string labelname = "label" + c.datID.ToString();
                Label mylabel1 = (Label)this.FindControl(labelname);
                try { question = c.datID; }
                catch (Exception ex) { }
                if (answer > 0 && question > 0)
                {
                    chkLst.InsertCheckListItems(MySessionManager.ClientID,
                                                MySessionManager.AppID,
                                                question,
                                                answer,
                                                comment);
                }
                i++;
            }



        }
    }

    public void loadData()
    {
            LoanDSTableAdapters.CheckListItemsTableAdapter CheckListItem = new LoanDSTableAdapters.CheckListItemsTableAdapter();
            LoanDS.CheckListItemsDataTable tblCheckLstVal = CheckListItem.GetCheckListItems(MySessionManager.AppID, MySessionManager.ClientID);
            foreach (LoanDS.CheckListItemsRow ch in tblCheckLstVal)
            {
                string text;
                try
                {
                    if (ch.datAnswer.ToString().Length > 0)
                    {
                        text = ch.datComment.ToString();

                        TextBox txtcomment = (TextBox)this.FindControl("txtComment" + ch.datQuestion.ToString());
                        try { txtcomment.Text = text; }
                        catch (Exception ex) { }
                        DropDownList ddl = (DropDownList)this.FindControl("cmb" + ch.datQuestion.ToString());
                        try { ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByValue(ch.datAnswer.ToString())); }
                        catch (Exception ex) { }

                    }
                }
                catch (Exception ex)
                {


                }

               
            }
            this.editskip.Value = "2";
    }
}
