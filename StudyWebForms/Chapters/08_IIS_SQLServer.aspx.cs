using System;
using System.Configuration;
using System.Web;

namespace StudyWebForms.Chapters
{
    public partial class _08_IIS_SQLServer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RenderInfo();
            }
        }

        protected void ShowInfoButton_Click(object sender, EventArgs e)
        {
            RenderInfo();
        }

        private void RenderInfo()
        {
            var connection = ConfigurationManager.ConnectionStrings["StudyDb"]?.ConnectionString ?? "未設定";
            InfoLiteral.Text =
                $"<strong>MachineName:</strong> {Server.HtmlEncode(Environment.MachineName)}<br />" +
                $"<strong>Application Path:</strong> {Server.HtmlEncode(HttpRuntime.AppDomainAppPath)}<br />" +
                $"<strong>AppDomain:</strong> {Server.HtmlEncode(AppDomain.CurrentDomain.FriendlyName)}<br />" +
                $"<strong>Session Mode:</strong> InProc<br />" +
                $"<strong>StudyDb ConnectionString:</strong> {Server.HtmlEncode(connection)}";
        }
    }
}
