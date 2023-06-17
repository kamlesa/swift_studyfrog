//
//  HomeViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 20/3/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dueDateTableView: UITableView!
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var inspoQuoteTextView: UITextView!
    
    @IBOutlet weak var massiveTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "frogBanner")
        inspoQuoteTextView.isEditable = false
        inspoQuoteTextView.text = "It takes two hands to clap!"
        inspoQuoteTextView.textAlignment = NSTextAlignment.center
        //indicator.startAnimating()
        //callAsync()
        //massiveTextView.text = ""
    }
    
    // MARK: - Quotes API
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //await requestQuote()
    }
    
    func callAsync() {
        let _ = Task {
            await requestQuote()
        }
    }
    
    func requestQuote() async {
        //https://api.goprogram.ai/inspiration
        print("Quote is being Requested!")
        var searchURLComponents = URLComponents()
        searchURLComponents.scheme = "https"
        searchURLComponents.host = "api.goprogram.ai"
        searchURLComponents.path = "/inspiration"
        
        guard let requestURL = searchURLComponents.url else {
            print("Invalid URL")
            return
        }
        
        let urlRequest = URLRequest(url: requestURL)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            let decoder = JSONDecoder()
            let quoteData = try decoder.decode(QuoteData.self, from: data)
            let quote = quoteData.quote
            var textInput = quote
            if let author = quoteData.author {
                textInput = textInput + "\n - " + author
            }
            inspoQuoteTextView.text = textInput
        } catch let error {
            print(error)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
