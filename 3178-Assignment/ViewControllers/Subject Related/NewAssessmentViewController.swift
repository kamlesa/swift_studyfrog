//
//  NewAssessmentViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class NewAssessmentViewController: UIViewController {

    @IBOutlet weak var worthField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    weak var databaseController: FirebaseProtocol?
    var subject:Subject = Subject()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.firebaseController
        // Do any additional setup after loading the view.
    }
    

    @IBAction func addAssessmnet(_ sender: Any) {
        
        let name = nameField.text
        let worth = Int(worthField.text ?? "0")
        if name == nil || name == "" {
            displayMessage(title: "Error", message: "Please Enter A Name For the Assessment")
            return
        }
        
        let a = databaseController?.addAssessment(name: name!, worth: worth!)
        _ = databaseController?.addAssessmentToSubject(assessment: a!, subject: subject)
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
