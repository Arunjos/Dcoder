//
//  ChatViewModelFromChat.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation
import Alamofire

class ChatViewModelFromChat: ChatViewModel {
    // a demo user when login implemented we need to implement loggined user instead of this
    struct User{
        public static let USER_NAME = "Dcoder"
        public static let USER_IMAGE_URL = "http://dcoder.tech/avatar/dev7.png"
    }
    
    var isOffline: Dynamic<Bool>
    var chatCount: Dynamic<Int>
    var isChatFetching: Dynamic<Bool>
    var error: Dynamic<String>
    
    private var chatList:[Chat] = []
    
    init() {
        isOffline = Dynamic(false)
        isChatFetching = Dynamic(false)
        chatCount = Dynamic(0)
        error = Dynamic("")
    }
    
    func getChatDataForCell(atIndex indexpath: IndexPath) -> Chat? {
        return chatList[safe: indexpath.row]
    }
    
    func getSelectedChatMessage(atIndex indexpath: IndexPath) -> Chat? {
        return chatList[safe: indexpath.row]
    }
    
    func fetchChatList(url: String) {
        self.isChatFetching.value = true
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        Alamofire.request(url, method:.get,parameters:nil, headers: headers).responseJSON { [unowned self] response in
            self.isChatFetching.value = false
            guard let responseArray = response.result.value as? [[String : Any]] else {
                self.error.value = "Failed to parse chat list response"
                return
            }
            self.chatList = Chat.getChatListFrom(jsonArray: responseArray)
            self.chatCount.value = self.chatList.count
        }
    }
    
    func refreshChatList() {
        fetchChatList(url: Constants.CHAT_API_URL)
    }
    
    func sentChat(withMessage msg:String){
        let chatDetail = Chat(name: User.USER_NAME, image: User.USER_IMAGE_URL, isMyMsg: true, textMsg: msg)
        self.chatList.append(chatDetail)
        self.chatCount.value = self.chatList.count
    }
    
    func getFullChatList() -> [Chat] {
        return self.chatList
    }
}

