//
//  HomeViewController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 20/3/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var inspoQuoteLabel: UILabel!
    @IBOutlet weak var dueDateTableView: UITableView!
    @IBOutlet weak var taskTableView: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = UIImage(named: "frogBanner")
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
