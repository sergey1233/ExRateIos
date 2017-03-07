import Foundation

struct ConstantVariables {
    
    struct URL {
        //Link for updload data
        static let URL_TYPE_Usa = "http://exrate.com.ua/app_response_usa.php"
        static let URL_TYPE_Uk = "http://exrate.com.ua/app_response_uk.php"
        static let URL_TYPE_Europe = "http://exrate.com.ua/app_response_eu.php"
        static let URL_TYPE_Poland = "http://exrate.com.ua/app_response_pl.php"
        static let URL_TYPE_Turkey = "http://exrate.com.ua/app_response_tr.php"
        static let URL_TYPE_Russia = "http://exrate.com.ua/app_response_ru.php"
        static let URL_TYPE_Ukraine = "http://exrate.com.ua/app_response_ua.php"
        
        static func getUrlType(country_id: Int) -> String {
            switch(country_id) {
            case ConstantVariables.Country.USA_ID:
                return ConstantVariables.URL.URL_TYPE_Usa
                
            case ConstantVariables.Country.EUROPE_ID:
                return ConstantVariables.URL.URL_TYPE_Europe
                
            case ConstantVariables.Country.UK_ID:
                return ConstantVariables.URL.URL_TYPE_Uk
                
            case ConstantVariables.Country.POLAND_ID:
                return ConstantVariables.URL.URL_TYPE_Poland
                
            case ConstantVariables.Country.TURKEY_ID:
                return ConstantVariables.URL.URL_TYPE_Turkey
                
            case ConstantVariables.Country.RUSSIA_ID:
                return ConstantVariables.URL.URL_TYPE_Russia
                
            case ConstantVariables.Country.UKRAINE_ID:
                return ConstantVariables.URL.URL_TYPE_Ukraine
                
            default:
                return ConstantVariables.URL.URL_TYPE_Uk
            }
        }
        
    }
    
    struct Country {
        //Country id
        static let USA_ID = 1
        static let EUROPE_ID = 2
        static let UK_ID = 3
        static let POLAND_ID = 4
        static let TURKEY_ID = 5
        static let RUSSIA_ID = 6
        static let UKRAINE_ID = 7
    }
    
    
    struct Bank {
        static let fieldsInBankListInPlist = ["buyUSD" : "changesBuyUSD", "sellUSD" : "changesSellUSD", "buyEUR" : "changesBuyEUR", "sellEUR" : "changesSellEUR", "buyRUB" : "changesBuyRUB", "sellRUB" : "changesSellRUB", "buyGBP" : "changesBuyGBP", "sellGBP" : "changesSellGBP", "buyCHF" : "changesBuyCHF", "sellCHF" : "changesSellCHF", "buyTYR" : "changesBuyTYR", "sellTYR" : "changesSellTYR", "buyCAD" : "changesBuyCAD", "sellCAD" : "changesSellCAD", "buyPLN" : "changesBuyPLN", "sellPLN" : "changesSellPLN", "buyILS" : "changesBuyILS", "sellILS" : "changesSellILS", "buyCNY" : "changesBuyCNY", "sellCNY" : "changesSellCNY", "buyCZK" : "changesBuyCZK", "sellCZK" : "changesSellCZK", "buySEK" : "changesBuySEK", "sellSEK" : "changesSellSEK", "buyJPY" : "changesBuyJPY", "sellJPY" : "changesSellJPY", "buyUAH" : "changesBuyUAH", "sellUAH" : "changesSellUAH"]
        
