//
//  GenerateUrl.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 09/02/22.
//

import Foundation

class AddUrlParams {
    let baseUrl = "http://www.boredapi.com/api/activity/"
    var url = ""
    
    static let sharedInstance = AddUrlParams()
    
    private init() {
        url = baseUrl
    }
}

