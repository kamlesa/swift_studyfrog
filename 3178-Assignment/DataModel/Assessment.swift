//
//  Assessment.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 15/6/2023.
//

import UIKit
import FirebaseFirestoreSwift


class Assessment: NSObject, Codable {
    
    @DocumentID var id: String?
    var name: String?
    var worth: Int?
    var score: Int?
    
    /*
     
     ["worth": 40, "name": exam, "score": 50]
     */
}
