//
//  QuoteData.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 9/5/2023.
//

import UIKit

class QuoteData: NSObject, Decodable {
    var quote:String
    var author:String?
    
    private enum RootKeys: String, CodingKey {
        case volumeInfo //todo figure this out lol
    }
    
    private enum QuoteKeys: String, CodingKey {
        case quote
        case author
    }
    
    required init(from decoder: Decoder) throws {
        
        let rootContainer = try decoder.container(keyedBy: QuoteKeys.self)
        
        //get info
        quote = try rootContainer.decode(String.self, forKey: .quote)
        author = try rootContainer.decode(String.self, forKey: .author)

    }
}
