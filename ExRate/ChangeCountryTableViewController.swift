import UIKit

class ChangeCountryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.navigationController?.navigationBar.tintColor = UIColor.white
        setNavigationAndTabBarInfo()
    }
    
    func setNavigationAndTabBarInfo() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = NSLocalizedString("change_country", comment: "")
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.sharedInstance.mainCountryInApp.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryCell!
        if cell == nil {
            cell = CountryCell(style: UITableViewCellStyle.default, reuseIdentifier: "CountryCell")
        }
        let rowElement = GlobalVariables.sharedInstance.mainCountryInApp[(indexPath as NSIndexPath).row]
        cell?.countryFlag.image = UIImage(named: rowElement.flag)
        cell?.countryName.text = rowElement.name

        if (indexPath as NSIndexPath).row != (GlobalVariables.sharedInstance.mainCountryInApp.count - 1) {
            let separatorView = UIView(frame: CGRect(x: 5, y: 61, width: tableView.bounds.size.width - 10, height: 0.5))
            separatorView.backgroundColor = UIColor.white
            cell?.addSubview(separatorView)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowElement = GlobalVariables.sharedInstance.mainCountryInApp[(indexPath as NSIndexPath).row]
        let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
        selectedCell.contentView.backgroundColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        
        GlobalVariables.sharedInstance.findLocalCountry = false
        GlobalVariables.sharedInstance.COUNTRY_ID = rowElement.countryId
        let prefs = UserDefaults.standard
        prefs.set(GlobalVariables.sharedInstance.COUNTRY_ID, forKey: "countryID")

        self.performSegue(withIdentifier: "unWindToInitialViewController", sender: self)
    }
}
