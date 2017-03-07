import UIKit

class OfficialRatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var titleController: UILabel!
    @IBOutlet weak var underTitle: UILabel!
    @IBOutlet weak var textEditCount: TextField!
    @IBOutlet weak var underTitleFromTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textEditFind: TextField!
    @IBOutlet weak var iconFind: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    var currencyArray: [CurrencyObject] = []
    var amountOfCurrency: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCurrencyArray()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        setTitleText()
        setTextEditCount()
        setTextEditFind()
        iconFind.image = UIImage(named: "icon_find")
        
        NotificationCenter.default.addObserver(self, selector: #selector(OfficialRatesViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(OfficialRatesViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OfficialRatesViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        if GlobalVariables.sharedInstance.COUNTRY_ID == ConstantVariables.Country.USA_ID || GlobalVariables.sharedInstance.COUNTRY_ID == ConstantVariables.Country.EUROPE_ID || GlobalVariables.sharedInstance.COUNTRY_ID == ConstantVariables.Country.TURKEY_ID {
            let currencyTab1 : UITabBarItem = (self.tabBarController?.tabBar.items![0])! as UITabBarItem
            currencyTab1.title = NSLocalizedString("rates", comment: "")
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GlobalVariables.sharedInstance.viewBefore = ""
        setNavigationAndTabBarInfo()
        setCurrencyTabInvise()
    }
    
    
    override func viewDidLayoutSubviews() {
        setTextFields()
    }
    
    
    func setCurrencyArray() {
        currencyArray = GlobalVariables.sharedInstance.getCountry()!.currencyArray
        currencyArray.remove(at: currencyArray.count - 1)
        
    }
    
    func setCurrencyTabInvise() {
        if (self.tabBarController?.tabBar.items?.count)! > 3 {
            let currencyTab : UITabBarItem = (self.tabBarController?.tabBar.items![3])! as UITabBarItem
            currencyTab.isEnabled = false
        }
    }
    
    func setNavigationAndTabBarInfo() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = NSLocalizedString("official_rates", comment: "")
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
    func setTitleText() {
        switch GlobalVariables.sharedInstance.COUNTRY_ID {
        case ConstantVariables.Country.USA_ID:
            titleController.isHidden = true
            underTitle.text = NSLocalizedString("show_rate_current_currency_us", comment: "")
            underTitleFromTopConstraint.constant = 10
            break
        case ConstantVariables.Country.EUROPE_ID:
            titleController.isHidden = true
            underTitle.text = NSLocalizedString("show_rate_current_currency_eu", comment: "")
            underTitleFromTopConstraint.constant = 10
            break
        case ConstantVariables.Country.UK_ID:
            titleController.isHidden = false
            titleController.text = NSLocalizedString("bankEngland", comment: "")
            underTitle.text = NSLocalizedString("show_rate_current_currency_uk", comment: "")
            underTitleFromTopConstraint.constant = 45
            break
        case ConstantVariables.Country.POLAND_ID:
            titleController.isHidden = false
            titleController.text = NSLocalizedString("nbp", comment: "")
            underTitle.text = NSLocalizedString("show_rate_current_currency_pl", comment: "")
            underTitleFromTopConstraint.constant = 45
            break
        case ConstantVariables.Country.TURKEY_ID:
            titleController.isHidden = true
            underTitle.text = NSLocalizedString("show_rate_current_currency_tr", comment: "")
            underTitleFromTopConstraint.constant = 10
            break
        case ConstantVariables.Country.RUSSIA_ID:
            titleController.isHidden = false
            titleController.text = NSLocalizedString("cbr", comment: "")
            underTitle.text = NSLocalizedString("show_rate_current_currency_ru", comment: "")
            underTitleFromTopConstraint.constant = 45
            break
        case ConstantVariables.Country.UKRAINE_ID:
            titleController.isHidden = false
            titleController.text = NSLocalizedString("nbu", comment: "")
            underTitle.text = NSLocalizedString("show_rate_current_currency_ua", comment: "")
            underTitleFromTopConstraint.constant = 45
            break
        default:
            titleController.isHidden = false
            titleController.text = NSLocalizedString("bankEngland", comment: "")
            underTitle.text = NSLocalizedString("show_rate_current_currency_uk", comment: "")
            underTitleFromTopConstraint.constant = 77
            break
        }
    }
    
    func setTextFields() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: textEditCount.frame.size.height - width, width:  textEditCount.frame.size.width, height: textEditCount.frame.size.height)
        
        border.borderWidth = width
        textEditCount.layer.addSublayer(border)
        textEditCount.layer.masksToBounds = true
        
        textEditFind.layer.addSublayer(border)
        textEditFind.layer.masksToBounds = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "OfficialCurrencyCell") as! OfficialCurrencyCell!
        if cell == nil {
            cell = OfficialCurrencyCell(style: UITableViewCellStyle.default, reuseIdentifier: "OfficialCurrencyCell")
        }
        let currency = currencyArray[(indexPath as NSIndexPath).row]
        
        cell?.countryFlag.image = UIImage(named: currency.countryFlag)
        cell?.currencyName.text = currency.currencyName
        cell?.countryName.text = currency.countryName
        cell?.currencyDescription.text = currency.currencyDescription
        cell?.date.text = currency.date
        
        if amountOfCurrency == 0 {
            cell?.amount.text = String(currency.rate)
        }
        else {
            cell?.amount.text = String(format: "%.2f", currency.rate * amountOfCurrency)
        }
        
        let separatorView = UIView(frame: CGRect(x: 5, y: 50, width: tableView.bounds.size.width - 10, height: 0.5))
        separatorView.backgroundColor = UIColor(red: (54/255.0), green: (54/255.0), blue: (54/255.0), alpha: 1)
        cell?.addSubview(separatorView)
        return cell!
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
    
    func setTextEditCount() {
        if textEditCount.text == "" || textEditCount.text == Optional("") {
            textEditCount.textColor = UIColor(red: (155/255.0), green: (155/255.0), blue: (155/255.0), alpha: 1)
            textEditCount.font = textEditFind.font?.withSize(12)
            textEditCount.text = NSLocalizedString("enter_amount", comment: "")
        }
    }
    
    func setTextEditFind() {
        if textEditFind.text == "" || textEditFind.text == Optional("") {
            textEditFind.textColor = UIColor(red: (155/255.0), green: (155/255.0), blue: (155/255.0), alpha: 1)
            textEditFind.font = textEditFind.font?.withSize(12)
            textEditFind.text = NSLocalizedString("find_currency", comment: "")
        }
    }

    @IBAction func enterTextEditCount(_ sender: Any) {
        textEditCount.textColor = UIColor.white
        textEditCount.font = textEditFind.font?.withSize(18)
        if let amount: Double = NumberFormatter().number(from: textEditCount.text!) as Double? {
            amountOfCurrency = amount
        }
        else {
            amountOfCurrency = 0
        }
        tableView.reloadData()
    }
    
    @IBAction func enterTextEditFind(_ sender: Any) {
        textEditFind.textColor = UIColor.white
        textEditFind.font = textEditFind.font?.withSize(18)
        var newCurrencyArray: [CurrencyObject] = []
        if textEditFind.text != "" || textEditFind.text != Optional("") {
            setCurrencyArray()
            for currency in currencyArray {
                if (currency.countryName.lowercased().range(of: textEditFind.text!.lowercased()) != nil) || (currency.currencyName.lowercased().range(of: textEditFind.text!.lowercased()) != nil) || (currency.currencyDescription.lowercased().range(of: textEditFind.text!.lowercased()) != nil) {
                    newCurrencyArray.append(currency)
                }
            }
            currencyArray = newCurrencyArray
        }
        else {
            setCurrencyArray()
        }
        tableView.reloadData()
    }
    
    @IBAction func startEnterTextEditCount(_ sender: Any) {
        textEditCount.text = ""
        enterTextEditCount(self)
    }
    
    @IBAction func startEnterTextEditFind(_ sender: Any) {
        textEditFind.text = ""
        enterTextEditFind(self)
    }
    
    @IBAction func endEnterTextEditFind(_ sender: Any) {
        setTextEditFind()
    }
    
    @IBAction func endEnterTextEditCount(_ sender: Any) {
        setTextEditCount()
    }

}
