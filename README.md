# SuperCoreData
It's just a wrapper for the CoreData to CRUD operations with easy way

All you need to set coreData persistentStoreCoordinator Options in `AppDelegate` or use the default ones

You can create entity 
```Swift
let person: Person = SuperCoreData.default.defaultContext.createEntity()
person.name = "Deda"
person.email = "Deda@gmail.com"
person.title = "Developer"
person.age = 28
```

Then you can save this entity by calling save with/without completion handler
  ```Swift
SuperCoreData.default.defaultContext.save { isSuccess in
    //Do what you need when it succeeded
}
```


Then you can fetch your modes by perdicate
  ```Swift
let perdicate = NSPredicate.init(format: "name == %@", "Deda")
let person: Person? = SuperCoreData.default.defaultContext.fetchFirst(Person.self, predicate: perdicate)
```

Then can get the number of the entity in DataBase like
  ```Swift
let personsCount = Person.count()
```
