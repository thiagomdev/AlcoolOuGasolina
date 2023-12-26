import UIKit

final class GasTypeCalculatorViewController: UIViewController {
    private var viewModel: GasTypeCalculatorViewModeling
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Botão Back"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var backgroungImageview = UIImageView.makeImageView("BG BLUR")
    private lazy var logoImageview = UIImageView.makeImageView("LOGO menor")

    private lazy var calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("CALCULAR", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 230/255, green: 0/255, blue: 127/255, alpha: 1.0)
        button.addTarget(self, action: #selector(handleCalculateButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var ethanolPriceTextField = UITextField.makeTextField("Preço do Àlcool")
    private lazy var gasPriceTextField = UITextField.makeTextField("Preço da Gasolina")

    init(viewModel: GasTypeCalculatorViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc
    private func handleCalculateButton() {
        handleAlert()
        guard let ethanol = ethanolPriceTextField.text else { return }
        guard let gas = gasPriceTextField.text else { return }
        viewModel.calculatePrice(from: ethanol, gas)
    }
    
    @objc
    private func handleBackButton() {
        viewModel.backToHome()
    }
    
    private func handleAlert() {
        viewModel.showAlert = {
            let alert = CustomAlert(view: self)
            alert.showAlert(
                title: "Atenção!",
                message: "Preencha ambos os campos, para que o calculo seja feito."
            )
        }
    }
}

extension GasTypeCalculatorViewController: ViewConfiguration {
    func buildViews() {
        view.add(
            subviews: backgroungImageview,
            calculateButton, logoImageview,
            ethanolPriceTextField,
            gasPriceTextField,
            backButton
        )
    }
    
    func setupPin() {
        NSLayoutConstraint.pin([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            backgroungImageview.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroungImageview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 104),
            logoImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            calculateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 60),
            calculateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -60),
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -125),
            calculateButton.heightAnchor.constraint(equalToConstant: 44),
            
            ethanolPriceTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ethanolPriceTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ethanolPriceTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ethanolPriceTextField.heightAnchor.constraint(equalToConstant: 44),
            
            gasPriceTextField.topAnchor.constraint(equalTo: ethanolPriceTextField.bottomAnchor, constant: 12),
            gasPriceTextField.leadingAnchor.constraint(equalTo: ethanolPriceTextField.leadingAnchor),
            gasPriceTextField.trailingAnchor.constraint(equalTo: ethanolPriceTextField.trailingAnchor),
            gasPriceTextField.heightAnchor.constraint(equalTo: ethanolPriceTextField.heightAnchor),
        ])
    }
    
    func configUI() {
        view.backgroundColor = .systemBackground
    }
}
