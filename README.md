# StudyWebForms

ASP.NET Web Forms の仕組みを体系的に理解するための講義用サンプルアプリです。

## 目的

Web Forms を単なる古い技術としてではなく、以下の観点から理解できるようにします。

- ページライフサイクル
- サーバーコントロール
- PostBack とイベント処理
- ViewState / Session / Application / Cache
- Master Page による共通レイアウト
- Validation Controls
- GridView とデータバインド
- IIS / SQL Server と関連する構成理解

## 想定環境

- Windows
- Visual Studio 2022
- .NET Framework 4.8
- ASP.NET Web Forms
- IIS Express または IIS
- SQL Server / SQL Server LocalDB

## 起動方法

1. Visual Studio で `StudyWebForms.sln` を開く
2. `StudyWebForms` プロジェクトを起動プロジェクトに設定
3. `Default.aspx` を実行
4. 画面上部のチャプターナビゲーションから各章へ移動

## チャプター構成

| Chapter | ページ | 学習テーマ |
|---|---|---|
| 01 | `Chapters/01_Lifecycle.aspx` | Web Forms のページライフサイクル |
| 02 | `Chapters/02_ServerControls.aspx` | サーバーコントロールと HTML 出力 |
| 03 | `Chapters/03_PostBack.aspx` | PostBack とイベント処理 |
| 04 | `Chapters/04_ViewState.aspx` | ViewState の役割 |
| 05 | `Chapters/05_StateManagement.aspx` | Session / Application / Cache |
| 06 | `Chapters/06_Validation.aspx` | 入力検証コントロール |
| 07 | `Chapters/07_DataBinding.aspx` | GridView とデータバインド |
| 08 | `Chapters/08_IIS_SQLServer.aspx` | IIS / AppPool / SQL Server との関係 |

## 講義での使い方

各章は 15〜20 分の説明と 10〜15 分の質疑応答を想定しています。

おすすめの進め方:

1. ページを開いて動きを確認する
2. `.aspx` のマークアップを見る
3. `.aspx.cs` のコードビハインドを見る
4. `Web.config` や IIS / SQL Server の関係を補足する
5. 現場の既存システムではどこに同じ仕組みが使われているか確認する

## 注意

このリポジトリは講義・理解を目的としたサンプルです。実運用向けのセキュリティ、認証、DB接続、例外処理は最小限にしています。
