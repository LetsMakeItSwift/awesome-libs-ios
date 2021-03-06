import Foundation
import LibraryDemo_GlitchLabel

extension Libraries {
    
    static let GlitchLabel = Library(
        id: "glitch-label",
        name: "GlitchLabel",
        description: .init(
            short: "Glitching UILabel for iOS",
            full: nil
        ),
        preview: .init(
            logo: nil,
            title: "GlitchLabel",
            subtitle: "Glitching UILabel for iOS"
        ),
        developers: [
            .init(
                name: "Lee Sun-Hyoup",
                contactInformation: ContactInformation(
                    email: "kciter@naver.com",
                    website: "http://kciter.github.io"
                ),
                isCompany: false
            )
        ],
        links: LibraryLinks(
            github: GitHubRepositoryLink(
                user: "kciter",
                repository: "GlitchLabel"
            ),
            other: []
        ),
        integration: LibraryPackageManagers(
            cocoapods: CocoaPodsIntegration(
                podName: "GlitchLabel"
            ),
            carthage: CarthageIntegration.github(
                withPath: "kciter/GlitchLabel"
            ),
            swiftPackageManager: SwiftPackageManagerIntegration(
                path: "https://github.com/kciter/GlitchLabel.git"
            )
        ),
        tags: [
            .ui
        ],
        license: .mit(),
        demo: LibraryDemo(
            screen: DemoScreen(
                viewControllerClass: LibraryDemoViewController.self,
                nibName: "LibraryDemoViewController",
                bundleIdentifier: "com.wizman.awesome-libraries.LibraryDemo-GlitchLabel",
                enabled: true
            )
        )
    )
}
