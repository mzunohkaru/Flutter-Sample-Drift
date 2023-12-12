# コードの自動生成

$ flutter pub run build_runner build


# Path Provider

Pub dev
https://pub.dev/packages/path_provider


getApplicationDocumentsDirectory
アプリケーションがそのアプリケーション専用のファイルを配置するディレクトリへのパス。アプリケーション自体が削除された場合にのみ消去されます。

getExternalStorageDirectory
アプリケーションが最上位ストレージにアクセスできるディレクトリへのパス。この機能は Android のみ利用可能なため、呼び出しの前に OS を判断する必要があります。

getTemporaryDirectory
デバイスの一時ディレクトリへのパス。