        //Array of all banks in appData.plist with their information(name, icon)
        static let ALL_BANKS = [
                                ["bankName" : "DEBENHAMS", "bankIcon" : "bank_icon_debenhams", "countryID" : 3],
//                                ["bankName" : "First Choice", "bankIcon" : "bank_icon_first_choice", "countryID" : 3],
//                                ["bankName" : "Thomson", "bankIcon" : "bank_icon_thomson", "countryID" : 3],
                                ["bankName" : "Travelex", "bankIcon" : "bank_icon_travelex", "countryID" : 3],
                                ["bankName" : "ICE", "bankIcon" : "bank_icon_ice", "countryID" : 3],
                                ["bankName" : "NATWEST", "bankIcon" : "bank_icon_natwest", "countryID" : 3],
                                ["bankName" : "RBS", "bankIcon" : "bank_icon_rbs", "countryID" : 3],
//                                ["bankName" : "Virgin Atlantic", "bankIcon" : "bank_icon_virgin_atlantic", "countryID" : 3],
                                ["bankName" : "MSBANK", "bankIcon" : "bank_icon_msbank", "countryID" : 3],
//                                ["bankName" : "Thomas Cook", "bankIcon" : "bank_icon_thomas_cook", "countryID" : 3],
                                ["bankName" : "Eurochange", "bankIcon" : "bank_icon_eurochange", "countryID" : 3],
                                ["bankName" : "ACE-FX", "bankIcon" : "bank_icon_ace_fx", "countryID" : 3],
                                ["bankName" : "GRIFFIN", "bankIcon" : "bank_icon_griffin", "countryID" : 3],
                                ["bankName" : "Sterling", "bankIcon" : "bank_icon_sterling", "countryID" : 3],
//                                ["bankName" : "MoneyCorp", "bankIcon" : "bank_icon_moneycorp", "countryID" : 3],
            
//                                ["bankName" : "ALIOR BANK", "bankIcon" : "alior_logo", "countryID" : 4],
                                ["bankName" : "BANK BPS", "bankIcon" : "bps_logo", "countryID" : 4],
                                ["bankName" : "ZACHODNI WBK", "bankIcon" : "zachodni_logo", "countryID" : 4],
                                ["bankName" : "BOS BANK", "bankIcon" : "bos_logo", "countryID" : 4],
                                ["bankName" : "CREDIT AGRICOLE", "bankIcon" : "credit_agricole_logo", "countryID" : 4],
                                ["bankName" : "GETIN BANK", "bankIcon" : "getin_logo", "countryID" : 4],
                                ["bankName" : "ING BANK SLASKI", "bankIcon" : "ing_logo", "countryID" : 4],
                                ["bankName" : "DEUTSCHE BANK", "bankIcon" : "deutche_logo", "countryID" : 4],
//                                ["bankName" : "BGZ BNP PARIBAS SA", "bankIcon" : "bnp_paribas_logo", "countryID" : 4],
                                ["bankName" : "Raiffeisen Polbank", "bankIcon" : "raiffeisen_logo", "countryID" : 4],
                                ["bankName" : "MBANK", "bankIcon" : "mbank_logo", "countryID" : 4],
                                ["bankName" : "PKO Bank Polski", "bankIcon" : "pko_logo", "countryID" : 4],
                                
                                ["bankName" : "Сбербанк России", "bankIcon" : "bank_icon_sber_russia", "countryID" : 6],
                                ["bankName" : "Газпромбанк", "bankIcon" : "bank_icon_gazprom_russia", "countryID" : 6],
                                ["bankName" : "Россельхозбанк", "bankIcon" : "bank_icon_rosselhozbank_russia", "countryID" : 6],
//                                ["bankName" : "Альфа-Банк", "bankIcon" : "bank_icon_alpha_russia", "countryID" : 6],
                                ["bankName" : "Московский Кредитный Банк", "bankIcon" : "bank_icon_moscow_credit_russia", "countryID" : 6],
                                ["bankName" : "Промсвязьбанк", "bankIcon" : "bank_icon_promsvyazbank_russia", "countryID" : 6],
                                ["bankName" : "ЮниКредит Банк", "bankIcon" : "bank_icon_unicredit_russia", "countryID" : 6],
//                                ["bankName" : "Бинбанк", "bankIcon" : "bank_icon_binbank_russia", "countryID" : 6],
                                ["bankName" : "Райффайзенбанк", "bankIcon" : "bank_icon_raiffaisen_russia", "countryID" : 6],
                                ["bankName" : "Росбанк", "bankIcon" : "bank_icon_rosbank_russia", "countryID" : 6],
                                ["bankName" : "Банк Москвы", "bankIcon" : "bank_icon_bank_of_moscow_russia", "countryID" : 6],
                                ["bankName" : "Банк Санкт-Петербург", "bankIcon" : "bank_icon_st_petersburg_russia", "countryID" : 6],
                                ["bankName" : "Совкомбанк", "bankIcon" : "bank_icon_sovkombank_russia", "countryID" : 6],
                                ["bankName" : "Русский Стандарт", "bankIcon" : "bank_icon_russian_standart_russia", "countryID" : 6],
                                ["bankName" : "Московский Областной Банк", "bankIcon" : "bank_icon_mosoblbank_russia", "countryID" : 6],
                                ["bankName" : "Ситибанк", "bankIcon" : "bank_icon_city_russia", "countryID" : 6],
                                ["bankName" : "Абсолют Банк", "bankIcon" : "bank_icon_absolutebank_russia", "countryID" : 6],
                                ["bankName" : "Тинькофф Банк", "bankIcon" : "bank_icon_tinkof_russia", "countryID" : 6],
                                
                                ["bankName" : "ПриватБанк", "bankIcon" : "bank_icon_privat", "countryID" : 7],
                                ["bankName" : "Ощадбанк", "bankIcon" : "bank_icon_oshad", "countryID" : 7],
                                ["bankName" : "СБЕРБАНК", "bankIcon" : "bank_icon_sber", "countryID" : 7],
                                ["bankName" : "Альфа-Банк", "bankIcon" : "bank_icon_alpha_bank", "countryID" : 7],
                                ["bankName" : "Райффайзен Банк Аваль", "bankIcon" : "bank_icon_raif", "countryID" : 7],
//                                ["bankName" : "Укрсоцбанк", "bankIcon" : "bank_icon_ukrsots", "countryID" : 7],
                                ["bankName" : "УкрСиббанк", "bankIcon" : "bank_icon_ukrsib", "countryID" : 7],
                                ["bankName" : "ПУМБ", "bankIcon" : "bank_icon_pumb", "countryID" : 7],
                                ["bankName" : "ВТБ Банк", "bankIcon" : "bank_icon_vtb", "countryID" : 7],
                                ["bankName" : "ОТП Банк", "bankIcon" : "bank_icon_otp", "countryID" : 7],
                                ["bankName" : "Креди Агриколь Банк", "bankIcon" : "bank_icon_crediagr", "countryID" : 7],
                                ["bankName" : "Укргазбанк", "bankIcon" : "bank_icon_ugb", "countryID" : 7],
//                                ["bankName" : "КРЕДИТ ДНЕПР", "bankIcon" : "bank_icon_kreditdnepr", "countryID" : 7],
                                ["bankName" : "ТАСкомбанк", "bankIcon" : "bank_icon_taskobank", "countryID" : 7]]
        
    }
    
