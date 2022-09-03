//
//  SceneDelegate.swift
//  YourMovie
//
//  Created by Bruno Silva on 01/12/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public Properties
    
    var window: UIWindow?
    
    // MARK: - Public Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let viewModel = ViewModel()
        let movieViewController = MovieViewController(viewModel: viewModel)
        
        self.window?.rootViewController = movieViewController
        self.window?.windowScene = windowScene
        self.window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

