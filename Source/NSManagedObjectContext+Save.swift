import CoreData

// MARK: - Save
extension NSManagedObjectContext {
    
    func save(_ complection: ((_ success: Bool) -> Void)? = nil) {
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
    
    private func doSave(_ complection: ((_ success: Bool) -> Void)) {
        performAndWait {
            do {
                complection(true)
                try self.save()
                try self.parent?.save()
            } catch {
                complection(false)
                fatalError("\(self): failed to save context \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Save Async
extension NSManagedObjectContext {
    func saveAsync(_ complection: ((_ success: Bool) -> Void)?) {
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
                    complection?(true)
                }
            }
        }
    }
    
    private func doSaveAsync(_ complection: ((_ success: Bool) -> Void)?) {
        do {
            try self.save()
            if let parent = self.parent {
                parent.doSaveAsync(complection)
            } else {
                complection?(true)
            }
        } catch {
            complection?(false)
            fatalError("\(self): failed to save context \(error.localizedDescription)")
        }
    }
}
