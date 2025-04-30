import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async in
        "It works!"
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("ping") { req async -> String in
        "pong!"
    }
    
    app.get("status") { req async -> [String: String] in
        ["message": "Vapor is alive!"]
    }
    
    app.post("location") { req async -> HTTPStatus in
        do {
            let location = try req.content.decode(LocationData.self)
            print("位置情報を受け取りました！:\(location)")
            return .ok
        } catch {
            print("リクエストを捌くの失敗しました・・;;")
            return .internalServerError
        }
    }

    try app.register(collection: TodoController())
}
