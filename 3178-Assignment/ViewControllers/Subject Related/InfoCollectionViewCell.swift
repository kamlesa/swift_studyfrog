//
//  InfoCollectionViewCell.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 15/6/2023.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    var subject: Subject = Subject()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var goalGradeLabel: UILabel!
    @IBOutlet weak var maxGradeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //let subject = delegate?.selectedSubject
        nameLabel.text = subject.name
        nameLabel.textAlignment = .left
        goalGradeLabel.textAlignment = .right
        gradeLabel.text = "\(subject.current_grade ?? 0)%"
        goalGradeLabel.text = "Goal Grade: \(subject.goal_grade ?? 90)%"
        maxGradeLabel.text = "Max Grade: \(subject.max_grade ?? 100)%"
    }
    
    
}
