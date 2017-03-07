import UIKit
import GoogleMobileAds

class CurrencyConverterViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var fromWhatCurrencyLabel: UILabel!
    @IBOutlet weak var toWhatCurrencyLable: UILabel!
    @IBOutlet weak var pickerFromC: UIPickerView!
    @IBOutlet weak var pickerToC: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var country: CountryObject = CountryObject()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        country = GlobalVariables.sharedInstance.getCountry()!
        pickerFromC.delegate = self
        pickerToC.delegate = self
        
        fromWhatCurrencyLabel.text = NSLocalizedString("fromWhatCurrency", comment: "")
        toWhatCurrencyLable.text = NSLocalizedString("toWhatCurrency", comment: "")
        confirmButton.setTitle(NSLocalizedString("confirm", comment: ""), for: .normal)
        
        bannerView.adUnitID = "ca-app-pub-4587937543235763/4325095936"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if GlobalVariables.sharedInstance.viewBefore != "converter" {
            navigationController!.popViewController(animated: true)
        }
        setNavigationAndTabBarInfo()
    }

    func setNavigationAndTabBarInfo() {
        navigationItem.hidesBackButton = true
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationItem.title = ""
        
        self.navigationItem.title = NSLocalizedString("changeCurrency", comment: "")
        
        self.tabBarController?.tabBar.barTintColor = UIColor(red: (28/255.0), green: (28/255.0), blue: (28/255.0), alpha: 1)
        self.tabBarController?.tabBar.isTranslucent = false
        self.tabBarController?.tabBar.tintColor = UIColor.white
    }
    
    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return country.mainCurrencyArrayConvert.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    //  MARK: UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 40))
        
        let myImageFlag = UIImageView()
        myImageFlag.frame = CGRect(x: 45, y: 5, width: 60, height: 30)
        let myImageIcon = UIImageView()
        myImageIcon.frame = CGRect(x: 130, y: 5, width: 20, height: myImageFlag.frame.height)
        let myLabel = UILabel()
        myLabel.textColor = UIColor.white
        myLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        myLabel.frame = CGRect(x: 175, y: 5, width: pickerView.bounds.width - 195, height: 30)
        
        myImageFlag.image = UIImage(named: (country.mainCurrencyArrayConvert[row].countryFlag))
        myImageIcon.image = UIImage(named: (country.mainCurrencyArrayConvert[row].currencyIcon))
        myLabel.text = (country.mainCurrencyArrayConvert[row].currencyName)
        
        myView.addSubview(myImageFlag)
        myView.addSubview(myImageIcon)
        myView.addSubview(myLabel)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
        GlobalVariables.sharedInstance.FROM_CURRENCY_ID = country.mainCurrencyArrayConvert[pickerFromC.selectedRow(inComponent: 0)].currencyID
        GlobalVariables.sharedInstance.TO_CURRENCY_ID = country.mainCurrencyArrayConvert[pickerToC.selectedRow(inComponent: 0)].currencyID
        
        tabBarController?.selectedIndex = 2
    }
}
