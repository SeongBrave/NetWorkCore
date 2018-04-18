//
//  Observable+SwiftyJSON.swift
//  Pods
//
//  Created by Icy on 2017/1/2.
//
//

import Foundation
import RxSwift
import SwiftyJSON
import ModelProtocol

// MARK: - 扩展ObservableType 转换String为JSON
public extension ObservableType where E == String {
    
    /**
     最基础的SwiftJSON解析的封装
     
     - returns: 返回JSON 对象
     */
    public func mapSwiftyJSON() -> Observable<JSON> {
        return flatMap { response -> Observable<JSON> in
            if let dataFromString = response.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    let json = try JSON(data: dataFromString)
                    return Observable.just(json)
                } catch _ {
                    throw MikerError("clienterrorcode",code:100,message:"JSON转换错误")
                }
            } else {
                throw MikerError("clienterrorcode",code:100,message:"JSON转换错误")
            }
        }
    }
    
    
    /**
     改方法主要是针对特殊返回的数据进行解析的，一般分两部
     改方法为第一步
     - returns: 返回JSON 对象
     */
    public func mapSwiftyJSONReg() -> Observable<JSON> {
        return flatMap { response -> Observable<JSON> in
            if let dataFromString = response.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    let json = try JSON(data: dataFromString)
                    guard let regObj = Reg(json: json) else {
                        throw MikerError("clienterrorcode",code:101,message:"对象转换错误")
                    }
                    if regObj.status == NetWorkCore.successCode{
                        return Observable.just(regObj.data)
                    }else{
                        throw MikerError("serverrrorcode",code:regObj.status,message:regObj.message)
                    }
                } catch _ {
                    throw MikerError("clienterrorcode",code:100,message:"JSON转换错误")
                }
            } else {
                throw MikerError("clienterrorcode",code:100,message:"JSON转换错误")
            }
        }
    }
    
    /**
     一次性解析成 model对象
     
     - parameter type:
     
     - returns: 返回model对象
     */
    public func mapSwiftyObject<T: ModelProtocol>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            if let dataFromString = response.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    let json = try JSON(data: dataFromString)
                    guard let regObj = Reg(json: json) else {
                        throw MikerError("clienterrorcode",code:101,message:"对象转换错误")
                    }
                    if regObj.status == NetWorkCore.successCode{
                        guard let mappedObject = T(json: regObj.data) else {
                            throw MikerError("clienterrorcode",code:101,message:"对象转换错误")
                        }
                        return Observable.just(mappedObject);
                    }else{
                        throw MikerError("serverrrorcode",code:regObj.status,message:regObj.message)
                    }
                } catch _ {
                    throw MikerError("clienterrorcode",code:100,message:"JSON转换错误")
                }
            } else {
                throw MikerError("clienterrorcode",code:100,message:"JSON转换错误")
            }
        }
    }
    
    /**
     一次性解析成model 的数组对象
     
     - parameter type:
     
     - returns: model 数组对象
     */
    public func mapSwiftyArray<T: ModelProtocol>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            if let dataFromString = response.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                do {
                    let json = try JSON(data: dataFromString)
                    guard let regObj = Reg(json: json) else {
                        throw MikerError("clienterrorcode",code:101,message:"对象转换错误");
                    }
                    if regObj.status == NetWorkCore.successCode{
                        let mappedObjectsArray = regObj.data.arrayValue.compactMap { T(json: $0) }
                        return Observable.just(mappedObjectsArray);
                    }else{
                        throw MikerError("serverrrorcode",code:regObj.status,message:regObj.message)
                    }
                } catch _ {
                    throw MikerError("clienterrorcode",code:100,message:"JSON转换错误")
                }
            } else {
                throw MikerError("clienterrorcode",code:100,message:"JSON转换错误");
            }
        }
    }
    
}


// MARK: - 扩展ObservableType 转换String为为对象
public extension ObservableType  where E == JSON {
    /**
     这块需要对应上面的mapSwiftyJSONReg第一步 ， 该方法是 第二步
     解析JSON 到 model 对象
     - parameter type:
     - returns: 返回model 对象
     */
    public func mapSwiftyObjectModel<T: ModelProtocol>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            guard let mappedObject = T(json: response) else {
                throw MikerError("clienterrorcode",code:101,message:"对象转换错误");
            }
            return Observable.just(mappedObject);
        }
    }
    
    /**
     这块需要对应上面的mapSwiftyJSONReg第一步 ， 该方法是 第二步
     解析JSON 到 model的数组对象
     */
    public func mapSwiftyArrayModel<T: ModelProtocol>(_ type: T.Type) -> Observable<[T]> {
        return flatMap { response -> Observable<[T]> in
            let mappedObjectsArray = response.arrayValue.compactMap { T(json: $0) }
            return Observable.just(mappedObjectsArray);
        }
    }
    
}

