

import UIKit

class RatesTableViewController: UITableViewController {
    
    private var urlUpdate: String = ""
    private let pathToPlist = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String) + "/appData.plist"
    var country: CountryObject = CountryObject()
    var rowsArray: [Any] = []
    
    
    //----------------------------------------------------------------------WORK WITH DATA----------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = UIColor.white
        refreshControl!.addTarget(self, action: #selector(RatesTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GlobalVariables.sharedInstance.viewBefore = ""
        country = GlobalVariables.sharedInstance.getCountry()!
        getDataFromPlist(countryID: country.countryId)
        appendObjectsToTableViewRows()
        setNavigationAndTabBarInfo()
        self.tableView.reloadData()
    }
    
    
//--------------------------------------------BEGIN UPLOAD DATA-------------------------------------------------------
    
    func refresh(_ sender: AnyObject) {
        self.urlUpdate = ConstantVariables.URL.getUrlType(country_id: GlobalVariables.sharedInstance.COUNTRY_ID)
        self.updateData(url: self.urlUpdate)
    }
    
    func updateData(url: String) {
            self.refreshControl?.beginRefreshing()
        
            guard let requestUrl = URL(string: url) else { return }
            let request = URLRequest(url: requestUrl)
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) {
                (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    DispatchQueue.main.async {
                        self.view.makeToast(NSLocalizedString("internet_problems", comment: ""))
                    }
                    self.refreshControl?.endRefreshing()
                }
                else {
                    DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
                        do {
                            let plistData = NSMutableDictionary(contentsOfFile: self.pathToPlist)
                            
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
                            plistData?.write(toFile: self.pathToPlist, atomically: true)
                            sleep(1)
                        }
                        catch {}
                        DispatchQueue.main.async {
                            self.getDataFromPlist(countryID: self.country.countryId)
                            self.tableView.reloadData()
                            self.refreshControl?.endRefreshing()
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

    
//--------------------------------------------END UPLOAD DATA-------------------------------------------------------

    
    func appendObjectsToTableViewRows() {
        rowsArray.removeAll()
        rowsArray.append(country.getCurrentMainCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)!)
        rowsArray.append(country.interBank)
        rowsArray.append(country.blackMarket)
    }
    
    func setNavigationAndTabBarInfo() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = NSLocalizedString("rates", comment: "Rates")
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.white
        
        let currencyTab1 : UITabBarItem = (self.tabBarController?.tabBar.items![0])! as UITabBarItem
        let currencyTab2 : UITabBarItem = (self.tabBarController?.tabBar.items![1])! as UITabBarItem
        let currencyTab3 : UITabBarItem = (self.tabBarController?.tabBar.items![2])! as UITabBarItem
        let currencyTab4 : UITabBarItem = (self.tabBarController?.tabBar.items![3])! as UITabBarItem
        
        currencyTab1.title = NSLocalizedString("rates", comment: "")
        currencyTab2.title = NSLocalizedString("official", comment: "")
        currencyTab3.title = NSLocalizedString("converter", comment: "")
        currencyTab4.title = NSLocalizedString("currency", comment: "")
        
        
        currencyTab4.isEnabled = true
        if let icon = country.getCurrentMainCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)?.currencyIcon {
            currencyTab4.image = UIImage(named: icon)
            currencyTab4.selectedImage = UIImage(named: icon)
        }
    }
    
    func getDataFromPlist(countryID: Int) {
        var plistD = NSMutableDictionary(contentsOfFile: self.pathToPlist)

        //Here aren't USA, EUROPE, TURKEY because they are in easyCountry performSegue identifier
        switch(countryID) {
        case ConstantVariables.Country.UK_ID:
            plistD = plistD?.value(forKey: "uk") as? NSMutableDictionary
            break
            
        case ConstantVariables.Country.POLAND_ID:
            plistD = plistD?.value(forKey: "poland") as? NSMutableDictionary
            break
            
        case ConstantVariables.Country.RUSSIA_ID:
            plistD = plistD?.value(forKey: "russia") as? NSMutableDictionary
            break
            
        case ConstantVariables.Country.UKRAINE_ID:
            plistD = plistD?.value(forKey: "ukraine") as? NSMutableDictionary
            break
            
        default:
            plistD = plistD?.value(forKey: "uk") as? NSMutableDictionary
            break
        }
        setDataFromPlistToCountryObject(plist: plistD)
    }
    
    func setDataFromPlistToCountryObject(plist: NSMutableDictionary?) {
        setDataFromPlistToBankArray(plistBankList: plist?.value(forKey: "bankList") as! NSDictionary)
        setDataFromPlistToCurrencyArray(plistCurrencyList: plist?.value(forKey: "currencyList") as! NSDictionary)
        if plist?.value(forKey: "mBank") != nil {
            setDataFromPlistToInterBank(plistInterBank: plist?.value(forKey: "mBank") as! NSDictionary)
        }
        if plist?.value(forKey: "blackM") != nil {
            setDataFromPlistToBlackMarket(plistBlackMarket: plist?.value(forKey: "blackM") as! NSDictionary)
        }
    }
    
    func setDataFromPlistToBankArray(plistBankList: NSDictionary) {
        if self.refreshControl?.isRefreshing == false {
            self.createCountryBankArray()
        }
        for bank in country.bankArray {
            for key in plistBankList.allKeys {
                if bank.name == key as! String {
                    let bankInPlist = plistBankList.value(forKey: key as! String)//get Plist Dictionary for current bank
                    for (field, fieldChanges) in ConstantVariables.Bank.fieldsInBankListInPlist {
                        if (bankInPlist as! NSDictionary).value(forKey: field) != nil {
                            switch field {
                            case "buyUSD"://if buy is, then change also are
                                bank.buyUSD = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyUSD = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellUSD"://if sell is, then change also are
                                bank.sellUSD = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellUSD = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyEUR"://if buy is, then change also are
                                bank.buyEUR = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyEUR = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellEUR"://if sell is, then change also are
                                bank.sellEUR = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellEUR = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyRUB"://if buy is, then change also are
                                bank.buyRUB = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyRUB = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellRUB"://if sell is, then change also are
                                bank.sellRUB = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellRUB = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyGBP"://if buy is, then change also are
                                bank.buyGBP = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyGBP = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellGBP"://if sell is, then change also are
                                bank.sellGBP = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellGBP = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyCHF"://if buy is, then change also are
                                bank.buyCHF = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyCHF = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellCHF"://if sell is, then change also are
                                bank.sellCHF = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellCHF = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyTRY"://if buy is, then change also are
                                bank.buyTRY = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyTRY = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellTRY"://if sell is, then change also are
                                bank.sellTRY = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellTRY = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyCAD"://if buy is, then change also are
                                bank.buyCAD = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyCAD = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellCAD"://if sell is, then change also are
                                bank.sellCAD = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellCAD = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyPLN"://if buy is, then change also are
                                bank.buyPLN = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyPLN = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellPLN"://if sell is, then change also are
                                bank.sellPLN = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellPLN = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyILS"://if buy is, then change also are
                                bank.buyILS = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyILS = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellILS"://if sell is, then change also are
                                bank.sellILS = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellILS = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyCNY"://if buy is, then change also are
                                bank.buyCNY = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyCNY = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellCNY"://if sell is, then change also are
                                bank.sellCNY = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellCNY = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyCZK"://if buy is, then change also are
                                bank.buyCZK = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyCZK = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellCZK"://if sell is, then change also are
                                bank.sellCZK = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellCZK = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buySEK"://if buy is, then change also are
                                bank.buySEK = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuySEK = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellSEK"://if sell is, then change also are
                                bank.sellSEK = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellSEK = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyJPY"://if buy is, then change also are
                                bank.buyJPY = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyJPY = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellJPY"://if sell is, then change also are
                                bank.sellJPY = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellJPY = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "buyUAH"://if buy is, then change also are
                                bank.buyUAH = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesBuyUAH = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break
                            case "sellUAH"://if sell is, then change also are
                                bank.sellUAH = (bankInPlist as! NSDictionary).value(forKey: field) as! Double
                                bank.changesSellUAH = (bankInPlist as! NSDictionary).value(forKey: fieldChanges) as! Double
                                break

                            default:
                                break
                            }
        
                            bank.date = (bankInPlist as! NSDictionary).value(forKey: "date") as! String
                            
                            setOwnCurrencyBank(bank: bank)
                        }
                    }
                    break
                }
            }
        }
    }
    
    func createCountryBankArray() {
        country.bankArray.removeAll()
        for bank in ConstantVariables.Bank.ALL_BANKS {
            if (bank as NSDictionary).value(forKey: "countryID") as! Int == country.countryId {
                country.bankArray.append(BankObject(bankName: (bank as NSDictionary).value(forKey: "bankName") as! String, bankIcon: (bank as NSDictionary).value(forKey: "bankIcon") as! String))
            }
        }
    }
    
    func setOwnCurrencyBank(bank: BankObject) {
        switch(country.countryId) {
        case ConstantVariables.Country.UK_ID:
            bank.buyGBP = 1
            bank.sellGBP = 1
            break
        case ConstantVariables.Country.POLAND_ID:
            bank.buyPLN = 1
            bank.sellPLN = 1
            break
        case ConstantVariables.Country.RUSSIA_ID:
            bank.buyRUB = 1
            bank.sellRUB = 1
            break
        case ConstantVariables.Country.UKRAINE_ID:
            bank.buyUAH = 1
            bank.sellUAH = 1
            break
        default:
            break
        }
    }
    
    func setDataFromPlistToCurrencyArray(plistCurrencyList: NSDictionary) {
        if self.refreshControl?.isRefreshing == false {
            createCountryCurrencyArray()
        }
        for currency in country.currencyArray {
            for currencyInPlist in plistCurrencyList {
                if currency.currencyName == currencyInPlist.key as! String {
                    currency.rate = (currencyInPlist.value as! NSDictionary).value(forKey: "rate") as! Double
                    currency.date = (currencyInPlist.value as! NSDictionary).value(forKey: "date") as! String
                    break
                }
            }
            
        }
        if self.refreshControl?.isRefreshing == false {
            createArrayOfficialCurrencyMainRates()
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
        case ConstantVariables.Country.UK_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesUk
            break
        case ConstantVariables.Country.POLAND_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesPoland
            break
        case ConstantVariables.Country.TURKEY_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesTurkey
            break
        case ConstantVariables.Country.RUSSIA_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesRussia
            break
        case ConstantVariables.Country.UKRAINE_ID:
            currencyNames = ConstantVariables.Currency.currecyNamesUkraine
            break
        default:
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
    
    func createArrayOfficialCurrencyMainRates() {
        var mainCurrencies = [""]
        var mainCurrenciesConvert = [""]
        switch country.countryId {
        case ConstantVariables.Country.UK_ID:
            mainCurrencies = ConstantVariables.Currency.mainCurrencyNamesUk
            mainCurrenciesConvert = ConstantVariables.Currency.mainCurrencyConvertNamesUk
            break
        case ConstantVariables.Country.POLAND_ID:
            mainCurrencies = ConstantVariables.Currency.mainCurrencyNamesPoland
            mainCurrenciesConvert = ConstantVariables.Currency.mainCurrencyConvertNamesPoland
            break
        case ConstantVariables.Country.RUSSIA_ID:
            mainCurrencies = ConstantVariables.Currency.mainCurrencyNamesRussia
            mainCurrenciesConvert = ConstantVariables.Currency.mainCurrencyConvertNamesRussia
            break
        case ConstantVariables.Country.UKRAINE_ID:
            mainCurrencies = ConstantVariables.Currency.mainCurrencyNamesUkraine
            mainCurrenciesConvert = ConstantVariables.Currency.mainCurrencyConvertNamesUkraine
            break
        default:
            break
        }
        setMainCurrencies(mainCurrencyArray: mainCurrencies)
        setMainCurrenciesConvert(mainCurrencyConvertArray: mainCurrenciesConvert)
    }
    
    func setMainCurrencies(mainCurrencyArray: [String]) {
        country.mainCurrencyArray.removeAll()
        for currencyMainName in mainCurrencyArray {
            for currencyAllName in country.currencyArray {
                if currencyAllName.currencyName == currencyMainName {
                    country.mainCurrencyArray.append(currencyAllName)
                    break
                }
            }
        }
    }
    
    func setMainCurrenciesConvert(mainCurrencyConvertArray: [String]) {
        country.mainCurrencyArrayConvert.removeAll()
        for currencyMainName in mainCurrencyConvertArray {
            for currencyAllName in country.currencyArray {
                if currencyAllName.currencyName == currencyMainName {
                    setOwnCurrencyRate(currency: currencyAllName)
                    country.mainCurrencyArrayConvert.append(currencyAllName)
                    break
                }
            }
        }
    }
    
    func setOwnCurrencyRate(currency: CurrencyObject) {
        switch country.countryId {
        case ConstantVariables.Country.UK_ID:
            if currency.currencyName == "GBP" {
                currency.rate = 1
            }
            break
        case ConstantVariables.Country.POLAND_ID:
            if currency.currencyName == "PLN" {
                currency.rate = 1
            }
            break
        case ConstantVariables.Country.RUSSIA_ID:
            if currency.currencyName == "RUB" {
                currency.rate = 1
            }
            break
        case ConstantVariables.Country.UKRAINE_ID:
            if currency.currencyName == "UAH" {
                currency.rate = 1
            }
            break
        default:
            break
        }
    }

    
    func setDataFromPlistToInterBank(plistInterBank: NSDictionary) {
        country.interBank.buyUSD = plistInterBank.value(forKey: "buyUSD") as! Double
        country.interBank.buyEUR = plistInterBank.value(forKey: "buyEUR") as! Double
        country.interBank.buyRUB = plistInterBank.value(forKey: "buyRUB") as! Double
        
        country.interBank.sellUSD = plistInterBank.value(forKey: "sellUSD") as! Double
        country.interBank.sellEUR = plistInterBank.value(forKey: "sellEUR") as! Double
        country.interBank.sellRUB = plistInterBank.value(forKey: "sellRUB") as! Double
        
        country.interBank.changesBuyUSD = plistInterBank.value(forKey: "changesBuyUSD") as! Double
        country.interBank.changesBuyEUR = plistInterBank.value(forKey: "changesBuyEUR") as! Double
        country.interBank.changesBuyRUB = plistInterBank.value(forKey: "changesBuyRUB") as! Double
        
        country.interBank.changesSellUSD = plistInterBank.value(forKey: "changesSellUSD") as! Double
        country.interBank.changesSellEUR = plistInterBank.value(forKey: "changesSellEUR") as! Double
        country.interBank.changesSellRUB = plistInterBank.value(forKey: "changesSellRUB") as! Double
        
        country.interBank.date = plistInterBank.value(forKey: "date") as! String
    }
    
    func setDataFromPlistToBlackMarket(plistBlackMarket: NSDictionary) {
        country.blackMarket.buyUSD = plistBlackMarket.value(forKey: "buyUSD") as! Double
        country.blackMarket.buyEUR = plistBlackMarket.value(forKey: "buyEUR") as! Double
        country.blackMarket.buyRUB = plistBlackMarket.value(forKey: "buyRUB") as! Double
        
        country.blackMarket.sellUSD = plistBlackMarket.value(forKey: "sellUSD") as! Double
        country.blackMarket.sellEUR = plistBlackMarket.value(forKey: "sellEUR") as! Double
        country.blackMarket.sellRUB = plistBlackMarket.value(forKey: "sellRUB") as! Double
        
        country.blackMarket.changesBuyUSD = plistBlackMarket.value(forKey: "changesBuyUSD") as! Double
        country.blackMarket.changesBuyEUR = plistBlackMarket.value(forKey: "changesBuyEUR") as! Double
        country.blackMarket.changesBuyRUB = plistBlackMarket.value(forKey: "changesBuyRUB") as! Double
        
        country.blackMarket.changesSellUSD = plistBlackMarket.value(forKey: "changesSellUSD") as! Double
        country.blackMarket.changesSellEUR = plistBlackMarket.value(forKey: "changesSellEUR") as! Double
        country.blackMarket.changesSellRUB = plistBlackMarket.value(forKey: "changesSellRUB") as! Double
        
        country.blackMarket.date = plistBlackMarket.value(forKey: "date") as! String
    }
    
    
    //TABLEVIEW func
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let bankArrayCount = country.bankArray.count
        
        if country.countryId == ConstantVariables.Country.UKRAINE_ID { //if Ukraine
            return section == 0 ? 3 : bankArrayCount
        }
        else {
            return section == 0 ? 1 : bankArrayCount
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
            returnedView.backgroundColor = UIColor(red: (54/255.0), green: (54/255.0), blue: (54/255.0), alpha: 1)
            
            let label = UILabel(frame: CGRect(x: 10, y: 20, width: tableView.bounds.size.width, height: 20))
            label.textAlignment = .left
            label.textColor = UIColor.white
            
            switch GlobalVariables.sharedInstance.COUNTRY_ID {
            case ConstantVariables.Country.UKRAINE_ID:
                label.text = NSLocalizedString("banks_of_ukraine", comment: "Banks of Ukraine")
                break
            case ConstantVariables.Country.RUSSIA_ID:
                label.text = NSLocalizedString("banks_of_russia", comment: "Russian Banks")
                break
            case ConstantVariables.Country.POLAND_ID:
                label.text = NSLocalizedString("banks_of_poland", comment: "Poland Banks")
                break
            case ConstantVariables.Country.UK_ID:
                label.text = NSLocalizedString("banks_of_uk", comment: "Currency exchange point")
                break
            default:
                label.text = NSLocalizedString("banks_of_uk", comment: "Currency exchange point")
            }
            
            label.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightSemibold)
            returnedView.addSubview(label)
            
            return returnedView
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "RateCell") as! RateCell!
            if cell == nil {
                cell = RateCell(style: UITableViewCellStyle.default, reuseIdentifier: "RateCell")
            }
            
            if country.countryId != ConstantVariables.Country.UKRAINE_ID {
                switch country.countryId {
                case ConstantVariables.Country.UK_ID:
                    cell?.title.text = NSLocalizedString("bankEngland", comment: "The Bank of England")
                    break
                case ConstantVariables.Country.POLAND_ID:
                    cell?.title.text = NSLocalizedString("nbp", comment: "National Bank of Poland")
                    break
                case ConstantVariables.Country.RUSSIA_ID:
                    cell?.title.text = NSLocalizedString("cbr", comment: "Central Bank of Russia")
                    break
                default:
                    break
                }
                
                if let rate = country.getCurrentMainCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)?.rate {
                    cell?.buyRate.text = "\(rate)"
                }
                else {
                    cell?.buyRate.text = "0"
                }
                
                if let date = country.getCurrentMainCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)?.date {
                    cell?.date.text = date
                }
                else {
                    cell?.date.text = "0"
                }
                
                
                cell?.arrowDownBuy.isHidden = true
                cell?.arrowUpBuy.isHidden = true
                cell?.arrowDownSell.isHidden = true
                cell?.arrowUpSell.isHidden = true
                cell?.sellRate.isHidden = true
                cell?.changeBuy.isHidden = true
                cell?.changeSell.isHidden = true
            }
            else {
                let rowElement = rowsArray[(indexPath as NSIndexPath).row]
                setCellInfo(infoForRow: rowElement, cell: cell!)
            }
            
            let separatorViewWhite = UIView(frame: CGRect(x: 5, y: 68, width: self.tableView.bounds.size.width - 10, height: 0.5))
            separatorViewWhite.backgroundColor = UIColor.white
            cell?.addSubview(separatorViewWhite)
            return cell!
        }
        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "RateBankCell", for: indexPath) as! RateBankCell
            var cell = tableView.dequeueReusableCell(withIdentifier: "RateBankCell") as! RateBankCell!
            if cell == nil {
                cell = RateBankCell(style: UITableViewCellStyle.default, reuseIdentifier: "RateBankCell")
            }
            let bankRow = country.bankArray[(indexPath as NSIndexPath).row]
            
            cell?.bankLogo.image = UIImage(named: bankRow.icon)
            cell?.title.numberOfLines = 0
            
            if bankRow.name == "Райффайзен Банк Аваль" {
                cell?.title.text = "Райффайзен Банк"
            }
            else if bankRow.name == "Креди Агриколь Банк" {
                cell?.title.text = "Креди Агриколь"
            }
            else {
                cell?.title.text = bankRow.name
            }
            cell?.date.text = bankRow.date
            if bankRow.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID) != 0 {
                cell?.buyRate.text = String(format:"%.2f", bankRow.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID))
            }
            else {
                cell?.buyRate.text = "N/A"
            }
            if bankRow.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID) != 0 {
                cell?.sellRate.text = String(format:"%.2f", bankRow.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID))
            }
            else {
                cell?.sellRate.text = "N/A"
            }
            
            setChangesArrow(changesBuy: bankRow.getChangesBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID), changesSell: bankRow.getChangesSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID), cell: cell!)
            
            let separatorViewBlack = UIView(frame: CGRect(x: 5, y: 68, width: self.tableView.bounds.size.width - 10, height: 0.5))
            separatorViewBlack.backgroundColor = UIColor(red: (54/255.0), green: (54/255.0), blue: (54/255.0), alpha: 1)
            cell?.addSubview(separatorViewBlack)
            return cell!
        }
    }
    
    func setCellInfo(infoForRow: Any, cell: RateCell) {
        switch (infoForRow) {
        case let nbuRow as CurrencyObject:
            cell.title.text = NSLocalizedString("nbu", comment: "National Bank of Ukraine")
            cell.buyRate.text = "\(nbuRow.rate)"
            cell.date.text = nbuRow.date
            
            cell.arrowDownBuy.isHidden = true
            cell.arrowUpBuy.isHidden = true
            cell.arrowDownSell.isHidden = true
            cell.arrowUpSell.isHidden = true
            cell.sellRate.isHidden = true
            cell.changeBuy.isHidden = true
            cell.changeSell.isHidden = true
            break
        case let interBankRow as InterBank:
            cell.title.text = NSLocalizedString("interBank", comment: "Interbank")
            let changesBuy = interBankRow.getChangesBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)
            let changesSell = interBankRow.getChangesSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)
            
            cell.buyRate.text = "\(interBankRow.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID))"
            changesBuy == 0 ? (cell.changeBuy.text = "") : (cell.changeBuy.text = "\(changesBuy)")
            cell.sellRate.text = "\(interBankRow.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID))"
            changesBuy == 0 ? (cell.changeBuy.text = "") : (cell.changeBuy.text = "\(changesBuy)")
            
            cell.date.text = interBankRow.date
            setChangesArrow(changesBuy: changesBuy, changesSell: changesSell, cell: cell)
            break
        case let blackMRow as BlackMarket:
            let changesBuy = blackMRow.getChangesBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)
            let changesSell = blackMRow.getChangesSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)
            
            cell.title.text = NSLocalizedString("blackM", comment: "Black Market")
            cell.buyRate.text = "\(blackMRow.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID))"
            changesBuy == 0 ? (cell.changeBuy.text = "") : (cell.changeBuy.text = "\(changesBuy)")
            
            cell.sellRate.text = "\(blackMRow.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID))"
            changesSell == 0 ? (cell.changeSell.text = "") : (cell.changeSell.text = "\(changesSell)")
            
            cell.date.text = blackMRow.date
            setChangesArrow(changesBuy: changesBuy, changesSell: changesSell, cell: cell)
            break
        default:
            break
        }
    }
    
    func setChangesArrow(changesBuy: Double, changesSell: Double, cell: AnyObject) {
        if cell is RateCell {
            if changesBuy < 0 {
                (cell as! RateCell).arrowUpBuy.isHidden = true
                (cell as! RateCell).arrowDownBuy.isHidden = false
            }
            else if changesBuy > 0 {
                (cell as! RateCell).arrowUpBuy.isHidden = false
                (cell as! RateCell).arrowDownBuy.isHidden = true
            }
            else {
                (cell as! RateCell).arrowUpBuy.isHidden = true
                (cell as! RateCell).arrowDownBuy.isHidden = true
            }
            //--------
            if changesSell < 0 {
                (cell as! RateCell).arrowUpSell.isHidden = true
                (cell as! RateCell).arrowDownSell.isHidden = false
            }
            else if changesSell > 0 {
                (cell as! RateCell).arrowUpSell.isHidden = false
                (cell as! RateCell).arrowDownSell.isHidden = true
            }
            else {
                (cell as! RateCell).arrowUpSell.isHidden = true
                (cell as! RateCell).arrowDownSell.isHidden = true
            }
        }
        else if cell is RateBankCell {
            if changesBuy < 0 {
                (cell as! RateBankCell).arrowUpBuy.isHidden = true
                (cell as! RateBankCell).arrowDownBuy.isHidden = false
            }
            else if changesBuy > 0 {
                (cell as! RateBankCell).arrowUpBuy.isHidden = false
                (cell as! RateBankCell).arrowDownBuy.isHidden = true
            }
            else {
                (cell as! RateBankCell).arrowUpBuy.isHidden = true
                (cell as! RateBankCell).arrowDownBuy.isHidden = true
            }
            //--------
            if changesSell < 0 {
                (cell as! RateBankCell).arrowUpSell.isHidden = true
                (cell as! RateBankCell).arrowDownSell.isHidden = false
            }
            else if changesSell > 0 {
                (cell as! RateBankCell).arrowUpSell.isHidden = false
                (cell as! RateBankCell).arrowDownSell.isHidden = true
            }
            else {
                (cell as! RateBankCell).arrowUpSell.isHidden = true
                (cell as! RateBankCell).arrowDownSell.isHidden = true
            }
        }
    }
}
