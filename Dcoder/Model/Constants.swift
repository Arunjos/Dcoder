//
//  Constants.swift
//  Dcoder
//
//  Created by Arun Jose on 23/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation
public struct Constants {
    static let CHAT_API_URL = "https://dcoder.tech/test_json/chat.json"
    static let CODE_API_URL = "https://dcoder.tech/test_json/codes.json"
    public struct PARAMS{
        public static let USER_NAME = "user_name"
        public static let USER_IMAGE_URL = "user_image_url"
        public static let IS_SENT_BY_ME = "is_sent_by_me"
        public static let TEXT = "text"
        public static let TIME = "time"
        public static let TAGs = "tags"
        public static let TITLE = "title"
        public static let CODE = "code"
        public static let CODE_LANGUAGE = "code_language"
        public static let UPVOTES = "upvotes"
        public static let DOWNVOTES = "downvotes"
        public static let COMMENTS = "comments"
    }
    static let MY_CHAT_CELL_ID = "MyChatCellID"
    static let OTHERS_CHAT_CELL_ID = "OthersChatCellID"
    static let CODE_CELL_ID = "CodeCellID"
}
