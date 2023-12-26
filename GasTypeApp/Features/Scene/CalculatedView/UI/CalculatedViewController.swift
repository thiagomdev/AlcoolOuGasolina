import UIKit

final class CalculatedViewController: UIViewController {
    private let viewModel: CalculatedViewModeling
    
    private lazy var backgroungImageview: UIImageView = {
        let backgroung = UIImageView()
        backgroung.image = UIImage(named: "BG BLUR")
        backgroung.contentMode = .scaleAspectFit
        return backgroung
    }()
    
    private lazy var logoImageview: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "LOGO menor")
        logo.contentMode = .scaleAspectFit
        return logo
    }()
    
    private lazy var phaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Abasteça com:"
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 36)
        return label
    }()
    
    lazy var calculatedPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 70)
        return label
    }()
    
    private lazy var calculatePriceAgainButton: UIButton = {
        let button = UIButton()
        button.setTitle("CALCULAR NOVAMENTE", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBrown
        button.backgroundColor = UIColor(red: 230/255, green: 0/255, blue: 127/255, alpha: 1.0)
        button.addTarget(self, action: #selector(handleCalculatedPriceButton), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: CalculatedViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleCalculatedPriceButton() {
        viewModel.calculatePrice()
    }
}

extension CalculatedViewController: ViewConfiguration {
    func buildViews() {
        view.add(
            subviews: backgroungImageview,
            logoImageview,
            phaseLabel,
            calculatedPriceLabel,
            calculatePriceAgainButton
        )
    }
    
    func setupPin() {
        NSLayoutConstraint.pin([
            backgroungImageview.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroungImageview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageview.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 104
            ),
            logoImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phaseLabel.topAnchor.constraint(
                equalTo: logoImageview.bottomAnchor,
                constant: 120
            ),
            phaseLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            calculatedPriceLabel.topAnchor.constraint(
                equalTo: phaseLabel.bottomAnchor,
                constant: 10
            ),
            calculatedPriceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            calculatePriceAgainButton.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 60
            ),
            calculatePriceAgainButton.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -60
            ),
            calculatePriceAgainButton.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                constant: -125
            ),
            calculatePriceAgainButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configUI() {
        view.backgroundColor = .systemBackground
    }
}
