import CallableKit
import CallableKitVaporTransport
import Vapor
import XCTest
import XCTVapor

@Callable
public protocol TestServiceProtocol {
    func hello(name: String) async throws -> String
}

struct TestService: TestServiceProtocol {
    func hello(name: String) async throws -> String {
        "Hello, \(name)!"
    }
}

final class CallableKitVaporTransportTests: XCTestCase {
    func testExample() async throws {
        let app = try await Application.make()
        defer {
            Task { try await app.asyncShutdown() }
        }

        configureTestServiceProtocol(transport: VaporTransport(router: app.routes) { _ in
            TestService()
        })

        try await app.test(
            .POST,
            "/Test/hello",
            beforeRequest: { (request) async throws in
                request.body = .init(string: """
                "Vapor"
                """)
            },
            afterResponse: { (response) async throws in
                XCTAssertEqual(response.status, .ok)
                XCTAssertEqual(String(buffer: response.body), """
                "Hello, Vapor!"
                """)
            }
        )
    }
}
