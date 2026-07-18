<%@ Page Title="02 サーバーコントロール" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="02_ServerControls.aspx.cs" Inherits="StudyWebForms.Chapters._02_ServerControls" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">02 サーバーコントロール</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>02. サーバーコントロール</h2>
        <p><span class="code-note">asp:TextBox</span> や <span class="code-note">asp:Label</span> のようなサーバーコントロールは、サーバー側の C# コードから操作でき、最終的には普通の HTML タグに変換されて画面に表示されます。</p>
        <div class="demo-box">
            <strong>✔ 体験的な学習フロー:</strong>
            <ol>
                <li><strong>テキストボックスに文字を入力</strong> (例: "花子")</li>
                <li><strong>「ラベルに反映」ボタンを押す</strong> → サーバー側で処理されて、下に結果が表示される</li>
                <li><strong>気づき: サーバーコントロール → C# コード → サーバー処理 → HTML</strong> という流れ</li>
                <li><strong>ブラウザの開発者ツール(F12)で「検査」を開く</strong> → <code>&lt;input type="text"&gt;</code> や <code>&lt;span&gt;</code> などの plain HTML になっていることを確認</li>
                <li><strong>ページのソースを表示して、asp:Label や asp:TextBox の文字列を探す</strong> → 見つからない!(すべて HTML に変換されているから)</li>
            </ol>
        </div>
        <asp:Label ID="NameLabel" runat="server" AssociatedControlID="NameTextBox" Text="名前" />
        <asp:TextBox ID="NameTextBox" runat="server" Placeholder="ここに何か入力してみてください" />
        <asp:Button ID="ReflectButton" runat="server" Text="ラベルに反映" OnClick="ReflectButton_Click" CssClass="button" />
        <div class="demo-box" style="margin-top: 20px;">
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
