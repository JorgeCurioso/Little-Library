//
//  Book.swift
//  Little-Library
//
//  Created by GLR on 6/25/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import Foundation
import UIKit

class Book {
    
    var title = String()
    var author = String()
    var image: UIImage? = nil
    var imageUrl: NSURL?
    
    var isCheckedOut = false
    var checkoutDate: NSDate?
    var dueDate: NSDate?
    var borrowerName: String?
    var borrowerContactInfo: String?
    
    var binNumber = Int()
    
    
    init(title: String, author: String) {
        self.title = title
        self.author = author
    }
    
}