    struct Currency {
        //Currency id
        static let USD_ID = 0
        static let EUR_ID = 1
        static let RUB_ID = 2
        static let GBP_ID = 3 //funt
        static let CHF_ID = 4 //switzerland frank
        static let TRY_ID = 5 // turkish
        static let CAD_ID = 6 // canada dollar
        static let PLN_ID = 7 // poland zlotuy
        static let ILS_ID = 8 // israel shekel
        static let CNY_ID = 9 // china yuan
        static let CZK_ID = 10 //czhech crona
        static let SEK_ID = 11 // sweden crona
        static let JPY_ID = 12 // japan yena
        static let UAH_ID = 13
        static let OTHER_ID = 999
        
        
        //Array of currencies names for each country
        static let currecyNamesUsa = ["HKD", "HUF", "INR", "ILS", "JPY", "KRW", "MXN", "NZD", "NOK", "RON", "SGD", "RUB", "SEK", "CHF", "TRY", "GBP", "EUR", "PLN", "BRL", "AUD", "BGN", "CAD", "CNY", "HRK", "CZK", "DKK", "IDR", "MYR", "PHP", "THB", "ZAR"]
        
        static let currecyNamesEurope = ["HKD", "HUF", "INR", "ILS", "JPY", "KRW", "MXN", "NZD", "NOK", "RON", "SGD", "RUB", "SEK", "CHF", "TRY", "GBP", "USD", "PLN", "BRL", "AUD", "BGN", "CAD", "CNY", "HRK", "CZK", "DKK", "IDR", "MYR", "PHP", "THB", "ZAR"]
        
