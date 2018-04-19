# NetWorkCore

再[Alamofire](https://github.com/Alamofire/Alamofire)的基础上封装了一套网络请求，并且实现数据解析的工具库,配合[RxSwift](https://github.com/ReactiveX/RxSwift)使用起来非常方便

## 使用要求

* Xcode 9.0+

## 安装

### CocoaPods

```ruby
pod 'UtilCore', '~> 0.0.1'
```

## 具体使用

### 1. 发起普通的网络请求

```swift
  NetWorkAPI.sharedInstance.requestSwiftyJSONReg(Api.topics) { (result) in
            switch result {
            case .success(let repos):
                print(repos)
            case .failure(let error):
                print(error)
            }
        }
```

### 2. 流式网络请求

```swift
 Observable.just("")
            .map { _ in Api.topics}
            .emeRequestApiForJson().subscribe(onNext: {(result) in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
```

### 3. 约定好返回数据状态

_在发起网络请求之前需要配置下_

```swift
//正确码 即:successCode 为1 的时候才会解析dataKey字段的值得
NetWorkCore.successCode = 1
// 获取successCode的建是对应的success
NetWorkCore.statusKey = "success"
// 获取data中的数据
NetWorkCore.dataKey = "data"
```

发起网络请求

```swift
 Observable.just("")
            .map { _ in Api.topics}
            .emeRequestApiForArray(TopicsModel.self)
            .subscribe(onNext: {(result) in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
```

### 4. 发起请求然后界面直接得到的是 model

```swift
   func request3()  {
        Observable.just("")
            .map { _ in Api.topics}
            .emeRequestApiForArray(TopicsModel.self)
            .subscribe(onNext: {(result) in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
            })
            .disposed(by: disposeBag)
    }
```
