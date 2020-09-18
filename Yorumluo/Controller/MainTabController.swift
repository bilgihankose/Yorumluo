//
//  MainTabController.swift
//  Yorumluo
//
//  Created by Bilgihan Köse on 17.09.2020.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        authUserAndConfigureUI()

    }
    
    
    //MARK: - API
    
    func authUserAndConfigureUI(){
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginVC())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            configureUI()
            
            }
        }
    
    
    
    
    
    
    //MARK: -Selector
    
    @objc func actionButtonTapped(){
        print("Hello")
    }
    
    
    //MARK: - UI
    
    func configureUI(){
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
    
    //MARK: - Helpers
    //Create programmaticly all of the view controllers for application
    
    func configureViewControllers(){
        
        let feed = FeedVC()
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootVC: feed)
        
        let explore = ExploreVC()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootVC: explore)
        
        let notification = NotificationVC()
        let nav3 = templateNavigationController(image: UIImage(named: "like_unselected"), rootVC: notification)
        
        let conversation = ConversationVC()
        let nav4 = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootVC: conversation)
        
        viewControllers = [nav1, nav2, nav3, nav4]
        
   
    }
    func templateNavigationController(image: UIImage?, rootVC: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootVC)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
}
