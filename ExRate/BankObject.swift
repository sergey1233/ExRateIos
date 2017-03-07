import Foundation

class BankObject: NSObject {

    var icon = ""
    var name = ""
    var date = ""
    
    var buyUSD: Double = 0
    var sellUSD: Double = 0
    var buyEUR: Double = 0
    var sellEUR: Double = 0
    var buyRUB: Double = 0
    var sellRUB: Double = 0
    var buyGBP: Double = 0
    var sellGBP: Double = 0
    var buyCHF: Double = 0
    var sellCHF: Double = 0
    var buyTRY: Double = 0
    var sellTRY: Double = 0
    var buyCAD: Double = 0
    var sellCAD: Double = 0
    var buyPLN: Double = 0
    var sellPLN: Double = 0
    var buyILS: Double = 0
    var sellILS: Double = 0
    var buyCNY: Double = 0
    var sellCNY: Double = 0
    var buyCZK: Double = 0
    var sellCZK: Double = 0
    var buySEK: Double = 0
    var sellSEK: Double = 0
    var buyJPY: Double = 0
    var sellJPY: Double = 0
    var buyUAH: Double = 0
    var sellUAH: Double = 0
    
    var changesBuyUSD: Double = 0
    var changesSellUSD: Double = 0
    var changesBuyEUR: Double = 0
    var changesSellEUR: Double = 0
    var changesBuyRUB: Double = 0
    var changesSellRUB: Double = 0
    var changesBuyGBP: Double = 0
    var changesSellGBP: Double = 0
    var changesBuyCHF: Double = 0
    var changesSellCHF: Double = 0
    var changesBuyTRY: Double = 0
    var changesSellTRY: Double = 0
    var changesBuyCAD: Double = 0
    var changesSellCAD: Double = 0
    var changesBuyPLN: Double = 0
    var changesSellPLN: Double = 0
    var changesBuyILS: Double = 0
    var changesSellILS: Double = 0
    var changesBuyCNY: Double = 0
    var changesSellCNY: Double = 0
    var changesBuyCZK: Double = 0
    var changesSellCZK: Double = 0
    var changesBuySEK: Double = 0
    var changesSellSEK: Double = 0
    var changesBuyJPY: Double = 0
    var changesSellJPY: Double = 0
    var changesBuyUAH: Double = 0
    var changesSellUAH: Double = 0
    
    override init() {
        super.init()
    }
    
    init(bankName: String, bankIcon: String) {
        self.name = bankName
        self.icon = bankIcon
    }
    
    func getBuyCurrentCurrency(currencyID: Int) -> Double {
        switch currencyID {
        case ConstantVariables.Currency.USD_ID:
            return buyUSD
        case ConstantVariables.Currency.EUR_ID:
            return buyEUR
        case ConstantVariables.Currency.RUB_ID:
            return buyRUB
        case ConstantVariables.Currency.GBP_ID:
            return buyGBP
        case ConstantVariables.Currency.CHF_ID:
            return buyCHF
        case ConstantVariables.Currency.TRY_ID:
            return buyTRY
        case ConstantVariables.Currency.CAD_ID:
            return buyCAD
        case ConstantVariables.Currency.PLN_ID:
            return buyPLN
        case ConstantVariables.Currency.ILS_ID:
            return buyILS
        case ConstantVariables.Currency.CNY_ID:
            return buyCNY
        case ConstantVariables.Currency.CZK_ID:
            return buyCZK
        case ConstantVariables.Currency.SEK_ID:
            return buySEK
        case ConstantVariables.Currency.JPY_ID:
            return buyJPY
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
        case ConstantVariables.Currency.GBP_ID:
            return sellGBP
        case ConstantVariables.Currency.CHF_ID:
            return sellCHF
        case ConstantVariables.Currency.TRY_ID:
            return sellTRY
        case ConstantVariables.Currency.CAD_ID:
            return sellCAD
        case ConstantVariables.Currency.PLN_ID:
            return sellPLN
        case ConstantVariables.Currency.ILS_ID:
            return sellILS
        case ConstantVariables.Currency.CNY_ID:
            return sellCNY
        case ConstantVariables.Currency.CZK_ID:
            return sellCZK
        case ConstantVariables.Currency.SEK_ID:
            return sellSEK
        case ConstantVariables.Currency.JPY_ID:
            return sellJPY
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
        case ConstantVariables.Currency.GBP_ID:
            return changesBuyGBP
        case ConstantVariables.Currency.CHF_ID:
            return changesBuyCHF
        case ConstantVariables.Currency.TRY_ID:
            return changesBuyTRY
        case ConstantVariables.Currency.CAD_ID:
            return changesBuyCAD
        case ConstantVariables.Currency.PLN_ID:
            return changesBuyPLN
        case ConstantVariables.Currency.ILS_ID:
            return changesBuyILS
        case ConstantVariables.Currency.CNY_ID:
            return changesBuyCNY
        case ConstantVariables.Currency.CZK_ID:
            return changesBuyCZK
        case ConstantVariables.Currency.SEK_ID:
            return changesBuySEK
        case ConstantVariables.Currency.JPY_ID:
            return changesBuyJPY
        case ConstantVariables.Currency.UAH_ID:
            return changesBuyUAH
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
        case ConstantVariables.Currency.GBP_ID:
            return changesSellGBP
        case ConstantVariables.Currency.CHF_ID:
            return changesSellCHF
        case ConstantVariables.Currency.TRY_ID:
            return changesSellTRY
        case ConstantVariables.Currency.CAD_ID:
            return changesSellCAD
        case ConstantVariables.Currency.PLN_ID:
            return changesSellPLN
        case ConstantVariables.Currency.ILS_ID:
            return changesSellILS
        case ConstantVariables.Currency.CNY_ID:
            return changesSellCNY
        case ConstantVariables.Currency.CZK_ID:
            return changesSellCZK
        case ConstantVariables.Currency.SEK_ID:
            return changesSellSEK
        case ConstantVariables.Currency.JPY_ID:
            return changesSellJPY
        case ConstantVariables.Currency.UAH_ID:
            return changesSellUAH
        default:
            return changesSellUSD
        }
    }
    
