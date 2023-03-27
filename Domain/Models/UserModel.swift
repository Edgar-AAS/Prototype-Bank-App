import Foundation

public typealias UserModel = [UserModelElement]

// MARK: - UserModelElement
public struct UserModelElement: Model {
    public let username: String
    public let totalBalance: Double
    public let userImageURL: String
    public let balanceIsHidden, isNotifying: Bool
    public let bankBranch, bankAccountNumber, bankNumber, corporateName: String
    public let cards: [Card]
    public let mainServices: [MainService]
    public let resources: [Resource]

    enum CodingKeys: String, CodingKey {
        case username, totalBalance
        case userImageURL = "userImageUrl"
        case balanceIsHidden, isNotifying, bankBranch, bankAccountNumber, bankNumber, corporateName, cards, mainServices
        case resources = "resources:"
    }

    public init(username: String, totalBalance: Double, userImageURL: String, balanceIsHidden: Bool, isNotifying: Bool, bankBranch: String, bankAccountNumber: String, bankNumber: String, corporateName: String, cards: [Card], mainServices: [MainService], resources: [Resource]) {
        self.username = username
        self.totalBalance = totalBalance
        self.userImageURL = userImageURL
        self.balanceIsHidden = balanceIsHidden
        self.isNotifying = isNotifying
        self.bankBranch = bankBranch
        self.bankAccountNumber = bankAccountNumber
        self.bankNumber = bankNumber
        self.corporateName = corporateName
        self.cards = cards
        self.mainServices = mainServices
        self.resources = resources
    }
}

// MARK: - Card
public struct Card: Model {
    public let isVirtual: Bool
    public let balance: Double
    public let cardFlag: String
    public let cardTag: Int
    public let cardBrandImageURL, cardNumber, cardExpirationDate, cardFunction: String
    public let cvc: String

    enum CodingKeys: String, CodingKey {
        case isVirtual, balance, cardFlag, cardTag
        case cardBrandImageURL = "cardBrandImageUrl"
        case cardNumber, cardExpirationDate, cardFunction, cvc
    }

    public init(isVirtual: Bool, balance: Double, cardFlag: String, cardTag: Int, cardBrandImageURL: String, cardNumber: String, cardExpirationDate: String, cardFunction: String, cvc: String) {
        self.isVirtual = isVirtual
        self.balance = balance
        self.cardFlag = cardFlag
        self.cardTag = cardTag
        self.cardBrandImageURL = cardBrandImageURL
        self.cardNumber = cardNumber
        self.cardExpirationDate = cardExpirationDate
        self.cardFunction = cardFunction
        self.cvc = cvc
    }
}

// MARK: - MainService
public struct MainService: Model {
    public let serviceIconURL, serviceName: String
    public let serviceTag: Int

    enum CodingKeys: String, CodingKey {
        case serviceIconURL = "serviceIconUrl"
        case serviceName, serviceTag
    }

    public init(serviceIconURL: String, serviceName: String, serviceTag: Int) {
        self.serviceIconURL = serviceIconURL
        self.serviceName = serviceName
        self.serviceTag = serviceTag
    }
}

// MARK: - Resources
public struct Resource: Model {
    public let applogoURL, resourceDescription: String

    enum CodingKeys: String, CodingKey {
        case applogoURL = "applogoUrl"
        case resourceDescription
    }

    public init(applogoURL: String, resourceDescription: String) {
        self.applogoURL = applogoURL
        self.resourceDescription = resourceDescription
    }
}