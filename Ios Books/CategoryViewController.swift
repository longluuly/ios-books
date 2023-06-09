//
//  CategoryViewController.swift
//  Ios Books
//
//  Created by hieu on 5/11/23.
//  Copyright © 2023 Long. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate
{
    
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!

//    let categorysRef = Firestore.firestore().collection("categories")
    let service = FireBaseServices()
    private var categoryBook = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        getCategorys()
    }
    
    
    //
    func getCategorys(){
//        let query = self.categorysRef
//            .order(by: "created", descending: true)
//        loadDataFromFirebaseToCategories(query: query)
        self.service.loadDataFromFirebaseToCategories { (data: [Category]) in
            self.categoryBook = data
            self.tableView.reloadData()
        }
    }
    
    
//    func loadDataFromFirebaseToCategories (query: Query) {
//        query.getDocuments { (snapshot, error) in
//            guard let snapshot = snapshot else {
//                print("Error fetching documents: \(error!)")
//                return
//            }
//            //            print("da lieu la \(String(describing: snapshot.documents.last?.data()["name"]))")
//
//            // lay du lieu sach ra
//            for document in snapshot.documents {
//                let data = document.data()
//
//                guard
//                    let name = data["name"] as? String,
//                    let photo = data["photo"] as? String
//
//                    else {
//                        continue
//                }
//
//                let newCategory = Category(
//                    categoryId: document.documentID,
//                    name: name,
//                    photo: photo)
//
//
//                if let newCategory = newCategory {
//                    // them du lieu vao mang sach
//                    self.categoryBook.append(newCategory)
//                    // load lai view khi co du lieu
//                    self.tableView.reloadData()
//
//                }
//
////                print("Da vo day")
//            }
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseCell = "Tableviewcell"
        if  let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? TableViewCell{
            
            //lay du lieu category
            
            let cate = categoryBook[indexPath.row]
            cell.lblCategory.text = cate.getName()
            cell.setData(category: cate)
            
            return cell
        }
        fatalError("ko the cell")
        
    }
    
    
    // MARK: An thanh dieu huong o man hinh dau tien
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "categoryDetail", sender: indexPath)
    }
    
    
    
    
    // MARK: - Navigation
    
    //  In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("Chuyen man hinh")
        
        let backItem = UIBarButtonItem()
        backItem.title = "Danh mục"
        navigationItem.backBarButtonItem = backItem
        
        
        if let destination = segue.destination as? CategoryDetailController{
            if let selecteđIndexPath = tableView.indexPathForSelectedRow{
                destination.category = categoryBook[selecteđIndexPath.row]
                
            }
        }
    }
}
