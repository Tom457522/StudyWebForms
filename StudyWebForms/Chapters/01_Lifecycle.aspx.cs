using System;
using System.Collections.Generic;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第1章: ページライフサイクル
    /// 
    /// このページの目的:
    /// Web Forms が 1回のリクエストごとに Page オブジェクトを新規作成し、
    /// 決まった順番でイベントを実行することを体験的に理解する。
    /// 
    /// 学習ポイント:
    /// ・Page インスタンスは毎回作り直される(Page_Init が呼ばれる)
    /// ・同じ Page_Load/Click イベントでも、IsPostBack で初回か PostBack かを判定できる
    /// ・状態を保持したい場合は ViewState などを使う
    /// </summary>
    public partial class _01_Lifecycle : System.Web.UI.Page
    {
        /// <summary>
        /// 各ページインスタンスの一意ID
        /// Page インスタンスが何回作り直されたかを追跡するため
        /// </summary>
        private string PageInstanceId { get; set; }

        /// <summary>
        /// ライフサイクルログを ViewState から取得
        /// PostBack 後も履歴が残るようにするため ViewState を使用
        /// (Page インスタンスは毎回新規作成されるため、このメンバ変数には格納できない)
        /// </summary>
        private List<string> Log
        {
            get
            {
                if (ViewState["LifecycleLog"] == null)
                {
                    ViewState["LifecycleLog"] = new List<string>();
                }
                return (List<string>)ViewState["LifecycleLog"];
            }
        }

        protected override void OnInit(EventArgs e)
        {
            // 【重要】基底クラスの OnInit は最初に呼ぶ
            base.OnInit(e);

            // 新しい Page インスタンスが作成されたことを記録
            // (Page_Init より前の段階で実行)
            PageInstanceId = Guid.NewGuid().ToString().Substring(0, 8);
            Log.Add(string.Format("┌─ Page インスタンス #{0}", PageInstanceId));
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            // 【ライフサイクル第1段階】コントロールの初期化
            // コントロールの ID や階層は決まるが、ViewState はまだ復元されていない
            Log.Add(string.Format("│  {0:HH:mm:ss.fff} ① Page_Init (コントロール初期化段階)", DateTime.Now));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 【ライフサイクル第2段階】ページロード
            // ViewState 復元後に呼ばれるので、この時点で復元したデータが使える
            string postBackInfo = IsPostBack ? "【PostBack】" : "【初回表示】";
            Log.Add(string.Format("│  {0:HH:mm:ss.fff} ② Page_Load {1}", DateTime.Now, postBackInfo));
        }

        protected void ReloadButton_Click(object sender, EventArgs e)
        {
            // 【ボタンクリック】イベントハンドラ
            // PostBack 時に Page_Load の後、Page_PreRender の前に呼ばれる
            // ここでビジネスロジック(画面操作への応答)を記述する
            Log.Add(string.Format("│  {0:HH:mm:ss.fff} ③ ReloadButton_Click (ボタンクリック処理)", DateTime.Now));
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            // 【ライフサイクル最終段階】描画前調整
            // HTML 生成の直前。ここが最後のデータ更新チャンス
            Log.Add(string.Format("└─ {0:HH:mm:ss.fff} ④ Page_PreRender (描画前調整)", DateTime.Now));

            // ライフサイクルトレースログを画面に表示
            LifecycleLog.DataSource = Log;
            LifecycleLog.DataBind();
        }
    }
}
