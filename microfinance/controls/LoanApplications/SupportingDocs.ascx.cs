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
using System.IO;

public partial class controls_SupportingDocs : System.Web.UI.UserControl
{
    public string type { set; get; }
    public int id { set; get; }
    Utility util = new Utility();
    protected void Page_Load(object sender, EventArgs e)
    {
        this.docView.Visible = false;
        if (!(Request.QueryString["sdedit"] == null))
        {
            type = "update";
            id = Convert.ToInt32(Request.QueryString["sdedit"]);
            if (!(this.editskip.Value == "2"))
            {
                loadSupportingDocs(id);
            }
        }
        else if (!(Request.QueryString["sddelete"] == null))
        {
            string id =Request.QueryString["sddelete"];

            util.deleteItem("tbl_supporting_documents", id);
            Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "sddelete"));
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string fileName = fuDocument.FileName;
        string targetPath = @"~\uploadDocs";
        try
        {

            string filepath = "";
            if (fuDocument.HasFile)
                // Call a helper method routine to save the file.
                filepath = SaveFile(fuDocument.PostedFile);
            else
                // Notify the user that a file was not uploaded.
                UploadStatusLabel.Text = "You did not specify a file to upload.";

            LoanDSTableAdapters.SupportingDocumentsTableAdapter tblSupportingDoc = new LoanDSTableAdapters.SupportingDocumentsTableAdapter();
            if (!(type == "update"))
            {
                


                tblSupportingDoc.InsertSupportingDocuments(MySessionManager.ClientID,
                                                           MySessionManager.AppID,
                                                           txtDocumentType.Value.Trim(),
                                                           txtDescription.Value.Trim(),
                                                           filepath,
                                                           MySessionManager.CurrentUser.UserID);
           
               
            }
            else if (type == "update")
            {
                tblSupportingDoc.UpdateSupportingDocument(txtDocumentType.Value.Trim(),
                                                          txtDescription.Value.Trim(),
                                                          filepath,
                                                          MySessionManager.CurrentUser.UserID,
                                                          id);
            
            
            }
           
        }
        catch (Exception ex) { }

      
        Page.Response.Redirect(util.RemoveQueryStringByKey(HttpContext.Current.Request.Url.AbsoluteUri, "sdedit"));
    }

    protected void gvSupportingDocs_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HyperLink delete = (HyperLink)e.Row.FindControl("hyperDelete");
            HyperLink edit = (HyperLink)e.Row.FindControl("hyperEdit");

            string enpValue = this.gvSupportingDocs.DataKeys[e.Row.RowIndex].Value.ToString();

            string urlpath = HttpContext.Current.Request.Url.AbsoluteUri + "&sdedit=" + enpValue;
            string urlpathDel = HttpContext.Current.Request.Url.AbsoluteUri + "&sddelete=" + enpValue;

            edit.NavigateUrl = urlpath;
            delete.NavigateUrl = urlpathDel;

        }

    }

    public void loadSupportingDocs(int id)
    {
        LoanDSTableAdapters.SupportingDocumentsTableAdapter suppDocs = new LoanDSTableAdapters.SupportingDocumentsTableAdapter();
        LoanDS.SupportingDocumentsDataTable tblSuppDocs = suppDocs.GetSupportingDocDetails(id);

        if (tblSuppDocs.Rows.Count > 0)
        {
            txtDescription.Value = tblSuppDocs[0].datDescription.ToString();
            txtDocumentType.Value = tblSuppDocs[0].datFileName.ToString();
            //Find a way to show the uploaded Docs
            this.docView.Visible = true; 
            HyperDocs.NavigateUrl ="";

            this.editskip.Value = "2";  
        }
    }
    public string SaveFile(HttpPostedFile file)
      {
          string path;
        // Specify the path to save the uploaded file to.

          string savePath =Server.MapPath(@"~\\uploadDocs\\"+ MySessionManager.AppID.ToString());
          if (!Directory.Exists(savePath))
          {
              Directory.CreateDirectory(savePath);
          }
        string fileName = this.fuDocument.FileName;

        // Create the path and file name to check for duplicates.
        string pathToCheck1 = Server.MapPath(@"~\\uploadDocs\\" + fileName.ToString());
        string pathToCheck = Server.MapPath(@"~\\uploadDocs\\" + MySessionManager.AppID.ToString() + "\\" + fileName.ToString());

        // Create a temporary file name to use for checking duplicates.
        string tempfileName = "";

        // Check to see if a file already exists with the
        // same name as the file to upload.        
        if (System.IO.File.Exists(pathToCheck)) 
        {
          int counter = 2;
          while (System.IO.File.Exists(pathToCheck))
          {
            // if a file with this name already exists,
            // prefix the filename with a number.
            tempfileName = counter.ToString() + fileName;
            pathToCheck = savePath + tempfileName;
            counter ++;
          }

          fileName = tempfileName;

          // Notify the user that the file name was changed.
           UploadStatusLabel.Text = "A file with the same name already exists." +
              "<br />Your file was saved as " + fileName;
           this.UploadStatusLabel.Visible = true;
        }
        else
        {

          // Notify the user that the file was saved successfully.
            UploadStatusLabel.Text = "Your file was uploaded successfully.";
            this.UploadStatusLabel.Visible = true;
        }

        // Append the name of the file to upload to the path.
        savePath += fileName;
        path = pathToCheck;
        // Call the SaveAs method to save the uploaded
        // file to the specified directory.
        fuDocument.SaveAs(path);
        return path;
      }
    
    
    
    }

