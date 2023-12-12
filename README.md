# コードの自動生成

$ flutter pub run build_runner build


# Drift
・String
・Bool
・DateTime

![Screenshot_1702353922](https://github.com/mzunohkaru/Flutter-Sample-Drift/assets/99012157/b46b68bd-cf29-49cc-99aa-a440d8b7d90f)

![Screenshot_1702353930](https://github.com/mzunohkaru/Flutter-Sample-Drift/assets/99012157/bd373419-39c2-4d12-81b0-91de237e9016)


# Path Provider

https://pub.dev/packages/path_provider


getApplicationDocumentsDirectory
アプリケーションがそのアプリケーション専用のファイルを配置するディレクトリへのパス。アプリケーション自体が削除された場合にのみ消去されます。

getExternalStorageDirectory
アプリケーションが最上位ストレージにアクセスできるディレクトリへのパス。この機能は Android のみ利用可能なため、呼び出しの前に OS を判断する必要があります。

getTemporaryDirectory
デバイスの一時ディレクトリへのパス。

