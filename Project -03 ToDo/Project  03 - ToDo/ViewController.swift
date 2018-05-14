//
//  ViewController.swift
//  Project  03 - ToDo
//
//  Created by 王洁 on 2018/5/10.
//  Copyright © 2018年 王洁. All rights reserved.
//

import UIKit

var todos:[ToDoItem] = []

class ViewController: UIViewController {

    @IBOutlet weak var todoTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        todos = [ToDoItem(id: "1", image: "child-selected", title: "Go to Disney", date: dateFromString(date: "2014-10-20")!),
                 ToDoItem(id: "2", image: "shopping-cart-selected", title: "Cicso Shopping", date: dateFromString(date:"2014-10-28")!),
                 ToDoItem(id: "3", image: "phone-selected", title: "Phone to Jobs", date: dateFromString(date:"2014-10-30")!),
                 ToDoItem(id: "4", image: "travel-selected", title: "Plan to Europe", date: dateFromString(date:"2014-10-31")!)]
        todoTabelView.tableFooterView = UIView()
    }
    
    func setMessageLabel(messageLabel:UILabel, frame:CGRect, text: String, textColor:UIColor, numberOfLine:Int, textAlignment:NSTextAlignment, font:UIFont) {
        messageLabel.frame = frame
        messageLabel.text = text
        messageLabel.textColor = textColor
        messageLabel.textAlignment = textAlignment
        messageLabel.font = font
        messageLabel.numberOfLines = numberOfLine
        messageLabel.sizeToFit()
    }
    
    func setCellWithTodoItem(cell:UITableViewCell, todo:ToDoItem) {
        let imageView:UIImageView = cell.viewWithTag(11) as! UIImageView
        let titleLabel:UILabel = cell.viewWithTag(12) as! UILabel
        let dateLabel:UILabel = cell.viewWithTag(13) as! UILabel
        
        imageView.image = UIImage(named: todo.image)
        titleLabel.text = todo.title
        dateLabel.text = stringFromDate(date: todo.date)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.todoTabelView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editTodo" {
            let vc = segue.destination as! DetailViewController
            let indexPath = todoTabelView.indexPathForSelectedRow
            if let indexPath = indexPath {
                vc.todo = todos[(indexPath as NSIndexPath).row]
            }
        }
    }
    
}

extension ViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todos.count != 0 {
            return todos.count
        } else {
            let messageLabel:UILabel = UILabel()
            setMessageLabel(messageLabel: messageLabel, frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height), text: "No data is currently available", textColor: UIColor.black, numberOfLine: 0, textAlignment: .center, font: UIFont(name: "Palatino-Italic", size: 30)!)
           self.todoTabelView.backgroundView = messageLabel
            self.todoTabelView.separatorStyle = .none
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier:String = "todoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        setCellWithTodoItem(cell: cell, todo: todos[indexPath.row])
        
        return cell
    }
}

extension ViewController:UITableViewDelegate {
    // Edit mode
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        todoTabelView.setEditing(editing, animated: true)
    }
    
    // Delete the cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            todos.remove(at: (indexPath as NSIndexPath).row)
            todoTabelView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // Move the cell
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: (sourceIndexPath as NSIndexPath).row)
        todos.insert(todo, at: (destinationIndexPath as NSIndexPath).row)
    }
}
