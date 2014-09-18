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

/// <summary>
/// Summary description for DateTimeExtensions
/// </summary>
public static class DateTimeExtensions
{
    public static DateTime GetFirstDayOfWeek(this DateTime sourceDateTime)
    {
        var daysAhead = (DayOfWeek.Sunday - (int)sourceDateTime.DayOfWeek);

        sourceDateTime = sourceDateTime.AddDays((int)daysAhead);

        return sourceDateTime;
    }

    public static DateTime GetLastDayOfWeek(this DateTime sourceDateTime)
    {
        var daysAhead = DayOfWeek.Saturday - (int)sourceDateTime.DayOfWeek;

        sourceDateTime = sourceDateTime.AddDays((int)daysAhead);

        return sourceDateTime;
    }
}
