//
//  EditSubjectViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class EditSubjectViewController: UIViewController {

    
    weak var databaseController: FirebaseProtocol?

    @IBOutlet weak var codeField: UITextField!
    var originalCode: String = ""
    @IBOutlet weak var nameField: UITextField!
    var originalName: String = ""
    @IBOutlet weak var gradeField: UITextField!
    var originalGrade: Int = 0
    var subject: Subject = Subject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeField.text = originalCode
        nameField.text = originalName
        gradeField.text = String(originalGrade)
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.firebaseController
    }
    
    @IBAction func editSubject(_ sender: Any) {
        let code = codeField.text
        let name = nameField.text
        let goalGrade = Int(gradeField.text ?? "0")
        if code == nil || code == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Code")
            return
        }
        databaseController?.updateSubject(subject: subject, fieldName: "code", newValue: code)
        subject.code = code
        if name == nil || name == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Name")
            return
        }
        subject.name = name
        subject.goal_grade = goalGrade
        databaseController?.updateSubject(subject: subject, fieldName: "name", newValue: name)
        databaseController?.updateSubject(subject: subject, fieldName: "goal_grade", newValue: goalGrade)
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

}
