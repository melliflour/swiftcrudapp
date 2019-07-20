//
//  EditTodoTableViewController.swift
//  swiftcrudapp
//
//  Created by Faith on 13/7/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit

class EditTodoTableViewController: UITableViewController {
  
  var todo: todoClass!
  var timeLeft: TimeInterval!
  
  
  @IBOutlet weak var titleField: UITextField!
  
  @IBOutlet weak var dateField: UIDatePicker!
  
  @IBOutlet weak var notesField: UITextField!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "unwindSave" {
      if todo == nil {
        let title = titleField.text ?? ""
        let notes = notesField.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: dateField.date)
        todo = todoClass(title: title, date: dateString, notes: notes)
        
      } else {
        todo.title = titleField.text ?? ""
        todo.notes = notesField.text ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: dateField.date)
        todo.date = dateString
      }
            
    }
  }
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()

    if todo != nil {
      titleField.text = todo.title
      notesField.text = todo.notes
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
      dateField.date = dateFormatter.date(from: todo.date)!
    }
    
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
