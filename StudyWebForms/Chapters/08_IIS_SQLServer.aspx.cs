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
            var setting = ConfigurationManager.ConnectionStrings["StudyDb"];
            var connection = setting != null ? setting.ConnectionString : "未設定";
            InfoLiteral.Text = string.Format(
                "<strong>マシン名 (MachineName):</strong> {0}<br /><strong>アプリケーションパス:</strong> {1}<br /><strong>AppDomain:</strong> {2}<br /><strong>セッションモード:</strong> InProc<br /><strong>StudyDb 接続文字列:</strong> {3}",
                Server.HtmlEncode(Environment.MachineName),
                Server.HtmlEncode(HttpRuntime.AppDomainAppPath),
                Server.HtmlEncode(AppDomain.CurrentDomain.FriendlyName),
                Server.HtmlEncode(connection));
        }
    }
}
