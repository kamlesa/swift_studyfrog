//
//  NewSubjectViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class NewSubjectViewController: UIViewController {
    
    weak var databaseController: DatabaseProtocol?
    @IBOutlet weak var subjectCodeField: UITextField!
    
    @IBOutlet weak var subjectColour: UISegmentedControl!
    @IBOutlet weak var goalGradeField: UITextField!
    @IBOutlet weak var subjectNameField: UITextField!
    
    @IBOutlet weak var subjectColourView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.databaseController
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func subjectColourChange(_ sender: Any) {
        //TODO: setup
    }
    
    @IBAction func addClass(_ sender: Any) {
        let code = subjectCodeField.text
        let name = subjectNameField.text
        if code == nil || code == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Code")
            return
        }
        if name == nil || name == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Name")
            return
        }
        _ = databaseController?.addSubject(name: name!, code: code!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    func displayMessage(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title:"Dismiss",style:.default,handler:nil))
        
        self.present(alertController, animated: true, completion: nil)
        
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