        static let currecyNamesTurkey = ["USD", "AUD", "DKK", "EUR", "GBP", "CHF", "SEK", "CAD", "KWD", "NOK", "SAR", "JPY", "BGN", "RON", "RUB", "CNY", "PKR"]
        
        
        static let currecyNamesUk = ["HKD", "HUF", "INR", "ILS", "JPY", "KRW", "MXN", "NZD", "NOK", "RON", "SGD", "RUB", "SEK", "CHF", "TRY", "USD", "EUR", "PLN", "BRL", "AUD", "BGN", "CAD", "CNY", "HRK", "CZK", "DKK", "IDR", "MYR", "PHP", "THB", "ZAR", "GBP"]
        static let mainCurrencyNamesUk = ["USD", "EUR", "RUB", "CAD", "TRY", "PLN", "ILS", "CNY", "CZK", "SEK", "CHF", "JPY"]
        static let mainCurrencyConvertNamesUk = ["USD", "EUR", "RUB", "CAD", "TRY", "PLN", "ILS", "CNY", "CZK", "SEK", "CHF", "JPY", "GBP"]
        
        
        static let currecyNamesPoland = ["HKD", "HUF", "INR", "ILS", "JPY", "KRW", "MXN", "NZD", "NOK", "RON", "SGD", "RUB", "SEK", "CHF", "TRY", "USD", "EUR", "UAH", "BRL", "AUD", "BGN", "CAD", "CNY", "HRK", "CZK", "DKK", "IDR", "MYR", "PHP", "THB", "ZAR", "GBP", "ISK", "PLN"]
        static let mainCurrencyNamesPoland = ["USD", "EUR", "GBP", "CHF"]
        static let mainCurrencyConvertNamesPoland = ["USD", "EUR", "GBP", "CHF", "PLN"]
        
        
        static let currecyNamesRussia = ["AZN", "HUF", "INR", "AMD", "JPY", "KRW", "BYN", "EUR", "NOK", "RON", "SGD", "UAH", "SEK", "CHF", "TRY", "GBP", "USD", "PLN", "BRL", "AUD", "BGN", "CAD", "CNY", "KZT", "CZK", "DKK", "KGS", "MDL", "TJS", "TMT", "ZAR", "UZS", "RUB"]
        static let mainCurrencyNamesRussia = ["USD", "EUR"]
        static let mainCurrencyConvertNamesRussia = ["USD", "EUR", "RUB"]
        
        
        static let currecyNamesUkraine = ["HKD", "HUF", "ISK", "INR", "IRR", "IQD", "ILS", "GEL", "JPY", "KZT", "KRW", "KWD", "KGS", "LBP", "LYD", "MXN", "MNT", "MDL", "NZD", "NOK", "PKR", "PEN", "RON", "SAR", "SGD", "RUB", "BYN", "SEK", "CHF", "SYP", "TRY", "TMT", "EGP", "GBP", "USD", "UZS", "TWD", "XOF", "XAU", "XAG", "XPT", "XPD", "EUR", "PLN", "BRL", "TJS", "AZN", "AUD", "AMD", "BGN", "CAD", "CLP", "CNY", "HRK", "CZK", "DKK", "UAH"]
        static let mainCurrencyNamesUkraine = ["USD", "EUR", "RUB"]
        static let mainCurrencyConvertNamesUkraine = ["USD", "EUR", "RUB", "UAH"]
        
