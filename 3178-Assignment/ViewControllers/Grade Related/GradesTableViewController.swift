//
//  GradesTableViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class GradesTableViewController: UITableViewController, DatabaseListener {

    weak var databaseController: FirebaseProtocol?
    var listenerType = ListenerType.subject
    var subjectList:[Subject] = []
    var selectedSubject:Subject = Subject()
    var subjectIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.firebaseController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    //MARK: - Database Listener
    
    func onToDoChange(change: DatabaseChange, todos: [ToDo]) {
        //do nothing
    }
    
    func onSubjectChange(change: DatabaseChange, subjects: [Subject]) {
        //todo: implement
        subjectList = subjects
        tableView.reloadData()
    }
    
    func onAllAssessmentsChange(change: DatabaseChange, assessments: [Assessment]) {
        //do nothing
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return subjectList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classGreenCell", for: indexPath)

        // Configure the cell...
        var content = cell.defaultContentConfiguration()
        var subject = subjectList[indexPath.row]
        let subjectCode = subject.code//"still need to implement multiple subjects you goof" //subjectList[indexPath.row].code
        let grade = "\(subject.current_grade ?? 0)%"
        content.text = subjectCode
        content.secondaryText = grade
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSubject = subjectList[indexPath.row] //subjectList[indexPath.row].code ?? "FAIL"
        subjectIndex = indexPath.row
        performSegue(withIdentifier: "subjectDetails", sender: Any?.self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //let subject = subjectList[indexPath.row]
            //databaseController?.deleteSubject(subject: subject)
            //tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "subjectDetails"{
            guard let destination = segue.destination as? SubjectCollectionViewController else{
                //cry T-T
                fatalError("Segue Issue!")
            }
            //Do stuff to do with database!
            //TODO: convert this to a persistent data type!
            destination.selectedSubject = selectedSubject
            destination.subjectIndex = subjectIndex
        } 
    }
    

}
