//
//  AddNewTaskViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/3/2023.
//

import UIKit

class AddNewTaskViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    
    
    @IBOutlet weak var taskDeadlinePicker: UIDatePicker!
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskSubjectPicker: UIPickerView!
    var pickerData: [String] = [String]()
    weak var databaseController: DatabaseProtocol?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
        taskSubjectPicker.dataSource = self
        taskSubjectPicker.delegate = self
        
        pickerData = ["3178", "3159", "2004", "General"]
        
    }
    
    @IBAction func addTask(_ sender: Any) {
        guard let name = taskName.text else{
            displayMessage(title: "Eror", message: "Please Enter a Task Name")
            return
        }
        if name == ""{
            displayMessage(title: "Eror", message: "Please Enter a Task Name")
            return
        }
        let subject = (databaseController?.addSubject(name: "POOP", code: "FIT2002"))!
        
        databaseController?.addTask(name: name, subject: subject)
        _ = navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
        
        // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pickerData.count
    }
        
        // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return pickerData[row]
    }
    
    

}
