import Foundation
import LibraryDemo_UIGradient

extension Libraries {
    
    static let UIGradient = Library(
        id: "UIGradient",
        name: "UIGradient",
        description: .init(
            short: "Simple and powerful library for using gradient layer, image, color",
            full: nil
        ),
        preview: .init(
            logo: Image(
                name: "library_uigradient",
                bundleIdentifier: Bundle.AwesomeData_identifier
            ),
            title: "UIGradient",
            subtitle: "Simple and powerful library for using gradient layer, image, color"
        ),
        developers: [
            .init(
                name: "Đinh Quang Hiếu",
                contactInformation: ContactInformation(
                    email: "dqhieu13@gmail.com",
                    website: "http://dqhieu.github.io"
                ),
                isCompany: false
            )
        ],
        links: LibraryLinks(
            github: GitHubRepositoryLink(
                user: "dqhieu",
                repository: "UIGradient"
            ),
            other: []
        ),
        integration: LibraryPackageManagers(
            cocoapods: CocoaPodsIntegration(
                podName: "UIGradient"
            ),
            carthage: nil,
            swiftPackageManager: nil
        ),
        tags: [
            .ui
        ],
        license: .mit(),
        demo: LibraryDemo(
            screen: DemoScreen(
                viewControllerClass: UIGradient_LibraryDemoViewController.self,
                nibName: "UIGradient_LibraryDemoViewController",
                bundleIdentifier: "com.wizman.awesome-libraries.LibraryDemo-UIGradient",
                enabled: true
            )
        )
    )
}
