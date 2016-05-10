//
//  FeedsService.swift
//  Menthas
//
//  Created by Hikaru Ito on 2016/05/10.
//  Copyright © 2016年 Hikaru. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct FeedsService {
    
    // Doc: https://github.com/ytanaka-/menthas
    
    private static let baseurl = "http://menthas.com"
    
    static func feedsList(category: String, offset: Int, cb: (JSON) -> Void) -> Void {
        let urlStr = baseurl + "/" + category + "/list"
        let params = [
            "offset": String(offset)
        ]
        Alamofire.request(.GET, urlStr, parameters: params).responseJSON { response in
            guard let obj = response.result.value else {
                return
            }
            let json = JSON(obj)
            
            cb(json)
        }
    }
}

