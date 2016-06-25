//
//  LibraryViewController.swift
//  Little-Library
//
//  Created by GLR on 6/9/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import UIKit
import PINRemoteImage

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    private var library = Library.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        libraryTableView.reloadData()
    }
    
}





extension LibraryViewController: UITableViewDataSource  {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.books.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: "libraryCell")
        let book = library.books[indexPath.row]
        
        cell.textLabel!.text = book.title
        cell.detailTextLabel?.text = book.author
        cell.imageView?.pin_setImageFromURL(book.imageUrl,
                                            placeholderImage: UIImage(named: "coverNotAvailable.jpeg"))
        
        return cell
        

    }
}

