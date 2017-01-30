//
//  ParentRandomListTableViewController.swift
//  RandomListTest
//
//  Created by Victor Stone on 1/30/17.
//  Copyright © 2017 Victor Stone. All rights reserved.
//

import CoreData
import UIKit

class ParentRandomListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    struct Identifiers {
        static let RandomListCell = "RandomListCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptFetch()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller?.sections {
            return sections.count
        }
        print("numberOfSections, We really shouldnt get here")
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller?.sections {
            if let objects = sections[section].objects {
                return objects.count
            }
        }
        print("tableView::numberOfRowsInSection, We really shouldnt get here")
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.RandomListCell , for: indexPath)

        configureCell(cell, at: indexPath)

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Core Data
    
    var controller: NSFetchedResultsController<RandomList>?
    
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<RandomList> = RandomList.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let localController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        localController.delegate = self
        controller = localController
        
        do {
            try controller?.performFetch()
        } catch {
            print(error)
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            if let deleteIndexPath = indexPath {
                tableView.deleteRows(at: [deleteIndexPath], with: .fade)
            }
        case .insert:
            if let insertIndexPath = indexPath {
                tableView.insertRows(at: [insertIndexPath], with: .fade)
            }
        case .move:
            if let previousIndexPath = indexPath, let currentIndexPath = newIndexPath {
                tableView.deleteRows(at: [previousIndexPath], with: .fade)
                tableView.insertRows(at: [currentIndexPath], with: .fade)
            }
        case .update:
            if let updateIndexPath = indexPath {
                if let cell = tableView.cellForRow(at: updateIndexPath) {
                    configureCell(cell, at: updateIndexPath)
                }
            }
        }
    }
    
    func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) {
        if let randomList = controller?.object(at: indexPath) {
            cell.textLabel?.text = randomList.title
            var detailStr = ""
            if let objects = randomList.listItems?.allObjects as? [RandomListItem] {
                for i in 0..<objects.count {
                    if i != 0 {
                        detailStr += ", "
                    }
                    detailStr += "\(objects[i].name!)"
                }
            }
            cell.detailTextLabel?.text = detailStr
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
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