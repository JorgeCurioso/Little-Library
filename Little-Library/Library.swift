//
//  Library.swift
//  Little-Library
//
//  Created by GLR on 6/25/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import Foundation

class Library   {
    
    var books = [Book]()
    var name = String()
    
    static let sharedInstance = Library()
    private init(){}
    
    
    func addBook(bookToAdd: Book)   {
        books.append(bookToAdd)
        print("just added \(bookToAdd.title) to library")
    }
    
    func deleteBook(bookToRemove: Book)   {
        for i in 0..<books.count  {
            if books[i].title == bookToRemove.title {
                books.removeAtIndex(i)
            }
        }
    }
    
    func checkOutBook(bookToCheckOut: Book, name: String?, contact: String?) {
        bookToCheckOut.isCheckedOut = true
        
        bookToCheckOut.borrowerName = name
        bookToCheckOut.borrowerContactInfo = contact
        
    }
    
    func returnBook(bookToReturn: Book, note: String?) {
        bookToReturn.isCheckedOut = false
    }
    
    init(name: String)  {
        self.name = name
        print("just created library named: \(name)")
    }
    
    
}