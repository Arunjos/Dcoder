//
//  CodeViewModel.swift
//  Dcoder
//
//  Created by Arun Jose on 24/03/19.
//  Copyright © 2019 Arun Jose. All rights reserved.
//

import Foundation

protocol CodeViewModel {
    var isOffline:Dynamic<Bool> { get }
    var codeListCount:Dynamic<Int> { get }
    var isCodeListFetching:Dynamic<Bool> { get }
    var error:Dynamic<String> { get }
    
    func getCodeDetailForCell(atIndex indexpath:IndexPath) -> Code?
    func getSelectedCode(atIndex indexpath:IndexPath) -> Code?
    func fetchCodeList()
    func refreshCodeList()
    func addCode(withMessage msg:String)
    func filterOneApply(forIndex index:Int)
    func filterTwoApply(forIndex index:Int)
}
