import CoreData

class SuperCoreData {
    
    private struct Configurations {
        struct Model {
            static let name = "MODEL"
            static let mom = "mom"
            static let momd = "momd"
        }
        
        static let persistentStoreCoordinatorOptions: [String: Any] = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true]
    }
    
    public static let `default`: SuperCoreData = SuperCoreData()
    
    public var mainBundle: Bundle = Bundle.main
    public var modelName: String = Configurations.Model.name
    public var persistentStoreCoordinatorOptions: [String: Any]  = Configurations.persistentStoreCoordinatorOptions
    
    private(set) lazy var sqliteStoreURL: URL = self.createSqliteStoreURL()
    private(set) lazy var modelURL: URL = self.createModelURL()
    
    fileprivate lazy var _presistentStoreCoordinator: NSPersistentStoreCoordinator = self.createPresistentStoreCoordinator()
    fileprivate lazy var _managedObjectModel: NSManagedObjectModel = self.createManagedObjectModel()
    fileprivate lazy var _defaultContext: NSManagedObjectContext = self.defaultManagedObjectContext()
    
    private init() {}
}

fileprivate extension SuperCoreData {
    
    func save() {
        self._defaultContext.save(nil)
    }
    
    func createManagedObjectModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel(contentsOf: self.modelURL)
        return model!
    }
    
    func createPresistentStoreCoordinator() -> NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        func doMigration() {
            //TODO: add migration later
        }
        
        func configureCoordinatorSqlite() {
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                   configurationName: nil,
                                                   at: self.sqliteStoreURL,
                                                   options: Configurations.persistentStoreCoordinatorOptions)
            } catch {
                fatalError("Couldnt add sqlite inot store coordinator" + error.localizedDescription)
            }
        }
       
        func checkMigrationsAvailability() {
            let migrateAuto =
                Configurations.persistentStoreCoordinatorOptions[NSMigratePersistentStoresAutomaticallyOption] as? Bool ?? false
            let inferMappingModelAuto =
                Configurations.persistentStoreCoordinatorOptions[NSInferMappingModelAutomaticallyOption] as? Bool ?? false
            
            switch (migrateAuto, inferMappingModelAuto) {
            case (true, false):
                doMigration()
            default:
                configureCoordinatorSqlite()
            }
        }
        
        checkMigrationsAvailability()
        return coordinator
    }
    
    func defaultManagedObjectContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.performAndWait { [weak self] in
            guard let `self` = self else { return }
            context.persistentStoreCoordinator =  self.presistentStoreCoordinator
        }
        return context
    }
}

extension SuperCoreData {
    
    public var presistentStoreCoordinator: NSPersistentStoreCoordinator {
        return _presistentStoreCoordinator
    }
    
    public var managedObjectModel: NSManagedObjectModel {
        return _managedObjectModel
    }
    
    public var defaultContext: NSManagedObjectContext {
        return _defaultContext
    }
}

fileprivate extension SuperCoreData {
    
    func createSqliteStoreURL() -> URL {
        guard let applicationDocumentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Couldnt get the application document directory")
        }
        let url = applicationDocumentDirectory.appendingPathComponent(self.modelName + ".sqlite")
        return url as URL
    }
    
    func createModelURL() -> URL {
        let mom = mainBundle.url(forResource: self.modelName, withExtension: Configurations.Model.mom)
        let momd = mainBundle.url(forResource: self.modelName, withExtension: Configurations.Model.momd)
        
        switch (mom, momd) {
        case (nil, let url):
            return url!
        case(let _url, nil):
            return _url!
        default:
            fatalError("Could not load default model URL. There is no \(modelName).mom/\(modelName).momd files in bundle: \(mainBundle)")
        }
    }
}
