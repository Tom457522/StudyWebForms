using System;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第3章: PostBack とイベント処理
    /// 
    /// このページの目的:
    /// ボタン押下がどのように「同じページへの再送信(PostBack)」として処理されるか、
    /// そして IsPostBack を使った条件分岐を体験する。
    /// 
    /// 学習ポイント:
    /// ・Web Forms ではボタン押下は「別ページへの遷移」ではなく「同じページへのフォーム再送信」
    /// ・Page_Load は毎回実行されるが、IsPostBack で初回か PostBack か判定できる
    /// ・初回表示時は IsPostBack=false、その後は IsPostBack=true
    /// ・イベントハンドラ(CountButton_Click など)は Page_Load の後に実行される
    /// ・状態を保持したい場合(ここではカウント値)は ViewState に保存
    /// </summary>
    public partial class _03_PostBack : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 【初回表示時の初期化】
            // if (!IsPostBack) は「初回表示か」を判定する重要なパターン
            // 初回表示でのみ初期化処理を実行し、以降の PostBack では初期化しない
            if (!IsPostBack)
            {
                // 【初回表示】カウントを 0 で初期化
                ViewState["Count"] = 0;
                ViewState["PostBackCount"] = 0;
            }
            else
            {
                // 【PostBack】何回目の PostBack か をカウント
                int pbCount = (int)ViewState["PostBackCount"];
                ViewState["PostBackCount"] = pbCount + 1;
            }

            // 画面にカウント情報を表示
            RenderCount();
        }

        protected void CountButton_Click(object sender, EventArgs e)
        {
            // 【イベント処理】カウントボタンが押された
            // この処理は PostBack 時に Page_Load の後に実行される
            int currentCount = (int)ViewState["Count"];
            ViewState["Count"] = currentCount + 1;

            // 画面を更新
            RenderCount();
        }

        protected void ResetButton_Click(object sender, EventArgs e)
        {
            // 【リセット処理】カウントを 0 に戻す
            ViewState["Count"] = 0;
            ViewState["PostBackCount"] = 0;

            // 画面を更新
            RenderCount();
        }

        private void RenderCount()
        {
            // 画面にデバッグ情報を表示(フロー理解を助ける)
            string debugInfo = string.Format(
                "<strong>状態:</strong> IsPostBack={0} | " +
                "<strong>カウント値:</strong> {1} | " +
                "<strong>PostBack 回数:</strong> {2}回<br/>" +
                "<small style='color:#666;'>※ ボタンを押すたびに Page インスタンスが新規作成され、ライフサイクルが実行されます</small>",
                IsPostBack,
                ViewState["Count"],
                ViewState["PostBackCount"]
            );
            CountLabel.Text = debugInfo;
        }
    }
}
