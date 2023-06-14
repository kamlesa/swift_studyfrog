//
//  NewSubjectViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class NewSubjectViewController: UIViewController, ColourChangeDelgate {
    func changedToColour(_ colour: UIColor) {
        subjectColourView.backgroundColor = colour
    }
    
    
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
        if code == nil || code == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Code")
            return
        }
        if name == nil || name == "" {
            displayMessage(title: "Error", message: "Please Enter A Subject Name")
            return
        }
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
            
            guard case let colour = subjectColourView.backgroundColor?.cgColor else {
                print("NOTHING!")
                return
            }
            //print(colour)
            destination.initialColour = colour
        }
    }
    

}
