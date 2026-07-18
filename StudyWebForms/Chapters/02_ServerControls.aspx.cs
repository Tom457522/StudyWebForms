using System;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第2章: サーバーコントロール
    /// 
    /// このページの目的:
    /// Web Forms の「サーバーコントロール」が、最終的には HTML に変換されることを理解する。
    /// TextBox → <input type="text">
    /// Label → <span> や <div> など
    /// Button → <button> や <input type="submit">
    /// 
    /// 学習ポイント:
    /// ・ASP.NET コントロール(runat="server")はサーバー側で処理され、最終的に plain HTML に変換される
    /// ・.aspx のコントロール定義は、code-behind(C#)から .Text などのプロパティでアクセスできる
    /// ・ブラウザが受け取るのは plain HTML なので、JavaScript でも操作可能(だがおすすめしない)
    /// ・入力値を出力するときは Server.HtmlEncode() で XSS 対策を施す
    /// </summary>
    public partial class _02_ServerControls : System.Web.UI.Page
    {
        protected void ReflectButton_Click(object sender, EventArgs e)
        {
            // 【ボタンクリック処理】
            // TextBox(ID=NameTextBox)から入力値を取得し、Label(ID=ResultLabel)に出力

            string inputValue = NameTextBox.Text;

            if (string.IsNullOrWhiteSpace(inputValue))
            {
                // 【入力なしの場合】
                ResultLabel.Text = "<strong style='color:#999;'>未入力です。</strong><br/>" +
                    "<small style='color:#666;'>TextBox.Text プロパティが空文字列になっています。</small>";
            }
            else
            {
                // 【入力ありの場合】
                // ブラウザに表示する前に Server.HtmlEncode() でエスケープ
                // (< > & などを HTML エンティティに変換 → XSS 対策)
                ResultLabel.Text = string.Format(
                    "<strong>✓ 反映成功!</strong><br/>" +
                    "こんにちは、<code style='background:#f0f0f0; padding:2px 4px;'>{0}</code> さん。<br/>" +
                    "<small style='color:#666;'>TextBox.Text プロパティから取得した値を、Label.Text に反映しました。</small>",
                    Server.HtmlEncode(inputValue)
                );
            }
        }
    }
}
