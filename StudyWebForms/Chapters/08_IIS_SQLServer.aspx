<%@ Page Title="08 IIS SQL Server" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="08_IIS_SQLServer.aspx.cs" Inherits="StudyWebForms.Chapters._08_IIS_SQLServer" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">08 IIS / SQL Server</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>08. IIS / Application Pool / SQL Server</h2>
        <p>Web Forms アプリは IIS 上で動作し、Application Pool のプロセス内で ASP.NET がページを処理します。</p>
        <asp:Button ID="ShowInfoButton" runat="server" Text="環境情報を表示" OnClick="ShowInfoButton_Click" />
        <div class="demo-box">
            <asp:Literal ID="InfoLiteral" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>構成イメージ</h3>
        <pre>Client Browser
  ↓ HTTP Request
IIS Site
  ↓ Application Pool / w3wp.exe
ASP.NET Web Forms Page
  ↓ connectionStrings
SQL Server</pre>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li>IIS Site は URL と物理フォルダを対応付ける</li>
            <li>Application Pool は実行プロセス、.NET CLR、ID、リサイクル設定に関係する</li>
            <li><span class="code-note">Web.config</span> はアプリ単位の設定ファイル</li>
            <li>SQL Server 接続文字列は <span class="code-note">connectionStrings</span> に置くことが多い</li>
            <li>本番では接続文字列、権限、ログ、エラー表示を分離して考える</li>
        </ul>
    </section>
</asp:Content>
