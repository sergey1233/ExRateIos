import Foundation

class InterBank: NSObject {
    
    var date: String = ""
    
    var buyUSD: Double = 0
    var buyEUR: Double = 0
    var buyRUB: Double = 0
    let buyUAH: Double = 1
    
    var sellUSD: Double = 0
    var sellEUR: Double = 0
    var sellRUB: Double = 0
    let sellUAH: Double = 1
    
    var changesBuyUSD: Double = 0
    var changesSellUSD: Double = 0
    var changesBuyEUR: Double = 0
    var changesSellEUR: Double = 0
    var changesBuyRUB: Double = 0
    var changesSellRUB: Double = 0
    
    func getBuyCurrentCurrency(currencyID: Int) -> Double {
        switch currencyID {
        case ConstantVariables.Currency.USD_ID:
            return buyUSD
        case ConstantVariables.Currency.EUR_ID:
            return buyEUR
        case ConstantVariables.Currency.RUB_ID:
            return buyRUB
        case ConstantVariables.Currency.UAH_ID:
            return buyUAH
        default:
            return buyUSD
        }
    }
    
    func getSellCurrentCurrency(currencyID: Int) -> Double {
        switch currencyID {
        case ConstantVariables.Currency.USD_ID:
            return sellUSD
        case ConstantVariables.Currency.EUR_ID:
            return sellEUR
        case ConstantVariables.Currency.RUB_ID:
            return sellRUB
        case ConstantVariables.Currency.UAH_ID:
            return sellUAH
        default:
            return sellUSD
        }
    }
    
    func getChangesBuyCurrentCurrency(currencyID: Int) -> Double {
        switch currencyID {
        case ConstantVariables.Currency.USD_ID:
            return changesBuyUSD
        case ConstantVariables.Currency.EUR_ID:
            return changesBuyEUR
        case ConstantVariables.Currency.RUB_ID:
            return changesBuyRUB
        default:
            return changesBuyUSD
        }
    }
    
    func getChangesSellCurrentCurrency(currencyID: Int) -> Double {
        switch currencyID {
        case ConstantVariables.Currency.USD_ID:
            return changesSellUSD
        case ConstantVariables.Currency.EUR_ID:
            return changesSellEUR
        case ConstantVariables.Currency.RUB_ID:
            return changesSellRUB
        default:
            return changesSellUSD
        }
    }
}

