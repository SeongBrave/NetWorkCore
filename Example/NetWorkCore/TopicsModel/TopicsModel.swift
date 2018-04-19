//
//  TopicsModel.swift
//
//  Created by eme on 2018/4/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ModelProtocol

class TopicsModel: ModelProtocol {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kTopicsContentKey: String = "content"
    internal let kTopicsCreateAtKey: String = "create_at"
    internal let kTopicsAuthorIdKey: String = "author_id"
    internal let kTopicsVisitCountKey: String = "visit_count"
    internal let kTopicsInternalIdentifierKey: String = "id"
    internal let kTopicsGoodKey: String = "good"
    internal let kTopicsTitleKey: String = "title"
    internal let kTopicsTabKey: String = "tab"
    internal let kTopicsReplyCountKey: String = "reply_count"
    internal let kTopicsAuthorKey: String = "author"
    internal let kTopicsTopKey: String = "top"
    internal let kTopicsLastReplyAtKey: String = "last_reply_at"
    
    
    // MARK: 属性
    var content: String
    var createAt: String
    var authorId: String
    var visitCount: Int
    var internalIdentifier: String
    var good: Bool = false
    var title: String
    var tab: String
    var replyCount: Int
    var author: AuthorModel
    var top: Bool = false
    var lastReplyAt: String
    
    
    // MARK: 实现MikerSwiftJSONAble 协议， 解析json数据
    public required  init?(json: JSON) {
        content = json[kTopicsContentKey].stringValue
        createAt = json[kTopicsCreateAtKey].stringValue
        authorId = json[kTopicsAuthorIdKey].stringValue
        visitCount = json[kTopicsVisitCountKey].intValue
        internalIdentifier = json[kTopicsInternalIdentifierKey].stringValue
        good = json[kTopicsGoodKey].boolValue
        title = json[kTopicsTitleKey].stringValue
        tab = json[kTopicsTabKey].stringValue
        replyCount = json[kTopicsReplyCountKey].intValue
        author = AuthorModel(json: json[kTopicsAuthorKey])!
        top = json[kTopicsTopKey].boolValue
        lastReplyAt = json[kTopicsLastReplyAtKey].stringValue
        
    }
    
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        
        dictionary.updateValue(content as AnyObject, forKey: kTopicsContentKey)
        
        
        dictionary.updateValue(createAt as AnyObject, forKey: kTopicsCreateAtKey)
        
        
        dictionary.updateValue(authorId as AnyObject, forKey: kTopicsAuthorIdKey)
        
        
        dictionary.updateValue(visitCount as AnyObject, forKey: kTopicsVisitCountKey)
        
        
        dictionary.updateValue(internalIdentifier as AnyObject, forKey: kTopicsInternalIdentifierKey)
        
        dictionary.updateValue(good as AnyObject, forKey: kTopicsGoodKey)
        
        dictionary.updateValue(title as AnyObject, forKey: kTopicsTitleKey)
        
        
        dictionary.updateValue(tab as AnyObject, forKey: kTopicsTabKey)
        
        
        dictionary.updateValue(replyCount as AnyObject, forKey: kTopicsReplyCountKey)
        
        dictionary.updateValue(top as AnyObject, forKey: kTopicsTopKey)
        
        dictionary.updateValue(lastReplyAt as AnyObject, forKey: kTopicsLastReplyAtKey)
        
        
        return dictionary
    }
    
    
}
