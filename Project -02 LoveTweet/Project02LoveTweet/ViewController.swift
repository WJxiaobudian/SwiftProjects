//
//  ViewController.swift
//  Project02LoveTweet
//
//  Created by 王洁 on 2018/5/9.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    fileprivate let space:CGFloat = 15.0
    
    var tweet:Tweet?
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let nameText = UITextField()
    let genderLabel = UILabel()
    var genderSegmented = UISegmentedControl()
    let birthdayLabel = UILabel()
    let pickerView = UIDatePicker()
    let workLabel = UILabel()
    let workText = UITextField()
    let salaryLabel = UILabel()
    let slider = UISlider()
    var sliderValue = UILabel()
    let straightLabel = UILabel()
    let straightSwitch = UISwitch()
    let button = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: Selector.endEditing))
        
        nameText.delegate = self as UITextFieldDelegate
        workText.delegate = self as UITextFieldDelegate
        
        self.addSubViews()
    }

    func addSubViews()  {
        titleLabel.text = "LoveTweet"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.view.addSubview(titleLabel)
        titleLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(stateHeight)
            make.right.left().equalTo()(self.view)
            make.height.equalTo()(44)
        }
        
        nameLabel.text = "Name"
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = UIColor.white
        self.view.addSubview(nameLabel)
        nameLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(titleLabel.mas_bottom)?.offset()(space)
            make.left.equalTo()(self.view)
            make.height.equalTo()(33)
            make.width.equalTo()(100)
        }
        
        nameText.borderStyle = .roundedRect
        nameText.placeholder = "请输入姓名"
        nameText.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(nameText)
        nameText.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(nameLabel)
            make.left.equalTo()(nameLabel.mas_right)?.offset()(space)
            make.right.equalTo()(self.view)?.offset()(-50)
            make.height.equalTo()(nameLabel)
        }
        
        genderLabel.text = "Gender"
        genderLabel.textAlignment = .center
        self.view.addSubview(genderLabel)
        genderLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(nameLabel.mas_bottom)?.offset()(space)
            make.left.equalTo()(nameLabel)
            make.height.equalTo()(nameLabel)
            make.width.equalTo()(nameLabel)
        }
        
        genderSegmented = UISegmentedControl(items: ["Male", "Female"])
        genderSegmented.selectedSegmentIndex = 0
        genderSegmented.addTarget(self, action: #selector(segmentedClick(sender:)), for: .valueChanged)
        self.view.addSubview(genderSegmented)
        genderSegmented.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(genderLabel)
            make.left.equalTo()(genderLabel.mas_right)?.offset()(space)
            make.width.equalTo()(100)
            make.height.equalTo()(nameLabel)
        }
        
        birthdayLabel.text = "Birthday"
        birthdayLabel.textAlignment = .center
        self.view.addSubview(birthdayLabel)
        birthdayLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(genderLabel.mas_bottom)?.offset()(space)
            make.right.left().equalTo()(self.view)
            make.height.equalTo()(nameLabel)
        }
        
        pickerView.datePickerMode = .date
        pickerView.locale = Locale(identifier: "zh_CN")
        self.view.addSubview(pickerView)
        pickerView.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(birthdayLabel.mas_bottom)?.offset()(space)
            make.left.equalTo()(self.view)?.offset()(50)
            make.right.equalTo()(self.view)?.offset()(-50)
            make.height.equalTo()(120)
        }
        
        workLabel.text = "Work"
        workLabel.textAlignment = .center
        self.view.addSubview(workLabel)
        workLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(pickerView.mas_bottom)?.offset()(space)
            make.left.equalTo()(nameLabel)
            make.height.equalTo()(nameLabel)
            make.width.equalTo()(nameLabel)
        }
        
       
        workText.borderStyle = .roundedRect
        workText.placeholder = "请输入工作地址"
        workText.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(workText)
        workText.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(workLabel)
            make.left.equalTo()(workLabel.mas_right)?.offset()(space)
            make.right.equalTo()(self.view)?.offset()(-50)
            make.height.equalTo()(nameLabel)
        }
        
        salaryLabel.text = "Salary"
        salaryLabel.textAlignment = .center
        self.view.addSubview(salaryLabel)
        salaryLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(workLabel.mas_bottom)?.offset()(space)
            make.width.equalTo()(100)
            make.left.equalTo()(self.view)
            make.height.equalTo()(nameLabel)
        }
        
        slider.maximumValue = 500
        slider.minimumValue = 100
        slider.value = 200
        slider.addTarget(self, action: #selector(sliderChange(sender:)), for: .valueChanged)
        self.view.addSubview(slider)
        slider.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(salaryLabel)
            make.left.equalTo()(salaryLabel.mas_right)
            make.width.equalTo()(200)
            make.height.equalTo()(nameLabel)
        }
        
        sliderValue.text = "$200K"
        sliderValue.textAlignment = .center
        self.view.addSubview(sliderValue)
        sliderValue.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(slider.mas_top)
            make.left.equalTo()(slider.mas_right)?.offset()(space)
            make.right.equalTo()(self.view)?.offset()(-10)
            make.height.equalTo()(nameLabel)
        }
        straightLabel.text = "Straight?"
        straightLabel.textAlignment = .right
        self.view.addSubview(straightLabel)
        straightLabel.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(salaryLabel.mas_bottom)?.offset()(space)
            make.left.equalTo()(self.view)
            make.width.equalTo()(200)
            make.height.equalTo()(nameLabel)
        }
        
        straightSwitch.isOn = true
        self.view.addSubview(straightSwitch)
        straightSwitch.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(straightLabel)
            make.left.equalTo()(straightLabel.mas_right)?.offset()(space)
            make.height.equalTo()(nameLabel)
        }
        
        button .setTitle("Tweet It", for: .normal)
        button .setTitleColor(UIColor.blue, for: .normal)
        button .addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        self.view.addSubview(button)
        button.mas_makeConstraints { (make:MASConstraintMaker!) in
            make.top.equalTo()(straightLabel.mas_bottom)?.offset()(20)
            make.centerX.equalTo()(self.view.mas_centerX)
            make.height.equalTo()(nameLabel)
        }
        
    }
    
    @objc private func segmentedClick(sender:UISegmentedControl) {
        print("\(String(describing: sender.titleForSegment(at: sender.selectedSegmentIndex)))")
    }
    
    @objc private func buttonClick(){
        
        let labelsInfo = getLabelsInfo()
        if let name = labelsInfo.name, let work = labelsInfo.work, let salary = labelsInfo.salary, let age = getAge() {
            tweet = Tweet(genger: Gender(rawValue: genderSegmented.selectedSegmentIndex)!, name: name, age: age, work: work, salary: salary, isStraight: straightSwitch.isOn)
        } else {
            tweet = nil
        }
        
        switch tweet {
        case .some(let tweet):
            showAlert(title: "Love Tweet", message: tweet.info, buttonTitle: "OK")
        case .none:
            showAlert(title: "Info miss or invalid", message: "Please fill out correct personal info", buttonTitle: "OK")
        }
    }
    
    @objc private func sliderChange(sender:UISlider) {
        let text = String(format: "$%.fK", sender.value)
        sliderValue.text = text
    }
    
    private func getLabelsInfo() -> (name:String?, work:String?, salary:String?) {
        guard let name = nameText.text,
            let work = workText.text,
            let salary = sliderValue.text
        else {
            return (nil, nil, nil)
        }
        if name.isEmpty || work.isEmpty || salary.isEmpty {
            return (nil, nil, nil)
        }
        return (name, work, salary)
    }
    
    private func getAge() -> Int? {
        let age = Calendar.current.dateComponents([.year], from: pickerView.date, to: Date())
        return  age.year
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

