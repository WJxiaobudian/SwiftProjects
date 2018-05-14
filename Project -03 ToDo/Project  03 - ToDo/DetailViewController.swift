//
//  DetailViewController.swift
//  Project  03 - ToDo
//
//  Created by 王洁 on 2018/5/10.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  
    @IBOutlet weak var childButton: UIButton!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var shopButto: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var todoTitle: UITextField!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    var todo:ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todo = todo {
            self.title = "Edit Todo"
            if todo.image  == "child-selected" {
                childButton.isSelected = true
            } else if todo.image == "phone-selected" {
                phoneButton.isSelected = true
            } else if todo.image == "shopping-cart-selected" {
                shopButto.isSelected = true
            } else if todo.image == "travel-selected" {
                travelButton.isSelected = true
            }
            
            todoTitle.text = todo.title
            datePickerView.setDate(todo.date, animated: true)
        } else {
            title = "New Todo"
            childButton.isSelected = true
        }
    }

    @IBAction func childButton(_ sender: UIButton) {
        resetButton()
        childButton.isSelected = true
    }
    
    @IBAction func phoneButton(_ sender: UIButton) {
        resetButton()
        phoneButton.isSelected = true
    }
    
    @IBAction func shopButton(_ sender: UIButton) {
        resetButton()
        shopButto.isSelected = true
    }
    
    @IBAction func travelButton(_ sender: UIButton) {
        resetButton()
        travelButton.isSelected = true
    }
    
    func resetButton() {
        childButton.isSelected = false
        phoneButton.isSelected = false
        shopButto.isSelected = false
        travelButton.isSelected = false
    }

    @IBAction func Done(_ sender: UIButton) {
        
        var image = ""
        if childButton.isSelected {
            image = "child-selected"
        } else if phoneButton.isSelected {
            image = "phone-selected"
        } else if shopButto.isSelected {
            image = "shopping-cart-selected"
        } else if travelButton.isSelected {
            image = "travel-selected"
        }
        if let todo = todo {
            todo.image = image
            todo.title = todoTitle.text!
            todo.date = datePickerView.date
        } else {
            let uuid = UUID().uuidString
            todo = ToDoItem(id: uuid, image: image, title: todoTitle.text!, date: datePickerView.date)
            todos.append(todo!)
        }
        
        let _ = navigationController?.popToRootViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

}
