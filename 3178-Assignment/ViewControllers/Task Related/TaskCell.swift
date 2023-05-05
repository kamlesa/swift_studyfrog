//
//  TaskCell.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var completionSlider: UISlider!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        completionSlider.minimumValue = 0
        completionSlider.maximumValue = 100
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sliderChange(_ sender: Any) {
        if completionSlider.value >= 100{
            //COMPLETE!
            //TODO: implement this!
            completionSlider.tintColor = UIColor(named:"DefaultRed")
        }
        if completionSlider.value < 30{
            //change colour
            completionSlider.tintColor = UIColor(named:"DefaultYellow")
        }else if completionSlider.value < 60{
            completionSlider.tintColor = UIColor(named:"DefaultOrange")
        }else if completionSlider.value < 98{
            completionSlider.tintColor = UIColor(named:"DefaultGreen")
        }
    }
    
}
