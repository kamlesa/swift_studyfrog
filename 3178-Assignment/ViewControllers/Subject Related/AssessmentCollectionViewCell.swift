//
//  AssessmentCollectionViewCell.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 15/6/2023.
//

import UIKit
import CoreMotion

class AssessmentCollectionViewCell: UICollectionViewCell {
    
   // var subject:Subject = Subject()
  //  var row = 0
    
    var assessment = Assessment()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var worthLabel: UILabel!
    @IBOutlet weak var scoreTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        nameLabel.text = "Name"
//        worthLabel.text = "Worth: 100%"
//        scoreTextField.text = "9"
        
        
        self.nameLabel.text = assessment.name
        self.worthLabel.text = "Worth: \(assessment.worth)"
        self.scoreTextField.text = String(assessment.score ?? 0)
                
    
    }
    


}




//these functions are from stackoverflow!
extension UICollectionViewCell {
    
    var collectionView: UICollectionView? {
        return self.next(of: UICollectionView.self)
    }
    
    var indexPath: IndexPath? {
        return self.collectionView?.indexPath(for: self)
    }
    
}

