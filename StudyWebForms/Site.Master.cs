using System;

namespace StudyWebForms
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            FooterInfoLabel.Text = string.Format("サーバー時刻: {0:yyyy/MM/dd HH:mm:ss} ／ IsPostBack: {1}", DateTime.Now, Page.IsPostBack);
        }
    }
}
