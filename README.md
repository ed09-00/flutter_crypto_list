# Flutter 虛擬貨幣清單與即時價格顯示
<img src="https://cdn.discordapp.com/attachments/917430039597965334/1212658297606512721/image.png?ex=65f2a30c&is=65e02e0c&hm=b22db36090779739dacac03a30d46d27179bc7adc43e09f98a1e34fa80c62957" height="686px" width="322px" /><img src="https://cdn.discordapp.com/attachments/917430039597965334/1212658833839620166/image.png?ex=65f2a38c&is=65e02e8c&hm=970745f0a3543780ec1e999bdf90ae111ebeed78be4cccc22a84cc28c3a70445&" height="686px" width="322px" />


使用Binance API 與 CoinMarketCap API獲取虛擬貨幣價格資訊並做成圖表

Binance api: https://binance-docs.github.io/apidocs/spot/en/#market-data-endpoints
CoinMarketCap: https://coinmarketcap.com/api/documentation/v1/#section/Authentication    

## 功能  
list page:
- 顯示項目價格。
- 無限制的添加自選項目。
- 刪除自選項目。
- 本地儲存。

chart page:
- 帶有兩條均線的K線圖(SMA14, SMA28)。
- 可選K線圖表時間週期(1m, 15m, 1h, 4h, 1d)。
- 顯示在幣安交易所BTC/USDT 24小時的最高價、最低價、成交量(顆)。
- 秒級別即時的價格變化。
- 價格變色表示漲(綠)、跌(紅)。(綠漲紅跌為美式風格)

  
## plugins
| plugin名稱  | 官方文件說明 | 使用場景 |
| ------------- | ------------- | ------------- |
|  [dio](https://pub.dev/packages/dio "dio")  |一個強大的 Dart/Flutter HTTP 網絡套件，支援全局配置、攔截器、表單數據、請求取消、文件上傳/下載、超時處理、自定義適配器、轉換器等功能。 | 操作RESTful API。|
| [web_socket_channel ](https://pub.dev/packages/web_socket_channel "web_socket_channel ") | 它提供了跨平台的 WebSocketChannel API，這個 API 的跨平台實現通過底層的 StreamChannel 進行通訊，其中包括一個封裝了 dart:io 的 WebSocket 類的實現，以及一個封裝了 dart:html 的類似實現。 | 獲取 [Binance API](https://binance-docs.github.io/apidocs/spot/en/#market-data-endpoints "Binance API") 及時價格資料。  |
|  [syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts "syncfusion_flutter_charts") | Flutter Charts 套件是一個資料視覺化庫，使用 Dart 語言原生編寫，用於創建美觀、動畫豐富且高性能的圖表。這些圖表可以通過 Flutter 構建高品質的移動應用程式用戶界面。 | 將 [Binance API](https://binance-docs.github.io/apidocs/spot/en/#market-data-endpoints "Binance API") 資料轉換為K線圖。  |
| [intl ](https://pub.dev/packages/intl "intl ") | 提供國際化和本地化設施，包括消息翻譯、複數形式和性別區分、日期/數字格式化和解析，以及雙向文字支援。  | 格式化圖表上顯示時間。  |
| [shared_preferences](https://pub.dev/packages/shared_preferences "shared_preferences") | 封裝了特定平台的持久性存儲功能，用於簡單數據（在 iOS 和 macOS 上使用 NSUserDefaults，在 Android 上使用 SharedPreferences 等）。 | 操作本地儲存資料。  |



## Demo
