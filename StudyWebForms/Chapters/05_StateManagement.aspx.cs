using System;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第5章: State Management
    /// 
    /// このページの目的:
    /// ViewState に続く、別の状態保持メカニズムを体験する:
    /// - Session: ユーザーごと(ブラウザセッションごと)の状態
    /// - Application: アプリケーション全体(全ユーザー共通)の状態
    /// - Cache: 一時的な保存(時間切れで自動削除)
    /// 
    /// 学習ポイント:
    /// ・Session は「1つのブラウザ/ユーザーの状態」を保持(他のユーザーには見えない)
    /// ・Application は「全アプリケーション共通の状態」(全ユーザーが見る)
    /// ・Cache は「データベースクエリ結果などを一時保存」(期限切れで消える)
    /// ・View/Session/Application の使い分けが重要(スコープの違い)
    /// </summary>
    public partial class _05_StateManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 画面に現在の状態を表示
            RenderState();
        }

        protected void AddSessionButton_Click(object sender, EventArgs e)
        {
            // 【Session に保存】
            // Session は「このブラウザ/ユーザーのみ」のデータ保存
            // 別のブラウザ/別のユーザーには見えない
            int currentCount = (int?)Session["Counter"] ?? 0;
            Session["Counter"] = currentCount + 1;

            // 画面を更新
            RenderState();
        }

        protected void AddCacheButton_Click(object sender, EventArgs e)
        {
            // 【Cache に保存】
            // Cache は「一時的なデータ保存」
            // 5分後に自動的に削除される
            // 全ユーザーで共有される
            Cache.Insert(
                "CachedMessage",
                string.Format("✓ Cache に保存しました (5分後に自動削除): {0:HH:mm:ss}", DateTime.Now),
                null,                           // キャッシュ依存性(なし)
                DateTime.Now.AddMinutes(5),     // 絶対有効期限(5分後)
                TimeSpan.Zero                   // スライディング有効期限(なし)
            );

            // 画面を更新
            RenderState();
        }

        private void RenderState()
        {
            // 各種状態保持メカニズムの現在値を表示
            string stateInfo = string.Format(
                "<strong>▼ 状態保持メカニズムの状態:</strong><br/>" +
                "<div style='margin-top:10px; padding:8px; background:#f9f9f9; border-left:3px solid #5EA8A7;'>" +
                "<strong>Session[Counter]</strong> (このブラウザのみ): {0}<br/>" +
                "<small style='color:#666;'>→ 複数のタブで異なる値を持つことも可能</small><br/><br/>" +
                "<strong>Application[StartedAt]</strong> (アプリ共通): {1}<br/>" +
                "<small style='color:#666;'>→ IIS のアプリケーションプール起動時刻(全ユーザーで同じ)</small><br/><br/>" +
                "<strong>Application[TotalRequests]</strong> (アプリ共通): {2} リクエスト<br/>" +
                "<small style='color:#666;'>→ このページを開くたびにカウント(全ユーザーの総数)</small><br/><br/>" +
                "<strong>Cache[CachedMessage]</strong> (一時保存, 5分有効): {3}<br/>" +
                "<small style='color:#666;'>→ ボタンを押すと 5分後に自動削除される</small>" +
                "</div>",
                Session["Counter"] ?? 0,
                Application["StartedAt"],
                Application["TotalRequests"],
                Cache["CachedMessage"] ?? "（未設定・期限切れ）"
            );
            StateLabel.Text = stateInfo;
        }
    }
}
