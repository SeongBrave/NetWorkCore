//
//  Reg.swift
//  Pods
//
//  Created by Icy on 2017/1/2.
//
//

import Foundation
import SwiftyJSON
import ModelProtocol

public class Reg: ModelProtocol {
    var status: Int!
    var message:String!
    var data: JSON
    required public init?(json:JSON){
        self.status = json[NetWorkCore.statusKey].intValue
        self.data = json[NetWorkCore.dataKey]
        self.message = json["message"].stringValue
    }
}
