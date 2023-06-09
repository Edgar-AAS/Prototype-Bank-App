import UIKit
import Domain

protocol HomeControllerProtocol where Self: UIViewController {
    var isNeedUpdateCard: Bool { get set }
    var isNeedUpdateProfile: Bool { get set }
    var isNeedUpdateWithoutAnimation: Bool { get set }
    var isOpenFromHome: Bool { get set }
}

private enum HomeCellsType: Int {
    case balanceCell
    case cardCell
    case serviceCell
    case resourcesCell
}

public final class HomeController: UITableViewController, HomeControllerProtocol {
    public lazy var refreshControlIndicator: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    var isNeedUpdateCard: Bool = false
    var isNeedUpdateProfile: Bool = false
    var isNeedUpdateWithoutAnimation: Bool = false
    var isOpenFromHome: Bool = false
    
    public var presenter: ViewToPresenterHomeProtocol?
    public var header: PersonHeader?
    public var balanceViewModel: BalanceViewModel?
    public var cards: UserCards?
    public var mainServices = [Service]()
    public var appResources = [Resource]()
    
    private var goToLastItem: (() -> (Void))?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCells()
        setupTableviewProperties()
        setupTableViewHeader()
        tableView.addSubview(refreshControlIndicator)
        navigationItem.backButtonTitle = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        presenter?.fetchData()
        presenter?.fechCards()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = Colors.primaryColor
        updateViewIfNeeded()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControlIndicator.endRefreshing()
        }
    }
    
    private func scrollToLastItem() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.goToLastItem?()
        }
    }
    
    private func updateViewIfNeeded() {
        switch true {
        case isNeedUpdateCard:
            presenter?.fechCards()
            scrollToLastItem()
            isNeedUpdateCard = false
        case isNeedUpdateWithoutAnimation:
            presenter?.fechCards()
            isNeedUpdateWithoutAnimation = false
        case isNeedUpdateProfile:
            header?.profileImageView.loadImageWith(path: makeUserImagePath())
            isNeedUpdateProfile = false
        default: return
        }
    }
    
    private func makeUserImagePath() -> String {
        let path = getDocumentsDirectory().appendingPathComponent(FileManagerPaths.userImage).path
        return path
    }
    
    private func setupTableViewHeader() {
        header = PersonHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: HeaderHeights.small))
        header?.profileImageView.loadImageWith(path: makeUserImagePath())
        header?.delegate = self
        tableView.tableHeaderView = header
    }
        
    private func registerTableViewCells() {
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        tableView.register(BalanceCell.self, forCellReuseIdentifier: BalanceCell.reuseIdentifier)
        tableView.register(ServicesCell.self, forCellReuseIdentifier: ServicesCell.reuseIdentifier)
        tableView.register(ResourcesGridCell.self, forCellReuseIdentifier: ResourcesGridCell.reuseIdentifier)
    }
    
    private func setupTableviewProperties() {
        view.backgroundColor = Colors.primaryColor
        tableView.backgroundColor = Colors.primaryColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
    }
}

//MARK: - TableView DataSource
extension HomeController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
        
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = HomeCellsType(rawValue: indexPath.row)
        switch type {
        case .balanceCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: BalanceCell.reuseIdentifier, for: indexPath) as? BalanceCell
            cell?.setupCell(with: balanceViewModel)
            return cell ?? UITableViewCell()
        case .cardCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell
            if let cardModel = cards {
                cell?.setupCell(with: cardModel)
                goToLastItem = cell?.goToLastItem
                cell?.delegate = self
            }
            return cell ?? UITableViewCell()
        case .serviceCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            cell?.setupCell(services: mainServices)
            cell?.delegate = self
            return cell ?? UITableViewCell()
        case .resourcesCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResourcesGridCell.reuseIdentifier, for: indexPath) as? ResourcesGridCell
            cell?.setupCell(resources: appResources)
            return cell ?? UITableViewCell()
        default: return UITableViewCell()
        }
    }
}

//MARK: - Delegate actions
extension HomeController: PersonHeaderDelegateProtocol {
    public func profileButtonDidTapped() {
        presenter?.routeToProfile()
    }
}

extension HomeController: ServicesCellDelegateProtocol {
    public func cardServiceDidTapped(serviceTag: Int) {
        presenter?.routeToServiceWith(tag: serviceTag)
    }
}

extension HomeController: CardCellDelegateProtocol {
    public func cardDidTapped(userCard: UserCard) {
        isOpenFromHome = true
        presenter?.routeToCardInformationScreen(with: userCard)
    }
    
    public func addCardButtonDidTapped() {
        presenter?.routeToCards()
    }
}

//MARK: - Views
extension HomeController: ProfileView {
    public func updateProfileView(viewModel: ProfileViewModel) {
        self.header?.updateHeaderDisplay(viewModel: viewModel)
        tableView.reloadData()
    }
}

extension HomeController: BalanceView {
    public func updateBalanceView(viewModel: BalanceViewModel) {
        self.balanceViewModel = viewModel
        tableView.reloadData()
    }
}

extension HomeController: CardsView {
    public func updateCardsView(cardsModel: UserCards) {
        self.cards = cardsModel
        tableView.reloadData()
    }
}

extension HomeController: ServicesView {
    public func updateServicesView(services: [Service]) {
        self.mainServices = services
        tableView.reloadData()
    }
}

extension HomeController: ResourcesView {
    public func updateResourcesView(resources: [Resource]) {
        appResources = resources
        tableView.reloadData()
    }
}

extension HomeController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        showAlertController(title: viewModel.title, message: viewModel.message)
    }
}
