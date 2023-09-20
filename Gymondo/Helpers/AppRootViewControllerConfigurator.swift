//
//  AppRootViewControllerConfigurator.swift
//  Gymondo
//
//  Created by Juan Diego Rodriguez Steller on 19/9/23.
//

import Foundation
import UIKit

public protocol AppRootViewControllerConfigurator {
    func getRootViewController() -> UIViewController
    func setupApplicationWindow(_ window: inout UIWindow?, scene: UIScene, using makeRootViewController: () -> UIViewController)
}

extension AppRootViewControllerConfigurator {
    public func setupApplicationWindow(_ window: inout UIWindow?, scene: UIScene, using makeRootViewController: () -> UIViewController) {
        let rootVC = makeRootViewController()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let appWindow = UIWindow(frame: UIScreen.main.bounds)
        appWindow.rootViewController = rootVC
        window = appWindow
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }
}

public struct CommonAppRootViewControllerConfigurator {
    public init() {}
}

extension CommonAppRootViewControllerConfigurator: AppRootViewControllerConfigurator {
    public func getRootViewController() -> UIViewController {
        let networkClient = NetworkClient()
        let wgerNetworkClient = WgerNetworkClient(networkClient: networkClient)
        let imageNetworkClient = ImageNetworkClient(networkClient: networkClient)
        let viewModel = ExerciseListViewModelImpl(networkClient: wgerNetworkClient, imageNetworkClient: imageNetworkClient)
        let viewController = ExerciseListViewController(viewModel: viewModel)
        let navigationVC = UINavigationController()
        navigationVC.pushViewController(viewController, animated: false)
        return navigationVC
    }
}
