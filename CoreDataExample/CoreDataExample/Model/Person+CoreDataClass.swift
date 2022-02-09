//
//  Person+CoreDataClass.swift
//  CoreDataExample
//
//  Created by Nitin Bhatt on 2/7/22.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    
    class func insertValues(name:String,address:String)->Person?{
        let manageObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: manageObjectContext)
        let person = NSManagedObject(entity: entity!, insertInto: manageObjectContext)
        
        person.setValue(name, forKey: "name")
        person.setValue(address, forKey: "address")
        
        do{
            try manageObjectContext.save()
            return person as? Person
        }catch let error as NSError{
            print("Not saved \(error)")
            return nil
        }
    }
    
    class func fetchValues()->[Person]?{
        let manageObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do{
             let person = try manageObjectContext.fetch(fetch)
            return person as? [Person]
        }catch let error as NSError{
            print("Error \(error)")
            return nil
        }
    }
    
    class func updateValues(name:String,address:String){
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do{
            let items = try managedObjectContext.fetch(fetchRequest)
            if items.count > 0{
                items[0].setValue(address, forKey: "address")
            }
            try managedObjectContext.save()
        }catch let error as NSError{
            print("Error \(error)")
        }
    }
    
    class func deleteValues(name:String){
        let managedObjectContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do{
            let values = try managedObjectContext.fetch(fetchRequest)
            
            for i in values{
                managedObjectContext.delete(i)
                try managedObjectContext.save()
            }
        }catch let error as NSError{
            print("Error\(error)")
        }
    }

}
