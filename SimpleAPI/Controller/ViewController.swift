//
//  ViewController.swift
//  ComprendreLesAPI
//
//  Created by Mathieu @theunknowman_80 29/05/2023.
//

//This controller will allow you to create a desired number of user profiles by selecting the gender (male, female, both) using a segmented controller, and specifying the number of profiles to create using a stepper. The data is then associated with a button that will redirect the user to another view controller, specifically a table view. This table view will have a dictionary for temporary storage of the profiles created by the API.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLbl: UILabel!
    @IBOutlet weak var recapLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //let url = APIHelper.shared.getUrl(results: 1, gender: .noGender)
        update()
    }
    
    func update() {
        recapLbl.text = "Your request asks for \(Int(stepper.value)) people(s) and of gender \(getGender().name)"
    }
    
    func getGender() -> (name: String, gender: Gender){
        switch segmented.selectedSegmentIndex {
        case 0 : return("Man", .male)
        case 1 : return("Woman", .female)
        default : return("Both", .noGender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToList" {
            if let list = segue.destination as? ListController {
                list.dict = sender as? [String: Any]
            }
        }
    }

    @IBAction func stepperChanged(_ sender : UIStepper) {
        update()
        
    }
    @IBAction func segmentedChanged(_ sender: UISegmentedControl) {
        update()
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let dict: [String: Any] = ["results": Int(stepper.value), "gender": getGender().gender]
        performSegue(withIdentifier: "ToList", sender: dict)
        
    }
}

