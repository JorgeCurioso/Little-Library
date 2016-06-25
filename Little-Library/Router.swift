//
//  Router.swift
//  Little-Library
//
//  Created by GLR on 6/25/16.
//  Copyright © 2016 GLR. All rights reserved.
//


import Foundation
import Alamofire

enum Router: URLRequestConvertible  {
    
    static let baseURLString = "http://openlibrary.org"
    static let baseCoverURLString = "http://covers.openlibrary.org/b/id/"
    
    case FromBarcode(barCode: String)
    case ByISBN(isbn: String)
    case SearchBooks(title: String?, author: String?, keyword: String?)
    
    var URLRequest: NSMutableURLRequest {
        
        var method: Alamofire.Method = .GET
        
        var addOn: (path: String, params: [String:AnyObject]?)  {
            switch self {
            case .FromBarcode(let barCode):
                return ("/api/books?", ["bib_keys":"ISBN:\(barCode)", "jscmd":"data", "format":"json"])
            case .ByISBN(let isbn):
                return ("/api/books?", ["bibkeys":"ISBN:\(isbn)", "jscmd":"data", "format":"json"])
                
            case .SearchBooks(let searchTitle, let searchAuthor, let searchKeyword):
                var parameters: [String: AnyObject]?
                
                if searchTitle == nil || (searchTitle?.isEmpty)! {
                    print("searchTitle was nil or empty")
                } else {
                    parameters = ["title" : searchTitle!]
                    print(parameters?.description)
                }
                
                if searchAuthor == nil || (searchAuthor?.isEmpty)! {
                    print("searchAuthor was nil or empty")
                } else {
                    if parameters == nil {
                        parameters = ["author": searchAuthor!]
                    } else {
                        parameters?.updateValue(searchAuthor!, forKey: "author")
                    }
                    print(parameters?.description)
                }
                
                if searchKeyword == nil || (searchKeyword?.isEmpty)! {
                    print("searchKeyword was nil or empty")
                } else {
                    if parameters == nil {
                        parameters = ["q": searchKeyword!]
                    } else {
                        parameters?.updateValue(searchKeyword!, forKey: "q")
                    }
                }
                
                
                let searchPath = "/search.json?"
                print("here's what i'm about to return\n\n\(searchPath, parameters)")
                
                return (searchPath, parameters)
            }
        }
        
        
        var url: (NSURL) {
            switch self {
                
            case .FromBarcode( _):
                let base = NSURL(string: Router.baseURLString)!
                return NSURL(string: addOn.path, relativeToURL: base)!
                
            case .ByISBN( _):
                let base = NSURL(string: Router.baseURLString)!
                return NSURL(string: addOn.path, relativeToURL: base)!
                
            case .SearchBooks( _):
                let base =  NSURL(string: Router.baseURLString)!
                return NSURL(string: addOn.path, relativeToURL: base)!
                
            }
        }
        
        let URLRequest = NSMutableURLRequest(URL: url)
        
        print("URL REQUEST: \n\n, \(URLRequest)")
        
        
        let encoding = Alamofire.ParameterEncoding.URL
        
        let (encodedRequest, _) = encoding.encode(URLRequest, parameters: addOn.params)
        encodedRequest.HTTPMethod = method.rawValue
        
        print("ENCODED REQUEST: \n\n, \(encodedRequest)")
        
        return encodedRequest
        
    }
    
    
}