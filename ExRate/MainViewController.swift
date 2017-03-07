import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let pathToPlist = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String) + "/"
    private var path = ""
    private var fileManager = FileManager.default
    var country: CountryObject = CountryObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        copyPlistToWriteAbleZone()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func copyPlistToWriteAbleZone() {
        path = pathToPlist + "appData.plist"
        
//                do {
//                    try self.fileManager.removeItem(atPath: self.path)
//                }
//                catch {
//                    print(error)
//                }
        
        if (!(fileManager.fileExists(atPath: path)))
        {
            let bundle : NSString = Bundle.main.path(forResource: "appData", ofType: "plist")! as NSString
            do {
                try fileManager.copyItem(atPath: bundle as String, toPath: path)
            }
            catch {
                print(error)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if GlobalVariables.sharedInstance.findLocalCountry == true {
            let prefs = UserDefaults.standard
            let countryID: Int = prefs.integer(forKey: "countryID")
            if countryID != 0  {
                GlobalVariables.sharedInstance.COUNTRY_ID = countryID
            }
            else {
                let locale = Locale.current
                
                setCountryId(countryRegionCode: checkCountry(regionCode: locale.regionCode!))
//                GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.UKRAINE_ID //--------------------------TEST
            }
        }
            
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        GlobalVariables.sharedInstance.findLocalCountry = true
        country = GlobalVariables.sharedInstance.getCountry()!
        loadData()
    }
    
    func checkCountry(regionCode: String) -> String {
        let europeRegion = ["at", "be", "de", "gr", "ie", "es", "it", "cy", "lv", "lt", "lu", "mt", "nl", "pt", "sk", "si", "fi", "fr", "ee", "ch"]
        let russiaRegion = ["ru", "kz", "am", "az", "by", "tm", "uz", "ge"]
        
        for region in europeRegion {
            if region.lowercased() == regionCode.lowercased() {
                return "EU"
            }
        }
        
        for region in russiaRegion {
            if region.lowercased() == regionCode.lowercased() {
                return "RU"
            }
        }
        
        return regionCode
    }
    
    func setCountryId(countryRegionCode: String) {
        switch countryRegionCode.lowercased() {
        case "US".lowercased():
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.USA_ID
            break
        case "EU".lowercased():
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.EUROPE_ID
            break
        case "UK".lowercased():
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.UK_ID
            break
        case "PL".lowercased():
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.POLAND_ID
            break
        case "TR".lowercased():
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.TURKEY_ID
            break
        case "RU".lowercased():
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.RUSSIA_ID
            break
        case "UA".lowercased():
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.UKRAINE_ID
            break
        default:
            GlobalVariables.sharedInstance.COUNTRY_ID = ConstantVariables.Country.UK_ID
        }
        // remember what country was set
        let prefs = UserDefaults.standard
        prefs.set(GlobalVariables.sharedInstance.COUNTRY_ID, forKey: "countryID")
    }
    
    func loadData() {
        let urlString = ConstantVariables.URL.getUrlType(country_id: GlobalVariables.sharedInstance.COUNTRY_ID)
        guard let requestUrl = URL(string: urlString) else { return }
        let request = URLRequest(url: requestUrl)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                self.openCurrentCountryView()
            }
            else {
                DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                    do {
                        let plistData = NSMutableDictionary(contentsOfFile: self.path)
                        
                        let jsonData = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                        
                        switch(GlobalVariables.sharedInstance.COUNTRY_ID) {
                        case ConstantVariables.Country.USA_ID:
                            self.setCurrencyListToPlist(arrayCurrencyJson:  jsonData.value(forKey: "currencyList") as? NSMutableArray, plistData: plistData?.value(forKey: "usa")! as! NSMutableDictionary)
                            break
                            
                        case ConstantVariables.Country.EUROPE_ID:
                            self.setCurrencyListToPlist(arrayCurrencyJson:  jsonData.value(forKey: "currencyList") as? NSMutableArray, plistData: plistData?.value(forKey: "eu") as! NSMutableDictionary)
                            break
                            
                        case ConstantVariables.Country.UK_ID:
                            self.setToPlistUkData(jsonData: jsonData, plistData: plistData?.value(forKey: "uk") as! NSMutableDictionary)
                            break
                            
                        case ConstantVariables.Country.POLAND_ID:
                            self.setToPlistPolandData(jsonData: jsonData, plistData: plistData?.value(forKey: "poland") as! NSMutableDictionary)
                            break
                            
                        case ConstantVariables.Country.TURKEY_ID:
                            self.setCurrencyListToPlist(arrayCurrencyJson:  jsonData.value(forKey: "currencyList") as? NSMutableArray, plistData: plistData?.value(forKey: "turkey")! as! NSMutableDictionary)
                            break
                            
                        case ConstantVariables.Country.RUSSIA_ID:
                            self.setToPlistRussiaData(jsonData: jsonData, plistData: plistData?.value(forKey: "russia") as! NSMutableDictionary)
                            break
                            
                        case ConstantVariables.Country.UKRAINE_ID:
                            self.setToPlistUkraineData(jsonData: jsonData, plistData: plistData?.value(forKey: "ukraine") as! NSMutableDictionary)
                            break
                            
                        default:
                            self.setToPlistUkData(jsonData: jsonData, plistData: plistData?.value(forKey: "uk") as! NSMutableDictionary)
                            break
                        }
                        plistData?.write(toFile: self.path, atomically: true)
                        sleep(1)
                    }
                    catch {}
                    DispatchQueue.main.async {
                        self.openCurrentCountryView()
                    }
                }
            }
        }
        task.resume()
    }
    
    //SET DATA about Currencies To Plist file
    func setCurrencyListToPlist(arrayCurrencyJson: NSMutableArray?, plistData: NSMutableDictionary) {
        if arrayCurrencyJson != nil {
            //Only currencyList in json and in plist
            let arrayInplist = plistData.value(forKey: "currencyList") as! NSDictionary
            
            //search all currency in Json
            for currencyJson in arrayCurrencyJson! {
                //search all currency dictionaries in appData.plist for specific country
                for (currencyNamePlist, valuesPlist) in arrayInplist {
                    //if currency name in Jsonarray == currencyName in Plist file
                    if ((currencyJson as! NSDictionary).value(forKey: "name") as! NSString) == currencyNamePlist as! NSString {
                        let currencyPlistDictionary = valuesPlist as! NSDictionary
                        //from new data
                        let rateValue = ((currencyJson as! NSDictionary).value(forKey: "rate") as! NSString).doubleValue
                        currencyPlistDictionary.setValue(rateValue, forKey: "rate")
                        
                        var date = (currencyJson as! NSDictionary).value(forKey: "date") as! String
                        if date.characters.count > 15 {
                            let indexDate = date.index(date.startIndex, offsetBy: 16)
                            date = date.substring(to: indexDate)
                        }

                        currencyPlistDictionary.setValue(date, forKey: "date")
                        break
                    }
                }
            }
            
        }
    }
    
    //SET DATA about banks To Plist file
    func setBankListToPlist(arrayBanksJson: NSMutableArray?, plistData: NSMutableDictionary) {
        if arrayBanksJson != nil {
            let arrayDictionariesInPlist = plistData.value(forKey: "bankList") as! NSDictionary
            
            for bankJson in arrayBanksJson! {
                for (bankNameInPlist, bankValueInPlist) in arrayDictionariesInPlist {
                    if ((bankJson as! NSDictionary).value(forKey: "name") as! NSString) == (bankNameInPlist as! NSString) {
                        for (field, fieldChanges) in ConstantVariables.Bank.fieldsInBankListInPlist {
                            checkAndUpdateFiled(field: field, fieldChanges: fieldChanges, bankJson: bankJson as! NSDictionary, bankInPlist: bankValueInPlist as! NSDictionary)
                        }
                        break
                    }
                }
            }
        }
    }
    
    func checkAndUpdateFiled(field: String, fieldChanges: String, bankJson: NSDictionary, bankInPlist: NSDictionary) {
        if bankJson[field] != nil && (bankJson.value(forKey: field) as! NSString).doubleValue != 0 {
            if bankInPlist[field] != nil {
                let jsonRate = (bankJson.value(forKey: field) as! NSString).doubleValue
                let plistRate = (bankInPlist.value(forKey: field)  as! Double)
                let changes = jsonRate - plistRate
                
                bankInPlist.setValue(jsonRate, forKey: field)
                bankInPlist.setValue(changes, forKey: fieldChanges)
            }
            
            var date = bankJson.value(forKey: "dateServer") as! String
            if date.characters.count > 15 {
                let indexDate = date.index(date.startIndex, offsetBy: 16)
                date = date.substring(to: indexDate)
            }
            bankInPlist.setValue(date, forKey: "date")
        }
    }
    
    func setToPlistUkData(jsonData: NSDictionary, plistData: NSMutableDictionary) {
        for iterator in jsonData {
            switch(iterator.key as! String) {
            case "bankList":
                setBankListToPlist(arrayBanksJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            case "currencyList":
                setCurrencyListToPlist(arrayCurrencyJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            default:
                break
            }
        }
    }
    
    func setToPlistPolandData(jsonData: NSDictionary, plistData: NSMutableDictionary) {
        for iterator in jsonData {
            switch(iterator.key as! String) {
            case "bankList":
                setBankListToPlist(arrayBanksJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            case "currencyList":
                setCurrencyListToPlist(arrayCurrencyJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            default:
                break
            }
        }
    }
    
    func setToPlistRussiaData(jsonData: NSDictionary, plistData: NSMutableDictionary) {
        for iterator in jsonData {
            switch(iterator.key as! String) {
            case "bankList":
                setBankListToPlist(arrayBanksJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            case "currencyList":
                setCurrencyListToPlist(arrayCurrencyJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            default:
                break
            }
        }
    }
    
    func setToPlistUkraineData(jsonData: NSDictionary, plistData: NSMutableDictionary) {
        for iterator in jsonData {
            switch(iterator.key as! String) {
            case "bankList":
                setBankListToPlist(arrayBanksJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            case "currencyList":
                setCurrencyListToPlist(arrayCurrencyJson: iterator.value as? NSMutableArray, plistData: plistData)
                break
            case "mBank":
                setMBankToPlist(mBankDictionaryJson: iterator.value as? NSDictionary, plistData: plistData)
                break
            case "blackM":
                setBlackMToPlist(blackMDictionaryJson: iterator.value as? NSDictionary, plistData: plistData)
                break
            default:
                break
            }
        }
    }
    
    //SET DATA about mBanl and blackMarket To Plist file, ONLY FOR UKRAINE
    func setMBankToPlist(mBankDictionaryJson: NSDictionary?, plistData: NSMutableDictionary) {
        let mBankDictionaryPlist = plistData.value(forKey: "mBank") as! NSDictionary
        if mBankDictionaryJson != nil {
            let buyJsonUSD = (mBankDictionaryJson!.value(forKey: "buyD") as! NSString).doubleValue
            let sellJsonUSD = (mBankDictionaryJson!.value(forKey: "sellD") as! NSString).doubleValue
            let buyJsonEUR = (mBankDictionaryJson!.value(forKey: "buyE") as! NSString).doubleValue
            let sellJsonEUR = (mBankDictionaryJson!.value(forKey: "sellE") as! NSString).doubleValue
            let buyJsonRUB = (mBankDictionaryJson!.value(forKey: "buyR") as! NSString).doubleValue
            let sellJsonRUB = (mBankDictionaryJson!.value(forKey: "sellR") as! NSString).doubleValue

            let buyPlistUSD = (mBankDictionaryJson!.value(forKey: "buyD") as! NSString).doubleValue
            let sellPlistUSD = (mBankDictionaryJson!.value(forKey: "sellD") as! NSString).doubleValue
            let buyPlistEUR = (mBankDictionaryJson!.value(forKey: "buyE") as! NSString).doubleValue
            let sellPlistEUR = (mBankDictionaryJson!.value(forKey: "sellE") as! NSString).doubleValue
            let buyPlistRUB = (mBankDictionaryJson!.value(forKey: "buyR") as! NSString).doubleValue
            let sellPlistRUB = (mBankDictionaryJson!.value(forKey: "sellR") as! NSString).doubleValue
                
            let changesBuyUSD = buyJsonUSD - buyPlistUSD
            let changesSellUSD = sellJsonUSD - sellPlistUSD
            let changesBuyEUR = buyJsonEUR - buyPlistEUR
            let changesSellEUR = sellJsonEUR - sellPlistEUR
            let changesBuyRUB = buyJsonRUB - buyPlistRUB
            let changesSellRUB = sellJsonRUB - sellPlistRUB
            
            mBankDictionaryPlist.setValue(buyJsonUSD, forKey: "buyUSD")
            mBankDictionaryPlist.setValue(sellJsonUSD, forKey: "sellUSD")
            mBankDictionaryPlist.setValue(buyJsonEUR, forKey: "buyEUR")
            mBankDictionaryPlist.setValue(sellJsonEUR, forKey: "sellEUR")
            mBankDictionaryPlist.setValue(buyJsonRUB, forKey: "buyRUB")
            mBankDictionaryPlist.setValue(sellJsonRUB, forKey: "sellRUB")
            
            mBankDictionaryPlist.setValue(changesBuyUSD, forKey: "changesBuyUSD")
            mBankDictionaryPlist.setValue(changesSellUSD, forKey: "changesSellUSD")
            mBankDictionaryPlist.setValue(changesBuyEUR, forKey: "changesBuyEUR")
            mBankDictionaryPlist.setValue(changesSellEUR, forKey: "changesSellEUR")
            mBankDictionaryPlist.setValue(changesBuyRUB, forKey: "changesBuyRUB")
            mBankDictionaryPlist.setValue(changesSellRUB, forKey: "changesSellRUB")
            
            var date = mBankDictionaryJson?.value(forKey: "dateServer") as! String
            if date.characters.count > 15 {
                let indexDate = date.index(date.startIndex, offsetBy: 16)
                date = date.substring(to: indexDate)
            }
            mBankDictionaryPlist.setValue(date, forKey: "date")
        }
    }
    
    func setBlackMToPlist(blackMDictionaryJson: NSDictionary?, plistData: NSMutableDictionary) {
        let blackMDictionaryPlist = plistData.value(forKey: "blackM") as! NSDictionary
        if blackMDictionaryJson != nil {
            let buyJsonUSD = (blackMDictionaryJson!.value(forKey: "buyD") as! NSString).doubleValue
            let sellJsonUSD = (blackMDictionaryJson!.value(forKey: "sellD") as! NSString).doubleValue
            let buyJsonEUR = (blackMDictionaryJson!.value(forKey: "buyE") as! NSString).doubleValue
            let sellJsonEUR = (blackMDictionaryJson!.value(forKey: "sellE") as! NSString).doubleValue
            let buyJsonRUB = (blackMDictionaryJson!.value(forKey: "buyR") as! NSString).doubleValue
            let sellJsonRUB = (blackMDictionaryJson!.value(forKey: "sellR") as! NSString).doubleValue
            
            let buyPlistUSD = (blackMDictionaryJson!.value(forKey: "buyD") as! NSString).doubleValue
            let sellPlistUSD = (blackMDictionaryJson!.value(forKey: "sellD") as! NSString).doubleValue
            let buyPlistEUR = (blackMDictionaryJson!.value(forKey: "buyE") as! NSString).doubleValue
            let sellPlistEUR = (blackMDictionaryJson!.value(forKey: "sellE") as! NSString).doubleValue
            let buyPlistRUB = (blackMDictionaryJson!.value(forKey: "buyR") as! NSString).doubleValue
            let sellPlistRUB = (blackMDictionaryJson!.value(forKey: "sellR") as! NSString).doubleValue
                
            let changesBuyUSD = buyJsonUSD - buyPlistUSD
            let changesSellUSD = sellJsonUSD - sellPlistUSD
            let changesBuyEUR = buyJsonEUR - buyPlistEUR
            let changesSellEUR = sellJsonEUR - sellPlistEUR
            let changesBuyRUB = buyJsonRUB - buyPlistRUB
            let changesSellRUB = sellJsonRUB - sellPlistRUB

            blackMDictionaryPlist.setValue(buyJsonUSD, forKey: "buyUSD")
            blackMDictionaryPlist.setValue(sellJsonUSD, forKey: "sellUSD")
            blackMDictionaryPlist.setValue(buyJsonEUR, forKey: "buyEUR")
            blackMDictionaryPlist.setValue(sellJsonEUR, forKey: "sellEUR")
            blackMDictionaryPlist.setValue(buyJsonRUB, forKey: "buyRUB")
            blackMDictionaryPlist.setValue(sellJsonRUB, forKey: "sellRUB")
            
            blackMDictionaryPlist.setValue(changesBuyUSD, forKey: "changesBuyUSD")
            blackMDictionaryPlist.setValue(changesSellUSD, forKey: "changesSellUSD")
            blackMDictionaryPlist.setValue(changesBuyEUR, forKey: "changesBuyEUR")
            blackMDictionaryPlist.setValue(changesSellEUR, forKey: "changesSellEUR")
            blackMDictionaryPlist.setValue(changesBuyRUB, forKey: "changesBuyRUB")
            blackMDictionaryPlist.setValue(changesSellRUB, forKey: "changesSellRUB")
            
            var date = blackMDictionaryJson?.value(forKey: "dateServer") as! String
            if date.characters.count > 15 {
                let indexDate = date.index(date.startIndex, offsetBy: 16)
                date = date.substring(to: indexDate)
            }
            blackMDictionaryPlist.setValue(date, forKey: "date")
        }
    }
    
    //------------------------------------------------
    
    func openCurrentCountryView() {
        if activityIndicator.isAnimating == true {
            activityIndicator.stopAnimating()
        }
        
        if (GlobalVariables.sharedInstance.COUNTRY_ID == ConstantVariables.Country.USA_ID || GlobalVariables.sharedInstance.COUNTRY_ID == ConstantVariables.Country.EUROPE_ID || GlobalVariables.sharedInstance.COUNTRY_ID == ConstantVariables.Country.TURKEY_ID) {
            
            getFromPlistInfo()
            performSegue(withIdentifier: "easyCountry", sender: self)
        }
        else {
            GlobalVariables.sharedInstance.CURRENCY_ID = ConstantVariables.Currency.USD_ID
            performSegue(withIdentifier: "hardCountry", sender: self)
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
    }
    
    func getFromPlistInfo() {
        path = pathToPlist + "appData.plist"
        var plistD = NSMutableDictionary(contentsOfFile: path)
        switch(GlobalVariables.sharedInstance.COUNTRY_ID) {
        case ConstantVariables.Country.USA_ID:
            plistD = plistD?.value(forKey: "usa") as? NSMutableDictionary
            break
            
        case ConstantVariables.Country.EUROPE_ID:
            plistD = plistD?.value(forKey: "eu") as? NSMutableDictionary
            break
            
        case ConstantVariables.Country.TURKEY_ID:
            plistD = plistD?.value(forKey: "turkey") as? NSMutableDictionary
            break
            
        default:
            plistD = plistD?.value(forKey: "eu") as? NSMutableDictionary
            break
        }
        setDataFromPlistToCountryObject(plist: plistD)
    }
    
    func setDataFromPlistToCountryObject(plist: NSMutableDictionary?) {
        setDataFromPlistToCurrencyArray(plistCurrencyList: plist?.value(forKey: "currencyList") as! NSDictionary)
    }
    
    func setDataFromPlistToCurrencyArray(plistCurrencyList: NSDictionary) {
        createCountryCurrencyArray()
        for currency in country.currencyArray {
            for currencyInPlist in plistCurrencyList {
                if currency.currencyName == currencyInPlist.key as! String {
                    currency.rate = (currencyInPlist.value as! NSDictionary).value(forKey: "rate") as! Double
                    currency.date = (currencyInPlist.value as! NSDictionary).value(forKey: "date") as! String
                    break
                }
            }
        }
    }
    
    func createCountryCurrencyArray() {
        country.currencyArray.removeAll()
        var currencyNames = [""]
        switch country.countryId {
        case ConstantVariables.Country.USA_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesUsa
            break
        case ConstantVariables.Country.EUROPE_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesEurope
            break
        case ConstantVariables.Country.TURKEY_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesTurkey
            break
        default:
            currencyNames = ConstantVariables.Currency.currecyNamesEurope
            break
        }
        
        for name in currencyNames {
            for nameInAll in ConstantVariables.Currency.ALL_CURRENCIES {
                if name == (nameInAll as NSDictionary).value(forKey: "currencyName") as! String {
                    let countryName = (nameInAll as NSDictionary).value(forKey: "countryName") as! String
                    let countryFlag = (nameInAll as NSDictionary).value(forKey: "countryFlag") as! String
                    let currencyName = (nameInAll as NSDictionary).value(forKey: "currencyName") as! String
                    let currencyDescription = (nameInAll as NSDictionary).value(forKey: "currencyDescription") as! String
                    let currencyIcon = (nameInAll as NSDictionary).value(forKey: "currencyIcon") as! String
                    let currencyID = (nameInAll as NSDictionary).value(forKey: "currencyID") as! Int
                    
                    country.currencyArray.append(CurrencyObject(countryName: countryName, countryFlag: countryFlag, currencyName: currencyName, currencyDescription: currencyDescription, currencyIcon: currencyIcon, currencyID: currencyID))
                    break
                }
            }
        }
    }
}


