//
//  ViewController.swift
//  DependencyInjection
//
//  Created by TCH Developer on 17/11/2022.
//

import UIKit
import APIKit
import MyAppUIKit

extension APICaller: DataFetchable {}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemRed
        button.setTitle("Press Me", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }

    @objc private func didTapButton() {
        // We tell the below that APICaller.shared is fetchable at the top of our code with the extension
        let vc = CoursesViewController(dataFetchable: APICaller.shared)
        present(vc, animated: true)
    }

}

