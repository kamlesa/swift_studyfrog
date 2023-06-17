//
//  TaskCell.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//
// https://stackoverflow.com/questions/40437550/how-can-i-get-indexpath-row-in-cell-swift

import UIKit

protocol TaskCellDelegate: AnyObject {
    func todoComplete(row: Int) -> Bool //TODO: potentially update the parameters.
    func todoProgress(row: Int, progress: Float)
    func todoRemove(row: Int)
    func deadlineChange()
    var cellRow:Int {get set}
}

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var deadlineButton: UIButton!
    //@IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var completionSlider: UISlider!
    weak var delegate: TaskCellDelegate?
    var previousSliderValue: Float = 0
    var row: Int = 0
    //var originalDate: Date = Date()
    
    var buttonActionTarget: AnyObject?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        row = indexPath?.row ?? 0
        //delegate?.cellRow
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sliderChange(_ sender: Any) {
        row = indexPath?.row ?? 0
        //update the todo with the progress assigned by user =)
        let sliderValue = completionSlider.value
        delegate?.todoProgress(row: row, progress: sliderValue)
        sliderColourChange(sliderValue: sliderValue)
        if sliderValue > previousSliderValue && sliderValue > 99{
            //if the progress is 95+ we see if they want to mark the test as completed!
            _ = delegate?.todoComplete(row: indexPath?.row ?? 0)
        }
        previousSliderValue = sliderValue
    }
    
    
    func sliderColourChange(sliderValue: Float){
        
        // Example color with reduced opacity

        if sliderValue < 30{
            completionSlider.tintColor = UIColor(named:"DefaultRed")?.withAlphaComponent(0.5)
        }
        
        if sliderValue > 30 && sliderValue < 60{
            completionSlider.tintColor = UIColor(named:"DefaultOrange")?.withAlphaComponent(0.5)
            
        }else if sliderValue > 60 && completionSlider.value < 98 {
            completionSlider.tintColor = UIColor(named:"DefaultYellow")?.withAlphaComponent(0.5)
            
        }else if sliderValue > 95{
            completionSlider.tintColor = UIColor(named:"DefaultGreen")?.withAlphaComponent(0.5)
        }
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        delegate?.cellRow = indexPath?.row ?? 0
        delegate?.deadlineChange()
        //guard let viewController = viewController
        //TasksTableViewController.performSegue(withIdentifier: "updateDeadline", sender: Any?.self)
    }
    
}


//these functions are from stackoverflow!
extension UITableViewCell {
    var tableView: UITableView? {
        return self.next(of: UITableView.self)
    }

    var indexPath: IndexPath? {
        return self.tableView?.indexPath(for: self)
    }
}

extension UIResponder {
    /**
     * Returns the next responder in the responder chain cast to the given type, or
     * if nil, recurses the chain until the next responder is nil or castable.
     */
    func next<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next() })
    }
}
