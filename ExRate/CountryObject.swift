import Foundation

class CountryObject: NSObject {
    
    var name = ""
    var flag = ""
    var countryId = 0
    
    var mainCurrencyArray: [CurrencyObject] = [] //The main Currencies for each country
    var mainCurrencyArrayConvert: [CurrencyObject] = [] //The main Currencies for each country with own currency of country
    
    var currencyArray: [CurrencyObject] = []
    var bankArray: [BankObject] = []
    var interBank = InterBank()
    var blackMarket = BlackMarket()
    
    
    override init() {
        super.init()
    }
    
    init(name: String, flag: String, countryId: Int) {
        super.init()
        self.name = name
        self.flag = flag
        self.countryId = countryId
    }
    
    func getCurrentMainCurrency(currencyID: Int) -> CurrencyObject? {
        for currency in self.mainCurrencyArray {
            if currency.currencyID == currencyID {
                return currency
            }
        }
        
        return nil
    }
    
    func getCurrentMainCurrencyConverter(fromCurrencyId: Int, toCurrencyId: Int) -> [CurrencyObject] {
        var arrayCurrency: [CurrencyObject] = []
        for currencyFrom in self.mainCurrencyArrayConvert {
            if currencyFrom.currencyID == fromCurrencyId {
                arrayCurrency.append(currencyFrom)
                break
            }
        }
        
        for currencyTo in self.mainCurrencyArrayConvert {
            if currencyTo.currencyID == toCurrencyId {
                arrayCurrency.append(currencyTo)
                break
            }
        }

        return arrayCurrency
    }
}
