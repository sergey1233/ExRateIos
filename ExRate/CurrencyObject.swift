import Foundation

class CurrencyObject: NSObject {
    
    var currencyName = ""
    var currencyDescription = ""
    var currencyIcon = ""
    var countryName = ""
    var countryFlag = ""
    var date = ""
    var rate: Double = 0
    var currencyID = -1 //default, meant not main currency
    
    
    override init() {
        super.init()
    }
    
    init(currencyName: String, currencyDescription: String, countryName: String, countryFlag: String) {
        self.currencyName = currencyName
        self.currencyDescription = currencyDescription
        self.countryName = countryName
        self.countryFlag = countryFlag
    }
    
    init (countryName: String, countryFlag: String, currencyName: String, currencyDescription: String, currencyIcon: String, currencyID: Int) {
        self.countryName = countryName
        self.countryFlag = countryFlag
        self.currencyName = currencyName
        self.currencyDescription = currencyDescription
        self.currencyIcon = currencyIcon
        self.currencyID = currencyID
    }
    
    func printClass() {
        print("===========")
        print("===========")
        print(self.currencyName)
        print(self.currencyDescription)
        print(self.currencyIcon)
        print(self.countryName)
        print(self.countryFlag)
        print(self.date)
        print(self.rate)
        print(self.currencyID)
    }
}
