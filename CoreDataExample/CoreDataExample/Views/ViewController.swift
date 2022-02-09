//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Nitin Bhatt on 2/7/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var persons = [Person]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPersonDetails()
    }
    
    func getPersonDetails(){
        persons = Person.fetchValues() ?? []
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.addPersonDetails()
    }
    
    
    @IBAction func addButtonAction(_ sender: Any) {
        self.addPersonDetails()
    }
    
    private func addPersonDetails(){
    
        let alertController = UIAlertController(title: "Add Person Details", message: "", preferredStyle: UIAlertController.Style.alert)
         
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Person Name"
         }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            
            if let insertPersonDetails  = Person.insertValues(name:firstTextField.text!, address:secondTextField.text!){
                self.getPersonDetails()
                self.tableView.reloadData()
                print(insertPersonDetails)
            }
            
         })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
       
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Address"
        }
        
         alertController.addAction(saveAction)
         alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    private func updateAddress(name:String){
    
        let alertController = UIAlertController(title: "Update Address", message: "", preferredStyle: UIAlertController.Style.alert)
         
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Address"
         }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            Person.updateValues(name: name, address: firstTextField.text!)
            self.getPersonDetails()
            self.tableView.reloadData()
         })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })
        
         alertController.addAction(saveAction)
         alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }


}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as? PersonTableViewCell
        cell?.nameLabel.text = persons[indexPath.row].name
        cell?.addressLabel.text = persons[indexPath.row].address
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.updateAddress(name: persons[indexPath.row].name!)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            Person.deleteValues(name: persons[indexPath.row].name!)
            self.getPersonDetails()
            self.tableView.reloadData()
        }
    }
}

class PersonTableViewCell:UITableViewCell{
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}
