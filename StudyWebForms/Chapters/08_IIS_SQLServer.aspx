<%@ Page Title="08 IIS / SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="08_IIS_SQLServer.aspx.cs" Inherits="StudyWebForms.Chapters._08_IIS_SQLServer" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">08 IIS / SQL Server</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>08. IIS / アプリケーションプール / SQL Server</h2>
        <p>Web Forms アプリは IIS 上で動作し、アプリケーションプールのプロセス(<span class="code-note">w3wp.exe</span>)内で ASP.NET がページを処理します。ここまでの章で見た ViewState / Session / SQL Server 接続などは、すべてこの構成の上で動いています。</p>
        <div class="demo-box">
            <strong>✔ 体験的な学習フロー:</strong>
            <ol>
                <li><strong>「環境情報を表示」ボタンを押す</strong> → 現在のプロセス・マシン・接続文字列が表示される</li>
                <li><strong>MachineName を確認</strong> → サーバーの名前(複数サーバー環境でどのマシンか判定できる)</li>
                <li><strong>AppDomain を確認</strong> → このアプリケーションの論理的な境界</li>
                <li><strong>IIS Manager を開く</strong> → このサイトのアプリケーションプール設定を見比べる</li>
                <li><strong>接続文字列を確認</strong> → Web.config から読み込まれたデータベース接続情報</li>
                <li><strong>気づき: 8章の内容は 1〜7章の基盤!</strong> Session/ViewState はすべてこのプロセス内に保存される</li>
            </ol>
        </div>
        <asp:Button ID="ShowInfoButton" runat="server" Text="環境情報を表示" OnClick="ShowInfoButton_Click" CssClass="button" />
        <div class="demo-box" style="margin-top: 20px;">
            <asp:Literal ID="InfoLiteral" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>構成イメージ</h3>
        <pre>クライアント (ブラウザ)
  ↓ HTTP リクエスト
IIS サイト
  ↓ アプリケーションプール / w3wp.exe
ASP.NET Web Forms ページ
  ↓ connectionStrings
SQL Server</pre>
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>「環境情報を表示」を押した後</td>
                <td><span class="code-note">MachineName</span> の表示</td>
                <td>このアプリが実際にどのマシン上のプロセスで実行されているか(本番では IIS サーバーの名前になる)</td>
            </tr>
            <tr>
                <td>同上</td>
                <td><span class="code-note">Application Path</span> の表示</td>
                <td><span class="code-note">HttpRuntime.AppDomainAppPath</span> から、IIS 上の物理フォルダのパスが分かること(IIS Manager の「物理パス」と一致する)</td>
            </tr>
            <tr>
                <td>同上</td>
                <td><span class="code-note">AppDomain</span> の表示</td>
                <td>ASP.NET は 1 つの w3wp.exe プロセス内に、サイトごとの AppDomain を分けて動作させていること</td>
            </tr>
            <tr>
                <td>同上</td>
                <td><span class="code-note">StudyDb ConnectionString</span> の表示</td>
                <td><span class="code-note">Web.config</span> の <span class="code-note">connectionStrings</span> セクションの値が、コードから <span class="code-note">ConfigurationManager</span> 経由で読み取れること</td>
            </tr>
            <tr>
                <td>IIS Manager を開いたとき</td>
                <td>サイトの「基本設定」と「アプリケーションプール」</td>
                <td>URL(バインディング)と物理フォルダの対応、実行に使われる .NET CLR バージョンや実行アカウント</td>
            </tr>
            <tr>
                <td><span class="code-note">Web.config</span> を開いたとき</td>
                <td><span class="code-note">&lt;compilation targetFramework&gt;</span> や <span class="code-note">&lt;connectionStrings&gt;</span></td>
                <td>アプリ単位の設定(対象フレームワークや DB 接続文字列)がこのファイルにまとまっていること</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li>IIS サイトは URL と物理フォルダを対応付ける</li>
            <li>アプリケーションプールは実行プロセス、.NET CLR バージョン、実行アカウント、リサイクル設定に関係する</li>
            <li><span class="code-note">Web.config</span> はアプリ単位の設定ファイル</li>
            <li>SQL Server 接続文字列は <span class="code-note">connectionStrings</span> に置くことが多い</li>
            <li>本番環境では、接続文字列・実行権限・ログ・エラー表示の扱いを開発環境と分けて設計する</li>
            <li>1つのアプリケーションプールで問題が起きても、別のプールで動くサイトには影響しない(プロセス分離)</li>
        </ul>
    </section>
</asp:Content>
