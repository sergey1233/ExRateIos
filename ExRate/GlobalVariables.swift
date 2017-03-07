import Foundation

class GlobalVariables: NSObject {
    
    static let sharedInstance = GlobalVariables()
    
    let mainCountryInApp = [
        CountryObject(name: NSLocalizedString("usa", comment: ""), flag: "currency_flag_usa", countryId: ConstantVariables.Country.USA_ID),
        CountryObject(name: NSLocalizedString("europe", comment: ""), flag: "currency_flag_europe", countryId: ConstantVariables.Country.EUROPE_ID),
        CountryObject(name: NSLocalizedString("turkey", comment: ""), flag: "currency_flag_turkey", countryId: ConstantVariables.Country.TURKEY_ID),
        CountryObject(name: NSLocalizedString("greatbritain", comment: ""), flag: "currency_flag_great_britain", countryId: ConstantVariables.Country.UK_ID),
        CountryObject(name: NSLocalizedString("poland", comment: ""), flag: "currency_flag_poland", countryId: ConstantVariables.Country.POLAND_ID),
        CountryObject(name: NSLocalizedString("russia", comment: ""), flag: "currency_flag_russia", countryId: ConstantVariables.Country.RUSSIA_ID),
        CountryObject(name: NSLocalizedString("ukraine", comment: ""), flag: "currency_flag_ukraine", countryId: ConstantVariables.Country.UKRAINE_ID)
    ]
    
    var viewBefore = ""
    
    var findLocalCountry = true
    var areReload = true
    
    var COUNTRY_ID = 0
    var CURRENCY_ID = 0
    
    var FROM_CURRENCY_ID = 0 //for converter
    var TO_CURRENCY_ID = 0 //for converter
    
    override fileprivate init() {}
    
    func getCountry() -> CountryObject? {
        for currentCountry in mainCountryInApp {
            if currentCountry.countryId == COUNTRY_ID {
                return currentCountry
            }
        }
        return nil
    }
}
