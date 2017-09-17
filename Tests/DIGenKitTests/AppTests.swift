//
//  AppTests.swift
//  DIKitPackageDescription
//
//  Created by Yosuke Ishikawa on 2017/09/16.
//

import XCTest
import DIGenKit
import DIKit

final class UserProfileViewCotroller: Injectable {
    struct Dependency {
        let userID: Int64
        let apiClient: APIClient
    }

    init(dependency: Dependency) {}
}

final class APIClient {}

protocol AppResolver: Resolver {
    func provideAPIClient() -> APIClient
}

final class AppTests: XCTestCase {
    func test() {
        let generator = CodeGenerator(path: #file)
        let contents = try! generator.generate().trimmingCharacters(in: .whitespacesAndNewlines)
        XCTAssertEqual(contents, """
            //
            //  Resolver.swift
            //  Generated by dikitgen.
            //

            extension AppResolver {

                func resolveAPIClient() -> APIClient {
                    return provideAPIClient()
                }

                func resolveUserProfileViewCotroller(userID: Int64) -> UserProfileViewCotroller {
                    let apiClient = resolveAPIClient()
                    return UserProfileViewCotroller(dependency: .init(userID: userID, apiClient: apiClient))
                }

            }
            """)
    }
}
