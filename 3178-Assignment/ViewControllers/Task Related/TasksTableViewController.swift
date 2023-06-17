//
//  TasksTableViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class TasksTableViewController: UITableViewController, DatabaseListener, TaskCellDelegate, NewDeadlineDelegate {
   
    weak var databaseController: DatabaseProtocol?
    var todoList:[ToDo] = []
    var listenerType = ListenerType.todo
    var rowHeight = 100
    var cellRow: Int = 0

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
        let todo = todoList[row]
        let name = todo.name
        let alertController = UIAlertController(title: "Complete: \(name ?? "")", message: "Would you like to mark this task as completed?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Yes!", style: .default, handler: { (action: UIAlertAction!) in
            self.todoRemove(row: row)
            result = true
        }))
        alertController.addAction(UIAlertAction(title: "No!", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        return result
    }
    
    func todoProgress(row: Int, progress: Float) {
        let todo = todoList[row]
        databaseController?.updateProgress(todo: todo, progress: progress)
        //TODO: DOES THIS ACTUALLY UPDATE? IM NOT 100% SURE T-T
    }
    
    func todoRemove(row: Int) {
        //todo: implement
        let todo = todoList[row]
        todoList.remove(at: row)
        databaseController?.deleteTodo(todo: todo)
        databaseController?.removeListener(listener: self)
        databaseController?.addListener(listener: self)
    }
    
    func deadlineChange() {
        performSegue(withIdentifier: "updateDeadline", sender: Any?.self)
    }
    
    
    func newDeadline(deadline: Date, row: Int) {
        let todo = todoList[row]
        databaseController?.updateDeadline(todo: todo, deadline: deadline)
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
        //cell.subjectLabel.text = "^-^" //TODO: remove this part of cell.
        cell.taskLabel.text = (todo.name)
        cell.delegate = self
        //cell.selectionStyle = UITableViewCellSelectionStyleNone
        
        //button:
        let calendar = Calendar.current
        var deadline: String = ""
        let date = todo.deadline
        let myDate = calendar.startOfDay(for: date ?? Date())
        
        //this gets a string format of the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        let dateString = dateFormatter.string(from: date ?? Date())
        
        
        if calendar.isDateInToday(myDate){
            deadline = "Today"
            cell.deadlineButton.tintColor = UIColor(named: "DefaultOrange")
        }else if calendar.isDateInTomorrow(myDate){
            deadline = "Tomorrow"
            cell.deadlineButton.tintColor = UIColor(named: "DefaultYellow")
        }else if date?.compare(Date()) == .orderedAscending{
            deadline = dateString
            cell.deadlineButton.tintColor = UIColor(named: "DefaultRed")
        }else{
            deadline = dateString
            cell.deadlineButton.tintColor = UIColor(named: "DefaultGreen")
        }

        cell.deadlineButton.setTitle(deadline, for: .normal)
        cell.deadlineButton.addTarget(cell, action: #selector(cell.buttonClicked(_:)), for: .touchUpInside)
        //progress slider:
        
        cell.completionSlider.minimumValue = 0
        cell.completionSlider.maximumValue = 100
        cell.completionSlider.value = todo.progress
        cell.sliderColourChange(sliderValue: todo.progress)
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
            databaseController?.removeListener(listener: self)
            databaseController?.addListener(listener: self)
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

    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let point = sender.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: point) {
                    let cell = tableView.cellForRow(at: indexPath) as! TaskCell
                    //cell.highlightCell()
                let alertController = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete \(cell.taskLabel.text ?? "this task")?", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in
                        let row = indexPath.row
                        self.databaseController?.deleteTodo(todo: self.todoList[row])
                        self.tableView.reloadData()
                    }))
                    alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    //cell.isHighlighted = false
                    //cell.unhighlightCell()
                }
            
            }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "updateDeadline"{
            guard let destination = segue.destination as? NewDeadlineViewController else {
                //cry T-T
                fatalError("Segue Issue!")
            }
            let todo = todoList[cellRow]
            destination.row = cellRow
            destination.originalDate = todo.deadline ?? Date()
            destination.delegate = self
        }
    }
    

}
