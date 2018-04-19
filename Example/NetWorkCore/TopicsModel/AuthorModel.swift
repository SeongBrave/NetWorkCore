//
//  AuthorModel.swift
//
//  Created by eme on 2018/4/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ModelProtocol

class AuthorModel: ModelProtocol {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kAuthorLoginnameKey: String = "loginname"
	internal let kAuthorAvatarUrlKey: String = "avatar_url"


    // MARK: 属性
	 var loginname: String
	 var avatarUrl: String


    // MARK: 实现MikerSwiftJSONAble 协议， 解析json数据
   public required  init?(json: JSON) {
		loginname = json[kAuthorLoginnameKey].stringValue
		avatarUrl = json[kAuthorAvatarUrlKey].stringValue

    }


    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]

			dictionary.updateValue(loginname as AnyObject, forKey: kAuthorLoginnameKey)
		

			dictionary.updateValue(avatarUrl as AnyObject, forKey: kAuthorAvatarUrlKey)
		

        return dictionary
    }


}
