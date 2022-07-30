//
//  WorkOrderDetailsViewController.swift
//  Yuriko-Uchida_COMP2125-Sec001_Lab04-Ex02
//
//  Created by user212402 on 2022-07-28.
//

import UIKit

class WorkOrderDetailsViewController: UIViewController {
    
    //Variable to store the user input value
    var user = UserInput()
    
    @IBOutlet weak var projNameTextField: UITextField!
    @IBOutlet weak var projCostTextField: UITextField!
    @IBOutlet weak var empNameTextField: UITextField!
    @IBOutlet weak var empPaymentTextField: UITextField!
    @IBOutlet weak var thanksTextView: UITextView!
    
    //Display the saved info
    @IBAction func submit(_ sender: Any) {
        thanksTextView.isHidden = false
        let msg = "Thanks for the order, looking forward working with you"
        thanksTextView.text = msg;
        
        //Initialize the user data
        user = UserInput()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let projCost = user.hourlyRate * user.projDuration
        let empPayment = user.hourlyRate * user.empDuration

        //Assign the vals
        projNameTextField.text = "Project Name : " + user.projName;
        projCostTextField.text = "Total Cost : $" + String(projCost);
        empNameTextField.text = "Employee Name : " + String(user.empName);
        empPaymentTextField.text = "Employee Salary : $" + String(empPayment);
    }

}
