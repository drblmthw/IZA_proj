//
//  SettingsViewController.swift
//  IZA_proj
//
//  Created by Matej Kubový on 18/05/2020.
//  Copyright © 2020 Matej Kubový. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var aktualityS: UISwitch!
    @IBAction func aktualitySwitch(_ sender: UISwitch) {
        if sender.isOn {
            userDefaults.set(true, forKey: "Set_aktuality")
        } else {
            userDefaults.set(false, forKey: "Set_aktuality")
        }
    }
    
    @IBOutlet weak var denniknS: UISwitch!
    @IBAction func denniknSwitch(_ sender: UISwitch) {
        if sender.isOn {
            userDefaults.set(true, forKey: "Set_dennikn")
        } else {
            userDefaults.set(false, forKey: "Set_dennikn")
        }
    }
    
    @IBOutlet weak var smeS: UISwitch!
    @IBAction func smeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            userDefaults.set(true, forKey: "Set_sme")
        } else {
            userDefaults.set(false, forKey: "Set_sme")
        }
    }
    
    @IBOutlet weak var hnonlineS: UISwitch!
    @IBAction func hnonlineSwitch(_ sender: UISwitch) {
        if sender.isOn {
            userDefaults.set(true, forKey: "Set_hnonline")
        } else {
            userDefaults.set(false, forKey: "Set_hnonline")
        }
    }
    
    @IBOutlet weak var pravdaS: UISwitch!
    @IBAction func pravdeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            userDefaults.set(true, forKey: "Set_pravda")
        } else {
            userDefaults.set(false, forKey: "Set_pravda")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        aktualityS.setOn(userDefaults.bool(forKey: "Set_aktuality"), animated: false)
        denniknS.setOn(userDefaults.bool(forKey: "Set_dennikn"), animated: false)
        smeS.setOn(userDefaults.bool(forKey: "Set_sme"), animated: false)
        hnonlineS.setOn(userDefaults.bool(forKey: "Set_hnonline"), animated: false)
        pravdaS.setOn(userDefaults.bool(forKey: "Set_pravda"), animated: false)
    }
}
