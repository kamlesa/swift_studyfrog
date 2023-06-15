//
//  Subject.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 15/6/2023.
//

import UIKit
import FirebaseFirestoreSwift
import FirebaseFirestore

class Subject: NSObject, Codable {
    
    @DocumentID var id: String?
    var code: String? = "fit1234"
    var name: String? = "Mess"
    var progress: Int? = 0
    var goal_grade: Int? = 100
    var max_grade: Int? = 100
    var current_grade: Int? = 0
    var assessments: [DocumentReference] = []
    
    /*
     
     Documentdata: ["max_grade": 100, "progress": 0, "code": FIT3178, "assessments": <__NSArrayM 0x6000036522b0>(
     <FIRDocumentReference: 0x600003652310>,
     <FIRDocumentReference: 0x600003652160>
     )
     , "name": iOS App Dev, "goal_grade": 70, "current_grade": 0]
     
     */

}
