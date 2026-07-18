using System;
using System.Collections.Generic;

namespace StudyWebForms
{
    /// <summary>
    /// Default.aspx (ホームページ)
    /// 
    /// このページの目的:
    /// - 8章すべてへのナビゲーション
    /// - 各章の学習ポイントを簡潔に説明
    /// - 推奨される学習順序を提示
    /// </summary>
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 【初回表示時のみデータをバインド】
            if (!IsPostBack)
            {
                // 8章のナビゲーションデータを構築
                ChapterRepeater.DataSource = new List<object>
                {
                    new
                    {
                        No = "01",
                        Title = "ページライフサイクル",
                        Description = "【基礎】 Page_Init → Page_Load → クリックイベント → Page_PreRender の実行順序を、実行ログで確認します。Page インスタンスが毎回作り直されることを理解します。",
                        Url = "Chapters/01_Lifecycle.aspx"
                    },
                    new
                    {
                        No = "02",
                        Title = "サーバーコントロール",
                        Description = "【基礎】 asp:Label や asp:TextBox などのコントロールが、最終的にどんな plain HTML (<span>, <input>など)として出力されるかを確認します。",
                        Url = "Chapters/02_ServerControls.aspx"
                    },
                    new
                    {
                        No = "03",
                        Title = "PostBack とイベント",
                        Description = "【基礎】 ボタンクリックが同じページへの再送信(PostBack)として扱われ、サーバー側でイベントが発生する流れを学びます。",
                        Url = "Chapters/03_PostBack.aspx"
                    },
                    new
                    {
                        No = "04",
                        Title = "ViewState",
                        Description = "【状態保持】 Page インスタンスが作り直されても、状態が保持される仕組み。隠しフィールド(__VIEWSTATE)にどのように保存されるかを理解します。",
                        Url = "Chapters/04_ViewState.aspx"
                    },
                    new
                    {
                        No = "05",
                        Title = "状態管理",
                        Description = "【状態保持】 ViewState・Session・Application・Cache の使い分け。共有範囲(ユーザー単位 vs アプリ全体)と有効期限を比較します。",
                        Url = "Chapters/05_StateManagement.aspx"
                    },
                    new
                    {
                        No = "06",
                        Title = "入力検証",
                        Description = "【セキュリティ】 RequiredFieldValidator などによる2段階検証(クライアント側 + サーバー側)の重要性を学びます。XSS 対策も含みます。",
                        Url = "Chapters/06_Validation.aspx"
                    },
                    new
                    {
                        No = "07",
                        Title = "データバインド",
                        Description = "【実践】 GridView へのデータバインドと、Repository パターンによるデータベースアクセスの分離。SQL Server 連携の基本を確認します。",
                        Url = "Chapters/07_DataBinding.aspx"
                    },
                    new
                    {
                        No = "08",
                        Title = "IIS / SQL Server",
                        Description = "【インフラ】 IIS・アプリケーションプール・AppDomain・接続文字列など、Web Forms が動作する基盤を整理します。1〜7章はすべてこの上で動作します。",
                        Url = "Chapters/08_IIS_SQLServer.aspx"
                    }
                };
                ChapterRepeater.DataBind();
            }
        }
    }
}
