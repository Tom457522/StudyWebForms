using System;
using System.Web;

namespace StudyWebForms
{
    /// <summary>
    /// Global.asax
    /// 
    /// アプリケーション全体のイベントハンドラを定義する場所。
    /// IIS のアプリケーションプール内で、Web Forms アプリが起動・終了する際に呼ばれるイベント。
    /// 
    /// このプロジェクトでは:
    /// ・Application_Start: アプリケーション起動時に1回だけ実行
    /// ・Application_BeginRequest: リクエストのたびに実行
    /// </summary>
    public partial class Global : HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            // 【アプリケーション起動時】IIS のアプリケーションプール内で最初に実行される
            // ここで「アプリケーション共有」の状態を初期化する(全ユーザー・全セッションで共有)

            Application["StartedAt"] = DateTime.Now;
            Application["TotalRequests"] = 0;

            // これらの値は、アプリケーションプールがリサイクルされるまで保持される
        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            // 【リクエストのたびに実行】クライアントからリクエストを受けるたびに呼ばれる
            // ここでは「全リクエスト数」をカウント

            // 【重要】Application は全スレッドから同時アクセスされるため、
            // 変更時には Lock() で排他制御し、変更が完了したら UnLock() で開放する
            Application.Lock();
            {
                Application["TotalRequests"] = ((int)(Application["TotalRequests"] ?? 0)) + 1;
            }
            Application.UnLock();
        }
    }
}
