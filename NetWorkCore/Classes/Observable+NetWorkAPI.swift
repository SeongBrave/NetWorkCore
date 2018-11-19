//
//  Observable+NetWorkAPI.swift
//  Pods
//
//  Created by Icy on 2017/1/2.
//
//

import Foundation
import Result
import RxSwift
import SwiftyJSON
import ModelProtocol

// MARK: - 扩展ObservableType 转换TargetType为Response
extension ObservableType where E:TargetType {
    /**
     将TargetType类型的流转换成网络请求并且解析成json格式的对象的事件流 , 改方法适配所有的返回格式是json类型的请求，不受reg类的类型影响
     - returns: 返回JSON格式的数据流
     */
    public func emeRequestApiForJson() -> Observable<Result<JSON,MikerError>> {
        return flatMapLatest { response -> Observable<Result<JSON,MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyJSON()
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
    public func emeRequestApiForJson(_ activityIndicator: ActivityIndicator) -> Observable<Result<JSON,MikerError>> {
        return flatMapLatest { response -> Observable<Result<JSON,MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyJSON()
                .trackActivity(activityIndicator)
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
    /**
     将TargetType类型的流转换成网络请求并且解析成json格式的对象的事件流，返回的数据格式必须是reg 类型的格式
     - returns: 返回JSON格式的数据流
     */
    public func emeRequestApiForRegJson() -> Observable<Result<JSON,MikerError>> {
        return flatMapLatest { response -> Observable<Result<JSON,MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyJSONReg()
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
    public func emeRequestApiForRegJson(_ activityIndicator: ActivityIndicator) -> Observable<Result<JSON,MikerError>> {
        return flatMapLatest { response -> Observable<Result<JSON,MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyJSONReg()
                .trackActivity(activityIndicator)
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
    /**
     将TargetType类型的流转换成网络请求并且解析成mode对象格式的对象的事件流
     - returns: 返回mode对象格式的数据流
     */
    public func emeRequestApiForObj<T: ModelProtocol>(_ type: T.Type) -> Observable<Result<T,MikerError>> {
        return flatMapLatest { response -> Observable<Result<T,MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyObject(type)
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
    public func emeRequestApiForObj<T: ModelProtocol>(_ type: T.Type,activityIndicator: ActivityIndicator) -> Observable<Result<T,MikerError>> {
        return flatMapLatest { response -> Observable<Result<T,MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyObject(type)
                .trackActivity(activityIndicator)
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
    /**
     将TargetType类型的流转换成网络请求并且解析成mode对象格数组式的对象的事件流
     - returns: 返回mode对象数组格式的数据流
     */
    public func emeRequestApiForArray<T: ModelProtocol>(_ type: T.Type) -> Observable<Result<[T],MikerError>> {
        return flatMapLatest { response -> Observable<Result<[T],MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyArray(type )
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
    public func emeRequestApiForArray<T: ModelProtocol>(_ type: T.Type,activityIndicator: ActivityIndicator) -> Observable<Result<[T],MikerError>> {
        return flatMapLatest { response -> Observable<Result<[T],MikerError>> in
            return  NetWorkAPI.sharedInstance.request(response)
                .observeOn(MainScheduler.instance)
                .do(onError: { str in
                    UrlManager.sharedInstance.getNext()
                })
                .retry(UrlManager.sharedInstance.retryNum)
                .mapSwiftyArray(type)
                .trackActivity(activityIndicator)
                .map{Result.success($0)}
                .catchError{ error in
                    if error is MikerError{
                        return Observable.just(Result.failure(error as! MikerError))
                    }else{
                        let errir  = error as NSError
                        return Observable.just(Result.failure(MikerError(errir.domain,code:errir.code,message: errir.localizedDescription)))
                    }
            }
        }
    }
}
extension ObservableType where E == Result<JSON,MikerError> {
    
    /// 将json类型转换成model，主要是通过reg_block外部确定怎么解析
    public func parsingObjectModel<T: ModelProtocol>(_ type: T.Type,reg_block:@escaping ((_ json:JSON) -> Any)) -> Observable<Result<T,MikerError>> {
        return flatMap { response -> Observable<Result<T,MikerError>> in
            switch response{
            case .success(let result):
                ///需要外部专门解析然后将剩余的json实例化为model
                let regObj = reg_block(result)
                if let regModel = regObj as? JSON{
                    guard let mappedObject = T(json: regModel) else {
                        return Observable.just(Result.failure(MikerError("clienterrorcode",code:101,message:"对象转换错误")))
                    }
                    return Observable.just(Result.success(mappedObject));
                }else if let error = regObj as? MikerError{
                    return Observable.just(Result.failure(error))
                }else{
                    return Observable.just(Result.failure(MikerError("clienterrorcode",code:101,message:"对象转换错误")))
                }
            case .failure(let error):
                return Observable.just(Result.failure(error))
                
            }
            
        }
    }
    /// 将json类型转换成mode的list，主要是通过reg_block外部确定怎么解析
    public func parsingObjectArray<T: ModelProtocol>(_ type: T.Type,reg_block:@escaping ((_ json:JSON) -> Any)) -> Observable<Result<[T],MikerError>> {
        return flatMap { response -> Observable<Result<[T],MikerError>> in
            switch response{
            case .success(let result):
                ///需要外部专门解析然后将剩余的json实例化为model
                let regObj = reg_block(result)
                if let regList = regObj as? JSON{
                    let mappedObjectsArray = regList.arrayValue.compactMap { T(json: $0) }
                    return Observable.just(Result.success(mappedObjectsArray))
                }else if let error = regObj as? MikerError{
                    return Observable.just(Result.failure(error))
                }else{
                    return Observable.just(Result.failure(MikerError("clienterrorcode",code:101,message:"对象转换错误")))
                }
            case .failure(let error):
                return Observable.just(Result.failure(error))
                
            }
            
        }
    }
}
