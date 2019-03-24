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
    
    init(name userName:String?, image userImage:String?, isMyMsg isMyMessage:Bool?, textMsg text:String?) {
        self.userImage = userImage
        self.userName = userName
        self.isMyMessage = isMyMessage
        self.text = text
    }
    
    public func mapping(map: Map) {
        userName <- map[Constants.PARAMS.USER_NAME]
        userImage <- map[Constants.PARAMS.USER_IMAGE_URL]
        isMyMessage <- map[Constants.PARAMS.IS_SENT_BY_ME]
        text <- map[Constants.PARAMS.TEXT]
    }
}

extension Chat: Equatable {
    public static func getChatListFrom(jsonArray:[[String:Any]]) -> [Chat] {
        let chatList = Mapper<Chat>().mapArray(JSONArray: jsonArray)
        return chatList
    }
    
    public static func == (lhs: Chat, rhs: Chat) -> Bool {
        if lhs.userName == rhs.userName && lhs.userImage == rhs.userImage && lhs.isMyMessage == rhs.isMyMessage && lhs.text == rhs.text{
            return true
        }
        return false
    }
}
