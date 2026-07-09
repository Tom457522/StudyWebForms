<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="StudyWebForms._Default" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">Home</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>ASP.NET Web Forms 講義用アプリ</h2>
        <p>このアプリは、チャプターごとに Web Forms の重要な仕組みを確認できるようにした教材です。</p>
        <div class="demo-box">
            <strong>講義の見方:</strong> 画面操作 → aspx マークアップ → code-behind → IIS / SQL Server との関連、の順で説明します。
        </div>
    </section>

    <section class="grid">
        <asp:Repeater ID="ChapterRepeater" runat="server">
            <ItemTemplate>
                <article class="card">
                    <h3><%# Eval("No") %> <%# Eval("Title") %></h3>
                    <p><%# Eval("Description") %></p>
                    <a href="<%# Eval("Url") %>">この章を開く</a>
                </article>
            </ItemTemplate>
        </asp:Repeater>
    </section>
</asp:Content>
