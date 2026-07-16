using System;
using System.Collections.Generic;

namespace StudyWebForms
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ChapterRepeater.DataSource = new List<object>
                {
                    new { No = "01", Title = "ページライフサイクル", Description = "Page_Init → Page_Load → クリックイベント → Page_PreRender の実行順序をログで確認します。", Url = "Chapters/01_Lifecycle.aspx" },
                    new { No = "02", Title = "サーバーコントロール", Description = "asp:Label や asp:TextBox がどんな HTML として出力されるかを確認します。", Url = "Chapters/02_ServerControls.aspx" },
                    new { No = "03", Title = "PostBack とイベント", Description = "ボタンクリックが PostBack としてサーバーに送られ、イベントが発生する流れを学びます。", Url = "Chapters/03_PostBack.aspx" },
                    new { No = "04", Title = "ViewState", Description = "コントロールの状態が hidden フィールドにどう保持されるかを理解します。", Url = "Chapters/04_ViewState.aspx" },
                    new { No = "05", Title = "状態管理", Description = "Session・Application・Cache の使い分けを比較します。", Url = "Chapters/05_StateManagement.aspx" },
                    new { No = "06", Title = "入力検証", Description = "RequiredFieldValidator などによる入力チェックを試します。", Url = "Chapters/06_Validation.aspx" },
                    new { No = "07", Title = "データバインド", Description = "GridView へのデータバインドと、SQL Server 連携の基本を確認します。", Url = "Chapters/07_DataBinding.aspx" },
                    new { No = "08", Title = "IIS / SQL Server", Description = "IIS・アプリケーションプール・Web.config・SQL Server 接続の関係を整理します。", Url = "Chapters/08_IIS_SQLServer.aspx" }
                };
                ChapterRepeater.DataBind();
            }
        }
    }
}
