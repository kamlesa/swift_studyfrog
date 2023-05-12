//
//  SubjectCollectionViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class SubjectCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let CELL_INFO = "infoCell"
    let CELL_ASSESSMENT = "assessmentCell"
    let CELL_MISSING = "missingWorthCell"
    let CELL_PROGRESS = "progressCell"
    
    let SECTION_INFO = 0
    let SECTION_ASSESSMENT = 1
    let SECTION_MISSING = 2
    let SECTION_PROGRESS = 3
    
    let spacing: CGFloat = 10
    let borderWidth: CGFloat = 0.5
    
    var subject:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = subject
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    
    @IBAction func addAssessment(_ sender: Any) {
        //TODO: ADD
        performSegue(withIdentifier: "addAssessment", sender: Any?.self)
    }
    
    
    @IBAction func editSubject(_ sender: Any) {
        //TODO: EDIT
        performSegue(withIdentifier: "editSubject", sender: Any?.self)
    }
    
    @IBAction func archiveSubject(_ sender: Any) {
        //TODO: ARCHIVE
        
    }
    
    @IBAction func deleteSubject(_ sender: Any) {
        //TODO: IMPLEMENT
        
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let identifier = segue.identifier
        
        if identifier == "addAssessment"{
            //Do nothing
        }else if identifier == "editSubject"{
            //Do nothing
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
   // override func collec


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        switch section {
        case SECTION_INFO:
            return 1
        case SECTION_ASSESSMENT:
            return 3
        case SECTION_PROGRESS:
            return 1
        case SECTION_MISSING:
            return 0
        default:
            return 0
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //TODO: properly set up cells!
        // Configure the cell
        let section = indexPath.section
        
        switch section {
        case SECTION_INFO:
            var infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_INFO, for: indexPath)
//            infoCell.leftAnchor.constraint(equalTo: leftAnchor)
//            infoCell.maxWidth = collectionView.bounds.width - (2*spacing)
            return infoCell
        case SECTION_ASSESSMENT:
            var assessmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ASSESSMENT, for: indexPath)
            return assessmentCell
        case SECTION_PROGRESS:
            var progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_PROGRESS, for: indexPath)
            return progressCell
        default:
            let missingWorthCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_MISSING, for: indexPath)
            return missingWorthCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize:CGFloat = UIScreen.main.bounds.width
        let section = indexPath.section
        if section == SECTION_INFO{
            return CGSize(width: screenSize, height: 200)
        }else if section == SECTION_PROGRESS{
            return CGSize(width: screenSize, height: 100)
        }
        return CGSize(width: screenSize, height: 50.0)
    }
    
    //MARK: attempt at arranging cells..
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
