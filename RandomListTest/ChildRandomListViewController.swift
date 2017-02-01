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
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    var list: RandomList!
    var create = false
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.RandomListItemCell, for: indexPath) as? ChildRandomListTableViewCell {
            if let listItems = list.listItems {
                if let randomListItems = listItems.allObjects as? [RandomListItem] {
                    let randomListItem = randomListItems[indexPath.row]
                    cell.configure(item: randomListItem)
                    return cell
                }
            }
        }
        print("tableView::cellForRowAt, we should never get here")
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let listItems = list.listItems {
            return listItems.allObjects.count
        } else {
            print("tableView::numberOfRowsInSection, we should never get here")
            return 0
        }
    }
    
    // MARK: - Actions
    @IBAction func titleTextFieldChanged(_ sender: UITextField) {
        self.title = sender.text
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
