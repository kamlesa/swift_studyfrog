//
//  TasksTableViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class TasksTableViewController: UITableViewController, DatabaseListener, TaskCellDelegate {

    

    
    
    weak var databaseController: DatabaseProtocol?
    var todoList:[ToDo] = []
    var listenerType = ListenerType.todo
    var rowHeight = 100

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
        tableView.allowsSelection = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.cleanup()
        databaseController?.removeListener(listener: self)
    }
    
    //MARK: - Database Listener
    
    func onToDoChange(change: DatabaseChange, todos: [ToDo]) {
        todoList = todos
        tableView.reloadData()
    }
    func onSubjectChange(change: DatabaseChange, subjects: [Subject]) {
        //do nothing
    }
    
    func onAllAssessmentsChange(change: DatabaseChange, assessments: [Assessment]) {
        //do nothing
    }
    
    // MARK: - Task Cell Delegate Functions
    
    func todoComplete(row: Int) -> Bool {
        var result = false
        var todo = todoList[row]
        let name = todo.name
        let alertController = UIAlertController(title: "Have you completed this Task?", message: "Task Info: \(name ?? "")", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes!", style: .default, handler: { (action: UIAlertAction!) in
            result = true
        }))
        alertController.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
        /*
         
         = UIAlertController(title: title, message: message, preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
         self.present(alertController, animated: true, completion: nil)
         */
        self.present(alertController, animated: true, completion: nil)
        return result
    }
    
    func todoProgress(row: Int, progress: Float) {
        var todo = todoList[row]
        databaseController?.updateProgress(todo: todo, progress: progress)
        //TODO: DOES THIS ACTUALLY UPDATE? IM NOT 100% SURE T-T
    }
    
    func todoRemove(row: Int) {
        //todo: implement
        let todo = todoList[row]
        todoList.remove(at: row)
        databaseController?.deleteTodo(todo: todo)
    }
    
    func deadlineChange() {
        performSegue(withIdentifier: "updateDeadline", sender: Any?.self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoList.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        let todo = todoList[indexPath.row]
        // Configure the cell...
        //var content = cell.defaultContentConfiguration()
        cell.subjectLabel.text = "Subject -_-" //TODO: remove this part of cell.
        cell.taskLabel.text = (todo.name)
        //cell.selectionStyle = UITableViewCellSelectionStyleNone
        
        //button:
        //cell.deadlineButton.setTitle("Test", for: .normal)
        //cell.deadlineButton.backgroundColor = UIColor(named:"DefaultGreen")
        
        //progress slider:
        cell.completionSlider.value = todo.progress
        cell.completionSlider.minimumValue = 0
        cell.completionSlider.maximumValue = 100
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let todo = todoList[indexPath.row]
            databaseController?.deleteTodo(todo: todo)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
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
    }
    

}
