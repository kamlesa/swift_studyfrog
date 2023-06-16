//
//  SubjectCollectionViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 21/4/2023.
// https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreMotion

private let reuseIdentifier = "Cell"

class SubjectCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DatabaseListener, UITextFieldDelegate, ButtonDelegate {

    
    //MARK: - Variables
    var listenerType: ListenerType = .all
    weak var databaseController: FirebaseProtocol?
    
    let CELL_INFO = "infoCell"
    let CELL_ASSESSMENT = "assessmentCell"
    let CELL_BUTTON = "buttonCell"
    let CELL_PROGRESS = "progressCell"
    
    let SECTION_INFO = 0
    let SECTION_ASSESSMENT = 1
    let SECTION_BUTTON = 2
    let SECTION_PROGRESS = 3
    
    let spacing: CGFloat = 10
    let borderWidth: CGFloat = 0.5
    
    var subjectIndex:Int = 0
    var selectedSubject:Subject = Subject()
    var assessments: [Assessment] = []
    
    let motionManager: CMMotionManager = CMMotionManager()
    
    
    

    //MARK: - View Load Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedSubject.code
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        databaseController = appDelegate?.firebaseController
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        

        setAssessments()
        _ = updateCurrentGrade()
        updateMaxGrade()
        updateProgress()


        // Do any additional setup after loading the view.
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //if textField ==
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: -  Button Functions
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
    
    // MARK: - Grade Updates
    func updateGrades() {
        //this function is called when the button is clicked. the goal is to update all assessments and reload the data displayed
        for i in 0 ..< (self.collectionView.numberOfItems(inSection: SECTION_ASSESSMENT)){
            let cell = self.collectionView.cellForItem(at: IndexPath(row: i, section: SECTION_ASSESSMENT)) as! AssessmentCollectionViewCell
            let value = cell.scoreTextField.text
            let score = Int(value ?? "0")
            self.databaseController?.updateAssessment(assessment: assessments[i], fieldName: "score", newValue: score)
        }
        databaseController?.cleanup()
        _ = updateCurrentGrade()
        updateProgress()
        updateMaxGrade()
    }
    
    func updateCurrentGrade()-> Int{
        //update current grade!
        var currentgrade = 0
        var sum = 0
        var weight = 0
        for a in assessments{
            sum += a.score ?? 0
            weight += a.worth ?? 0
        }
        if weight > 0{
            currentgrade = sum/weight*100
        }else{
            currentgrade = sum/100*100
        }
        selectedSubject.current_grade = currentgrade
        databaseController?.updateSubject(subject: selectedSubject, fieldName: "current_grade", newValue: currentgrade)
        
        self.collectionView.reloadData()
        return currentgrade
    }
    
    func updateMaxGrade(){
        //update current grade!
        //var maxgrade = 100
        var sum = 0
        for a in assessments{
            sum += a.score ?? 0
        }
        let x = 100 - ((selectedSubject.progress ?? 0) - sum)
        
        selectedSubject.max_grade = x
        databaseController?.updateSubject(subject: selectedSubject, fieldName: "max_grade", newValue: x)

        self.collectionView.reloadData()
    }
    
    func updateProgress(){
        //update current grade!
        var progress = 0
        //var sum = 0
        for a in assessments{
            progress += a.worth ?? 0
        }
        selectedSubject.progress = progress
        databaseController?.updateSubject(subject: selectedSubject, fieldName: "progress", newValue: progress)
        self.collectionView.reloadData()
    }
    
    func fetchAssessment(i: Int) -> Assessment {
        let documentReference: DocumentReference = selectedSubject.assessments[i]
        var assessment:Assessment = Assessment()
        documentReference.getDocument { (document, error) in
            if let error = error {
                print("Error fetching document: \(error.localizedDescription)")
                return
            }
            
            guard let document = document, document.exists else {
                print("Document does not exist")
                return
            }
            
            do {
                // Convert the document data to your custom object type
                let object = try document.data(as: Assessment.self)
                // You can now use the object
                print("Fetched object: \(object)")
                self.assessments.append(object)
                
            } catch {
                print("Error decoding document: \(error.localizedDescription)")
            }
            
        }
        return assessment
    }
    
