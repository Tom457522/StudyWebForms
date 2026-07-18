using System;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第4章: ViewState
    /// 
    /// このページの目的:
    /// Web Forms の状態保持メカニズム = ViewState を実際に体験する。
    /// 入力した値を保存→復元されるまでの流れを、ステップバイステップで観察できる。
    /// 
    /// 学習ポイント:
    /// ・ViewState はクライアント側の hidden フィールドに Base64 エンコード・暗号化されて保存される
    /// ・PostBack 時に、サーバーが hidden フィールドから ViewState を復号化・復元する
    /// ・Page インスタンスが毎回作り直されても、ViewState があれば状態が維持される
    /// ・ViewState に大きなデータを入れるとレスポンスサイズが増える(パフォーマンス上の注意)
    /// </summary>
    public partial class _04_ViewState : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 【初回表示時】
            // この段階では ViewState はまだ復元されていない。
            // 初回表示なら TextBox は空、PostBack なら前回保存した値が復元されている。
            RenderViewState();
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            // 【保存処理】
            // TextBox から入力値を取得して、ViewState に書き込む
            string userInput = MemoTextBox.Text;
            ViewState["Memo"] = userInput;

            // 画面表示を更新
            RenderViewState();

            // 【重要】この後、Page_PreRender が実行されて、
            // ViewState は HTML の隠しフィールド (__VIEWSTATE) に Base64 エンコード・暗号化されて出力される
        }

        protected void ClearButton_Click(object sender, EventArgs e)
        {
            // 【削除処理】
            // ViewState から "Memo" キーを完全に削除
            ViewState.Remove("Memo");
            MemoTextBox.Text = string.Empty;

            // 画面表示を更新
            RenderViewState();
        }

        private void RenderViewState()
        {
            // ViewState["Memo"] の現在値を画面に表示する
            // これにより「現在何が保存されているか」が一目瞭然

            var memo = ViewState["Memo"] as string;

            if (string.IsNullOrEmpty(memo))
            {
                // 未設定の場合
                ViewStateLabel.Text = "<strong style='color: #999;'>ViewState[\"Memo\"] は未設定です。値を入力して「保存」ボタンを押してください。</strong>";
                MemoTextBox.Text = string.Empty;
            }
            else
            {
                // 設定済みの場合(保存されたメモの内容を表示)
                ViewStateLabel.Text = string.Format(
                    "<strong>✔ 保存済み:</strong> ViewState[\"Memo\"] = <code style='background:#f0f0f0; padding:4px; border-radius:3px;'>{0}</code><br/>" +
                    "<small style='color:#666;'>※ この値は Page インスタンスが作り直されてもクライアント側の ViewState から復元されます</small>",
                    Server.HtmlEncode(memo)
                );
            }
        }
    }
}
