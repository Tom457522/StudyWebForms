using System;
using System.Configuration;
using System.Web;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第8章: IIS / SQL Server
    /// 
    /// このページの目的:
    /// Web Forms アプリケーションが IIS/AppPool 上で実行され、
    /// データベースに接続する基盤を体験的に理解する。
    /// 
    /// 学習ポイント:
    /// ・IIS は Windows サーバーの Web サーバーソフトウェア
    /// ・アプリケーションプール(AppPool)は IIS 上で Web アプリが動作するプロセス(w3wp.exe)
    /// ・同じアプリケーション内でも複数の AppDomain が分かれることがある(本サンプルでは通常1つ)
    /// ・接続文字列は Web.config から ConfigurationManager で読み取る
    /// ・複数の Web Forms インスタンスは同じ AppPool プロセス内で実行される
    /// </summary>
    public partial class _08_IIS_SQLServer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 【初回表示時のみ情報を取得】
            // (毎回取得してもいいが、通常は初回表示のみで十分)
            if (!IsPostBack)
            {
                RenderInfo();
            }
        }

        protected void ShowInfoButton_Click(object sender, EventArgs e)
        {
            // 【ボタンクリック時に再取得】
            // IIS/AppPool の情報は通常変わらないが、
            // 「今このボタンが実行されているプロセス・マシンを確認」という
            // デバッグ目的でボタンを設置
            RenderInfo();
        }

        private void RenderInfo()
        {
            // 【現在の実行環境情報を取得】

            // 1. マシン名 (複数マシンの場合に、どれで実行されているか確認)
            string machineName = Environment.MachineName;

            // 2. IIS 上のアプリケーション物理パス
            // (IIS Manager で「物理パス」と表示されている場所)
            string appPath = HttpRuntime.AppDomainAppPath;

            // 3. AppDomain 名
            // (通常は アプリケーション名 + GUID のようなもの)
            string appDomainName = AppDomain.CurrentDomain.FriendlyName;

            // 4. Web.config から接続文字列を読み取る
            // ConfigurationManager は IIS の web.config を自動的に読み込む
            var connectionStringSetting = ConfigurationManager.ConnectionStrings["StudyDb"];
            string connectionString = connectionStringSetting != null
                ? connectionStringSetting.ConnectionString
                : "❌ 未設定 (Web.config の &lt;connectionStrings&gt; を確認してください)";

            // 【画面に表示】
            InfoLiteral.Text = string.Format(
                "<div style='background:#f9f9f9; border-left:3px solid #5EA8A7; padding:12px;'>" +
                "<strong>実行マシン (MachineName):</strong> <code>{0}</code><br/>" +
                "<small style='color:#666;'>→ 複数サーバー構成の場合、どのマシンで実行されているか</small><br/><br/>" +
                "<strong>IIS アプリケーション物理パス:</strong> <code>{1}</code><br/>" +
                "<small style='color:#666;'>→ IIS Manager の「物理パス」と一致します</small><br/><br/>" +
                "<strong>AppDomain 名:</strong> <code>{2}</code><br/>" +
                "<small style='color:#666;'>→ このプロセス内の論理的なアプリケーション境界</small><br/><br/>" +
                "<strong>セッションモード:</strong> <code>InProc</code> (ローカルメモリ保存)<br/>" +
                "<small style='color:#666;'>→ Session は w3wp.exe プロセスのメモリに保存(AppPool 再起動で消える)</small><br/><br/>" +
                "<strong>StudyDb 接続文字列:</strong> <code>{3}</code><br/>" +
                "<small style='color:#666;'>→ ConfigurationManager が Web.config から読み取ります</small>" +
                "</div>",
                Server.HtmlEncode(machineName),
                Server.HtmlEncode(appPath),
                Server.HtmlEncode(appDomainName),
                Server.HtmlEncode(connectionString)
            );
        }
    }
}
