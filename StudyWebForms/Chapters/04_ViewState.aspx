<%@ Page Title="04 ViewState" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="04_ViewState.aspx.cs" Inherits="StudyWebForms.Chapters._04_ViewState" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">04 ViewState</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>04. ViewState</h2>
        <p>ViewState は、ページ内コントロールの状態を PostBack 後も保持する仕組みです。</p>
        <asp:TextBox ID="MemoTextBox" runat="server" TextMode="MultiLine" Rows="4" Columns="50" />
        <br />
        <asp:Button ID="SaveButton" runat="server" Text="ViewState に保存" OnClick="SaveButton_Click" />
        <asp:Button ID="ClearButton" runat="server" Text="ViewState をクリア" OnClick="ClearButton_Click" />
        <div class="demo-box">
            <asp:Label ID="ViewStateLabel" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li>ViewState はページ単位の状態保持</li>
            <li>実体は HTML の hidden 項目 <span class="code-note">__VIEWSTATE</span></li>
            <li>大きなデータを入れるとレスポンスサイズが増える</li>
        </ul>
    </section>
</asp:Content>
