//
//  MaskInfos.swift
//  TrueLoveProject
//
//  Created by Bomi on 2020/5/17.
//  Copyright © 2020 PrototypeC. All rights reserved.
//

import Foundation

struct MaskInfos: Decodable, Equatable {
    let id: String
    let name: String
    let phone: String
    let address: String
    let mask_adult: Double
    let mask_child: Double
    let updated: String
    let available: String
    let note: String
    let custom_note: String
    let website: String
    let county: String
    let town: String
    let cunli: String
    let service_periods: String
}
