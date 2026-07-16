<%@ Page Title="01 ページライフサイクル" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="01_Lifecycle.aspx.cs" Inherits="StudyWebForms.Chapters._01_Lifecycle" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">01 ページライフサイクル</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>01. ページライフサイクル</h2>
        <p>Web Forms は、1回のリクエストごとに Page オブジェクトを新しく作り直し、決まった順番でイベントを実行します。この仕組みを理解しないと、「なぜ毎回同じ処理が動くのか」「なぜ入力値が消えないのか」が分かりにくくなります。</p>
        <div class="demo-box">
            <strong>操作手順:</strong>
            <ol>
                <li>まずページを開いた直後の「実行ログ」を確認する(初回表示時のイベント順序)</li>
                <li>「PostBack を発生させる」ボタンを押して、ログがどう増えるかを確認する</li>
                <li>もう一度ボタンを押して、ログの増え方に規則性があるかを確認する</li>
            </ol>
        </div>
        <asp:Button ID="ReloadButton" runat="server" Text="PostBack を発生させる" CssClass="button" OnClick="ReloadButton_Click" />
    </section>

    <section class="card">
        <h3>実行ログ</h3>
        <asp:BulletedList ID="LifecycleLog" runat="server" />
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>ページを開いた直後(初回表示)</td>
                <td>実行ログの並び</td>
                <td><span class="code-note">Page_Init</span> → <span class="code-note">Page_Load</span> → <span class="code-note">Page_PreRender</span> の順で実行され、クリックイベントはまだ発生しないこと</td>
            </tr>
            <tr>
                <td>「PostBack を発生させる」を押した直後</td>
                <td>ログに追加された行</td>
                <td><span class="code-note">Page_Init</span> → <span class="code-note">Page_Load</span> → <span class="code-note">ReloadButton_Click</span> → <span class="code-note">Page_PreRender</span> の順で、イベント処理が <span class="code-note">Page_Load</span> の後に実行されること</td>
            </tr>
            <tr>
                <td>ボタンを複数回押したとき</td>
                <td>ログが消えずに積み上がっていくか</td>
                <td>ログを <span class="code-note">ViewState</span> に保存しているため、PostBack のたびに Page インスタンスが作り直されても履歴が残ること</td>
            </tr>
            <tr>
                <td>コードを確認するとき</td>
                <td><span class="code-note">01_Lifecycle.aspx.cs</span> のメソッド名</td>
                <td>メソッド名(<span class="code-note">Page_Init</span> など)がそのままライフサイクルのイベント名に対応していること</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li><span class="code-note">Page_Init</span> はコントロールの初期化段階。コントロールの ID や階層は決まるが、ViewState はまだ復元されていない</li>
            <li><span class="code-note">Page_Load</span> は ViewState 復元後に呼ばれ、画面表示や初期データ設定でよく使う</li>
            <li>ボタンなどのイベント処理は <span class="code-note">Page_Load</span> の後、<span class="code-note">Page_PreRender</span> の前に実行される</li>
            <li><span class="code-note">Page_PreRender</span> は HTML を生成する直前の最終調整に使う(この後は変更してもレンダリング内容に反映しにくい項目もある)</li>
            <li>PostBack のたびに Page クラスのインスタンスは毎回新規作成される。状態を保持したい場合は ViewState / Session など明示的な仕組みが必要</li>
        </ul>
    </section>
</asp:Content>
