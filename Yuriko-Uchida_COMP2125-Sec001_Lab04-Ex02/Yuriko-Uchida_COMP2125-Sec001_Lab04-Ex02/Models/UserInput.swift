//
//  UserInput.swift
//  Yuriko-Uchida_COMP2125-Sec001_Lab04-Ex02
//
//  Created by user212402 on 2022-07-29.
//

import Foundation




class UserInput{
    public var projId: Int
    public var projName: String
    public var projDuration: Int
    public var hourlyRate: Int
    public var empId: Int
    public var empName: String
    public var empDuration: Int
    
    init(){
        self.projId = 0
        self.projName = ""
        self.projDuration = 0
        self.hourlyRate = 0
        self.empId = 0
        self.empName = ""
        self.empDuration = 0
    }
}
