//
//  SceneDelegate.swift
//  Geo Data
//
//  Created by Денис Павлов on 13.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        

        
        let eventsNavigationController = UINavigationController()
        let eventsBuilder = EventsAssemblyBuilder()
        let eventsRouter = EventsRouter(navigationController: eventsNavigationController, eventsAssemblyBuilder: eventsBuilder)
        eventsRouter.showEventsInitial()
        
        let profileNavigationController = UINavigationController()
        let profileBuilder = ProfileAssemblyBuilder()
        let profileRouter = ProfileRouter(navigationController: profileNavigationController, profileAssemblyBuilder: profileBuilder)
        profileRouter.showInitial()
        
        let mapNavigationComtroller = UINavigationController()
        let mapBuilder = MapAssemblyBuilder()
        let mapRouter = MapRouter(navigationController: mapNavigationComtroller, mapAssemblyBuilder: mapBuilder)
        mapRouter.showInitial()
        
        //mainVC.tabBarItem = UITabBarItem(title: ElementNames.TitleNames.mainTitleName, image: UIImage(named: "MainItem"), tag: 0)
        
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .systemGray6
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0, green: 0.750218153, blue: 0.4715135098, alpha: 1)
        tabBarController.setViewControllers([mapNavigationComtroller,
                                             eventsNavigationController,
                                             profileNavigationController],
                                            animated: true)
        
        window.rootViewController = tabBarController
        //tabBarController.selectedIndex = 2
        window.makeKeyAndVisible()

        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

