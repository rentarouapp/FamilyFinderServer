import NIOSSL
import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    if let dbURL = Environment.get("DATABASE_URL") {
        print("🚀 DATABASE_URL: \(dbURL)")
    } else {
        print("⚠️ DATABASE_URL not found in environment")
    }
    
    if let userName = Environment.get("DATABASE_USERNAME") {
        print("👦 DATABASE_USERNAME: \(userName)")
    } else {
        print("⚠️ DATABASE_USERNAME not found in environment")
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
