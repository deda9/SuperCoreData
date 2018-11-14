import CoreData

// MARK: - Entity Name
extension NSManagedObject {
    class var entityName: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

// MARK: - Create
extension NSManagedObject {
    class func createEntity(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext) -> NSManagedObject{
        let entity = NSEntityDescription.insertNewObject(forEntityName: NSManagedObject.entityName, into: context)
        return entity
    }
}

// MARK: - Delete
extension NSManagedObject {
    func deleteEntity(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext) {
        context.delete(self)
    }
    
    class func deleteAll(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext) {
        context.fetchAll(self).forEach{ $0.deleteEntity(in: context) }
    }
    
    class func deleteAll(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext, predicate: NSPredicate) {
        context.fetchAll(self, predicate: predicate).forEach{ $0.deleteEntity(in: context) }
    }
}

// MARK: - Fetch
extension NSManagedObject {
    class func fetchAll(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext) -> [NSManagedObject] {
        return context.fetchAll(self)
    }
    
    class func fetchAll(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                        predicate: NSPredicate) -> [NSManagedObject] {
        return context.fetchAll(self, predicate: predicate)
    }
    
    class func fetchAll(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                        predicate: NSPredicate,
                        sortDescriptors: [NSSortDescriptor]) -> [NSManagedObject] {
        return context.fetchAll(self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    class func fetchAll(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                        predicate: NSPredicate?,
                        sortDescriptors: [NSSortDescriptor],
                        limit: Int) -> [NSManagedObject] {
        return context.fetchAll(self, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit)
    }
    
    class func fetchAll(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                        predicate: NSPredicate,
                        sortDescriptors: [NSSortDescriptor],
                        limit: Int,
                        batchSize: Int) -> [NSManagedObject] {
        return context.fetchAll(self, predicate: predicate, sortDescriptors: sortDescriptors,
                                limit: limit, batchSize: batchSize)
    }
}

// MARK: - Fetch First
extension NSManagedObject {
    class func fetchFirst(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext) -> NSManagedObject? {
        return context.fetchFirst(self)
    }
    
    class func fetchFirst(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                          predicate: NSPredicate) -> NSManagedObject? {
        return context.fetchFirst(self, predicate: predicate)
    }
    
    class func fetchFirst(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                          predicate: NSPredicate,
                          sortDescriptors: [NSSortDescriptor]) -> NSManagedObject? {
        return context.fetchFirst(self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    class func fetchFirst(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                          predicate: NSPredicate,
                          sortDescriptors: [NSSortDescriptor],
                          limit: Int) -> NSManagedObject? {
        return context.fetchFirst(self, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit)
    }
    
    class func fetchFirst(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                          predicate: NSPredicate,
                          sortDescriptors: [NSSortDescriptor],
                          limit: Int,
                          batchSize: Int) -> NSManagedObject? {
        return context.fetchFirst(self, predicate: predicate, sortDescriptors: sortDescriptors,
                                  limit: limit, batchSize: batchSize)
    }
}

// MARK: - Fetch Last
extension NSManagedObject {
    class func fetchLast(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext) -> NSManagedObject? {
        return context.fetchLast(self)
    }
    
    class func fetchLast(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                         predicate: NSPredicate) -> NSManagedObject? {
        return context.fetchLast(self, predicate: predicate)
    }
    
    class func fetchLast(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                         predicate: NSPredicate,
                         sortDescriptors: [NSSortDescriptor]) -> NSManagedObject? {
        return context.fetchLast(self, predicate: predicate, sortDescriptors: sortDescriptors)
    }
    
    class func fetchLast(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                         predicate: NSPredicate,
                         sortDescriptors: [NSSortDescriptor],
                         limit: Int) -> NSManagedObject? {
        return context.fetchLast(self, predicate: predicate, sortDescriptors: sortDescriptors, limit: limit)
    }
    
    class func fetchLast(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                         predicate: NSPredicate,
                         sortDescriptors: [NSSortDescriptor],
                         limit: Int,
                         batchSize: Int) -> NSManagedObject? {
        return context.fetchLast(self, predicate: predicate, sortDescriptors: sortDescriptors,
                                 limit: limit, batchSize: batchSize)
    }
}

// MARK: - Fetch Last
extension NSManagedObject {
    class func count(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext) -> Int {
        return context.fetchAll(self).count
    }
    
    class func count(in context: NSManagedObjectContext = SuperCoreData.shared.defaultContext,
                     predicate: NSPredicate) -> Int {
        return context.fetchAll(self, predicate:predicate).count
    }
}
