//
//  ChooseColourViewController.swift
//  3178-LAB2
//
//  Created by Anika Kamleshwaran on 10/3/2023.
//

import UIKit

protocol ColourChangeDelgate: AnyObject {
    func changedToColour(_ colour: UIColor)
    
}

class ColourViewController: UIViewController {
    
    @IBOutlet weak var colourView: UIView!
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    weak var delegate: ColourChangeDelgate?
    weak var initialColour: CGColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
//
        
        redSlider.value = 0// initialRed
        blueSlider.value = 0 //initialBlue
        greenSlider.value = 0// initialGreen
        
        let redValue = CGFloat(redSlider.value)
        let blueValue = CGFloat(blueSlider.value)
        let greenValue = CGFloat(greenSlider.value)
        let initialColour = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        colourView.backgroundColor = initialColour
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        let redValue = CGFloat(redSlider.value)
        let blueValue = CGFloat(blueSlider.value)
        let greenValue = CGFloat(greenSlider.value)
        let newColour = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        colourView.backgroundColor = newColour
        delegate?.changedToColour(newColour)
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
