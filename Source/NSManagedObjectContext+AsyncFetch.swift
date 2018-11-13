import CoreData

// MARK: - Fetch All Async
extension NSManagedObjectContext {
    
    func fetchAllAsyncAsync<T: NSManagedObject>(_ entity: T.Type, complection: (([T]) -> Void)?) {
        doFetchAllAsync(entity, predicate: nil, sortDescriptors: nil, limit: nil,
                        batchSize: nil, complection: complection)
    }
    
    func fetchAllAsync<T: NSManagedObject>(_ entity: T.Type,
                                           predicate: NSPredicate,
                                           complection: (([T]) -> Void)?) {
        doFetchAllAsync(entity, predicate: predicate, sortDescriptors: nil,
                        limit: nil, batchSize: nil, complection: complection)
    }
    
    func fetchAllAsync<T: NSManagedObject>(_ entity: T.Type,
                                           predicate: NSPredicate,
                                           sortDescriptors: [NSSortDescriptor],
                                           complection: (([T]) -> Void)?) {
        doFetchAllAsync(entity, predicate: predicate, sortDescriptors: sortDescriptors,
                        limit: nil, batchSize: nil, complection: complection)
    }
    
    func fetchAllAsync<T: NSManagedObject>(_ entity: T.Type,
                                           predicate: NSPredicate?,
                                           sortDescriptors: [NSSortDescriptor],
                                           limit: Int,
                                           complection: (([T]) -> Void)?) {
        doFetchAllAsync(entity, predicate: predicate, sortDescriptors: sortDescriptors,
                        limit: limit, batchSize: nil, complection: complection)
    }
    
    func fetchAllAsync<T: NSManagedObject>(_ entity: T.Type,
                                           predicate: NSPredicate,
                                           sortDescriptors: [NSSortDescriptor],
                                           limit: Int,
                                           batchSize: Int,
                                           complection: (([T]) -> Void)?) {
        doFetchAllAsync(entity, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit,
                        batchSize: batchSize, complection: complection)
    }
}

// MARK: - Core
fileprivate extension NSManagedObjectContext {
    
    func doFetchAllAsync<T: NSManagedObject>(_ entity: T.Type,
                                             predicate: NSPredicate?,
                                             sortDescriptors: [NSSortDescriptor]?,
                                             limit: Int?,
                                             batchSize: Int?,
                                             complection: (([T]) -> Void)?) {
        
        let request = NSFetchRequest<T>(entityName: entity.entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        if let limit = limit, limit != 0 {
            request.fetchLimit = limit
        }
        if let batchSize = batchSize, batchSize != 0 {
            request.fetchBatchSize = batchSize
        }
        
        let asyncRequest = NSAsynchronousFetchRequest(fetchRequest: request) { result in
            complection?(result.finalResult ?? [])
        }
        
        perform {
            do {
                try self.execute(asyncRequest)
            }catch {
                fatalError("Couldnt fetch async the enities for \(entity.entityName) " + error.localizedDescription)
            }
        }
    }
}
