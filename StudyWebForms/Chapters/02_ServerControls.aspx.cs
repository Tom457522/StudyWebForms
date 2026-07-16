using System;

namespace StudyWebForms.Chapters
{
    public partial class _02_ServerControls : System.Web.UI.Page
    {
        protected void ReflectButton_Click(object sender, EventArgs e)
        {
            ResultLabel.Text = string.IsNullOrWhiteSpace(NameTextBox.Text)
                ? "未入力です。TextBox.Text は空です。"
                : string.Format("こんにちは、{0} さん。TextBox.Text を Label.Text に反映しました。", Server.HtmlEncode(NameTextBox.Text));
        }
    }
}
