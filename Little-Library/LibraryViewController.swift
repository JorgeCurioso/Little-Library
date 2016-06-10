//
//  LibraryViewController.swift
//  Little-Library
//
//  Created by GLR on 6/9/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    
}





extension LibraryViewController: UITableViewDataSource  {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("libraryCell", forIndexPath: indexPath)

        cell.textLabel!.text = "a book goes here"
        
        return cell
    }
}

