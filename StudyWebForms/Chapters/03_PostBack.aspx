<%@ Page Title="03 PostBack" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="03_PostBack.aspx.cs" Inherits="StudyWebForms.Chapters._03_PostBack" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">03 PostBack</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>03. PostBack とイベント処理</h2>
        <p>Web Forms では、ボタン押下などで同じページへリクエストを送り返し、サーバー側イベントを実行します。</p>
        <asp:Button ID="CountButton" runat="server" Text="クリック回数を増やす" OnClick="CountButton_Click" />
        <asp:Button ID="ResetButton" runat="server" Text="リセット" OnClick="ResetButton_Click" />
        <div class="demo-box">
            <asp:Label ID="CountLabel" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li>初回表示は <span class="code-note">IsPostBack == false</span></li>
            <li>ボタン押下後は <span class="code-note">IsPostBack == true</span></li>
            <li>イベントハンドラはサーバー側で実行され、HTML が再生成される</li>
        </ul>
    </section>
</asp:Content>
