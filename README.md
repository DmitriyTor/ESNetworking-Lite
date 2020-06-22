# ESNetworking-Lite

We create simple network library with only GET and POST request. 
# Usage

## Standart use

1) Import in project

```swift
import ESNetworking-Lite
```

2) For request create  [model of request](https://eskaria.github.io/ESNetworking-Lite/Typealiases.html#/s:17ESNetworking_Lite9ESRequesta) and run request [with params](https://eskaria.github.io/ESNetworking-Lite/Structs/ESNetworking_5FLite.html#/s:17ESNetworking_LiteAAV7request7baseUrl0C5Model15completionQueue11cachePolicy7timeOut13resultHandlerySS_AA08_RequestF8Protocol_AA01_oF0CXcSo17OS_dispatch_queueCSo017NSURLRequestCacheJ0VSdys6ResultOyxAA14ESRequestErrorOGctSeRzSERzlF)

```swift
ESNetworking_Lite().request(baseUrl: baseUrl, requestModel: requestModel) { (result: Result<*YOUR MODEL*, ESRequestError>) in
    switch result {
    case .success(let model):
        print(model)
    case .failure(let error):
        print(error)
    }
}
```
Its used Result Generic type and you can use switch result for catch error
