//
//  SingleListItemViewController.swift
//  RandomListTest
//
//  Created by Victor Stone on 2/1/17.
//  Copyright © 2017 Victor Stone. All rights reserved.
//

import CoreData
import UIKit

class SingleListItemViewController: UIViewController {
    
    private struct Identifiers {
        static let DeleteUnwindSegue = "Delete Unwind Segue"
    }
    
    var list: RandomList!
    var randomListItem: RandomListItem!
    var creating = false
    var num: Int32=0
    @IBOutlet weak var listItemNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("SingleListItemViewController view loaded")
        if randomListItem == nil {
            creating = true
            print("Creating new random list item")
            randomListItem = RandomListItem(context: managedObjectContext)
            randomListItem.num = num
            randomListItem.name = ""
            randomListItem.list = list
        } else {
            listItemNameTextField.text = randomListItem.name
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listItemNameTextField.becomeFirstResponder()
    }
    
    @IBAction func nameTextChanged(_ sender: UITextField) {
        randomListItem.name = sender.text
    }
    
    @IBAction func deleteClicked(_ sender: UIButton) {
        managedObjectContext.delete(randomListItem)
        performSegue(withIdentifier: Identifiers.DeleteUnwindSegue, sender: nil)
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        if (creating) {
            managedObjectContext.delete(randomListItem)
            dismiss(animated: true, completion: nil)
        } else {
            _ = navigationController?.popViewController(animated: true)
        }
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
