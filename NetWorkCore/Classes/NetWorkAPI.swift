//
//  NetWorkAPI.swift
//  Pods
//
//  Created by Icy on 2017/1/2.
//
//

import UIKit
import Alamofire
import RxSwift
import enum Result.Result
import ModelProtocol
import SwiftyJSON

public protocol TargetType {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
}

public class NetWorkAPI {
    
    public var headers:HTTPHeaders = [
        "Accept": "application/json"
    ]
    var alamofireManager : SessionManager?
    /// 单例模式
    public static var sharedInstance : NetWorkAPI {
        struct Static {
            static let instance : NetWorkAPI = NetWorkAPI(timeout: 15)
        }
        return Static.instance
    }
    init (timeout: TimeInterval) {
        let config = URLSessionConfiguration.default
        /// 设置请求超时时间
        config.timeoutIntervalForRequest = timeout
        let manger = SessionManager(configuration: config)
        self.alamofireManager = manger
    }
    private let disposeBag = DisposeBag()
    /**
     在这块 发起网络请求并且 将返回的数据转换成事件流传下去
     - returns: 返回String类型结果的数据流
     */
    public func request(_ target:TargetType) -> Observable<String>{
        return Observable.create {[unowned self] observer -> Disposable in
            var  baseurl:String = ""
            if target.path.hasPrefix("http") {
                baseurl = target.path
            }else{
                baseurl = UrlManager.sharedInstance.baseUrl + target.path;
            }
            Alamofire.request(baseurl,method: target.method , parameters: target.parameters,encoding: URLEncoding.default,headers:self.headers) .responseString { response in
                switch response.result {
                case.success(let repos):
                    if NetWorkCore.isDebug == true {
                        if let httpUrl = response.response?.url{
                            if target.method == .post{
                                let showparam = "\(httpUrl.absoluteString)\(self.getShowParamUrl(param: target.parameters as [String : AnyObject]?))"
                                print("post:\n\(showparam)\n")
                            }else{
                                print("get:\n\(httpUrl.absoluteString)\n")
                            }
                        }
                        print(repos)
                    }
                    observer.onNext(repos)
                    observer.onCompleted()
                case.failure(let error):
                    print(String(describing: error))
                    if NetWorkCore.isDebug == true {
                        if target.method == .post{
                            let showparam = baseurl + self.getShowParamUrl(param: target.parameters as [String : AnyObject]?)
                            print("post:\n\(showparam)\n")
                        }else{
                            print("get:\n\(baseurl)\n")
                        }
                    }
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
        
    }
    /**
     在这块 发起网络请求并且 将返回的数据转换成事件流传下去
     - returns: 返回String类型结果的数据流Result<String,MikerError>
     */
    public func request(_ target:TargetType,didResponseBlock:@escaping ((_ responsedata : Result<String,MikerError>) -> Void)) -> Void{
        var  baseurl:String = ""
        if target.path.hasPrefix("http") {
            baseurl = target.path
        }else{
            baseurl = UrlManager.sharedInstance.baseUrl + target.path;
        }
        Alamofire.request(baseurl,method: target.method , parameters: target.parameters,encoding: URLEncoding.default,headers:self.headers) .responseString { response in
            switch response.result {
            case.success(let repos):
                if NetWorkCore.isDebug == true {
                    if let httpUrl = response.response?.url{
                        if target.method == .post{
                            let showparam = "\(httpUrl.absoluteString)\(self.getShowParamUrl(param: target.parameters as [String : AnyObject]?))"
                            print("post:\n\(showparam)\n")
                        }else{
                            print("get:\n\(httpUrl.absoluteString)\n")
                        }
                    }
                    print(repos)
                }
                ///调用回调
                didResponseBlock(Result(repos))
            case.failure(let error):
                print(String(describing: error))
                if NetWorkCore.isDebug == true {
                    if target.method == .post{
                        let showparam = baseurl + self.getShowParamUrl(param: target.parameters as [String : AnyObject]?)
                        print("post:\n\(showparam)\n")
                    }else{
                        print("get:\n\(baseurl)\n")
                    }
                }
                ///调用回调
                didResponseBlock(Result.failure(MikerError(error: error as NSError)))
            }
        }
    }
    /**
     在这块 发起网络请求并且 将返回的数据转换成事件流传下去
     - returns: 返回String类型结果的数据流
     */
    public func requestSwiftyJSONReg(_ target:TargetType,didResponseBlock:@escaping ((_ responsedata : Result<JSON,MikerError>) -> Void)) -> Void{
        self.request(target){ result in
            switch result{
            case .success(let data):
                if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    do {
                        let json = try JSON(data: dataFromString)
                        guard let regObj = Reg(json: json) else {
                            return didResponseBlock(Result.failure(MikerError("clienterrorcode",code:101,message:"对象转换错误")))
                        }
                        if regObj.status == NetWorkCore.successCode{
                            ///调用回调
                            didResponseBlock(Result(regObj.data))
                        }else{
                            didResponseBlock(Result.failure(MikerError("serverrrorcode",code:regObj.status,message:regObj.message)))
                        }
                    } catch _ {
                       didResponseBlock(Result.failure( MikerError("clienterrorcode",code:100,message:"JSON转换错误")))
                    }
                }else{
                    didResponseBlock(Result.failure( MikerError("clienterrorcode",code:100,message:"JSON转换错误")))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    /**
     主要用于显示 post 请求时 的参数 方便浏览器调试
     - returns:
     */
    private func getShowParamUrl(param:[String:AnyObject]?) -> String {
        var relStr = ""
        var relArr:[String] = []
        if let param = param {
            for item in param {
                relArr.append(item.0 + "=" + String(describing: item.1))
            }
        }
        if relArr.count > 0 {
            relStr = "?" + relArr.joined(separator: "&")
        }
        return relStr
    }
    
}

