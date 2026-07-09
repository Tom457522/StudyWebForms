using System;

namespace StudyWebForms.Chapters
{
    public partial class _05_StateManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RenderState();
        }

        protected void AddSessionButton_Click(object sender, EventArgs e)
        {
            Session["Counter"] = ((int?)Session["Counter"] ?? 0) + 1;
            RenderState();
        }

        protected void AddCacheButton_Click(object sender, EventArgs e)
        {
            Cache.Insert("CachedMessage", $"Cache に保存しました: {DateTime.Now:HH:mm:ss}", null, DateTime.Now.AddMinutes(5), TimeSpan.Zero);
            RenderState();
        }

        private void RenderState()
        {
            StateLabel.Text =
                $"Session[Counter]={Session["Counter"] ?? 0}<br />" +
                $"Application[StartedAt]={Application["StartedAt"]}<br />" +
                $"Application[TotalRequests]={Application["TotalRequests"]}<br />" +
                $"Cache[CachedMessage]={Cache["CachedMessage"] ?? "未設定"}";
        }
    }
}
