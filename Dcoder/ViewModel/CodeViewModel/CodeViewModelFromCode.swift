//
//  CodeViewModelFromCode.swift
//  Dcoder
//
//  Created by Arun Jose on 24/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation
import Alamofire


class CodeViewModelFromCode: CodeViewModel {
    // a demo user when login implemented we need to implement loggined user instead of this
    struct User{
        public static let USER_NAME = "Dcoder"
        public static let USER_IMAGE_URL = "http://dcoder.tech/avatar/dev7.png"
    }
    
    var isOffline: Dynamic<Bool>
    var codeListCount: Dynamic<Int>
    var isCodeListFetching: Dynamic<Bool>
    var error: Dynamic<String>
    static let filter1DataSource = ["All", "Trending", "Most Popular", "Recent", "Mycodes"]
    static let filter2DataSource = ["All", "C", "C#", "CPP", "JAVA", "PYTHON"]
    
    private var codeList:[Code] = []
    private var filterCodeList:[Code] = []
    private var filter1Value = "All"
    private var filter2Value = "All"
    
    init() {
        isOffline = Dynamic(false)
        isCodeListFetching = Dynamic(false)
        codeListCount = Dynamic(0)
        error = Dynamic("")
    }
    
    func getCodeDetailForCell(atIndex indexpath: IndexPath) -> Code? {
        return filterCodeList[safe: indexpath.row]
    }
    
    func getSelectedCode(atIndex indexpath: IndexPath) -> Code? {
        return filterCodeList[safe: indexpath.row]
    }
    
    func fetchCodeList(url:String) {
        self.isCodeListFetching.value = true
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        Alamofire.request(url, method:.get,parameters:nil, headers: headers).responseJSON { [unowned self] response in
            self.isCodeListFetching.value = false
            guard let responseArray = response.result.value as? [[String : Any]] else {
                self.error.value = "Failed to parse code list response"
                return
            }
            self.codeList = Code.getCodeListFrom(jsonArray: responseArray)
            self.filterCodeList = self.codeList
            self.codeListCount.value = self.filterCodeList.count
        }
    }
    
    func refreshCodeList() {
        fetchCodeList(url: Constants.CODE_API_URL)
    }
    
     func filterOneApply(forIndex index:Int) {
        filter1Value = CodeViewModelFromCode.filter1DataSource[index]
        filter()
    }
    
    func filterTwoApply(forIndex index:Int) {
        filter2Value = CodeViewModelFromCode.filter2DataSource[index]
        filter()
    }
    fileprivate func filter() {
        if filter2Value.lowercased() == "All".lowercased() {
            filterCodeList = codeList
            codeListCount.value = filterCodeList.count
            return
        }
        // Filter 2 logic
        var filterArray:[Code] = Array<Code>()
        for code in codeList {
            if let tags = code.tags, tags.contains(filter2Value.lowercased()) {
                filterArray.append(code)
            }
        }
        filterCodeList = filterArray
        codeListCount.value = filterCodeList.count
        
        //Filter One logic goes below currently the filter criteria is unknown
        //
        //
        
    }
    
    func addCode(title:String, code:String, tag:String){
        let time = String(Date().timeIntervalSince1970)
        let codeDetail = Code(userName: User.USER_NAME, userImageURL: User.USER_IMAGE_URL, time: time, tags: tag.components(separatedBy: ","), title: title, code: code, codeLanguage: "", upvotes: 0, downvotes: 0, comments: 0)
        self.codeList.insert(codeDetail, at: 0)
        self.filterCodeList = self.codeList
        self.codeListCount.value = self.filterCodeList.count
    }
    
    func getFullCodeList() -> [Code] {
        return self.codeList
    }
}
