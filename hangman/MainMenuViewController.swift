//
//  MainMenuViewController.swift
//  hangman
//
//  Created by Trakya9 on 5.06.2024.
//

import UIKit

class MainMenuViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let languages = ["Türkçe","English", "Spanish", "French", "German"]
    var selectedLanguage: String = "Türkçe"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        languagePicker.delegate = self
        languagePicker.dataSource = self
        
    }
    
    @IBAction func playGameButton(_ sender: UIButton) {
        performSegue(withIdentifier: "startGameSegue", sender: self)
    }
    
    @IBOutlet weak var languagePicker: UIPickerView!
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    // UIPickerView Delegate Metotları
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = languages[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startGameSegue" {
            if let viewController = segue.destination as? ViewController {
                viewController.selectedLanguage = selectedLanguage
            }
        }
    }
}
