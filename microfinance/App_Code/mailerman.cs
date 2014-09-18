using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Net.Mail;

/// <summary>
/// Summary description for mailerman
/// </summary>
public class mailerman
{
    public string message{get;set;}
    public string ToAddress{get;set;}
    public string fromAddress{get;set;}
	public mailerman()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int sendMail()
    {
        int result=0;
        SmtpClient smtpClient = new SmtpClient("mail.MyWebsiteDomainName.com", 25);

        smtpClient.Credentials = new System.Net.NetworkCredential("info@MyWebsiteDomainName.com", "myIDPassword");
        smtpClient.UseDefaultCredentials = true;
        smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
        smtpClient.EnableSsl = true;
        MailMessage mail = new MailMessage();

        //Setting From , To and CC
        try
        {
            mail.From = new MailAddress("info@MyWebsiteDomainName", "MyWeb Site");
            mail.To.Add(new MailAddress("info@MyWebsiteDomainName"));
            mail.CC.Add(new MailAddress("MyEmailID@gmail.com"));

            smtpClient.Send(mail);
        }
        catch (Exception ex)
        {
                }

        return result;
            }
}
