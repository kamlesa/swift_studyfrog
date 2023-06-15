//
//  FirebaseController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 15/6/2023.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseAuth
import Firebase

class FirebaseController: NSObject, FirebaseProtocol {
    
    // MARK: - Variables
    
    let DEFAULT_SUBJECT_NAME = "Default Subject"
    var listeners = MulticastDelegate<DatabaseListener>()
    var assessmentList: [Assessment] = []
    var subjectList: [Subject] = []
    var defaultSubject: Subject
    var currentSubject: Subject
    
    var authController: Auth
    var database: Firestore
    var assessmentsRef: CollectionReference?
    var subjectsRef: CollectionReference?
    var currentUser: FirebaseAuth.User?
    
    //MARK: - init
    override init(){
        FirebaseApp.configure()
        authController = Auth.auth()
        database = Firestore.firestore()
        assessmentList = [Assessment]()
        subjectList = [Subject]()
        defaultSubject = Subject()
        currentSubject = Subject()
        
        super.init()
        
        Task {
            do {
                let authDataResult = try await authController.signInAnonymously()
                currentUser = authDataResult.user
            }
            catch {
                fatalError("Firebase Authentication Failed with Error \(String(describing: error))")
            }
            self.setupAssessmentListener()
        }
    }
    
    //MARK: - Firebase Specific Methods
    
    func getSubjectByID(_ id: String) -> Subject?{
        for s in subjectList {
            if s.id == id {
                return s
            }
        }
        return nil
    }
    
    func getAssessmentByID(_ id: String) -> Assessment?{
        for a in assessmentList {
            if a.id == id {
                return a
            }
        }
        return nil
    }
    
    func setupAssessmentListener(){
        assessmentsRef = database.collection("assessments")
        assessmentsRef?.addSnapshotListener() {
            (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                print("Failed to fetch documents with error: \(String(describing: error))")
                return
            }
            self.parseAssessmentsSnapshot(snapshot: querySnapshot)
            if self.subjectsRef == nil {
                self.setupSubjectListener()
            }
        }
    }
    
    func setupSubjectListener(){
        subjectsRef = database.collection("subjects")
        subjectsRef?.addSnapshotListener() {
            (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
                print("Failed to fetch documents with error: \(String(describing: error))")
                return
            }
            self.parseSubjectSnapshot(snapshot: querySnapshot)
        }
    }
    
    
    /*
    func setupSubjectListener(){
        subjectsRef = database.collection("subjects")
        subjectsRef?.whereField("name", isEqualTo: DEFAULT_SUBJECT_NAME).addSnapshotListener {
            (querySnapshot, error) in
            guard let querySnapshot = querySnapshot, let subjectSnapshot = querySnapshot.documents.first else {
                print("Error fetching teams")//: \(error!)")
                return
            }
            self.parseSubjectSnapshot(snapshot: subjectSnapshot)
        }
    }
    */
    func parseAssessmentsSnapshot(snapshot: QuerySnapshot){
        snapshot.documentChanges.forEach { (change) in
            var assessment: Assessment
            do {
                
                let documentData = change.document.data()
                print("Documentdata:", documentData)
                assessment = try change.document.data(as: Assessment.self)
                
            } catch {
                fatalError("Unable to decode assessment: \(error.localizedDescription)")
            }
            //let ass = assessmentList
            if change.type == .added {
                print("index for ass = \(Int(change.newIndex))")
                assessmentList.insert(assessment, at: Int(change.newIndex))
            } else if change.type == .modified {
                assessmentList.remove(at: Int(change.oldIndex))
                assessmentList.insert(assessment, at: Int(change.newIndex))
            } else if change.type == .removed {
                assessmentList.remove(at: Int(change.oldIndex))
            }
            //let ass = assessmentList
            listeners.invoke { (listener) in
                if listener.listenerType == ListenerType.assessment || listener.listenerType == ListenerType.all {
                    listener.onAllAssessmentsChange(change: .update, assessments: assessmentList)
                }
            }
            
        }
    }
        
