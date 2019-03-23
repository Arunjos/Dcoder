//
//  ChatViewModel.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation

protocol ChatViewModel {
    var isOffline:Dynamic<Bool> { get }
    var chatCount:Dynamic<Int> { get }
    var isChatFetching:Dynamic<Bool> { get }
    var error:Dynamic<String> { get }
    
    func getChatDataForCell(atIndex indexpath:IndexPath) -> Chat?
    func getSelectedChatMessage(atIndex indexpath:IndexPath) -> Chat?
    func fetchChatList()
    func refreshChatList()
}
