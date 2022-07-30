//
//  ProjectDetailsViewController.swift
//  Yuriko-Uchida_COMP2125-Sec001_Lab04-Ex02
//
//  Created by user212402 on 2022-07-28.
//

import UIKit

class ProjectDetailsViewController: UIViewController {

    //Variable to store the user input values
    var user = UserInput()
    
    //TextField obj
    @IBOutlet weak var projIdTextField: UITextField!
    @IBOutlet weak var projNameTextField: UITextField!
    @IBOutlet weak var projDurationTextField: UITextField!
    @IBOutlet weak var hourlyRateTextField: UITextField!
    
    //Move to the next page
    @IBAction func goToResourcePage() {
        //Ensure the inputs are all valid
        let isValid = shouldPerformSegue(withIdentifier: "ResourcesDetailsViewController", sender: nil)
        if (isValid){
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ResourcesDetailsViewController") as! ResourcesDetailsViewController
            user.projName = projNameTextField.text!
            user.projDuration = Int(projDurationTextField.text!)!
            user.hourlyRate = Int(hourlyRateTextField.text!)!
            nextVC.user = user
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign the input vals previously user typed
        if (user.projId == 0){
            user.projId = Int.random(in: 100..<1000)
        }
        projIdTextField.text = "Project ID : " + String(user.projId);
        if (user.projName != ""){
            projNameTextField.text = user.projName;
        }
        if (user.projDuration != 0){
            projDurationTextField.text = String(user.projDuration);
        }
        if (user.hourlyRate != 0){
            hourlyRateTextField.text = String(user.hourlyRate);
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var isValid = true;
        var isNameValid = true;
        var isDurationValid = true;
        var isRateValid = true;

        //Regular expression for project name
        let nameRange = NSRange(location: 0, length: projNameTextField.text!.count)
        let nameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]{1}[a-zA-Z ]*$")
        isNameValid = (nameRegex.firstMatch(in: projNameTextField.text!, options: [], range: nameRange) != nil)

        //Regular expression for project duration
        let durationRange = NSRange(location: 0, length: projDurationTextField.text!.utf16.count)
        let durationRegex = try! NSRegularExpression(pattern: "^[1-9]{1}[0-9]{1,2}$")
        isDurationValid = (durationRegex.firstMatch(in: projDurationTextField.text!, options: [], range: durationRange) != nil)

        //Regular expression for rate
        let rateRange = NSRange(location: 0, length: hourlyRateTextField.text!.utf16.count)
        let rateRegex = try! NSRegularExpression(pattern: "^[1-9]{1}[0-9]{1,2}$")
        isRateValid = (rateRegex.firstMatch(in: hourlyRateTextField.text!, options: [], range: rateRange) != nil)

        //Validate
        if (isDurationValid){
            if (100 < Int(projDurationTextField.text!)! || Int(projDurationTextField.text!)! < 50){
                isDurationValid = false
            }
        }
        if (isRateValid){
            if (150 < Int(hourlyRateTextField.text!)! || Int(hourlyRateTextField.text!)! < 30){
                isRateValid = false
            }
        }
        if(!isNameValid || !isDurationValid || !isRateValid){
            isValid = false
        }

        //Alert the invalid fields
        if (!isNameValid){
            projNameTextField.backgroundColor = .red;
        }else {
            projNameTextField.backgroundColor = .white
        }
        if (!isDurationValid){
            projDurationTextField.backgroundColor = .red
        }else {
            projDurationTextField.backgroundColor = .white
        }
        if (!isRateValid){
            hourlyRateTextField.backgroundColor = .red
        }else {
            hourlyRateTextField.backgroundColor = .white
        }

        
        return isValid
    }
    
    

}