        //Array of all currencies in appData.plist with their information(name, description, country and country flag)
        static let ALL_CURRENCIES = [["currencyName" : "HKD", "currencyDescription" : NSLocalizedString("hong_kong_currency", comment: ""),
                                      "countryName" : NSLocalizedString("hong_kong", comment: ""), "countryFlag" : "currency_flag_hongong", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "HUF", "currencyDescription" : NSLocalizedString("hungary_currency", comment: ""), "countryName" : NSLocalizedString("hungary", comment: ""), "countryFlag" : "currency_flag_hungary", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "HUF", "currencyDescription" : NSLocalizedString("hungary_currency", comment: ""), "countryName" : NSLocalizedString("hungary", comment: ""), "countryFlag" : "currency_flag_hungary", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "ISK", "currencyDescription" : NSLocalizedString("island_currency", comment: ""), "countryName" : NSLocalizedString("island", comment: ""), "countryFlag" : "currency_flag_island", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "INR", "currencyDescription" : NSLocalizedString("india_currency", comment: ""), "countryName" : NSLocalizedString("india", comment: ""), "countryFlag" : "currency_flag_india", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "IRR", "currencyDescription" : NSLocalizedString("iran_currency", comment: ""), "countryName" : NSLocalizedString("iran", comment: ""), "countryFlag" : "currency_flag_iran", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "IQD", "currencyDescription" : NSLocalizedString("irak_currency", comment: ""), "countryName" : NSLocalizedString("irak", comment: ""), "countryFlag" : "currency_flag_irak", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "ILS", "currencyDescription" : NSLocalizedString("israel_currency", comment: ""), "countryName" : NSLocalizedString("israel", comment: ""), "countryFlag" : "currency_flag_israel", "currencyID" : ILS_ID, "currencyIcon" : "icon_ils_dark"],
                                     
                                     ["currencyName" : "GEL", "currencyDescription" : NSLocalizedString("georgia_currency", comment: ""), "countryName" : NSLocalizedString("georgia", comment: ""), "countryFlag" : "currency_flag_georgia", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "JPY", "currencyDescription" : NSLocalizedString("japan_currency", comment: ""), "countryName" : NSLocalizedString("japan", comment: ""), "countryFlag" : "currency_flag_japan", "currencyID" : JPY_ID, "currencyIcon" : "icon_jpy_dark"],
                                     
                                     ["currencyName" : "UAH", "currencyDescription" : NSLocalizedString("ukraine_currency", comment: ""), "countryName" : NSLocalizedString("ukraine", comment: ""), "countryFlag" : "currency_flag_ukraine", "currencyID" : UAH_ID, "currencyIcon" : "icon_uah_dark"],
                                     
                                     ["currencyName" : "KZT", "currencyDescription" : NSLocalizedString("kazakhstan_currency", comment: ""), "countryName" : NSLocalizedString("kazakhtan", comment: ""), "countryFlag" : "currency_flag_kazakhstan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "KRW", "currencyDescription" : NSLocalizedString("south_korea_currency", comment: ""), "countryName" : NSLocalizedString("south_korea", comment: ""), "countryFlag" : "currency_flag_korea", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "KWD", "currencyDescription" : NSLocalizedString("kuwait_currency", comment: ""), "countryName" : NSLocalizedString("kuwait", comment: ""), "countryFlag" : "currency_flag_kuwait", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "KGS", "currencyDescription" : NSLocalizedString("kyrgyzstan_currency", comment: ""), "countryName" : NSLocalizedString("kyrgyzstan", comment: ""), "countryFlag" : "currency_flag_kyrgystan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "LBP", "currencyDescription" : NSLocalizedString("lebanon_currency", comment: ""), "countryName" : NSLocalizedString("lebanon", comment: ""), "countryFlag" : "currency_flag_lebanon", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "LYD", "currencyDescription" : NSLocalizedString("libya_currency", comment: ""), "countryName" : NSLocalizedString("libya", comment: ""), "countryFlag" : "currency_flag_libya", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "MXN", "currencyDescription" : NSLocalizedString("mexico_currency", comment: ""), "countryName" : NSLocalizedString("mexico", comment: ""), "countryFlag" : "currency_flag_mexico", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "MNT", "currencyDescription" : NSLocalizedString("mongolia_currency", comment: ""), "countryName" : NSLocalizedString("mongolia", comment: ""), "countryFlag" : "currency_flag_mongolia", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "MDL", "currencyDescription" : NSLocalizedString("moldova_currency", comment: ""), "countryName" : NSLocalizedString("moldova", comment: ""), "countryFlag" : "currency_flag_moldova", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "NZD", "currencyDescription" : NSLocalizedString("new_zealand_currency", comment: ""), "countryName" : NSLocalizedString("new_zealand", comment: ""), "countryFlag" : "currency_flag_new_zealand", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "NOK", "currencyDescription" : NSLocalizedString("norway_currency", comment: ""), "countryName" : NSLocalizedString("norway", comment: ""), "countryFlag" : "currency_flag_norway", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "PKR", "currencyDescription" : NSLocalizedString("pakistan_currency", comment: ""), "countryName" : NSLocalizedString("pakistan", comment: ""), "countryFlag" : "currency_flag_pakistan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "PEN", "currencyDescription" : NSLocalizedString("peru_currency", comment: ""), "countryName" : NSLocalizedString("peru", comment: ""), "countryFlag" : "currency_flag_peru", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "RON", "currencyDescription" : NSLocalizedString("romania_currency", comment: ""), "countryName" : NSLocalizedString("romania", comment: ""), "countryFlag" : "currency_flag_romania", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "SAR", "currencyDescription" : NSLocalizedString("saudi_arabia_currency", comment: ""), "countryName" : NSLocalizedString("saudi_arabia", comment: ""), "countryFlag" : "currency_flag_saudi_arabia", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "SGD", "currencyDescription" : NSLocalizedString("singapore_currency", comment: ""), "countryName" : NSLocalizedString("singapore", comment: ""), "countryFlag" : "currency_flag_singapore", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "RUB", "currencyDescription" : NSLocalizedString("russia_currency", comment: ""), "countryName" : NSLocalizedString("russia", comment: ""), "countryFlag" : "currency_flag_russia", "currencyID" : RUB_ID, "currencyIcon" : "icon_rub_dark"],
                                     
                                     ["currencyName" : "BYN", "currencyDescription" : NSLocalizedString("belarus_currency", comment: ""), "countryName" : NSLocalizedString("belarus", comment: ""), "countryFlag" : "currency_flag_belarus", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "SEK", "currencyDescription" : NSLocalizedString("sweden_currency", comment: ""), "countryName" : NSLocalizedString("sweden", comment: ""), "countryFlag" : "currency_flag_sweden", "currencyID" : SEK_ID, "currencyIcon" : "icon_sek_dark"],
                                     
                                     ["currencyName" : "CHF", "currencyDescription" : NSLocalizedString("switzerland_currency", comment: ""), "countryName" : NSLocalizedString("switzerland", comment: ""), "countryFlag" : "currency_flag_switzerland", "currencyID" : CHF_ID, "currencyIcon" : "icon_chf_dark"],
                                     
                                     ["currencyName" : "SYP", "currencyDescription" : NSLocalizedString("syria_currency", comment: ""), "countryName" : NSLocalizedString("syria", comment: ""), "countryFlag" : "currency_flag_syria", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "TRY", "currencyDescription" : NSLocalizedString("turkey_currency", comment: ""), "countryName" : NSLocalizedString("turkey", comment: ""), "countryFlag" : "currency_flag_turkey", "currencyID" : TRY_ID, "currencyIcon" : "icon_try_dark"],
                                     
                                     ["currencyName" : "TMT", "currencyDescription" : NSLocalizedString("turkmenistan_currency", comment: ""), "countryName" : NSLocalizedString("turkmenistan", comment: ""), "countryFlag" : "currency_flag_turkmenistan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "EGP", "currencyDescription" : NSLocalizedString("egypt_currency", comment: ""), "countryName" : NSLocalizedString("egypt", comment: ""), "countryFlag" : "currency_flag_egypt", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "GBP", "currencyDescription" : NSLocalizedString("greatbritain_currency", comment: ""), "countryName" : NSLocalizedString("greatbritain", comment: ""), "countryFlag" : "currency_flag_great_britain", "currencyID" : GBP_ID, "currencyIcon" : "icon_gbp_dark"],
                                     
                                     ["currencyName" : "USD", "currencyDescription" : NSLocalizedString("usa_currency", comment: ""), "countryName" : NSLocalizedString("usa", comment: ""), "countryFlag" : "currency_flag_usa", "currencyID" : USD_ID, "currencyIcon" : "icon_usd_dark"],
                                     
                                     ["currencyName" : "UZS", "currencyDescription" : NSLocalizedString("uzbekistan_currency", comment: ""), "countryName" : NSLocalizedString("uzbekistan", comment: ""), "countryFlag" : "currency_flag_uzbekistan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "TWD", "currencyDescription" : NSLocalizedString("taiwan_currency", comment: ""), "countryName" : NSLocalizedString("taiwan", comment: ""), "countryFlag" : "currency_flag_taiwan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "XOF", "currencyDescription" : NSLocalizedString("western_africa_currency", comment: ""), "countryName" : NSLocalizedString("western_africa", comment: ""), "countryFlag" : "currency_flag_western_africa", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "XAU", "currencyDescription" : NSLocalizedString("gold_currency", comment: ""), "countryName" : NSLocalizedString("gold", comment: ""), "countryFlag" : "currency_flag_gold", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "XAG", "currencyDescription" : NSLocalizedString("silver_currency", comment: ""), "countryName" : NSLocalizedString("silver", comment: ""), "countryFlag" : "currency_flag_silver", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "XPT", "currencyDescription" : NSLocalizedString("platinum_currency", comment: ""), "countryName" : NSLocalizedString("platinum", comment: ""), "countryFlag" : "currency_flag_platinum", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "XPD", "currencyDescription" : NSLocalizedString("paladium_currency", comment: ""), "countryName" : NSLocalizedString("paladium", comment: ""), "countryFlag" : "currency_flag_paladium", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "EUR", "currencyDescription" : NSLocalizedString("europe_currency", comment: ""), "countryName" : NSLocalizedString("europe", comment: ""), "countryFlag" : "currency_flag_europe", "currencyID" : EUR_ID, "currencyIcon" : "icon_eur_dark"],
                                     
                                     ["currencyName" : "PLN", "currencyDescription" : NSLocalizedString("poland_currency", comment: ""), "countryName" : NSLocalizedString("poland", comment: ""), "countryFlag" : "currency_flag_poland", "currencyID" : PLN_ID, "currencyIcon" : "icon_pln_dark"],
                                     
                                     ["currencyName" : "BRL", "currencyDescription" : NSLocalizedString("brazil_currency", comment: ""), "countryName" : NSLocalizedString("brazil", comment: ""), "countryFlag" : "currency_flag_brazil", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "TJS", "currencyDescription" : NSLocalizedString("tajikistan_currency", comment: ""), "countryName" : NSLocalizedString("tajikistan", comment: ""), "countryFlag" : "currency_flag_tajikistan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "AZN", "currencyDescription" : NSLocalizedString("azerbaijan_currency", comment: ""), "countryName" : NSLocalizedString("azerbaijan", comment: ""), "countryFlag" : "currency_flag_azerbaijan", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "AUD", "currencyDescription" : NSLocalizedString("australia_currency", comment: ""), "countryName" : NSLocalizedString("australia", comment: ""), "countryFlag" : "currency_flag_australia", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "AMD", "currencyDescription" : NSLocalizedString("armenia_currency", comment: ""), "countryName" : NSLocalizedString("armenia", comment: ""), "countryFlag" : "currency_flag_armenia", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "BGN", "currencyDescription" : NSLocalizedString("bulgary_currency", comment: ""), "countryName" : NSLocalizedString("bulgary", comment: ""), "countryFlag" : "currency_flag_bulgaria", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "CAD", "currencyDescription" : NSLocalizedString("canada_currency", comment: ""), "countryName" : NSLocalizedString("canada", comment: ""), "countryFlag" : "currency_flag_canada", "currencyID" : CAD_ID, "currencyIcon" : "icon_cad_dark"],
                                     
                                     ["currencyName" : "CLP", "currencyDescription" : NSLocalizedString("chile_currency", comment: ""), "countryName" : NSLocalizedString("chile", comment: ""), "countryFlag" : "currency_flag_chile", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "CNY", "currencyDescription" : NSLocalizedString("china_currency", comment: ""), "countryName" : NSLocalizedString("china", comment: ""), "countryFlag" : "currency_flag_china", "currencyID" : CNY_ID, "currencyIcon" : "icon_cny_dark"],
                                     
                                     ["currencyName" : "HRK", "currencyDescription" : NSLocalizedString("croatia_currency", comment: ""), "countryName" : NSLocalizedString("croatia", comment: ""), "countryFlag" : "currency_flag_croatia", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "CZK", "currencyDescription" : NSLocalizedString("czech_currency", comment: ""), "countryName" : NSLocalizedString("czech", comment: ""), "countryFlag" : "currency_flag_czech", "currencyID" : CZK_ID, "currencyIcon" : "icon_czk_dark"],
                                     
                                     ["currencyName" : "DKK", "currencyDescription" : NSLocalizedString("denmark_currency", comment: ""), "countryName" : NSLocalizedString("denmark", comment: ""), "countryFlag" : "currency_flag_denmark", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "MYR", "currencyDescription" : NSLocalizedString("malaysia_currency", comment: ""), "countryName" : NSLocalizedString("malaysia", comment: ""), "countryFlag" : "currency_flag_malaysia", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "ZAR", "currencyDescription" : NSLocalizedString("south_africa_currency", comment: ""), "countryName" : NSLocalizedString("south_africa", comment: ""), "countryFlag" : "currency_flag_south_africa", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "THB", "currencyDescription" : NSLocalizedString("thailand_currency", comment: ""), "countryName" : NSLocalizedString("thailand", comment: ""), "countryFlag" : "currency_flag_thailand", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "PHP", "currencyDescription" : NSLocalizedString("philippines_currency", comment: ""), "countryName" : NSLocalizedString("philippines", comment: ""), "countryFlag" : "currency_flag_philippines", "currencyID" : OTHER_ID, "currencyIcon" : ""],
                                     
                                     ["currencyName" : "IDR", "currencyDescription" : NSLocalizedString("indonesia_currency", comment: ""), "countryName" : NSLocalizedString("indonesia", comment: ""), "countryFlag" : "currency_flag_indonesia", "currencyID" : OTHER_ID, "currencyIcon" : ""]]
    }
}
