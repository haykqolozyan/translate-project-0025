//
//  ResponseSrtuct.swift
//  TranslaterProject
//
//  Created by Hayk Qolozyan on 3/7/20.
//  Copyright © 2020 Hayk Qolozyan. All rights reserved.
//

import UIKit

public struct ResponseSrtuct: Codable {
    
    var text: String
    var meanings: [MeaningsStruct]
}
