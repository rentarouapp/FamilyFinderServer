import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    if let host = Environment.get("DATABASE_HOST") {
        print("🔌 DATABASE_HOST: \(host)")
    } else {
        print("⚠️ DATABASE_HOST not found in environment")
    }
    
    if let port = Environment.get("DATABASE_PORT") {
        print("⚓️ DATABASE_PORT: \(port)")
    } else {
        print("⚠️ DATABASE_PORT not found in environment")
    }
    
    if let userName = Environment.get("DATABASE_USERNAME") {
        print("👦 DATABASE_USERNAME: \(userName)")
    } else {
        print("⚠️ DATABASE_USERNAME not found in environment")
    }
    
    if let password = Environment.get("DATABASE_PASSWORD"),
       password.isEmpty == false {
        print("㊙️ DATABASE_PASSWORD is available")
    } else {
        print("⚠️ DATABASE_PASSWORD not found in environment")
    }
    
    if let name = Environment.get("DATABASE_NAME") {
        print("📛 DATABASE_NAME: \(name)")
    } else {
        print("⚠️ DATABASE_NAME not found in environment")
    }

    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database",
        tls: .disable)
    ), as: .psql)

    app.migrations.add(CreateTodo())
    app.migrations.add(CreateLocation())
    app.migrations.add(SeedLocation())
    
    // 外部からアクセスを許可するために必要
    app.http.server.configuration.hostname = "0.0.0.0"

    // register routes
    try routes(app)
}
