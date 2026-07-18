<%@ Page Title="05 状態管理" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="05_StateManagement.aspx.cs" Inherits="StudyWebForms.Chapters._05_StateManagement" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">05 状態管理</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>05. 状態管理</h2>
        <p>Web Forms では、状態をどこに置くかによって「誰と共有されるか」「いつまで残るか」が変わります。目的に応じて ViewState / Session / Application / Cache を使い分けます。</p>
        <div class="demo-box">
            <strong>✔ 体験的な学習フロー:</strong>
            <ol>
                <li><strong>「Session カウント +1」を何度か押す</strong> → このブラウザ内でだけカウンタが増える</li>
                <li><strong>別のブラウザ(またはプライベートウィンドウ)でこのページを開く</strong> → Session の値が別々にカウントされていることに気づく!</li>
                <li><strong>「Cache に保存」を押す</strong> → Cache の値が記録される</li>
                <li><strong>Application[TotalRequests] に注目</strong> → ページを何度も開くたびに(全ユーザー合算で)増える</li>
                <li><strong>複数のタブ・複数のブラウザで動作の違いを確認</strong> → Session と Application の違いが体感できる</li>
            </ol>
        </div>
        <asp:Button ID="AddSessionButton" runat="server" Text="Session カウント +1" OnClick="AddSessionButton_Click" CssClass="button" />
        <asp:Button ID="AddCacheButton" runat="server" Text="Cache に保存" OnClick="AddCacheButton_Click" CssClass="button" />
        <div class="demo-box" style="margin-top: 20px;">
            <asp:Label ID="StateLabel" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>「Session カウント +1」を押した後</td>
                <td><span class="code-note">Session[Counter]</span> の値</td>
                <td>自分のブラウザ(セッション)でだけ値が増えていくこと。<span class="code-note">05_StateManagement.aspx.cs</span> の <span class="code-note">AddSessionButton_Click</span> が対応する</td>
            </tr>
            <tr>
                <td>別のブラウザで同じページを開いたとき</td>
                <td>その画面の <span class="code-note">Session[Counter]</span></td>
                <td>Session はユーザー(ブラウザ)ごとに別々に管理されており、他の人の操作とは独立していること</td>
            </tr>
            <tr>
                <td>ページを開くたび(誰が開いても)</td>
                <td><span class="code-note">Application[TotalRequests]</span></td>
                <td><span class="code-note">Global.asax.cs</span> の <span class="code-note">Application_BeginRequest</span> がリクエストのたびに実行され、全ユーザー共通で値が増えること</td>
            </tr>
            <tr>
                <td>アプリケーションを起動した直後</td>
                <td><span class="code-note">Application[StartedAt]</span></td>
                <td><span class="code-note">Global.asax.cs</span> の <span class="code-note">Application_Start</span> がアプリ起動時に一度だけ実行され、以降固定値のままであること</td>
            </tr>
            <tr>
                <td>「Cache に保存」を押した後</td>
                <td><span class="code-note">Cache[CachedMessage]</span></td>
                <td>Cache に保存した値は、保存した本人以外(別のユーザー)がアクセスしても同じ値が見えること(アプリ全体で共有される)</td>
            </tr>
            <tr>
                <td>5分以上待ってから再読み込みしたとき</td>
                <td><span class="code-note">Cache[CachedMessage]</span> の表示(「未設定」に戻るか)</td>
                <td>Cache には有効期限(このサンプルでは5分)を設定でき、期限切れになると自動的に消えること</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>使い分け</h3>
        <table>
            <tr><th>種類</th><th>単位</th><th>用途</th></tr>
            <tr><td>ViewState</td><td>ページ</td><td>同一ページ内のコントロール状態</td></tr>
            <tr><td>Session</td><td>ユーザー</td><td>ログインユーザーごとの情報</td></tr>
            <tr><td>Application</td><td>アプリ全体</td><td>全ユーザー共通の値</td></tr>
            <tr><td>Cache</td><td>アプリ全体</td><td>再利用したいデータの一時保存(有効期限あり)</td></tr>
        </table>
    </section>
</asp:Content>
