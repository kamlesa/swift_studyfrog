//
//  ClassesTableViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit
import EventKit

class ClassesTableViewController: UITableViewController {
    
    
    let CELL_INFO = "dayCell"
    let CELL_ITEM = "itemCell"
    let CELL_EMPTY = "noClassCell"
    
    let SECTION_INFO = 0
    let SECTION_ITEM = 1
    
    var daysAhead = 3
    weak var databaseController: DatabaseProtocol?
    weak var eventStore: EKEventStore?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
        eventStore = appDelegate?.store
    }

    @IBAction func newClass(_ sender: Any) {
        performSegue(withIdentifier: "newClass", sender: Any?.self)
    }
    
    @IBAction func authCalendar(_ sender: Any) {
        Task{
            _ = try await requestAccess(to: .event)
        }
    }
    
    func requestAccess(to entityType: EKEntityType) async throws -> Bool{
//          TODO: SET UP ACCESS REQUEST ^-^
//        let status = eventStore.authorizationStatus(for: .event)
//
//        switch (status) {
//        case EKAuthorizationStatus.notDetermined:
//                  // This happens on first-run
//                //requestAccessToCalendar()
//
//        case EKAuthorizationStatus.authorized:
//                   // Things are in line with being able to show the calendars in the table view
//                //loadCalendars()
//                //   refreshTableView()
//            tableView.reloadData()
//        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
//                   // We need to help them give us permission
//               // needPermissionView.fadeIn()
//            await eventStore?.requestAccess(to: .event)
//        }
//
//        eventStore?.requestAccess(to: EKEntityType.event){
//            granted, error in //?
//        }
        return false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2*daysAhead
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let sectionType = section%2
        switch sectionType {
        case SECTION_INFO:
            return 1
        case SECTION_ITEM:
            return 2
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section%2
        if section == SECTION_INFO{
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_INFO, for: indexPath)
            return cell
        }else {//if section == SECTION_ITEM{
            var cell = tableView.dequeueReusableCell(withIdentifier: CELL_ITEM, for: indexPath)
            return cell
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        if section == SECTION_INFO{
            return 50
        }
        return 70
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
