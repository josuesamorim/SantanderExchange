//
//  AboutViewController.swift
//  Santander Exchange
//
//  Created by Josué Amorim on 08/10/23.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        view.backgroundColor = .santanderRed
        
      
        let imageView = UIImageView(image: UIImage(named: "Logo_Bootcamp"))
        
       
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        
        
        let logoImageView = UIImageView(image: UIImage(named: "Logo_Dio"))
        

        let helloLabel = UILabel()
        helloLabel.text = "www.dio.me/users/josuedesouzaamorim"
        helloLabel.textColor = .white
        

        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(helloLabel)
        

        view.addSubview(imageView)
        view.addSubview(stackView)
        

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
    }
}
