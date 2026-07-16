<%@ Page Title="02 サーバーコントロール" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="02_ServerControls.aspx.cs" Inherits="StudyWebForms.Chapters._02_ServerControls" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">02 サーバーコントロール</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>02. サーバーコントロール</h2>
        <p><span class="code-note">asp:TextBox</span> や <span class="code-note">asp:Label</span> のようなサーバーコントロールは、サーバー側の C# コードから操作でき、最終的には普通の HTML タグに変換されて画面に表示されます。</p>
        <div class="demo-box">
            <strong>操作手順:</strong>
            <ol>
                <li>テキストボックスに好きな文字を入力する</li>
                <li>「ラベルに反映」ボタンを押す</li>
                <li>下の結果ラベルにサーバー側で組み立てたメッセージが表示されることを確認する</li>
                <li>ブラウザの「ページのソースを表示」または開発者ツールで、<span class="code-note">asp:Label</span> や <span class="code-note">asp:TextBox</span> が最終的にどんな HTML タグ(<span class="code-note">&lt;span&gt;</span> や <span class="code-note">&lt;input&gt;</span>)になっているかを確認する</li>
            </ol>
        </div>
        <asp:Label ID="NameLabel" runat="server" AssociatedControlID="NameTextBox" Text="名前" />
        <asp:TextBox ID="NameTextBox" runat="server" />
        <asp:Button ID="ReflectButton" runat="server" Text="ラベルに反映" OnClick="ReflectButton_Click" />
        <div class="demo-box">
            <asp:Label ID="ResultLabel" runat="server" Text="ここに結果が表示されます" />
        </div>
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>ページを開いた直後</td>
                <td><span class="code-note">02_ServerControls.aspx</span> のマークアップ</td>
                <td><span class="code-note">runat="server"</span> が付いた要素だけがサーバー側のコード(<span class="code-note">NameTextBox</span> など)から参照できること</td>
            </tr>
            <tr>
                <td>「ラベルに反映」を押した後</td>
                <td>結果ラベルの文言</td>
                <td><span class="code-note">02_ServerControls.aspx.cs</span> の <span class="code-note">ReflectButton_Click</span> が、TextBox の値を読み取って Label に書き込んでいること</td>
            </tr>
            <tr>
                <td>ブラウザの「ページのソースを表示」を見たとき</td>
                <td>出力された HTML タグ</td>
                <td><span class="code-note">asp:Label</span> は <span class="code-note">&lt;span&gt;</span>、<span class="code-note">asp:TextBox</span> は <span class="code-note">&lt;input type="text"&gt;</span> に変換されており、サーバーコントロールの実体は最終的に素の HTML であること</td>
            </tr>
            <tr>
                <td>HTML タグの id 属性を見たとき</td>
                <td><span class="code-note">id="NameTextBox"</span> などの値</td>
                <td>Web Forms の ID がそのまま(あるいは命名規則に沿って)HTML の id / name に反映されていること</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li><span class="code-note">runat="server"</span> が付いた要素は、コードビハインドから同じ ID のプロパティとして参照できる。</li>
            <li>サーバーコントロールは、レスポンスを返す前にプレーンな HTML に変換される。</li>
            <li>ブラウザの開発者ツールで実際のレンダリング結果を確認すると理解が深まる。</li>
            <li><span class="code-note">Server.HtmlEncode</span> を使うと、入力値をそのまま HTML に埋め込んでも安全に表示できる(XSS 対策の基本)。</li>
        </ul>
    </section>
</asp:Content>
