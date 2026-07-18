using System;

namespace StudyWebForms.Chapters
{
    /// <summary>
    /// 第7章: データバインド
    /// 
    /// このページの目的:
    /// データベースのレコードを取得し、GridView にバインドして表示する
    /// 全体的なフロー:
    /// List<データ> → GridView.DataSource = データ → GridView.DataBind() → HTML テーブルレンダリング
    /// 
    /// 学習ポイント:
    /// ・DataSource に List などのコレクションを設定
    /// ・DataBind() を呼んで初めてレンダリングが実行される
    /// ・if(!IsPostBack) で初回表示時のみバインド処理を実行(PostBack では TextBox 値が復元されて再バインドできる)
    /// ・Repository パターン:データベースアクセスロジックを独立させて、画面から切り離す
    /// ・GridView は複数件のデータを効率的にテーブルで表示
    /// </summary>
    public partial class _07_DataBinding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 【初回表示時のみデータをバインド】
            // PostBack では TextBox の値が ViewState から復元されているため、
            // 明示的に BindGrid() を呼ぶまでグリッドは再バインドされない
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void SearchButton_Click(object sender, EventArgs e)
        {
            // 【検索ボタンクリック】
            // TextBox の入力値(SearchButton_Click 時点で既に復元されている)を使用して、
            // Repository でデータベース検索を実行し、GridView に再バインド
            BindGrid();
        }

        private void BindGrid()
        {
            // 【DataBinding 実行】
            // 1. Repository.Search() でデータベースから List<Course> を取得
            // 2. GridView.DataSource にセット
            // 3. GridView.DataBind() で、リストのデータを HTML テーブル行に変換してレンダリング

            var keyword = KeywordTextBox.Text;
            var searchResults = CourseRepository.Search(keyword);

            CourseGridView.DataSource = searchResults;
            CourseGridView.DataBind();

            // UI フィードバック
            if (searchResults != null && searchResults.Count > 0)
            {
                SearchResultLabel.Text = string.Format("✓ {0} 件の結果が見つかりました", searchResults.Count);
            }
            else
            {
                SearchResultLabel.Text = "検索キーワードに該当するコースはありません。別のキーワードで検索してみてください。";
            }
        }
    }
}
