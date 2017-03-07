import UIKit

class ConverterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var flagCountryFromCurrency: UIButton!
    @IBOutlet weak var flagCountryToCurrency: UIButton!
    @IBOutlet weak var iconCurrencyFrom: UIImageView!
    @IBOutlet weak var iconCurrencyTo: UIImageView!
    @IBOutlet weak var amountCurrencyTextEdit: UITextField!
    @IBOutlet weak var ownRateTextEdit: UITextField!
    @IBOutlet weak var resultWithOwnRate: UILabel!
    @IBOutlet weak var topConstraintTableView: NSLayoutConstraint!
    @IBOutlet weak var ownRateView: UIView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    
    var country: CountryObject = GlobalVariables.sharedInstance.getCountry()!
    var bankArray: [BankObject] = []
    var rowsArray: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        setAmountWithOwnRate()
        showHideOwnRate(self)
        setFirstFromToCurrencyId()
        
        NotificationCenter.default.addObserver(self, selector: #selector(OfficialRatesViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OfficialRatesViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OfficialRatesViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currencyTab : UITabBarItem = (self.tabBarController?.tabBar.items![3])! as UITabBarItem
        currencyTab.isEnabled = true
        GlobalVariables.sharedInstance.viewBefore = "converter"
        setNavigationAndTabBarInfo()
        setTopImages()
        setBankArray()
        appendObjectsToTableViewRows()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setTextFields()
    }
    
    func setFirstFromToCurrencyId() {
        switch(country.countryId) {
        case ConstantVariables.Country.UK_ID:
            GlobalVariables.sharedInstance.FROM_CURRENCY_ID = ConstantVariables.Currency.GBP_ID
            GlobalVariables.sharedInstance.TO_CURRENCY_ID = ConstantVariables.Currency.USD_ID
            break
        case ConstantVariables.Country.POLAND_ID:
            GlobalVariables.sharedInstance.FROM_CURRENCY_ID = ConstantVariables.Currency.USD_ID
            GlobalVariables.sharedInstance.TO_CURRENCY_ID = ConstantVariables.Currency.PLN_ID
            break
        case ConstantVariables.Country.RUSSIA_ID:
            GlobalVariables.sharedInstance.FROM_CURRENCY_ID = ConstantVariables.Currency.USD_ID
            GlobalVariables.sharedInstance.TO_CURRENCY_ID = ConstantVariables.Currency.RUB_ID
            break
        case ConstantVariables.Country.UKRAINE_ID:
            GlobalVariables.sharedInstance.FROM_CURRENCY_ID = ConstantVariables.Currency.USD_ID
            GlobalVariables.sharedInstance.TO_CURRENCY_ID = ConstantVariables.Currency.UAH_ID
            break
        default:
            break
        }
    }
    
    func setBankArray() {
        bankArray.removeAll()
        for bank in country.bankArray {
            var rateFrom: Double = 0
            var rateTo: Double = 0
            if GlobalVariables.sharedInstance.COUNTRY_ID != ConstantVariables.Country.UK_ID {
                rateFrom = bank.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.FROM_CURRENCY_ID)
                rateTo = bank.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
            }
            else {
                rateFrom = bank.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.FROM_CURRENCY_ID)
                rateTo = bank.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
            }
            if rateFrom != 0 && rateTo != 0 {
                bankArray.append(bank)
            }
        }
    }
    
    func setNavigationAndTabBarInfo() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = NSLocalizedString("converter", comment: "")
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
    func setTopImages() {
        let fromToCurrencies = country.getCurrentMainCurrencyConverter(fromCurrencyId: GlobalVariables.sharedInstance.FROM_CURRENCY_ID, toCurrencyId: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
        flagCountryFromCurrency.setImage(UIImage(named: fromToCurrencies[0].countryFlag), for: .normal)
        flagCountryFromCurrency.setImage(UIImage(named: fromToCurrencies[0].countryFlag), for: .selected)
        flagCountryFromCurrency.setImage(UIImage(named: fromToCurrencies[0].countryFlag), for: .highlighted)
        iconCurrencyFrom.image = UIImage(named: fromToCurrencies[0].currencyIcon)
        
        flagCountryToCurrency.setImage(UIImage(named: fromToCurrencies[1].countryFlag), for: .normal)
        iconCurrencyTo.image = UIImage(named: fromToCurrencies[1].currencyIcon)
    }
    
    func setTextFields() {
        let borderAmount = CALayer()
        let borderOwnRate = CALayer()
        let width = CGFloat(1.0)
        borderAmount.borderColor = UIColor.white.cgColor
        borderOwnRate.borderColor = UIColor.white.cgColor
        borderAmount.frame = CGRect(x: 0, y: amountCurrencyTextEdit.frame.size.height - width, width:  amountCurrencyTextEdit.frame.size.width, height: amountCurrencyTextEdit.frame.size.height)
        
        borderOwnRate.frame = CGRect(x: 0, y: ownRateTextEdit.frame.size.height - width, width:  ownRateTextEdit.frame.size.width, height: ownRateTextEdit.frame.size.height)
        
        borderAmount.borderWidth = width
        borderOwnRate.borderWidth = width
        
        amountCurrencyTextEdit.layer.addSublayer(borderAmount)
        amountCurrencyTextEdit.layer.masksToBounds = true
        ownRateTextEdit.layer.addSublayer(borderOwnRate)
        ownRateTextEdit.layer.masksToBounds = true
    }
    
    func setAmountWithOwnRate() {
        if ownRateView.isHidden == false {
            resultWithOwnRate.text = "0"
            if let amount = amountCurrencyTextEdit.text {
                if let ownRate = ownRateTextEdit.text {
                    resultWithOwnRate.text = countWithOwnRate(amount: amount, ownRate: ownRate)
                }
            }
        }
    }
    
    func countWithOwnRate(amount: String, ownRate: String) -> String {
        if let amountDecemical: Double = NumberFormatter().number(from: amount) as Double? {
            if let ownRateDecemical = Double(ownRate) {
                let result = String(round(amountDecemical * ownRateDecemical * 100)/100)
                
                return result
            }
        }
        return "0"
    }
    
    func appendObjectsToTableViewRows() {
        rowsArray.removeAll()
        rowsArray.append(country.getCurrentMainCurrencyConverter(fromCurrencyId: GlobalVariables.sharedInstance.FROM_CURRENCY_ID, toCurrencyId: GlobalVariables.sharedInstance.TO_CURRENCY_ID))
        rowsArray.append(country.interBank)
        rowsArray.append(country.blackMarket)
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let bankArrayCount = bankArray.count
        
        if country.countryId == ConstantVariables.Country.UKRAINE_ID { //if Ukraine
            return section == 0 ? 3 : bankArrayCount
        }
        else {
            return section == 0 ? 1 : bankArrayCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "RateCellConverter") as! RateCellConverter!
            if cell == nil {
                cell = RateCellConverter(style: UITableViewCellStyle.default, reuseIdentifier: "RateCellConverter")
            }
            if country.countryId != ConstantVariables.Country.UKRAINE_ID {
                switch country.countryId {
                case ConstantVariables.Country.UK_ID:
                    cell?.title.text = NSLocalizedString("bankEngland", comment: "")
                    break
                case ConstantVariables.Country.POLAND_ID:
                    cell?.title.text = NSLocalizedString("nbp", comment: "")
                    break
                case ConstantVariables.Country.RUSSIA_ID:
                    cell?.title.text = NSLocalizedString("cbr", comment: "")
                    break
                default:
                    break
                }
                let currenciesFromTo = country.getCurrentMainCurrencyConverter(fromCurrencyId: GlobalVariables.sharedInstance.FROM_CURRENCY_ID, toCurrencyId: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
                let rateFrom = currenciesFromTo[0].rate
                let rateTo = currenciesFromTo[1].rate
                
                if (rateFrom != 0) {
                    cell?.rateFrom.text = "\(rateFrom)"
                }
                else {
                    cell?.rateFrom.text = "0"
                }
                
                if (rateTo != 0) {
                    cell?.rateTo.text = "\(rateTo)"
                }
                else {
                    cell?.rateTo.text = "0"
                }
                
                cell?.amount.text = String(format: "%.2f", countAmount(rateFrom: rateFrom, rateTo: rateTo, amountFrom: amountCurrencyTextEdit.text!))
            }
            else {
                
                let rowElement = rowsArray[(indexPath as NSIndexPath).row]
                setCellInfo(infoForRow: rowElement, cell: cell!)
                
                if (indexPath as NSIndexPath).row != rowsArray.count - 1 {
                    let separatorViewWhite = UIView(frame: CGRect(x: 5, y: 60, width: self.tableView.bounds.size.width - 10, height: 0.5))
                    separatorViewWhite.backgroundColor = UIColor.white
                    cell?.addSubview(separatorViewWhite)
                }
            }
            
            return cell!
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "RateBankCellConverter") as! RateBankCellConverter!
            if cell == nil {
                cell = RateBankCellConverter(style: UITableViewCellStyle.default, reuseIdentifier: "RateBankCellConverter")
            }
            let bank = bankArray[(indexPath as NSIndexPath).row]
            
            var rateFrom: Double = 0
            var rateTo: Double = 0
            if country.countryId != ConstantVariables.Country.UK_ID {
                rateFrom = bank.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.FROM_CURRENCY_ID)
                rateTo = bank.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
            }
            else {
                rateFrom = bank.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.FROM_CURRENCY_ID)
                rateTo = bank.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
            }
            cell?.logoBank.image = UIImage(named: bank.icon)
            cell?.nameBank.text = bank.name
            cell?.rateFromBank.text = String(rateFrom)
            cell?.rateToBank.text = String(rateTo)
            cell?.amountBank.text = String(format: "%.2f",countAmount(rateFrom: rateFrom, rateTo: rateTo, amountFrom: amountCurrencyTextEdit.text))
            
            
            let separatorViewBlack = UIView(frame: CGRect(x: 5, y: 60, width: self.tableView.bounds.size.width - 10, height: 0.5))
            separatorViewBlack.backgroundColor = UIColor(red: (54/255.0), green: (54/255.0), blue: (54/255.0), alpha: 1)
            cell?.addSubview(separatorViewBlack)
            
            return cell!
        }
    }
    
    func setCellInfo(infoForRow: Any, cell: RateCellConverter) {
        switch (infoForRow) {
        case let nbuRow as [CurrencyObject]:
            let rateFrom = nbuRow[0].rate
            let rateTo = nbuRow[1].rate
            cell.title.text = NSLocalizedString("nbu", comment: "")
            cell.rateFrom.text = String(rateFrom)
            cell.rateTo.text = String(rateTo)
            cell.amount.text = String(format: "%.2f", countAmount(rateFrom: rateFrom, rateTo: rateTo, amountFrom: amountCurrencyTextEdit.text))
            break
        case let interBankRow as InterBank:
            let rateFrom = interBankRow.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.FROM_CURRENCY_ID)
            let rateTo = interBankRow.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
            cell.title.text = NSLocalizedString("interBank", comment: "")
            cell.rateFrom.text = String(rateFrom)
            cell.rateTo.text = String(rateTo)
            cell.amount.text = String(format: "%.2f", countAmount(rateFrom: rateFrom, rateTo: rateTo, amountFrom: amountCurrencyTextEdit.text))
            break
        case let blackMRow as BlackMarket:
            let rateFrom = blackMRow.getBuyCurrentCurrency(currencyID: GlobalVariables.sharedInstance.FROM_CURRENCY_ID)
            let rateTo = blackMRow.getSellCurrentCurrency(currencyID: GlobalVariables.sharedInstance.TO_CURRENCY_ID)
            cell.title.text = NSLocalizedString("blackM", comment: "")
            cell.rateFrom.text = String(rateFrom)
            cell.rateTo.text = String(rateTo)
            cell.amount.text = String(format: "%.2f", countAmount(rateFrom: rateFrom, rateTo: rateTo, amountFrom: amountCurrencyTextEdit.text))
            break
        default:
            break
        }
    }
    
    func countAmount(rateFrom: Double?, rateTo: Double?, amountFrom: String?) -> Double {
        var rateF: Double = 0
        var rateT: Double = 0
        var amountTo: Double = 0
        
        if country.countryId == ConstantVariables.Country.UK_ID {
            if rateFrom != nil {
                rateF = 1 / rateFrom!
            }
            if rateTo != nil {
                rateT = 1 / rateTo!
            }
        }
        else {
            if rateFrom != nil {
                rateF = rateFrom!
            }
            if rateTo != nil {
                rateT = rateTo!
            }
        }
        
        if let amountFromAble = amountFrom {
            if let amountFromDecemical: Double = NumberFormatter().number(from: amountFromAble) as Double? {
                if amountFromDecemical != 0 {
                    if rateF != 0 && rateTo != 0 {
                        amountTo = amountFromDecemical * rateF / rateT
                    }
                }
            }
        }
        
        return amountTo
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = ((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableViewBottomConstraint.constant = keyboardSize.height - (tabBarController?.tabBar.frame.height)!
        }
        
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if (((notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableViewBottomConstraint.constant = 0
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func showHideOwnRate(_ sender: Any) {
        if ownRateView.isHidden == false {
            ownRateView.isHidden = true
            topConstraintTableView.constant = 10
        }
        else {
            ownRateView.isHidden = false
            topConstraintTableView.constant = 48
        }
    }
    
    @IBAction func changeOwnRateTextEdit(_ sender: Any) {
        checkMaxLength(textField: ownRateTextEdit, maxLength: 5)
        setAmountWithOwnRate()
    }
    
    @IBAction func beginChangeOwnRate(_ sender: Any) {
        setAmountWithOwnRate()
    }
    
    @IBAction func changeAmountTextEdit(_ sender: Any) {
        checkMaxLength(textField: amountCurrencyTextEdit, maxLength: 8)
        setAmountWithOwnRate()
        self.tableView.reloadData()
    }
    
    @IBAction func beginChangeAmountText(_ sender: Any) {
        setAmountWithOwnRate()
        self.tableView.reloadData()
    }
    
    func checkMaxLength(textField: UITextField?, maxLength: Int) {
        if let text = textField?.text {
            if (text.characters.count > maxLength) {
                textField?.deleteBackward()
            }
        }
    }
    @IBAction func clickTheFlagFrom(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3
    }
    
    @IBAction func clickTheFlagTo(_ sender: Any) {
        self.tabBarController?.selectedIndex = 3
    }
}
