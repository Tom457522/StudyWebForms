using System;
using System.Collections.Generic;

namespace StudyWebForms.Chapters
{
    public partial class _01_Lifecycle : System.Web.UI.Page
    {
        private List<string> Log
        {
            get
            {
                if (ViewState["LifecycleLog"] == null)
                {
                    ViewState["LifecycleLog"] = new List<string>();
                }
                return (List<string>)ViewState["LifecycleLog"];
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            Log.Add($"{DateTime.Now:HH:mm:ss.fff} Page_Init");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Log.Add($"{DateTime.Now:HH:mm:ss.fff} Page_Load / IsPostBack={IsPostBack}");
        }

        protected void ReloadButton_Click(object sender, EventArgs e)
        {
            Log.Add($"{DateTime.Now:HH:mm:ss.fff} ReloadButton_Click");
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            Log.Add($"{DateTime.Now:HH:mm:ss.fff} Page_PreRender");
            LifecycleLog.DataSource = Log;
            LifecycleLog.DataBind();
        }
    }
}
