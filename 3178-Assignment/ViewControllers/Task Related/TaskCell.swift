//
//  TaskCell.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//

import UIKit

protocol TaskCellDelegate: AnyObject {
    func taskComplete(_ placeholder: String) -> Bool
    
}

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var completionSlider: UISlider!
    weak var delegate: TaskCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sliderChange(_ sender: Any) {
        if completionSlider.value < 30{
            //COMPLETE!
            //TODO: implement this!
            completionSlider.tintColor = UIColor(named:"DefaultRed")
        }
        if completionSlider.value > 30 && completionSlider.value < 60{
            //change colour
            completionSlider.tintColor = UIColor(named:"DefaultOrange")
        }else if completionSlider.value > 60 && completionSlider.value < 98 {
            completionSlider.tintColor = UIColor(named:"DefaultYellow")
        }else if completionSlider.value > 95{
            completionSlider.tintColor = UIColor(named:"DefaultGreen")
            var value = delegate?.taskComplete("Test")
            print(value)
            if !(value ?? false){
                //delete
                return
            }
            print(value)
            //delete self..?
        }
    }

    
}
