//
//  ResourcesDetailsViewController.swift
//  Yuriko-Uchida_COMP2125-Sec001_Lab04-Ex02
//
//  Created by user212402 on 2022-07-28.
//

import UIKit

class ResourcesDetailsViewController: UIViewController {
   
    //Variable to store the user input values
    var user = UserInput()
    
    //TextField obj
    @IBOutlet weak var empIdTextField: UITextField!
    @IBOutlet weak var empNameTextField: UITextField!
    @IBOutlet weak var empDurationTextField: UITextField!
    @IBOutlet weak var hourlyRateTextField: UITextField!
    @IBOutlet weak var savedInfoTextView: UITextView!
    
    
    @IBAction func goToOrderPage() {
        let isValid = shouldPerformSegue(withIdentifier: "WorkOrderDetailsViewController", sender: nil)
        if (isValid){
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "WorkOrderDetailsViewController") as! WorkOrderDetailsViewController
            user.empName = empNameTextField.text!
            user.empDuration = Int(empDurationTextField.text!)!
            nextVC.user = user
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    //Display the saved info
    @IBAction func saveInfo(_ sender: Any) {
        savedInfoTextView.isHidden = false
        let cost = user.hourlyRate * user.projDuration
        let msg = "- Project Name : \(user.projName)\n- Employee Name : \(empNameTextField.text!)\n- Total Cost : $\(cost)"
        savedInfoTextView.text = msg;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign the input vals previously user typed
        if (user.empId == 0){
            user.empId = Int.random(in: 100..<1000)
        }
        empIdTextField.text = "Employee ID : " + String(user.empId);
        if (user.empName != ""){
            empNameTextField.text = user.empName;
        }
        if (user.empDuration != 0){
            empDurationTextField.text = String(user.empDuration);
        }
        hourlyRateTextField.text = "Hourly Rate : $" + String(user.hourlyRate);
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var isValid = true;
        var isNameValid = true;
        var isDurationValid = true;

        if (identifier == "WorkOrderDetailsViewController"){
            //Regular expression for project name
            let nameRange = NSRange(location: 0, length: empNameTextField.text!.count)
            let nameRegex = try! NSRegularExpression(pattern: "^[a-zA-Z]{1}[a-zA-Z ]*$")
            isNameValid = (nameRegex.firstMatch(in: empNameTextField.text!, options: [], range: nameRange) != nil)
            
            //Regular expression for employement duration
            let durationRange = NSRange(location: 0, length: empDurationTextField.text!.utf16.count)
            let durationRegex = try! NSRegularExpression(pattern: "^[1-9]{1}[0-9]{1,2}$")
            isDurationValid = (durationRegex.firstMatch(in: empDurationTextField.text!, options: [], range: durationRange) != nil)

            //Validate
            if (isDurationValid){
                if (user.projDuration < Int(empDurationTextField.text!)! || Int(empDurationTextField.text!)! < 50){
                    isDurationValid = false
                }
            }
            if(!isNameValid || !isDurationValid){
                isValid = false
            }

            //Alert the invalid fields
            if (!isNameValid){
                empNameTextField.backgroundColor = .red;
            }else {
                empNameTextField.backgroundColor = .white
            }
            if (!isDurationValid){
                empDurationTextField.backgroundColor = .red
            }else {
                empDurationTextField.backgroundColor = .white
            }
        }

        return isValid
    }

    
    
    
    

}
