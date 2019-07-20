//
//  ToDoTableViewController.swift
//  swiftcrudapp
//
//  Created by Faith on 13/7/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit

class todoClass: Codable {
  var title : String
  var date : String
  var notes : String
  init(title: String, date: String, notes: String) {
    self.title = title
    self.date = date
    self.notes = notes
  }
  
  static func loadSampleData() -> [todoClass] {
    var todoArray = [
      todoClass(title: "Do homework", date: "15/7/2019 07:19", notes: "Important"),
      todoClass(title: "Do homework", date: "15/7/2019 07:19", notes: "Important"),
      todoClass(title: "Do homework", date: "15/7/2019 07:19", notes: "Important")
    ]
    return todoArray
  }
  
  static func getArchiveURL() -> URL {
    let plistName = "todos"
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
  }
  
  static func saveToFile(friends: [todoClass]) {
    let archiveURL = getArchiveURL()
    let propertyListEncoder = PropertyListEncoder()
    let encodedFriends = try? propertyListEncoder.encode(friends)
    try? encodedFriends?.write(to: archiveURL, options: .noFileProtection)
  }
  
  static func loadFromFile() -> [todoClass]? {
    let archiveURL = getArchiveURL()
    let propertyListDecoder = PropertyListDecoder()
    guard let retrievedFriendsData = try? Data(contentsOf: archiveURL) else { return nil }
    guard let decodedFriends = try? propertyListDecoder.decode(Array<todoClass>.self, from: retrievedFriendsData) else { return nil }
    return decodedFriends
  }
  
}

class ToDoTableViewController: UITableViewController {
  
  var todoArray: [todoClass] = []
  
  
  @IBAction func backToTodoList(with segue: UIStoryboardSegue) {
    if segue.identifier == "unwindSave", let source = segue.source as? EditTodoTableViewController {
      if tableView.indexPathForSelectedRow == nil {
        todoArray.append(source.todo)
        tableView.reloadData()
        let dateField = source.dateField!
        let text = source.titleField.text!
        let timeLeft = dateField.date.timeIntervalSinceNow
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: dateField.date)
        Timer.scheduledTimer(withTimeInterval: timeLeft, repeats: false) { timer in
          let alertController = UIAlertController(title: "It's \(dateString)!", message:
            "Complete to do \(text)", preferredStyle: .alert)
          
          let action = UIAlertAction(title: "Will do it now", style: .default, handler: { (_) in
            // code to run when button is pressed
            print("Done")
          })
          
          alertController.addAction(action)
          
          self.present(alertController, animated: true, completion: nil)
        }

        todoClass.saveToFile(friends: todoArray)
        
      } else {
        tableView.reloadData()
      }
    }
  }
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      if let loadedFriends = todoClass.loadFromFile() {
        print("Found file! Loading friends!")
        todoArray = loadedFriends
      } else {
        print("No friends 😢 Making some up")
        todoArray = todoClass.loadSampleData()
      }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return todoArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)

        // Configure the cell...
      cell.textLabel?.text = "\(todoArray[indexPath.row].title)"
      cell.detailTextLabel?.text = "Do by \(todoArray[indexPath.row].date)"

        return cell
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showTodoDetail" {
      if let destVC = segue.destination as? DetailViewController {
        if let indexPath = tableView.indexPathForSelectedRow {
          destVC.todo = todoArray[indexPath.row]
        }
      }
    }
  }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            todoClass.saveToFile(friends: todoArray)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
  
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
      
      let todo = todoArray.remove(at: fromIndexPath.row)
      todoArray.insert(todo, at: to.row)
      todoClass.saveToFile(friends: todoArray)
      tableView.reloadData()
      
    }
  

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
