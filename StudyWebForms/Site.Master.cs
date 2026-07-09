using System;

namespace StudyWebForms
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FooterInfoLabel.Text = $"Server time: {DateTime.Now:yyyy/MM/dd HH:mm:ss} / IsPostBack: {Page.IsPostBack}";
        }
    }
}