    func printClass() {
        print("=============================================")
        print(self.name)
        print(self.icon)
        print(self.date)
        print("buyUSD = \(self.buyUSD)")
        print("changesBuyUSD = \(self.changesBuyUSD)")
        print("sellUSD = \(self.sellUSD)")
        print("changesSellUSD = \(self.changesSellUSD)")
        print("--")
        print("buyEUR = \(self.buyEUR)")
        print("changesBuyEUR = \(self.changesBuyEUR)")
        print("sellEUR = \(self.sellEUR)")
        print("changesSellEUR = \(self.changesSellEUR)")
        print("--")
        print("buyRUB = \(self.buyRUB)")
        print("changesBuyRUB = \(self.changesBuyRUB)")
        print("sellRUB = \(self.sellRUB)")
        print("changesSellRUB = \(self.changesSellRUB)")
        print("--")
        print("buyGBP = \(self.buyGBP)")
        print("changesBuyGBP = \(self.changesBuyGBP)")
        print("sellGBP = \(self.sellGBP)")
        print("changesSellGBP = \(self.changesSellGBP)")
        print("--")
        print("buyCHF = \(self.buyCHF)")
        print("changesBuyCHF = \(self.changesBuyCHF)")
        print("sellCHF = \(self.sellCHF)")
        print("changesSellCHF = \(self.changesSellCHF)")
        print("--")
        print("buyTRY = \(self.buyTRY)")
        print("changesBuyTRY = \(self.changesBuyTRY)")
        print("sellTRY = \(self.sellTRY)")
        print("changesSellTRY = \(self.changesSellTRY)")
        print("--")
        print("buyCAD = \(self.buyCAD)")
        print("changesBuyCAD = \(self.changesBuyCAD)")
        print("sellCAD = \(self.sellCAD)")
        print("changesSellCAD = \(self.changesSellCAD)")
        print("--")
        print("buyPLN = \(self.buyPLN)")
        print("changesBuyPLN = \(self.changesBuyPLN)")
        print("sellPLN = \(self.sellPLN)")
        print("changesSellPLN = \(self.changesSellPLN)")
        print("--")
        print("buyILS = \(self.buyILS)")
        print("changesBuyILS = \(self.changesBuyILS)")
        print("sellILS = \(self.sellILS)")
        print("changesSellILS = \(self.changesSellILS)")
        print("--")
        print("buyCNY = \(self.buyCNY)")
        print("changesBuyCNY = \(self.changesBuyCNY)")
        print("sellCNY = \(self.sellCNY)")
        print("changesSellCNY = \(self.changesSellCNY)")
        print("--")
        print("buyCZK = \(self.buyCZK)")
        print("changesBuyCZK = \(self.changesBuyCZK)")
        print("sellCZK = \(self.sellCZK)")
        print("changesSellCZK = \(self.changesSellCZK)")
        print("--")
        print("buySEK = \(self.buySEK)")
        print("changesBuySEK = \(self.changesBuySEK)")
        print("sellSEK = \(self.sellSEK)")
        print("changesSellSEK = \(self.changesSellSEK)")
        print("--")
        print("buyJPY = \(self.buyJPY)")
        print("changesBuyJPY = \(self.changesBuyJPY)")
        print("sellJPY = \(self.sellJPY)")
        print("changesSellJPY = \(self.changesSellJPY)")
        print("--")
        print("buyUAH = \(self.buyUAH)")
        print("changesBuyUAH = \(self.changesBuyUAH)")
        print("sellUAH = \(self.sellUAH)")
        print("changesSellUAH = \(self.changesSellUAH)")
    }
}
