//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Luis Yoshida on 5/12/15.
//  Copyright (c) 2015 Msen. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
    
}