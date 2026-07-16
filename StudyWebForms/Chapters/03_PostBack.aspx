<%@ Page Title="03 ポストバック" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="03_PostBack.aspx.cs" Inherits="StudyWebForms.Chapters._03_PostBack" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">03 ポストバック</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>03. PostBack とイベント処理</h2>
        <p>Web Forms では、ボタン押下などの操作が「同じページへの再送信(PostBack)」として扱われ、サーバー側でイベント処理が実行されます。ブラウザは別ページに遷移せず、同じ画面がサーバーで作り直されて返ってきます。</p>
        <div class="demo-box">
            <strong>操作手順:</strong>
            <ol>
                <li>「カウントを増やす」ボタンを数回押して、数値が増えていくことを確認する</li>
                <li>ブラウザの URL が変わらないことを確認する(ページ遷移していない)</li>
                <li>「リセット」ボタンを押して、カウントが 0 に戻ることを確認する</li>
            </ol>
        </div>
        <asp:Button ID="CountButton" runat="server" Text="カウントを増やす" OnClick="CountButton_Click" />
        <asp:Button ID="ResetButton" runat="server" Text="リセット" OnClick="ResetButton_Click" />
        <div class="demo-box">
            <asp:Label ID="CountLabel" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>ページを開いた直後(初回表示)</td>
                <td>ラベルの <span class="code-note">IsPostBack</span> の値</td>
                <td><span class="code-note">IsPostBack == False</span> であり、<span class="code-note">03_PostBack.aspx.cs</span> の <span class="code-note">Page_Load</span> で <span class="code-note">Count</span> が 0 に初期化されていること</td>
            </tr>
            <tr>
                <td>「カウントを増やす」を押した後</td>
                <td>ラベルの <span class="code-note">IsPostBack</span> と <span class="code-note">Count</span> の値</td>
                <td><span class="code-note">IsPostBack == True</span> になり、<span class="code-note">CountButton_Click</span> が呼ばれて <span class="code-note">Count</span> が加算されていること</td>
            </tr>
            <tr>
                <td>ボタンを押している間</td>
                <td>ブラウザのアドレスバー</td>
                <td>URL が変化していない(別のページに移動したのではなく、同じ URL にフォームが再送信されている)こと</td>
            </tr>
            <tr>
                <td>コードを確認するとき</td>
                <td><span class="code-note">CountButton</span> の <span class="code-note">OnClick="CountButton_Click"</span></td>
                <td>マークアップのイベント属性と、コードビハインドのメソッドがどう対応付けられているか</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li>初回表示は <span class="code-note">IsPostBack == false</span></li>
            <li>ボタン押下後は <span class="code-note">IsPostBack == true</span></li>
            <li>イベントハンドラはサーバー側で実行され、その結果を反映した HTML が毎回再生成される</li>
            <li>PostBack は「フォーム全体をサーバーに送り返す」仕組みのため、ページ内のどのボタンを押しても一度ページ全体がサーバーへ送信される</li>
        </ul>
    </section>
</asp:Content>
