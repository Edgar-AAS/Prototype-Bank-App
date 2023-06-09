import Foundation
import UIKit

public class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.primaryColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.primaryColor
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = Colors.secundaryColor
        return label
    }()
    
    lazy var loginDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Acesse sua conta com email e senha."
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor(hexString: "#cecece")
        return label
    }()	
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        loadingView.style = .large
        loadingView.color = Colors.secundaryColor
        return loadingView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Colors.secundaryColor
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = Colors.primaryColor
        return button
    }()
    
    lazy var loginImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "home-logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var emailTextField = CustomTextField(placeholderText: "Digite seu email")
    lazy var passwordTextField = CustomTextField(placeholderText: "Digite sua senha")
    
    private lazy var goToSignUpLabel: UILabel = {
        let label = UILabel()
        let firstAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: UIColor.white]
        let secondAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor: Colors.secundaryColor]
        let attributedText = NSMutableAttributedString()
        attributedText.append(NSAttributedString(string: "Não tem conta?", attributes: firstAttributes))
        attributedText.append(NSAttributedString(string: " Cadastre-se",attributes: secondAttributes))
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        return label
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        loginButton.layer.cornerRadius = 30
        loginButton.clipsToBounds = true
    }
}

extension LoginView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backgroundView)
        backgroundView.addSubview(loginImageView)
        containerView.addSubview(loginLabel)
        containerView.addSubview(loginDescriptionLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(loginButton)
        containerView.addSubview(goToSignUpLabel)
        containerView.addSubview(loadingIndicator)
    }
    
    func setupConstrains() {
        let safeArea = safeAreaLayoutGuide
        
        scrollView.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: bottomAnchor
        )
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        backgroundView.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        
        loginImageView.fillConstraints(
            top: backgroundView.topAnchor,
            leading: nil,
            trailing: nil,
            bottom: backgroundView.bottomAnchor,
            padding: .init(top: 16, left: 0, bottom: 16, right: 0),
            size: .init(width: 128, height: 128)
        )
        
        loginImageView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        
        loginLabel.fillConstraints(
            top: backgroundView.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        loginDescriptionLabel.fillConstraints(
            top: loginLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 16, bottom: 0, right: 16)
        )
        
        emailTextField.fillConstraints(
            top: loginDescriptionLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        passwordTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        loginButton.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 32, bottom: 0, right: 32),
            size: .init(width: 0, height: 60)
        )
        
        goToSignUpLabel.fillConstraints(
            top: loginButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        loadingIndicator.fillConstraints(
            top: goToSignUpLabel.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 20, left: 16, bottom: 16, right: 16)
        )
        
        loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        configureTextFieldsOrder()
        setupKeyboardTypes()
        emailTextField.setupLeftImageView(image: UIImage(systemName: "envelope")!, with: Colors.secundaryColor)
        passwordTextField.setupLeftImageView(image: UIImage(systemName: "lock")!, with: Colors.secundaryColor)
        emailTextField.text = "test@gmail.com"
        passwordTextField.text = "123@"
    }
    
    private func setupKeyboardTypes() {
        emailTextField.keyboardType = .emailAddress
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true
    }
    
    private func configureTextFieldsOrder() {
        emailTextField.tag = 1
        passwordTextField.tag = 2
    }
    
    func setupDelegateTextFields(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
}
