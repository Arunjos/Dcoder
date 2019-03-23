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
    
    func fetchChatList() {
        self.isChatFetching.value = true
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        Alamofire.request(Constants.CHAT_API_URL, method:.get,parameters:nil, headers: headers).responseJSON { [unowned self] response in
            self.isChatFetching.value = false
            guard let responseCode = response.response?.statusCode else{
                self.error.value = "Chats fetch faild due to internal error"
                return
            }
            if (responseCode >= 400) {
                self.error.value = "Failed chats fetch with error \(response.error?.localizedDescription ?? "")"
            } else {
                guard let responseArray = response.result.value as? [[String : Any]] else {
                    self.error.value = "Failed to parse chat list response"
                    return
                }
                self.chatList = Chat.getChatListFrom(jsonArray: responseArray)
                self.chatCount.value = self.chatList.count
            }
        }
    }
    
    func refreshChatList() {
        fetchChatList()
    }
}

