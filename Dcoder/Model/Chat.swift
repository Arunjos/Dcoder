//
//  Chat.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation
import ObjectMapper

public class Chat: Mappable {
    public var userName:String?
    public var userImage:String?
    public var isMyMessage:Bool?
    public var text:String?
    
    required public init?(map: Map){
        
    }
    
    public func mapping(map: Map) {
        userName <- map[Constants.PARAMS.USER_NAME]
        userImage <- map[Constants.PARAMS.USER_IMAGE_URL]
        isMyMessage <- map[Constants.PARAMS.IS_SENT_BY_ME]
        text <- map[Constants.PARAMS.TEXT]
    }
}

extension Chat {
    public static func getChatListFrom(jsonArray:[[String:Any]]) -> [Chat] {
        let chatList = Mapper<Chat>().mapArray(JSONArray: jsonArray)
        return chatList
    }
}
