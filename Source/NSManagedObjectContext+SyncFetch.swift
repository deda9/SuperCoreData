import CoreData

// MARK: - Fetch All
extension NSManagedObjectContext {
    
    func fetchAll<T: NSManagedObject>(_ entity: T.Type) -> [T] {
        return doFetchAll(entity, predicate: nil, sortDescriptors: nil, limit: nil, batchSize: nil)
    }
    
    func fetchAll<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate) -> [T] {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: nil, limit: nil, batchSize: nil)
    }
    
    func fetchAll<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate,
                                      sortDescriptors: [NSSortDescriptor]) -> [T] {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: nil, batchSize: nil)
    }
    
    func fetchAll<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate?,
                                      sortDescriptors: [NSSortDescriptor],
                                      limit: Int) -> [T] {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit, batchSize: nil)
    }
    
    func fetchAll<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate,
                                      sortDescriptors: [NSSortDescriptor],
                                      limit: Int,
                                      batchSize: Int) -> [T] {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit, batchSize: batchSize)
    }
}

// MARK: - Fetch First
extension NSManagedObjectContext {
    
    func fetchFirst<T: NSManagedObject>(_ entity: T.Type) -> T? {
        return doFetchAll(entity, predicate: nil, sortDescriptors: nil, limit: nil, batchSize: nil).first
    }
    
    func fetchFirst<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: nil, limit: nil, batchSize: nil).first
    }
    
    func fetchFirst<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate,
                                      sortDescriptors: [NSSortDescriptor]) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: nil, batchSize: nil).first
    }
    
    func fetchFirst<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate?,
                                      sortDescriptors: [NSSortDescriptor],
                                      limit: Int) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit, batchSize: nil).first
    }
    
    func fetchFirst<T: NSManagedObject>(_ entity: T.Type,
                                      predicate: NSPredicate,
                                      sortDescriptors: [NSSortDescriptor],
                                      limit: Int,
                                      batchSize: Int) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit, batchSize: batchSize).first
    }
}

// MARK: - Fetch Last
public extension NSManagedObjectContext {
    
    func fetchLast<T: NSManagedObject>(_ entity: T.Type) -> T? {
        return doFetchAll(entity, predicate: nil, sortDescriptors: nil, limit: nil, batchSize: nil).last
    }
    
    func fetchLast<T: NSManagedObject>(_ entity: T.Type,
                                        predicate: NSPredicate) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: nil, limit: nil, batchSize: nil).last
    }
    
    func fetchLast<T: NSManagedObject>(_ entity: T.Type,
                                        predicate: NSPredicate,
                                        sortDescriptors: [NSSortDescriptor]) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: nil, batchSize: nil).last
    }
    
    func fetchLast<T: NSManagedObject>(_ entity: T.Type,
                                        predicate: NSPredicate?,
                                        sortDescriptors: [NSSortDescriptor],
                                        limit: Int) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit, batchSize: nil).last
    }
    
    func fetchLast<T: NSManagedObject>(_ entity: T.Type,
                                        predicate: NSPredicate,
                                        sortDescriptors: [NSSortDescriptor],
                                        limit: Int,
                                        batchSize: Int) -> T? {
        return doFetchAll(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit, batchSize: batchSize).last
    }
}

// MARK: - Core
fileprivate extension NSManagedObjectContext {
    
    func doFetchAll<T: NSManagedObject>(_ entity: T.Type,
                                        predicate: NSPredicate?,
                                        sortDescriptors: [NSSortDescriptor]?,
                                        limit: Int?,
                                        batchSize: Int?) -> [T] {
        
        let request = NSFetchRequest<T>(entityName: entity.entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        if let limit = limit, limit != 0 {
            request.fetchLimit = limit
        }
        if let batchSize = batchSize, batchSize != 0 {
            request.fetchBatchSize = batchSize
        }
    
        do {
            let items = try fetch(request)
            return items
        } catch {
            fatalError("Couldnt fetch the enities for \(entity.entityName) " + error.localizedDescription)
        }
        
        return []
    }
}
