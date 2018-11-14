import CoreData

// MARK: - Create Entity
extension NSManagedObjectContext {
    
    func createEntity<T: NSManagedObject>() -> T {
        return T(entity: T.entityDescription(), insertInto: self)
    }
}
