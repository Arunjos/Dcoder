//
//  Code.swift
//  Dcoder
//
//  Created by Arun Jose on 24/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation
import ObjectMapper

public class Code: Mappable {
    public var userName:String?
    public var userImageURL:String?
    public var time:String?
    public var tags:[String]?
    public var title:String?
    public var code:String?
    public var codeLanguage:String?
    public var upvotes:Int?
    public var downvotes:Int?
    public var comments:Int?
    
    
    required public init?(map: Map){
        
    }
    
    init(userName:String?, userImageURL:String?, time:String?, tags:[String]?, title:String?, code:String?, codeLanguage:String?, upvotes:Int?, downvotes:Int?, comments:Int?) {
        self.userName = userName
        self.userImageURL = userImageURL
        self.time = time
        self.tags = tags
        self.title = title
        self.code = code
        self.codeLanguage = codeLanguage
        self.upvotes = upvotes
        self.downvotes = downvotes
        self.comments = comments
    }
    
    public func mapping(map: Map) {
        userName <- map[Constants.PARAMS.USER_NAME]
        userImageURL <- map[Constants.PARAMS.USER_IMAGE_URL]
        time <- map[Constants.PARAMS.TIME]
        tags <- map[Constants.PARAMS.TAGs]
        title <- map[Constants.PARAMS.TITLE]
        code <- map[Constants.PARAMS.CODE]
        codeLanguage <- map[Constants.PARAMS.CODE_LANGUAGE]
        upvotes <- map[Constants.PARAMS.UPVOTES]
        downvotes <- map[Constants.PARAMS.DOWNVOTES]
        comments <- map[Constants.PARAMS.COMMENTS]
    }
}

extension Code {
    public static func getCodeListFrom(jsonArray:[[String:Any]]) -> [Code] {
        let codeList = Mapper<Code>().mapArray(JSONArray: jsonArray)
        return codeList
    }
}
