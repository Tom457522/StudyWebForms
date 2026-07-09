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

            ResultLabel.Text = $"登録できます。Email={Server.HtmlEncode(EmailTextBox.Text)}, Age={Server.HtmlEncode(AgeTextBox.Text)}";
        }
    }
}
