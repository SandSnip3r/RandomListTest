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
    
    var list: RandomList!
    var randomListItem: RandomListItem?
    @IBOutlet weak var listItemNameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("SingleListItemViewController view loaded")
        if randomListItem != nil {
            print("randomListItem exists")
            listItemNameTextField.text = randomListItem?.name
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
