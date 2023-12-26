import UIKit

final class HomeViewController: UIViewController {
    fileprivate enum Layout {}
    private var viewModel: HomeViewModeling
    
    private lazy var backgroungImageview = UIImageView.makeImageView("BG HOME")
    private lazy var logoImageview = UIImageView.makeImageView("LOGO")

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("COMEÇAR", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(red: 230/255, green: 0/255, blue: 127/255, alpha: 1.0)
        button.addTarget(self, action: #selector(handleStartButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(viewModel: HomeViewModeling) {
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
    
    @objc
    private func handleStartButton() {
        viewModel.openGasTypeView()
    }
}

extension HomeViewController: ViewConfiguration {
    func buildViews() {
        view.add(subviews: backgroungImageview, logoImageview, startButton)
    }
    
    func setupPin() {
        NSLayoutConstraint.pin([
            backgroungImageview.topAnchor.constraint(equalTo: view.topAnchor),
            backgroungImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroungImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroungImageview.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.Padding.constant),
            logoImageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: Layout.Padding.startButtonConstant),
            
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -Layout.Padding.startButtonConstant),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: Layout.Padding.startButtonBottom
            ),
            startButton.heightAnchor.constraint(equalToConstant: Layout.Height.startButtonHeight)
        ])
    }
    
    func configUI() {
        view.backgroundColor = .systemBackground
    }
}

extension HomeViewController.Layout {
    enum Padding {
        static var constant: CGFloat = 104
        static var startButtonConstant: CGFloat = 60
        static var startButtonBottom: CGFloat = -125
    }
    
    enum Height {
        static var startButtonHeight: CGFloat = 44
    }
}
