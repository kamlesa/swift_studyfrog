//
//  ProgressCollectionViewCell.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 15/6/2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    var subject: Subject = Subject()
    //var progress: Int = 0
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //todo: figure out progress
        //let subject = delegate?.selectedSubject
        print(subject.progress)
        progressView.setProgress(1.0, animated: false)
        progressView.progress = Float(subject.progress ?? 0)/100
        textView.text = "You have current progressed \(subject.progress ?? 0)% through the semester. Keep up the hard work!"
    }
    
}
