<%@ Page Title="04 ビューステート" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="04_ViewState.aspx.cs" Inherits="StudyWebForms.Chapters._04_ViewState" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">04 ビューステート</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>04. ViewState</h2>
        <p>ViewState は、ページ内コントロールの状態を PostBack 後も保持する仕組みです。Page オブジェクトは PostBack のたびに作り直されますが、ViewState に保存した値は次のリクエストでも復元されます。</p>
        <div class="demo-box">
            <strong>✔ 体験的な学習フロー:</strong>
            <ol>
                <li><strong>メモ欄に文字を入力</strong>して、「ViewState に保存」ボタンを押す</li>
                <li><strong>ラベルに保存内容が表示</strong>されることを確認する(ViewState["Memo"] の値が見える)</li>
                <li><strong>ページをリロード(F5 キー)</strong>したり、別の操作をしてから戻ってくる → メモが消えずに残っているはず!</li>
                <li><strong>ブラウザの「ページのソースを表示」</strong>を開いて、<code>&lt;input type="hidden" name="__VIEWSTATE" ...&gt;</code> を探す
                    <ul><li>ViewState は長い文字列になっている(Base64 エンコード・暗号化)</li>
                        <li>入力文字列を増やすと、この文字列が長くなる(レスポンスサイズが増える)</li></ul>
                </li>
                <li><strong>「ViewState をクリア」ボタン</strong>を押すと、保存内容が消えることを確認する</li>
            </ol>
        </div>
        <asp:TextBox ID="MemoTextBox" runat="server" TextMode="MultiLine" Rows="4" Columns="50" Placeholder="ここに文字を入力してから「保存」ボタンを押してください" />
        <br />
        <asp:Button ID="SaveButton" runat="server" Text="ViewState に保存" OnClick="SaveButton_Click" CssClass="button" />
        <asp:Button ID="ClearButton" runat="server" Text="ViewState をクリア" OnClick="ClearButton_Click" CssClass="button" />
        <div class="demo-box" style="margin-top: 20px;">
            <asp:Label ID="ViewStateLabel" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>「ViewState に保存」を押した後</td>
                <td>ラベルの表示内容</td>
                <td><span class="code-note">04_ViewState.aspx.cs</span> の <span class="code-note">SaveButton_Click</span> が、TextBox の値を <span class="code-note">ViewState["Memo"]</span> に書き込んでいること</td>
            </tr>
            <tr>
                <td>保存後にページの他の操作をしたとき</td>
                <td>メモ欄の内容が消えないか</td>
                <td>PostBack のたびに Page が作り直されても、ViewState に入れた値は保持され続けること</td>
            </tr>
            <tr>
                <td>ブラウザの「ページのソースを表示」を見たとき</td>
                <td><span class="code-note">&lt;input type="hidden" name="__VIEWSTATE" ...&gt;</span></td>
                <td>ViewState の実体は暗号化・エンコードされた文字列としてクライアントの hidden フィールドに保存されていること(サーバー側のメモリに残っているわけではない)</td>
            </tr>
            <tr>
                <td>保存する文字列を長くしたとき</td>
                <td><span class="code-note">__VIEWSTATE</span> の文字数と、ページの応答サイズ</td>
                <td>ViewState に入れるデータが大きくなるほど、HTML のレスポンスサイズも大きくなること(多用しすぎると通信量が増える理由)</td>
            </tr>
            <tr>
                <td>「ViewState をクリア」を押した後</td>
                <td>ラベルの表示内容</td>
                <td><span class="code-note">ClearButton_Click</span> が <span class="code-note">ViewState.Remove("Memo")</span> を呼んでおり、キーそのものを削除していること</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li>ViewState はページ単位の状態保持であり、他のページやユーザー間では共有されない</li>
            <li>実体は HTML の hidden 項目 <span class="code-note">__VIEWSTATE</span> で、クライアント側に保存されている</li>
            <li>大きなデータを入れるとレスポンスサイズが増え、表示や通信が遅くなる原因になる</li>
            <li>パスワードや機密情報など、クライアントに見られたくないデータは ViewState ではなく Session などサーバー側の仕組みで管理する</li>
        </ul>
    </section>
</asp:Content>
