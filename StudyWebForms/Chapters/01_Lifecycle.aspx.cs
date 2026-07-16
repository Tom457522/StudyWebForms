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
            Log.Add(string.Format("{0:HH:mm:ss.fff} Page_Init", DateTime.Now));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Log.Add(string.Format("{0:HH:mm:ss.fff} Page_Load / IsPostBack={1}", DateTime.Now, IsPostBack));
        }

        protected void ReloadButton_Click(object sender, EventArgs e)
        {
            Log.Add(string.Format("{0:HH:mm:ss.fff} ReloadButton_Click", DateTime.Now));
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            Log.Add(string.Format("{0:HH:mm:ss.fff} Page_PreRender", DateTime.Now));
            LifecycleLog.DataSource = Log;
            LifecycleLog.DataBind();
        }
    }
}
