<%@ Page Title="07 データバインド" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="07_DataBinding.aspx.cs" Inherits="StudyWebForms.Chapters._07_DataBinding" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">07 データバインド</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>07. GridView とデータバインド</h2>
        <p>GridView に List や DataTable をバインドすると、一覧画面を簡単に作成できます。列の定義(マークアップ)とデータの中身(コードビハインド)が分離されているのがポイントです。</p>
        <div class="demo-box">
            <strong>✔ 体験的な学習フロー:</strong>
            <ol>
                <li><strong>ページを開く</strong> → GridView に複数件の講座データが自動表示される</li>
                <li><strong>キーワード欄に「Web」と入力</strong>して「検索」を押す → 該当する講座だけが表示される</li>
                <li><strong>キーワード欄を空にして「検索」</strong> → 全件に戻る</li>
                <li><strong>気づき: Repository パターン!</strong> コード側と画面側が独立して、保守性が高い</li>
                <li><strong>コードを確認</strong> → C#側で List<Course> を用意して、GridView.DataBind() で自動的にテーブルレンダリング</li>
            </ol>
        </div>
        <asp:TextBox ID="KeywordTextBox" runat="server" Placeholder="検索キーワード (例: Web, SQL)" />
        <asp:Button ID="SearchButton" runat="server" Text="検索" OnClick="SearchButton_Click" CssClass="button" />
        <div class="demo-box" style="margin-top: 12px;">
            <asp:Label ID="SearchResultLabel" runat="server" />
        </div>
        <asp:GridView ID="CourseGridView" runat="server" AutoGenerateColumns="False" CssClass="simple">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" ItemStyle-Width="40px" />
                <asp:BoundField DataField="Title" HeaderText="タイトル" ItemStyle-Width="40%" />
                <asp:BoundField DataField="Category" HeaderText="カテゴリ" />
                <asp:BoundField DataField="DurationMinutes" HeaderText="所要時間(分)" ItemStyle-HorizontalAlign="Right" />
            </Columns>
        </asp:GridView>
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>ページを開いた直後(初回表示)</td>
                <td>GridView の行数</td>
                <td><span class="code-note">07_DataBinding.aspx.cs</span> の <span class="code-note">Page_Load</span> が <span class="code-note">!IsPostBack</span> のときだけ <span class="code-note">BindGrid()</span> を呼んでいること</td>
            </tr>
            <tr>
                <td>「検索」を押した後</td>
                <td>絞り込まれた行数</td>
                <td><span class="code-note">SearchButton_Click</span> が <span class="code-note">CourseRepository.Search</span> にキーワードを渡し、その結果を再度 <span class="code-note">DataBind()</span> していること</td>
            </tr>
            <tr>
                <td>マークアップの列定義を見たとき</td>
                <td><span class="code-note">&lt;asp:BoundField DataField="Title" HeaderText="タイトル" /&gt;</span></td>
                <td><span class="code-note">DataField</span> が C# 側の <span class="code-note">Course</span> クラスのプロパティ名と対応していること(<span class="code-note">App_Code/Course.cs</span> を参照)</td>
            </tr>
            <tr>
                <td>データの中身を確認したいとき</td>
                <td><span class="code-note">App_Code/CourseRepository.cs</span></td>
                <td>今は固定のリストを返しているが、実際の案件では同じ場所で SQL Server から取得したデータを返すように差し替えるだけで済むこと</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>SQL Server とつなぐ場合</h3>
        <p>このサンプルは説明しやすさのために <span class="code-note">CourseRepository</span> の固定データを使っています。</p>
        <p>実DBに変更する場合は、<span class="code-note">Web.config</span> の <span class="code-note">connectionStrings</span> から SQL Server に接続し、<span class="code-note">CourseRepository</span> 内で SELECT 文を実行して結果を <span class="code-note">List&lt;Course&gt;</span> に詰め替えます。画面(GridView)側のコードは変更しなくて済むのが、この構成(Repository で画面とデータ取得を分離する設計)の利点です。</p>
    </section>
</asp:Content>
