import CoreData

// MARK: - Save
extension NSManagedObjectContext {
    
    func save(_ complection: (() -> Void)? = nil) {
        if let complection = complection {
            self.doSave(complection)
        } else {
            self.doSave()
        }
    }
    
    private func doSave() {
        do {
            try self.save()
            try self.parent?.save()
        } catch {
            fatalError("\(self): failed to save context \(error.localizedDescription)")
        }
    }
    
    private func doSave(_ complection: (() -> Void)) {
        performAndWait {
            complection()
            self.doSave()
        }
    }
}

// MARK: - Save Async
extension NSManagedObjectContext {
    func saveAsync(_ complection: ((_ context: NSManagedObjectContext) -> Void)?) {
        var context = self
        if self.concurrencyType != .privateQueueConcurrencyType {
            context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
            context.parent = self
        }
        
        context.perform {
            if context.hasChanges {
                self.doSaveAsync(complection)
            } else {
                DispatchQueue.main.async {
                    complection?(context)
                }
            }
        }
    }
    
    private func doSaveAsync(_ complection: ((_ context: NSManagedObjectContext) -> Void)?) {
        do {
            try self.save()
            if let parent = self.parent {
                parent.doSaveAsync(complection)
            } else {
                complection?(self)
            }
        } catch {
            complection?(self)
            fatalError("\(self): failed to save context \(error.localizedDescription)")
        }
    }
}
