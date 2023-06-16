//
//  NewSubjectViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class NewSubjectViewController: UIViewController, ColourChangeDelgate, UITextFieldDelegate {
    func changedToColour(_ colour: UIColor) {
        subjectColourView.backgroundColor = colour
    }
    
    
    weak var databaseController: FirebaseProtocol?
    @IBOutlet weak var subjectCodeField: UITextField!
    
    @IBOutlet weak var subjectColour: UISegmentedControl!
    @IBOutlet weak var goalGradeField: UITextField!
    @IBOutlet weak var subjectNameField: UITextField!
    
    @IBOutlet weak var subjectColourView: UIView!



    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.firebaseController
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)

        subjectCodeField.delegate = self
        goalGradeField.delegate = self
        subjectNameField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //if textField ==
        textField.resignFirstResponder()
        return true
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func subjectColourChange(_ sender: Any) {
        //TODO: setup
        var colourName = subjectColour.titleForSegment(at: subjectColour.selectedSegmentIndex) ?? ""
        var defaultText = "Default"
        if colourName == "Custom"{
            performSegue(withIdentifier: "customColour", sender: sender)
        }else{
            defaultText = defaultText.appending(colourName)
            //colourName = colourName.appending("Colour")
            subjectColourView.backgroundColor = UIColor(named: defaultText)
        }
    }
    
    @IBAction func addClass(_ sender: Any) {
        let code = subjectCodeField.text
        let name = subjectNameField.text
        let goalGrade = Int(goalGradeField.text ?? "0")
        if code == nil || code == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Code")
            return
        }
        if name == nil || name == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Name")
            return
        }
        _ = databaseController?.addSubject(name: name!, code: code!, goal_grade: goalGrade!)
       // _ = databaseController?.addSubject(name: name!, code: code!)
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "customColour"{
            let destination = segue.destination as! ColourViewController
            destination.delegate = self
            
            guard let colour = subjectColourView.backgroundColor?.cgColor else {
                //print("NOTHING!")
                return
            }
            //print(colour)
            destination.initialColour = colour
        }
    }
    

}
