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
| plugin名稱  | 使用說明 |
| ------------- | ------------- |
|  [dio](https://pub.dev/packages/dio "dio")  | 操作RESTful API  |
| [web_socket_channel ](https://pub.dev/packages/web_socket_channel "web_socket_channel ")  | 獲取 [Binance API](https://binance-docs.github.io/apidocs/spot/en/#market-data-endpoints "Binance API") 及時價格資料。  |
|  [syncfusion_flutter_charts](https://pub.dev/packages/syncfusion_flutter_charts "syncfusion_flutter_charts")  | 將 [Binance API](https://binance-docs.github.io/apidocs/spot/en/#market-data-endpoints "Binance API") 資料轉換為K線圖。  |
| [intl ](https://pub.dev/packages/intl "intl ")  | 格式化圖表上顯示時間。  |
| [shared_preferences](https://pub.dev/packages/shared_preferences "shared_preferences")  | 操作本地儲存資料。  |



## Demo
