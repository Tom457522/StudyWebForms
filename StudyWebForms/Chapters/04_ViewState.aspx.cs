using System;

namespace StudyWebForms.Chapters
{
    public partial class _04_ViewState : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            RenderViewState();
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            ViewState["Memo"] = MemoTextBox.Text;
            RenderViewState();
        }

        protected void ClearButton_Click(object sender, EventArgs e)
        {
            ViewState.Remove("Memo");
            MemoTextBox.Text = string.Empty;
            RenderViewState();
        }

        private void RenderViewState()
        {
            var memo = ViewState["Memo"] as string;
            ViewStateLabel.Text = string.IsNullOrEmpty(memo)
                ? "ViewState[\"Memo\"] は未設定です。"
                : string.Format("ViewState[\"Memo\"] = {0}", Server.HtmlEncode(memo));
        }
    }
}
