import UIKit
import Domain

public class HomeRouter {
    public weak var viewController: UIViewController?
    private var destinationController: UIViewController?
    private var cardsControllerFactory: () -> CardsViewController
    private var profileControllerFactory: () -> ProfileController
    private var cardInformationFactory: (UserCard) -> CardInformationViewController
    private var pixAreaControllerFactory: () -> PixAreaViewController
    
    public init(viewController: UIViewController?,
                profileControllerFactory: @escaping () -> ProfileController,
                cardsControllerFactory: @escaping () -> CardsViewController,
                cardInformationFactory: @escaping (UserCard) -> CardInformationViewController,
                pixAreaControllerFactory: @escaping () -> PixAreaViewController
    )
    {
        self.viewController = viewController
        self.cardsControllerFactory = cardsControllerFactory
        self.profileControllerFactory = profileControllerFactory
        self.cardInformationFactory = cardInformationFactory
        self.pixAreaControllerFactory = pixAreaControllerFactory
    }
}

extension HomeRouter: PresenterToRouterHomeProtocol {
    public func goToCardServiceWith(tag: Int) {
        switch tag {
        case 0:
            viewController?.navigationController?.pushViewController(pixAreaControllerFactory(), animated: true)
        default:
            break
        }
    }
    
    public func goToInformationControllerWith(selectedCard: UserCard) {
        viewController?.navigationController?.pushViewController(cardInformationFactory(selectedCard), animated: true)
    }
    
    public func goToProfile() {
        viewController?.navigationController?.pushViewController(profileControllerFactory(), animated: true)
    }
    
    public func goToCardsController() {
        viewController?.navigationController?.pushViewController(cardsControllerFactory(), animated: true)
    }
}
