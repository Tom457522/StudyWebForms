using System;

namespace StudyWebForms.Chapters
{
    public partial class _06_Validation : System.Web.UI.Page
    {
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                ResultLabel.Text = "入力エラーがあります。Validator の結果を確認してください。";
                return;
            }

            ResultLabel.Text = string.Format(
                "登録できます。Email={0}, Age={1}",
                Server.HtmlEncode(EmailTextBox.Text),
                Server.HtmlEncode(AgeTextBox.Text));
        }
    }
}
