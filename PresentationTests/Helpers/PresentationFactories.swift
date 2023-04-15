import Foundation
import Presentation
import Domain

func makeSignUpRequest(name: String = "any_name", email: String =  "valid_email@gmail.com", password: String = "any_password", passwordConfirmation: String = "any_password") -> SignUpRequest {
    return SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation)
}

func makeLoginRequest(email: String =  "valid_email@gmail.com", password: String = "any_password") -> LoginRequest {
    return LoginRequest(email: email, password: password)
}

func makeCardViewModel() -> CardsViewViewModel {
    return CardsViewViewModel(
        cards: [
            CardModel(
                name: "rodolfo",
                isVirtual: true,
                balance: "R$ 530,00",
                cardFlag: "Mastercard",
                cardTag: 1,
                cardBrandImageUrl: "anyImageUrl.com",
                cardNumber: "•••• 1246",
                cardExpirationDate: "04/12",
                cardFunction: "Débito e crédito",
                cvc: "345"
            )
        ]
    )
}

func makeServicesModel() -> [MainService] {
    return [
        MainService(serviceIconURL: "anyIconUrl.com", serviceName: "Área pix", serviceTag: 0),
        MainService(serviceIconURL: "anyIconUrl.com", serviceName: "Depositar", serviceTag: 1)
    ]
}

func makeResourcesModel() -> [Resource] {
    return [
        Resource(applogoURL: "anyUrl", resourceDescription: "Description 123 test"),
        Resource(applogoURL: "anyUrl", resourceDescription: "123 test Description")
    ]
}
