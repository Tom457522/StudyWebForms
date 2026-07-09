<%@ Page Title="01 Lifecycle" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="01_Lifecycle.aspx.cs" Inherits="StudyWebForms.Chapters._01_Lifecycle" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">01 Lifecycle</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>01. ページライフサイクル</h2>
        <p>Web Forms は、1回のリクエストごとに Page オブジェクトを作成し、決まった順番でイベントを実行します。</p>
        <asp:Button ID="ReloadButton" runat="server" Text="PostBack を発生させる" CssClass="button" OnClick="ReloadButton_Click" />
    </section>

    <section class="card">
        <h3>実行ログ</h3>
        <asp:BulletedList ID="LifecycleLog" runat="server" />
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li><span class="code-note">Page_Init</span> はコントロール初期化の段階</li>
            <li><span class="code-note">Page_Load</span> は画面表示や初期データ設定でよく使う</li>
            <li>ボタンなどのイベントは <span class="code-note">Page_Load</span> の後に実行される</li>
            <li><span class="code-note">Page_PreRender</span> は表示直前の最終調整に使う</li>
        </ul>
    </section>
</asp:Content>
