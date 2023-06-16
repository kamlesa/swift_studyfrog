//
//  ButtonCollectionViewCell.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 16/6/2023.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var updateButton: UIButton!
    var delegate:ButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //updateButton.
    }
    
    @IBAction func updateGrades(_ sender: Any) {
        delegate?.updateGrades()
        //updateButton.
    }
}

protocol ButtonDelegate {
    func updateGrades()
}
