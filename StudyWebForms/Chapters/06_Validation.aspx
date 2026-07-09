<%@ Page Title="06 Validation" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="06_Validation.aspx.cs" Inherits="StudyWebForms.Chapters._06_Validation" %>

<asp:Content ID="Title" ContentPlaceHolderID="TitleContent" runat="server">06 Validation</asp:Content>

<asp:Content ID="Main" ContentPlaceHolderID="MainContent" runat="server">
    <section class="card">
        <h2>06. 入力検証</h2>
        <p>Web Forms には RequiredFieldValidator などの検証コントロールがあります。</p>

        <p>
            <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="EmailTextBox" Text="メールアドレス" /><br />
            <asp:TextBox ID="EmailTextBox" runat="server" />
            <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="EmailTextBox" ErrorMessage="メールアドレスは必須です" ForeColor="Red" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="EmailFormat" runat="server" ControlToValidate="EmailTextBox" ErrorMessage="メール形式で入力してください" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" ForeColor="Red" Display="Dynamic" />
        </p>

        <p>
            <asp:Label ID="AgeLabel" runat="server" AssociatedControlID="AgeTextBox" Text="年齢" /><br />
            <asp:TextBox ID="AgeTextBox" runat="server" />
            <asp:RangeValidator ID="AgeRange" runat="server" ControlToValidate="AgeTextBox" Type="Integer" MinimumValue="0" MaximumValue="120" ErrorMessage="0〜120 の数値で入力してください" ForeColor="Red" Display="Dynamic" />
        </p>

        <asp:Button ID="SubmitButton" runat="server" Text="登録" OnClick="SubmitButton_Click" />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />

        <div class="demo-box">
            <asp:Label ID="ResultLabel" runat="server" />
        </div>
    </section>
</asp:Content>
