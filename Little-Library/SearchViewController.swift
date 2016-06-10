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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func clearTextFields()  {
        titleTextField!.text = ""
        authorTextField!.text = ""
        keywordTextField!.text = ""
        ISBNTextField!.text = ""
    }
}


extension SearchViewController: UITableViewDataSource   {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("searchResultCell", forIndexPath: indexPath)
        cell.textLabel!.text = "Search results go here"
        
        return cell
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
