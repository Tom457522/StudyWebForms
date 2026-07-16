using System;

namespace StudyWebForms.Chapters
{
    public partial class _03_PostBack : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ViewState["Count"] = 0;
            }
            RenderCount();
        }

        protected void CountButton_Click(object sender, EventArgs e)
        {
            ViewState["Count"] = ((int)ViewState["Count"]) + 1;
            RenderCount();
        }

        protected void ResetButton_Click(object sender, EventArgs e)
        {
            ViewState["Count"] = 0;
            RenderCount();
        }

        private void RenderCount()
        {
            CountLabel.Text = string.Format("IsPostBack={0} / Count={1}", IsPostBack, ViewState["Count"]);
        }
    }
}
