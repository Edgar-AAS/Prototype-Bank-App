import Foundation

public protocol BalanceView {
    func updateBalanceView(viewModel: BalanceViewModel)
}

public struct BalanceViewModel {
    public let totalBalance: String
    public let balanceIsHidden: Bool
    
    public init(totalBalance: String, balanceIsHidden: Bool) {
        self.totalBalance = totalBalance
        self.balanceIsHidden = balanceIsHidden
    }
}
