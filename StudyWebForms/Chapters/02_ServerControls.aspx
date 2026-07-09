<%@ Page Title="02 Server Controls" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="02_ServerControls.aspx.cs" Inherits="StudyWebForms.Chapters._02_ServerControls" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">02 Server Controls</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>02. サーバーコントロール</h2>
        <p><span class="code-note">asp:TextBox</span> や <span class="code-note">asp:Label</span> は、サーバー側で操作でき、最終的に HTML としてブラウザへ返されます。</p>
        <asp:Label ID="NameLabel" runat="server" AssociatedControlID="NameTextBox" Text="名前" />
        <asp:TextBox ID="NameTextBox" runat="server" />
        <asp:Button ID="ReflectButton" runat="server" Text="Label に反映" OnClick="ReflectButton_Click" />
        <div class="demo-box">
            <asp:Label ID="ResultLabel" runat="server" Text="ここに結果が表示されます" />
        </div>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li><span class="code-note">runat="server"</span> がある要素はサーバー側から操作できる</li>
            <li>サーバーコントロールは最終的には HTML に変換される</li>
            <li>ブラウザの開発者ツールで出力 HTML を見ると理解しやすい</li>
        </ul>
    </section>
</asp:Content>
