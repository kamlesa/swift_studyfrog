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
    
    //var assessment:Assessment //= Assessment()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var worthLabel: UILabel!
    @IBOutlet weak var scoreTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func highlightCell() {
        // Update the cell's appearance to indicate selection
        self.contentView.backgroundColor = UIColor.systemGray.withAlphaComponent(0.5)
        // You can also modify other visual properties as needed
    }
        
    // Method to unhighlight the cell
    func unhighlightCell() {
        // Reset the cell's appearance to the default
        self.contentView.backgroundColor = UIColor.systemBackground
        // You can revert other visual properties to their original state
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

