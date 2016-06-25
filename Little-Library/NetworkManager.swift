//
//  NetworkManager.swift
//  Little-Library
//
//  Created by GLR on 6/25/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire


class NetworkManager  {
    
    var alamofireManager:Alamofire.Manager
    var library = Library.sharedInstance
    
    
    init()  {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        alamofireManager = Alamofire.Manager(configuration: configuration)
    }
    
    
    
    func searchBooks(title: String?, author: String?, keyword: String?, completionHandler: ([Book?] -> Void)) {
        alamofireManager.request(Router.SearchBooks(title: title, author: author, keyword: keyword)).responseJSON { (response) in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error making network call")
                print(response.result.error?.description)
                return
            }
            
            print("RESPONSE::\n\n\(response.response)\n\n")
            print("RESPONSE RESULT::\n\n\(response.result.value)")
            
            
            if let value = response.result.value {
                let allData = SwiftyJSON.JSON(value)
                
                var booksToPeruse = [Book?]()
                
                if let docs = allData["docs"].array  {
                    for eachDoc in docs {
                        if let title = eachDoc["title_suggest"].string,
                            authorName = eachDoc["author_name"][0].string  {
                            
                            let searchBook = Book(title: title, author: authorName)
                            
                            guard let coverCode = eachDoc["cover_i"].int else {
                                print("we failed to grab the cover code")
                                continue
                            }
                            
                            let coverURLString = Router.baseCoverURLString + "\(coverCode)" + "-M.jpg"
                            
                            searchBook.imageUrl = NSURL(string: coverURLString)
                            
                            print(searchBook.imageUrl)
                            booksToPeruse.append((searchBook))
                        }
                    }
                }
                completionHandler(booksToPeruse)
            }
            
        }
    }
    
    
    
    func getBookByISBN(barCode: String, completionHandler: Book? -> Void)  {
        alamofireManager.request(Router.ByISBN(isbn: barCode)).responseJSON(completionHandler: { (response) in
            
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("error making network call")
                print(response.result.error?.description)
                return
            }
            
            
            if let value = response.result.value {
                
                let allData = SwiftyJSON.JSON(value)
                let isbn = allData["ISBN:\(barCode)"]
                
                guard let authorName = isbn["authors"][0]["name"].string,
                    let title = isbn["title"].string else  {
                        print("No book info?")
                        return
                }
                
                let book: Book? = Book(title: title, author: authorName)
                
                //grabbing image...
                if let cover = isbn["cover"]["medium"].string   {
                    if let thumbnailUrl = NSURL(string: "\(cover)") {
                        if let imageData = NSData(contentsOfURL: thumbnailUrl)    {
                            book!.image = UIImage(data: imageData)
                        }
                    } else  {
                        book!.image = UIImage(named: "coverNotAvailable")
                    }
                } else  {
                    book!.image = UIImage(named: "coverNotAvailable")
                }
                
                completionHandler(book)
                
            }
        })
    }
    
    
    
}