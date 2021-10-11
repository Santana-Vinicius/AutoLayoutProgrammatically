//
//  ViewController.swift
//  AutoLayoutTutorial
//
//  Created by Vinicius Araujo on 08/10/21.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    
    /**
     * ContainerView será a área azul onde todas as subviews estarão
     * dentro! Utilizamos lazy nesse caso para que o Xcode não execute
     * o código dentro das closures até que a View seja inicializada
     */
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        
        // Adiciona a imagem de perfil
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // Centraliza a view
        profileImageView.anchor(top: view.topAnchor, paddingTop: 88, width: 120, height: 120) // Configura seu anchor
        profileImageView.layer.cornerRadius = 120 / 2 // Arredonda as bordas
        
        // Adiciona botão de mensagens e configuramos seu anchor
        view.addSubview(messageButtom)
        messageButtom.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 64,
                             paddingLeft: 32, width: 32, height: 32)
        
        // Adiciona botão de mensagens e configuramos seu anchor
        view.addSubview(followButtom)
        followButtom.anchor(top: view.topAnchor, right: view.rightAnchor, paddingTop: 64,
                            paddingRight: 32, width: 32, height: 32)
        
        // Adiciona a label de nome e configura seu anchor abaixo da imagem de perfil
        view.addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // Centraliza a label
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
        
        // Adiciona a label de email e configura seu anchor abaixo da label de nome
        view.addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // Centraliza a label
        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
        
        return view
    }()
    
    // Declaração e configuração da imagem de perfil
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "venom")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        
        return imageView
    }()
    
    // Declaração e configuração do botão de mensagens
    let messageButtom: UIButton = {
        let buttom = UIButton(type: .system)
        buttom.setImage(UIImage(named: "ic_mail_outline_white_2x")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttom.addTarget(self, action: #selector(handleMessageUser), for: .touchUpInside)
    
        return buttom
    }()
    
    // Declaração e configuração do botão de follow
    let followButtom: UIButton = {
        let buttom = UIButton(type: .system)
        buttom.setImage(UIImage(named: "baseline_person_add_white_36dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        buttom.addTarget(self, action: #selector(handleFollowUser), for: .touchUpInside)
        
        return buttom
    }()
    
    
    // Declaração e configuração da label com o username
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Eddie Brock"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textColor = .white
    
        return label
    }()
    
    // Declaração e configuração da label com o email
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "venom@gmail.com"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    
    //MARK: - Lifeycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 300)
    }
    
    // Setamos a StatusBar para o modo Light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // MARK: - Selectors
    @objc func handleMessageUser() {
        print("Message user here...")
    }
    
    @objc func handleFollowUser() {
        print("Follow user here...")
    }
    
}

extension UIColor {
    // Criamos cores a partir do código RGB
    static func rgd(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    // Criamos uma nova UIColor chamada mainBlue
    static let mainBlue = UIColor.rgd(red: 0, green: 120, blue: 255)
}


extension UIView {
    /* Esses valores (top, left,bottom and right) são pré inicializados com nil
     * pois nem sempre precisaremos de todos eles.
     *
     * O mesmo ocorre para os elementos padding, nós provavelmente não utilizaremos
     * todos eles, portanto vamos pré inicializá-los.
     *
     * Para width e height utilizamos nil pois para elementos como labels o
     * Xcode pode inferir seus valores sozinho. Caso utilizemos 0, eles simplesmente
     * não aparecerão!
     *
     */
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat? = 0, paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0,
                paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil){
        
        // Precisamos setar esse cara como false caso contrário nossas constraints programaticas não funcionarão!
        translatesAutoresizingMaskIntoConstraints = false
        
        
        // Ativamos as nossas constraints para top, left, bottom, right, width e height
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
            
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
            
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}

