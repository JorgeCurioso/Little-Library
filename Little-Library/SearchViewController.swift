//
//  SearchViewController.swift
//  Little-Library
//
//  Created by GLR on 6/9/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField?
    @IBOutlet weak var authorTextField: UITextField?
    @IBOutlet weak var ISBNTextField: UITextField?
    @IBOutlet weak var keywordTextField: UITextField?
    
    @IBOutlet weak var searchResultsTableView: UITableView!
    
    private var networkManager = NetworkManager()
    private var library = Library.sharedInstance
    private var searchResults = [Book?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func clearTextFields()  {
        titleTextField!.text = ""
        authorTextField!.text = ""
        keywordTextField!.text = ""
        ISBNTextField!.text = ""
    }
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
        
        if !(ISBNTextField!.text!.isEmpty) {
            networkManager.getBookByISBN((ISBNTextField?.text)!, completionHandler: { (book) in
                self.searchResults.append(book)
                dispatch_async(dispatch_get_main_queue(), {
                    self.searchResultsTableView.reloadData()
                    self.clearTextFields()
                })
            })
        } else {
            networkManager.searchBooks(titleTextField!.text, author: authorTextField?.text, keyword: keywordTextField?.text) {
                books in
                self.searchResults = books
                dispatch_async(dispatch_get_main_queue(), {
                    self.searchResultsTableView.reloadData()
                    self.clearTextFields()
                })
            }
        }
    }
}



extension SearchViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let book = searchResults[indexPath.row] else {
            print("no search results")
            return
        }
        
        let previewAlertVC = UIAlertController(title: "Is this your book madam?", message: "\(book.title)\n\nby:\n\n\(book.author)", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Yep! Add it", style: .Default) { (action) in
            self.library.addBook(book)
        }
        
        let cancelAction = UIAlertAction(title: "nah thanks", style: .Default, handler: nil)
        
        previewAlertVC.addAction(okAction)
        previewAlertVC.addAction(cancelAction)
        
        self.presentViewController(previewAlertVC, animated: true, completion: nil)
    }
    
    
    
}

extension SearchViewController: UITableViewDataSource   {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "searchCell")
        guard let book = searchResults[indexPath.row] else {
            print("no books found")
            return cell
        }
        
        cell.textLabel!.text = book.title
        cell.detailTextLabel!.text = book.author
        cell.imageView?.pin_setImageFromURL(searchResults[indexPath.row]!.imageUrl, placeholderImage: UIImage(named: "coverNotAvailable.jpeg"))
        
        return cell
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