    func parseSubjectSnapshot(snapshot: QuerySnapshot){
        snapshot.documentChanges.forEach { (change) in
            var subject: Subject
            do {
                let documentData = change.document.data()
                print("Documentdata:", documentData)

                subject = try change.document.data(as: Subject.self)
            } catch {
                fatalError("Unable to decode subject: \(error.localizedDescription)")
            }
            //let sub = subjectList
            if change.type == .added {
                print("index for subject = \(Int(change.newIndex))")
                //subjectList.insert(subject, at: 0)
                subjectList.insert(subject, at: Int(change.newIndex))
            } else if change.type == .modified {
                subjectList.remove(at: Int(change.oldIndex))
                subjectList.insert(subject, at: Int(change.newIndex))
            } else if change.type == .removed {
                subjectList.remove(at: Int(change.oldIndex))
            }
            
            listeners.invoke { (listener) in
                if listener.listenerType == ListenerType.subject || listener.listenerType == ListenerType.all {
                    listener.onSubjectChange(change: .update, subjAssessments: subjectList)
                }
            }
            
        }
    }
    
    /* this version is for one subject only existing ....
     func parseSubjectSnapshot(snapshot: QueryDocumentSnapshot){
         defaultSubject = Subject()
         defaultSubject.name = snapshot.data()["name"] as? String
         defaultSubject.id = snapshot.documentID
         if let assessmentReferences = snapshot.data()["assessments"] as? [DocumentReference] {
             for reference in assessmentReferences {
                 if let assessment = getAssessmentByID(reference.documentID) {
                     defaultSubject.assessments.append(assessment)
                 }
             }
         }
         listeners.invoke { (listener) in
             if listener.listenerType == ListenerType.subject || listener.listenerType == ListenerType.all {
                 listener.onSubjectChange(change: .update, subjAssessments: defaultSubject.assessments)
             }
         }
     }
     */
    
    //MARK: - Database Protocol Basic Functions

    func cleanup() {
        //Does nothing
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        if listener.listenerType == .subject || listener.listenerType == .all {
            listener.onSubjectChange(change: .update, subjAssessments: subjectList)
        }
        if listener.listenerType == .assessment || listener.listenerType == .all {
            listener.onAllAssessmentsChange(change: .update, assessments: assessmentList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)
    }
    
    //MARK: - Database Protocol Add/Delete

    func addSubject(name: String, code: String, goal_grade: Int) -> Subject {
        let subject = Subject()
        subject.name = name
        subject.code = code
        subject.progress = 0
        subject.goal_grade = goal_grade
        subject.max_grade = 100
        subject.current_grade = 0
        if let subjectRef = subjectsRef?.addDocument(data: ["name" : name, "code": code, "progress": 0, "goal_grade": goal_grade, "current_grade": 0, "max_grade": 100, "assessments": []]) {
            subject.id = subjectRef.documentID
        }
        return subject
    }
    
    func deleteSubject(subject: Subject) {
        if let subjectID = subject.id {
            subjectsRef?.document(subjectID).delete()
        }
    }
    
    func addAssessment(name: String, worth: Int) -> Assessment {
        let a = Assessment()
        a.name = name
        a.worth = worth
        a.score = 0
        
        do {
            if let aRef = try assessmentsRef?.addDocument(from: a) {
                a.id = aRef.documentID
            }
        } catch {
            print("Failed to serialize hero")
        }
        return a
        //TODO: handle this error e.g. like with the user.
    }
    
    func deleteAssessment(assessment: Assessment) {
        if let assessmentID = assessment.id {
            assessmentsRef?.document(assessmentID).delete()
        }
    }
    
    func addAssessmentToSubject(assessment: Assessment, subject: Subject) -> Bool {
        guard let aID = assessment.id, let sID = subject.id else {
            return false
        }
        if let newARef = assessmentsRef?.document(aID) {
            subjectsRef?.document(sID).updateData(["assessments": FieldValue.arrayUnion([newARef])])
        }
        return true
    }

}
