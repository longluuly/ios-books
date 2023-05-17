//
//  AboutViewController.swift
//  Ios Books
//
//  Created by Long on 5/13/23.
//  Copyright © 2023 Long. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var bookAbout: UITextView!
    @IBOutlet weak var btnReadBook: UIButton!
    var book: Book!
    let segueReadBookViewIdentifier: String = "AboutToReadBook"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // load du lieu sach len man hinh
        if let book = book {
            //            print("ten sach la: \(book.getName())")
            bookImage.getImageFromCach(imageName: book.getPhoto(), uiImage: bookImage)
            bookLabel.text = book.getName()
            bookAbout.text = book.getAbout()
        }
        
        btnReadBook.layer.cornerRadius = 8
    }
    
    // Nhan vao nut doc sach chuyen sang man hinh doc sach
    @IBAction func readBookTap(_ sender: UIButton) {
        performSegue(withIdentifier: segueReadBookViewIdentifier, sender: nil)
    }
    
    // MARK: - Navigation
    
    // Thay doi noi dung nut back o man hinh tiep theo
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Trở về"
        navigationItem.backBarButtonItem = backItem
        
        // Lay Destination
        if let destination = segue.destination as? ReadBookViewController {
            destination.book = book
            destination.page = 1
        }
    }
    
}