    func setAssessments() {
        //var a:[Assessment] = []
        assessments = []
        for i in 0..<selectedSubject.assessments.count{
            //let x = await fetchAssessment(i: i)
            //a.append(x)
            _ = fetchAssessment(i: i)
        }
        //self.assessments = a
    }
    


    
    //MARK: - Database Listener
    
    func onToDoChange(change: DatabaseChange, todos: [ToDo]) {
        //do nothing
    }
    
    func onSubjectChange(change: DatabaseChange, subjects: [Subject]) {
        selectedSubject = subjects[subjectIndex]
        //assessments = subjAssessments
        self.collectionView.reloadData()
    }
    
    func onAllAssessmentsChange(change: DatabaseChange, assessments: [Assessment]) {
        //do nothing?
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let identifier = segue.identifier
        
        if identifier == "addAssessment"{
            guard let destination = segue.destination as? NewAssessmentViewController else{
                fatalError("Issue!")
            }
            destination.subject = selectedSubject
        }else if identifier == "editSubject"{
            //Do nothing
            guard let destination = segue.destination as? EditSubjectViewController else{
                fatalError("Wrong Destintion WHAT THE!")
            }
            destination.originalName = selectedSubject.name ?? ""
            destination.originalCode = selectedSubject.code ?? ""
            destination.originalGrade = selectedSubject.goal_grade ?? 0
            destination.subject = selectedSubject
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
            return selectedSubject.assessments.count
        case SECTION_PROGRESS:
            return 1
        case SECTION_BUTTON:
            return 1
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
            //var infoCell = InfoCollectionViewCell()
            let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_INFO, for: indexPath) as! InfoCollectionViewCell
//            infoCell.leftAnchor.constraint(equalTo: leftAnchor)
//            infoCell.maxWidth = collectionView.bounds.width - (2*spacing)
            infoCell.subject = selectedSubject
            infoCell.awakeFromNib()
            return infoCell
        case SECTION_ASSESSMENT:
            let assessmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_ASSESSMENT, for: indexPath) as! AssessmentCollectionViewCell
            if assessments.count >= 1{
                let assessment = assessments[indexPath.row]
                assessmentCell.scoreTextField.text = String(assessment.score ?? 0 )
                assessmentCell.nameLabel.text = assessment.name
                assessmentCell.worthLabel.text = String(assessment.worth ?? 0 )
            }
            assessmentCell.awakeFromNib()
            return assessmentCell
        case SECTION_PROGRESS:
            //let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
            //var progressCell = ProgressCollectionViewCell()
            let progressCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_PROGRESS, for: indexPath) as! ProgressCollectionViewCell
            progressCell.subject = selectedSubject
            progressCell.awakeFromNib()
            return progressCell
        default:
            let buttonCell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_BUTTON, for: indexPath)
            return buttonCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let screenSize:CGFloat = UIScreen.main.bounds.width
        let section = indexPath.section
        let screenSize = collectionView.bounds.width - 10
        if section == SECTION_INFO{
            return CGSize(width: screenSize, height: 200)
        }else if section == SECTION_PROGRESS{
            return CGSize(width: screenSize, height: 100)
        }
        return CGSize(width: screenSize, height: 50.0)
    }
    
    //MARK: attempt at arranging cells..
    

    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case SECTION_ASSESSMENT:
            return true
        default:
            return false
        }
    }
    

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case SECTION_ASSESSMENT:
            return true
        default:
            return false
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AssessmentCollectionViewCell
        cell.nameLabel.text = "Changed !"
        let alertController = UIAlertController(title: "Delete Assessment", message: "Are you sure you want to delete \(cell.nameLabel.text ?? "this assessmnet")?", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {_ in
            let row = indexPath.row
            self.databaseController?.deleteAssessment(assessment: self.assessments[row])
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    

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


