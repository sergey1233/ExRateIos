import UIKit

class MoreTableViewController: UITableViewController {

    let appStoreAppIDPlus = "1210289612"
    let appStoreAppIDFree = "1210026851"
    
    let rowsArray = [
        ["icon_plus_version" : NSLocalizedString("plus_version", comment: "")],
        ["icon_current_version" : NSLocalizedString("rates_app", comment: "")],
        ["icon_change_country" : NSLocalizedString("change_country", comment: "")]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        setNavigationAndTabBarInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        GlobalVariables.sharedInstance.viewBefore = ""
        if (self.tabBarController?.tabBar.items?.count)! > 3 {
            let currencyTab : UITabBarItem = (self.tabBarController?.tabBar.items![3])! as UITabBarItem
            currencyTab.isEnabled = false
        }
    }
    
    func setNavigationAndTabBarInfo() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationItem.title = NSLocalizedString("more_settings", comment: "")
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowsArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "MoreCell") as! MoreCell!
        if cell == nil {
            cell = MoreCell(style: UITableViewCellStyle.default, reuseIdentifier: "MoreCell")
        }
        let rowElement = rowsArray[(indexPath as NSIndexPath).row]
        for (key, value) in rowElement {
            cell?.icon.image = UIImage(named: key)
            cell?.label.text = value
        }
        
        if (indexPath as NSIndexPath).row != (rowsArray.count - 1) {
            let separatorView = UIView(frame: CGRect(x: 5, y: 61, width: tableView.bounds.size.width - 10, height: 0.5))
            separatorView.backgroundColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
            cell?.addSubview(separatorView)
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            open(scheme: "itms://itunes.apple.com/app/id" + appStoreAppIDPlus)
            break
        case 1:
            open(scheme: "itms://itunes.apple.com/app/id" + appStoreAppIDFree)
            break
        case 2:
            goToChangeCountry()
            break
        default:
            break
        }
    }
    
    func open(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func goToChangeCountry() {
        performSegue(withIdentifier: "changeCountry", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = NSLocalizedString("more", comment: "")
        navigationItem.backBarButtonItem =  backItem
    }
}
