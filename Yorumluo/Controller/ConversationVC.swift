//
//  ConversationVC.swift
//  Yorumluo
//
//  Created by Bilgihan Köse on 17.09.2020.
//

import UIKit

class ConversationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       configureUI()
    }
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}


