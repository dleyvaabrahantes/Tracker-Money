//
//  PersistenceController.swift
//  Tracker Money
//
//  Created by David on 5/27/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(){
        container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error \(error.localizedDescription)")
            }
        }
    }
    
    func save(completion: @escaping (Error?)-> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges{
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }
    
    func delete(_ object: NSManagedObject, completion: @escaping (Error?)-> () = {_ in}){
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }
    
    func deletePredicate(id: String){
        let context = container.viewContext
        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ExpensesMO")
        
        fetchrequest.predicate = NSPredicate(format: "id == %@", id)
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchrequest)
        
        do{
            try context.execute(deleteRequest)
        } catch let error as NSError{
            print("Could not delete \(error), \(error.userInfo)")
        }
    }
}

