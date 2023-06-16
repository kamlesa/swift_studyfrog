//
//  NewDeadlineViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

protocol NewDeadlineDelegate {
    func newDeadline(deadline: Date, row: Int)
}

class NewDeadlineViewController: UIViewController {
    
    var originalDate: Date = Date()
    var row: Int = 0
    @IBOutlet weak var datePicker: UIDatePicker!
    var delegate: NewDeadlineDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //datePicker.date = Date()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateDeadline(_ sender: Any) {
        let d = datePicker.date
        delegate?.newDeadline(deadline: d, row: row)
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
