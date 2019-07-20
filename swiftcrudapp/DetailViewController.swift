//
//  ViewController.swift
//  swiftcrudapp
//
//  Created by Faith on 13/7/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  var todo: todoClass!

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = todo.title
    dateTimeLabel.text = todo.date
    notesLabel.text = todo.notes
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editTodo",
      let navController = segue.destination as? UINavigationController,
      let destVC = navController.viewControllers.first as? EditTodoTableViewController
    {
      destVC.todo = todo
    }
  }

  @IBOutlet weak var dateTimeLabel: UILabel!
  
  @IBOutlet weak var notesLabel: UILabel!
}

