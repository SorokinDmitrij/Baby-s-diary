//
//  ViewController.swift
//  Baby's diary
//
//  Created by mac on 19.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
        let image = UIImageView ()
        image.backgroundColor = .cyan
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var labelOne: UILabel = {
        let label = UILabel()
        label.text = "Hi there!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 23)
        return label
    }()
    
    lazy var labelTwo: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var verticalStackViewOne: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    
    func setup(){
        view.addSubview(verticalStackView)
        view.addSubview(verticalStackViewOne)
        view.backgroundColor = .white
        setupStackViews()
        
        
    }
    
    func setupStackViews() {
        verticalStackView.addArrangedSubview(imageView)
        verticalStackView.addArrangedSubview(labelOne)
       verticalStackViewOne.addArrangedSubview(labelTwo)
        
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            verticalStackViewOne.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 20),
            verticalStackViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            verticalStackViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
    }
    
}




