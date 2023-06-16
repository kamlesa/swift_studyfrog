//
//  EditSubjectViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

class EditSubjectViewController: UIViewController {

    
    
    @IBOutlet weak var codeField: UITextField!
    var originalCode: String = ""
    @IBOutlet weak var nameField: UITextField!
    var originalName: String = ""
    @IBOutlet weak var gradeField: UITextField!
    var originalGrade: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        codeField.text = originalCode
        nameField.text = originalName
        gradeField.text = String(originalGrade)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func editSubject(_ sender: Any) {
        
        
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
