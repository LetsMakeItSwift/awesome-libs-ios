import Foundation

extension Libraries {
    
    static let DynamicColor = Library(
        id: "DynamicColor",
        name: "DynamicColor",
        description: .init(
            short: "Powerful methods to manipulate colors in an easy way in Swift and SwiftUI",
            full: nil
        ),
        preview: .init(
            logo: nil,
            title: "DynamicColor",
            subtitle: "Powerful methods to manipulate colors in an easy way in Swift and SwiftUI"
        ),
        developers: [
            .init(
                name: "Yannick Loriot",
                contactInformation: ContactInformation(
                    email: nil,
                    website: "http://yannickl.github.io"
                ),
                isCompany: false
            )
        ],
        links: LibraryLinks(
            github: GitHubRepositoryLink(
                user: "yannickl",
                repository: "DynamicColor"
            ),
            other: []
        ),
        integration: LibraryPackageManagers(
            cocoapods: CocoaPodsIntegration(
                podName: "DynamicColor"
            ),
            carthage: CarthageIntegration.github(
                withPath: "yannickl/DynamicColor"
            ),
            swiftPackageManager: nil
        ),
        tags: [
            .ui
        ],
        license: .mit(),
        demo: LibraryDemo(
            screen: nil
        )
    )
}
