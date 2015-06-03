//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Colin Fraser on 01/06/2015.
//  Copyright (c) 2015 Colin Fraser. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{

// set the two variables for the class
    
    var filePathUrl: NSURL!
    var title: String!
    
// initialiser for the variables requires a filePath of type NSURL and title of type String
    
    init(filePath: NSURL, title: String) {
        self.filePathUrl = filePath
        self.title = title
    }
    
    
}