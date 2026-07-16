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
            Cache.Insert("CachedMessage", string.Format("Cache に保存しました: {0:HH:mm:ss}", DateTime.Now), null, DateTime.Now.AddMinutes(5), TimeSpan.Zero);
            RenderState();
        }

        private void RenderState()
        {
            StateLabel.Text = string.Format(
                "Session[Counter]={0}<br />Application[StartedAt]={1}<br />Application[TotalRequests]={2}<br />Cache[CachedMessage]={3}",
                Session["Counter"] ?? 0,
                Application["StartedAt"],
                Application["TotalRequests"],
                Cache["CachedMessage"] ?? "未設定");
        }
    }
}
