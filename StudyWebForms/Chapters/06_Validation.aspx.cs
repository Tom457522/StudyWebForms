using System;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第6章: 入力検証
    /// 
    /// このページの目的:
    /// Web Forms の Validator コントロールを使った、クライアント側とサーバー側の
    /// 2段階検証を体験する。
    /// 
    /// 学習ポイント:
    /// ・RequiredFieldValidator, RangeValidator など複数の Validator コントロールが利用可能
    /// ・Validator はクライアント側(JavaScript)でも動作し、サーバー送信前に検証できる
    /// ・但し、JavaScript は改ざん・無効化される可能性があるため、サーバー側の確認も必須
    /// ・Page.IsValid プロパティで、全 Validator の検証結果を確認できる
    /// ・Server.HtmlEncode() で、入力値の XSS 対策を行う(< > & などの特殊文字をエスケープ)
    /// </summary>
    public partial class _06_Validation : System.Web.UI.Page
    {
        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // 【サーバー側検証】
            // Validator コントロールの検証結果を Page.IsValid で確認
            // (クライアント側 JavaScript での検証を突破して、不正なデータが来ていないか再確認)
            if (!Page.IsValid)
            {
                ResultLabel.Text = "<strong style='color:#d32f2f;'>❌ エラー: 入力内容が条件を満たしていません。上のメッセージを確認してください。</strong>";
                return;
            }

            // 【検証成功時の処理】
            // 入力値を画面に表示(Server.HtmlEncode で < > & などの特殊文字をエスケープ)
            ResultLabel.Text = string.Format(
                "<strong style='color:#2e7d32;'>✓ 登録成功! </strong><br/>" +
                "メールアドレス: <code>{0}</code><br/>" +
                "年齢: <code>{1}</code>",
                Server.HtmlEncode(EmailTextBox.Text),
                Server.HtmlEncode(AgeTextBox.Text)
            );

            // ここからデータベースに登録するなど、実際の業務処理を進める
        }
    }
}
