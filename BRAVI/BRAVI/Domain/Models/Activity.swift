//
//  Activity.swift
//  BRAVI
//
//  Created by Zanette Ciriaco on 08/02/22.
//

import Foundation

struct Activity: Decodable {
    let activity: String
    let type: String
    let participants: Int
    let price: Double
    let link: String
    let key: String
    let accessibility: Double
}
