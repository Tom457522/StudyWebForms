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
                    new { No = "01", Title = "Lifecycle", Description = "Page_Init / Page_Load / イベント / Page_PreRender の順序をログで確認します。", Url = "Chapters/01_Lifecycle.aspx" },
                    new { No = "02", Title = "Server Controls", Description = "asp:Label や asp:TextBox が HTML としてどう出力されるか確認します。", Url = "Chapters/02_ServerControls.aspx" },
                    new { No = "03", Title = "PostBack", Description = "ボタン押下でサーバーに戻り、イベントが実行される流れを確認します。", Url = "Chapters/03_PostBack.aspx" },
                    new { No = "04", Title = "ViewState", Description = "サーバーコントロールの状態が hidden 項目で保持される仕組みを確認します。", Url = "Chapters/04_ViewState.aspx" },
                    new { No = "05", Title = "State Management", Description = "Session / Application / Cache の違いを比較します。", Url = "Chapters/05_StateManagement.aspx" },
                    new { No = "06", Title = "Validation", Description = "RequiredFieldValidator などの入力検証を確認します。", Url = "Chapters/06_Validation.aspx" },
                    new { No = "07", Title = "Data Binding", Description = "GridView とデータバインド、SQL Server 利用時の考え方を確認します。", Url = "Chapters/07_DataBinding.aspx" },
                    new { No = "08", Title = "IIS / SQL Server", Description = "IIS、Application Pool、Web.config、SQL Server 接続の関係を整理します。", Url = "Chapters/08_IIS_SQLServer.aspx" }
                };
                ChapterRepeater.DataBind();
            }
        }
    }
}
