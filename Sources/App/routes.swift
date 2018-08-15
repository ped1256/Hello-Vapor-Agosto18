import Vapor
import Foundation

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    
    
    router.get("hello", String.parameter) { req -> String in
        guard let name = req.parameters.values.first?.value else { return "null" }

        return "Hello \(name) !"
    }

//    router.post("info") { req -> InfoResponse in
//        let data = try req.content.decode(InfoData.self)
//
//    }
    
    router.get("count",Int.parameter) { req -> NumberJSON in
        let count = try req.parameters.next(Int.self)
        return NumberJSON(count: count)
    }
    
    router.get("date") { req in
        return String("\(Date())")
    }
    
    router.post("user-info"){ req -> UserInfoJSON in
        let data = try req.content.syncDecode(UserInfoJSON.self)
        return UserInfoJSON(name: data.name, age: data.age)
    }
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let request: InfoData
}
struct NumberJSON: Content {
    let count: Int
}
struct UserInfoJSON: Content {
    let name: String
    let age: Int
}



