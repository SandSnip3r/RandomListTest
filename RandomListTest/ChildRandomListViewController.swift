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
        static let GoToCreateListItem = "GoToCreateListItem"
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    var list: RandomList!
    var listItems: [RandomListItem] {
        get {
            if var arrOfItems = list.listItems!.allObjects as? [RandomListItem] {
                arrOfItems.sort {
                    return $0.num < $1.num
                }
                return arrOfItems
            } else {
                return []
            }
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func shuffleClicked(_ sender: UIButton) {
        for i in 0..<listItems.count {
            //Pick a random list item >=i to go here
            let newPos = Int(arc4random_uniform(UInt32(listItems.count-i)))
            if (newPos != i) {
                //Swap i and newPos
                swap(&listItems[i].num, &listItems[newPos].num)
            }
        }
        appDelegate.saveContext()
        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
    }
    
    @IBAction func titleTextFieldChanged(_ sender: UITextField) {
        self.title = sender.text
        list.title = sender.text
        appDelegate.saveContext()
    }
    
    // MARK: - Misc
    func swapListItems(smallerIndex pos1: Int, largerIndex pos2: Int) {
        //TODO: Revisit
        var path1 = IndexPath(row: pos1, section: 0)
        let path2 = IndexPath(row: pos2, section: 0)
        self.tableView.reloadRows(at: [path1], with: .none)
        self.tableView.reloadRows(at: [path2], with: .none)
//        tableView.moveRow(at: path2, to: path1)
//        path1.row = path1.row+1
//        tableView.moveRow(at: path1, to: path2)
//        tableView.reloadRows(at: [path1], with: .none)
//        tableView.reloadRows(at: [path2], with: .none)
        CATransaction.begin()
        tableView.beginUpdates()
        CATransaction.setCompletionBlock { () -> Void in
        }
        tableView.moveRow(at: path2, to: path1)
        path1.row = path1.row+1
        tableView.moveRow(at: path1, to: path2)
        tableView.endUpdates()
        CATransaction.commit()
    }

    // MARK: - Navigation
    
    @IBAction func listItemSaved(unwindSegue: UIStoryboardSegue) {
        if let source = unwindSegue.source as? SingleListItemViewController {
            if source.randomListItem != nil {
                //Item exists, save it
                appDelegate.saveContext()
                print("Need to reload data, just saved")
                tableView.reloadData()
            }
        }
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
    
    @IBAction func listItemDeleted(unwindSegue: UIStoryboardSegue) {
        print("Deleted a list item")
        if let source = unwindSegue.source as? SingleListItemViewController {
            //Shift all numbers down of ones greater
            let deletedNum = Int(source.num)
            for i in deletedNum..<listItems.count {
                listItems[i].num = listItems[i].num-1
            }
        }
        appDelegate.saveContext()
        tableView.reloadData()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination.contentViewController as? SingleListItemViewController {
            destination.list = list
            if segue.identifier == Identifiers.GoToEditListItem {
                if let cell = sender as? UITableViewCell {
                    if let indexPath = tableView.indexPath(for: cell) {
                        destination.randomListItem = listItems[indexPath.row]
                    }
                }
            } else if segue.identifier == Identifiers.GoToCreateListItem {
                destination.num = listItems.count+1
            }
        }
    }

}
