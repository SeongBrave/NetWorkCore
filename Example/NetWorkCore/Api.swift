//
//  Api.swift
//  NetWorkCore_Example
//
//  Created by eme on 2018/4/19.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire
import ModelProtocol
import NetWorkCore
import UtilCore


public enum Api{
    /// 获取文章列表
    case topics
    
}
extension Api: TargetType {
    
    //设置请求路径
    public var path: String {
        switch self {
        case .topics:
            return "/topics"
        }
    }
    
    //设置请求方式 get post等
    public var method: HTTPMethod {
        switch self {
        default :
            return .get
            
        }
    }
    /// 设置请求参数
    public var parameters: Parameters? {
        switch self {
        default :
            return nil
        }
    }
    
}
