<%@ Page Title="05 State Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="05_StateManagement.aspx.cs" Inherits="StudyWebForms.Chapters._05_StateManagement" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">05 State Management</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>05. 状態管理</h2>
        <p>Web Forms では、目的に応じて ViewState / Session / Application / Cache を使い分けます。</p>
        <asp:Button ID="AddSessionButton" runat="server" Text="Session カウント +1" OnClick="AddSessionButton_Click" />
        <asp:Button ID="AddCacheButton" runat="server" Text="Cache を設定" OnClick="AddCacheButton_Click" />
        <div class="demo-box">
            <asp:Label ID="StateLabel" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>使い分け</h3>
        <table>
            <tr><th>種類</th><th>単位</th><th>用途</th></tr>
            <tr><td>ViewState</td><td>ページ</td><td>同一ページ内のコントロール状態</td></tr>
            <tr><td>Session</td><td>ユーザー</td><td>ログインユーザーごとの情報</td></tr>
            <tr><td>Application</td><td>アプリ全体</td><td>全ユーザー共通の値</td></tr>
            <tr><td>Cache</td><td>アプリ全体</td><td>再利用したいデータの一時保存</td></tr>
        </table>
    </section>
</asp:Content>
