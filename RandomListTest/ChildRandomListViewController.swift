//
//  ChildRandomListViewController.swift
//  RandomListTest
//
//  Created by Victor Stone on 1/30/17.
//  Copyright © 2017 Victor Stone. All rights reserved.
//

import CoreData
import UIKit

class ChildRandomListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Identifiers {
        static let RandomListItemCell = "RandomListItemCell"
        static let GoToEditListItem = "GoToEditListItem"
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    var list: RandomList!
    private var _listItems: [RandomListItem]?
    var listItems: [RandomListItem] {
        get {
            if _listItems == nil {
                _listItems = list.listItems!.allObjects as! [RandomListItem]
                _listItems!.sort {
                    return $0.num < $1.num
                }
            }
            return _listItems!
        }
    }
    var create = false
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if list == nil {
            //Creating a new list
            create = true
            list = RandomList(context: managedObjectContext)
        }
        
        titleTextField.text = list.title
        self.title = list.title
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.RandomListItemCell , for: indexPath)
        if let specificCell = cell as? ChildRandomListTableViewCell {
            let thisItem = listItems[indexPath.row]
            specificCell.configure(item: thisItem)
            return specificCell
        }
        
        return cell
    }
    
    // MARK: - Actions
    @IBAction func titleTextFieldChanged(_ sender: UITextField) {
        self.title = sender.text
    }

    // MARK: - Navigation
    
    @IBAction func listItemSaved(unwindSegue: UIStoryboardSegue) {
        print("List item was saved")
        /*if randomListItem == nil {
            print("RandomListItem == nil")
            randomListItem = RandomListItem(context: managedObjectContext)
        } else {
            print("RandomListItem exists")
        }
        
        randomListItem!.name = listItemNameTextField.text
        if list != nil {
            if list.listItems != nil {
                let items = list.listItems!
                print(items.allObjects)
            } else {
                print("No list items")
            }
        } else {
            print("No list")
        }
        randomListItem!.num = Int32(list.listItems!.allObjects.count)
        randomListItem!.list = list
        
        appDelegate.saveContext()*/
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.GoToEditListItem {
            if let destination = segue.destination as? SingleListItemViewController {
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPath(for: cell) {
                        destination.list = list
                        destination.randomListItem = listItems[indexPath.row]
                    }
                }
            }
        }
    }

}
