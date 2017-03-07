import UIKit

class ChangeCurrencyTableViewController: UITableViewController {

    var country: CountryObject = CountryObject()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        country = GlobalVariables.sharedInstance.getCountry()!
        
        setNavigationAndTabBarInfo()
        
        if GlobalVariables.sharedInstance.viewBefore == "converter" {
            performSegue(withIdentifier: "currencyConvert", sender: nil)
            navigationItem.hidesBackButton = true
            navigationItem.title = ""
        }
    
        self.tableView.reloadData()
    }

    func setNavigationAndTabBarInfo() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = NSLocalizedString("changeCurrency", comment: "")
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.white
        
        if let icon = country.getCurrentMainCurrency(currencyID: GlobalVariables.sharedInstance.CURRENCY_ID)?.currencyIcon {
            if let tabItem = tabBarController?.tabBar.items![3] {
                tabItem.image = UIImage(named: icon)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currencyArrayCount = country.mainCurrencyArray.count
        return currencyArrayCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "RateCurrencyCell") as! RateCurrencyCell!
        if cell == nil {
            cell = RateCurrencyCell(style: UITableViewCellStyle.default, reuseIdentifier: "RateCurrencyCell")
        }
        let rowElement = country.mainCurrencyArray[(indexPath as NSIndexPath).row]
        cell?.rateCurrencyFlag.image = UIImage(named: rowElement.countryFlag)
        cell?.rateCurrencyIcon.image = UIImage(named: rowElement.currencyIcon)
        cell?.rateCurrencyLabel.text = rowElement.currencyDescription
        
        if (indexPath as NSIndexPath).row != country.mainCurrencyArray.count - 1 {
            let separatorView = UIView(frame: CGRect(x: 5, y: 60, width: self.tableView.bounds.size.width - 10, height: 0.5))
            separatorView.backgroundColor = UIColor.white
            cell?.addSubview(separatorView)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        GlobalVariables.sharedInstance.CURRENCY_ID = country.mainCurrencyArray[(indexPath as IndexPath).row].currencyID
        
        tabBarController?.selectedIndex = 0
    }
}
