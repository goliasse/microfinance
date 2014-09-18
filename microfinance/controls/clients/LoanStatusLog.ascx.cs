using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class controls_clients_LoanStatusLog : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (MySessionManager.AppID == 0)
        {

        }
        else
        {
            LoanDSTableAdapters.LoanMonitoringTableAdapter monAdd = new LoanDSTableAdapters.LoanMonitoringTableAdapter();
            LoanDS.LoanMonitoringDataTable statLog = monAdd.getLoanAppMonInfo(MySessionManager.AppID);
            if (statLog.Count > 0)
            {   

                LoanDS.LoanMonitoringRow sl = statLog[0];
                usersTableAdapters.GetUserNameTableAdapter un = new usersTableAdapters.GetUserNameTableAdapter();

                string html = "<p>";
                DateTime  txt;
                try
                {
                    txt = sl.datStatusChangedDate1;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate1.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy1))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex)
                { }

                try
                {
                    txt = sl.datStatusChangedDate2;
                    html += "<h5>Registered For Interview</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate2.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy2))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate3;
                    html += "<h5>Moved For Pre Approval</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate3.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy3))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate4;
                    html += "<h5>Moved For Appraisal</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate4.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy4))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate5;
                    html += "<h5>Moved for Risk Accessment</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate5.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy5))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate6;
                    html += "<h5>Moved to Legal Accessment</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate6.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy6))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate7;
                    html += "<h5>Moved for Approval</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate7.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy7))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate8;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate8.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy8))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }
                try
                {
                    txt = sl.datStatusChangedDate9;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate9.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy9))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }
                try
                {
                    txt = sl.datStatusChangedDate10;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate10.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy10))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate11;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate11.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy11))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate12;
                    html += "<h5>Moved to Approved Loans</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate12.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy12))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate13;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate13.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy13))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate14;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate14.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy14))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate15;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate15.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy15))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate16;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate16.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy16))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate17;
                    html += "<h5>Application Declined</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate17.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy17))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate18;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate18.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy18))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate19;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate19.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy19))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                try
                {
                    txt = sl.datStatusChangedDate20;
                    html += "<h5>Appraisal Time</h5>";
                    html += "<span>Time : </span><span>" + sl.datStatusChangedDate20.ToString() + "</span><br/>";
                    html += "<span>By : </span>";
                    try
                    {
                        html += "<span>" + un.GetUserName(Convert.ToInt32(sl.datStatusChangedBy20))[0].name + "</span>";
                    }
                    catch (Exception ex)
                    {
                    }
                    html += "<br/><br/>";
                }
                catch (Exception ex) { }

                html += "</p>";
                logPanel.InnerHtml = html;
            }
        }
    }
}
