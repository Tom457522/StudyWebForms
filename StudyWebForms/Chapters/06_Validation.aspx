<%@ Page Title="06 入力検証" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="06_Validation.aspx.cs" Inherits="StudyWebForms.Chapters._06_Validation" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">06 入力検証</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>06. 入力検証</h2>
        <p>Web Forms には <span class="code-note">RequiredFieldValidator</span> などの検証コントロールがあり、サーバー側に処理を送る前(場合によっては JavaScript でブラウザ側でも)に入力内容をチェックできます。</p>
        <div class="demo-box">
            <strong>操作手順:</strong>
            <ol>
                <li>何も入力せずに「登録」ボタンを押し、どんなエラーが出るか確認する</li>
                <li>メールアドレス欄に「abc」のような不正な形式を入力して「登録」を押し、エラーメッセージを確認する</li>
                <li>年齢欄に「200」のような範囲外の値を入力して「登録」を押し、エラーメッセージを確認する</li>
                <li>正しい値(例: メール = test@example.com、年齢 = 30)を入力して「登録」を押し、結果ラベルにメッセージが表示されることを確認する</li>
            </ol>
        </div>

        <p>
            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="EmailTextBox" Text="メールアドレス" /><br />
            <asp:TextBox ID="EmailTextBox" runat="server" />
            <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="EmailTextBox" ErrorMessage="メールアドレスは必須です。" ForeColor="Red" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="EmailFormat" runat="server" ControlToValidate="EmailTextBox" ErrorMessage="メール形式で入力してください。" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ForeColor="Red" Display="Dynamic" />
        </p>

        <p>
            <asp:Label ID="AgeLabel" runat="server" AssociatedControlID="AgeTextBox" Text="年齢" /><br />
            <asp:TextBox ID="AgeTextBox" runat="server" />
            <asp:RangeValidator ID="AgeRange" runat="server" ControlToValidate="AgeTextBox" Type="Integer" MinimumValue="0" MaximumValue="120" ErrorMessage="0〜120 の数値で入力してください。" ForeColor="Red" Display="Dynamic" />
        </p>

        <asp:Button ID="SubmitButton" runat="server" Text="登録" OnClick="SubmitButton_Click" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

        <div class="demo-box">
            <asp:Label ID="ResultLabel" runat="server" />
        </div>
    </section>

    <section class="card">
        <h3>観察ポイント(いつ・どこを見ると・何が分かるか)</h3>
        <table>
            <tr><th>いつ</th><th>どこを見る</th><th>何が分かるか</th></tr>
            <tr>
                <td>未入力のまま「登録」を押したとき</td>
                <td>メールアドレス欄の下に出るエラー</td>
                <td><span class="code-note">RequiredFieldValidator</span> が <span class="code-note">ControlToValidate</span> で指定した TextBox を監視し、空欄なら送信をブロックすること</td>
            </tr>
            <tr>
                <td>不正な形式のメールを入力したとき</td>
                <td><span class="code-note">EmailFormat</span> のエラーメッセージ</td>
                <td><span class="code-note">RegularExpressionValidator</span> が正規表現で形式チェックを行っていること</td>
            </tr>
            <tr>
                <td>範囲外の年齢を入力したとき</td>
                <td><span class="code-note">AgeRange</span> のエラーメッセージ</td>
                <td><span class="code-note">RangeValidator</span> が <span class="code-note">MinimumValue</span>〜<span class="code-note">MaximumValue</span> の範囲でチェックしていること</td>
            </tr>
            <tr>
                <td>エラーがある状態で「登録」を押したとき</td>
                <td><span class="code-note">06_Validation.aspx.cs</span> の <span class="code-note">SubmitButton_Click</span></td>
                <td><span class="code-note">Page.IsValid</span> が false になり、サーバー側の登録処理(結果ラベルの更新)が実行されずに終了していること</td>
            </tr>
            <tr>
                <td>すべて正しい値を入力して「登録」を押したとき</td>
                <td>結果ラベルの表示内容</td>
                <td><span class="code-note">Page.IsValid</span> が true になり、初めて本来の登録処理が実行されること</td>
            </tr>
        </table>
    </section>

    <section class="card">
        <h3>講義ポイント</h3>
        <ul>
            <li>各 Validator は <span class="code-note">ControlToValidate</span> で対象コントロールを指定する</li>
            <li>Validator はブラウザ側(JavaScript)とサーバー側の両方でチェックが行われるため、JavaScript が無効な環境でも安全性が保たれる</li>
            <li>サーバー側では必ず <span class="code-note">Page.IsValid</span> を確認してから処理を進めること(クライアント側のチェックだけに頼らない)</li>
            <li><span class="code-note">ValidationSummary</span> を使うと、すべてのエラーメッセージを1か所にまとめて表示できる</li>
        </ul>
    </section>
</asp:Content>
