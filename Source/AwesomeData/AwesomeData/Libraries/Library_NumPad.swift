import Foundation
import LibraryDemo_NumPad

extension Libraries {
    
    static let NumPad = Library(
        id: "numpad",
        name: "NumPad",
        description: .init(
            short: "Number Pad inspired by Square",
            full: nil
        ),
        preview: .init(
            logo: nil,
            title: "NumPad",
            subtitle: "Number Pad inspired by Square"
        ),
        developers: [
            .init(
                name: "Lasha Efremidze",
                contactInformation: ContactInformation(
                    email: nil,
                    website: "http://twitter.com/efremidze_"
                ),
                isCompany: false
            )
        ],
        links: LibraryLinks(
            github: GitHubRepositoryLink(
                user: "efremidze",
                repository: "Cluster"
            ),
            other: []
        ),
        integration: LibraryPackageManagers(
            cocoapods: CocoaPodsIntegration(
                podName: "NumPad"
            ),
            carthage: CarthageIntegration.github(
                withPath: "efremidze/NumPad"
            ),
            swiftPackageManager: nil
        ),
        tags: [
            .ui
        ],
        license: .mit(),
        demo: LibraryDemo(
            screen: DemoScreen(
                viewControllerClass: LibraryDemoViewController.self,
                nibName: "LibraryDemoViewController",
                bundleIdentifier: "com.wizman.awesome-libraries.LibraryDemo-NumPad",
                enabled: true
            )
        )
    )
}
