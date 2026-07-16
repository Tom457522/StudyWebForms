<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="StudyWebForms._Default" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">Home</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>ASP.NET Web Forms 講義用アプリ</h2>
        <p>このアプリは、章ごとに Web Forms の重要な仕組みを実際に動かしながら確認できる教材です。</p>
        <div class="demo-box">
            <strong>各章の学び方:</strong>
            <ol>
                <li>まず画面を操作して、ボタンを押すと何が起きるかを確認する</li>
                <li>次に <span class="code-note">.aspx</span> のマークアップを見て、画面のどの部分がどのコントロールに対応するかを確認する</li>
                <li>続いて <span class="code-note">.aspx.cs</span> のコードビハインドを見て、どのイベントでどのメソッドが動いているかを確認する</li>
                <li>各章の「観察ポイント」の表で、<strong>いつ・どこを見ると・何が分かるか</strong> を整理して理解を固める</li>
                <li>最後に IIS / SQL Server など、実際の運用環境との関連を補足する(特に 08 章)</li>
            </ol>
        </div>
        <p>画面上部のナビゲーションから、いつでも好きな章に移動できます。番号順に進めると無理なく理解できるように構成しています。</p>
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
