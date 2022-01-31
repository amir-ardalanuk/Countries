//
//  HomeViewController.swift
//  Countries
//
//  Created by Amir Ardalani on 1/29/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        let syb = UIView()
        self.view.addSubview(syb)
        syb.frame = self.view.frame
        syb.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }
    
    deinit {
        print("deinit")
    }
}
