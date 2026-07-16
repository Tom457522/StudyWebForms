using System;
using System.Web;

namespace StudyWebForms
{
    public partial class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            Application["StartedAt"] = DateTime.Now;
            Application["TotalRequests"] = 0;
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            Application.Lock();
            Application["TotalRequests"] = ((int)(Application["TotalRequests"] ?? 0)) + 1;
            Application.UnLock();
        }
    }
}
