<%@ Page Title="07 Data Binding" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="07_DataBinding.aspx.cs" Inherits="StudyWebForms.Chapters._07_DataBinding" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">07 Data Binding</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>07. GridView とデータバインド</h2>
        <p>GridView に List や DataTable をバインドすると、一覧画面を簡単に作成できます。</p>
        <asp:TextBox ID="KeywordTextBox" runat="server" />
        <asp:Button ID="SearchButton" runat="server" Text="検索" OnClick="SearchButton_Click" />
        <asp:GridView ID="CourseGridView" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Id" HeaderText="ID" />
                <asp:BoundField DataField="Title" HeaderText="講座名" />
                <asp:BoundField DataField="Category" HeaderText="分類" />
                <asp:BoundField DataField="DurationMinutes" HeaderText="時間（分）" />
            </Columns>
        </asp:GridView>
    </section>

    <section class="card">
        <h3>SQL Server とつなぐ場合</h3>
        <p>このサンプルは説明しやすさのために <span class="code-note">CourseRepository</span> の固定データを使っています。</p>
        <p>実DBに変更する場合は、<span class="code-note">Web.config</span> の connectionStrings から SQL Server に接続し、Repository 内で SELECT を実行します。</p>
    </section>
</asp:Content>
