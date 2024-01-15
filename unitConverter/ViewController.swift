//
//  ViewController.swift
//  unitConverter
//
//  Created by Atul Dhiman on 15/01/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    // MARK: IB Outlets
    @IBOutlet weak var convertVw: UIView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var unitLbl: UILabel!
    @IBOutlet weak var unitBT: UIButton!
    @IBOutlet weak var outputLbl: UILabel!
    @IBOutlet weak var doneBT: UIButton!
    @IBOutlet weak var pickerVw: UIView!
    @IBOutlet weak var unitPicker: UIPickerView!
    
    // MARK: DataModel Variables
    private let list = Unit.allCases()
    private var selectedIndex = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIload()
    }
}

// MARK: - Picker Delgate Methods.
extension ViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = list[row]
        unitLbl.text = "\(selectedIndex)"
    }
}

// MARK: - IB Outlet Methods
extension ViewController {
    
    @IBAction func unitAction(_ sender: Any) {
        pickerVw.isHidden = false
    }
    @IBAction func doneAction(_ sender: Any) {
       convertUnit()
    }
}

// MARK: - UI Compement Methods...
extension ViewController {
    private func UIload() {
        unitPicker.delegate = self
        unitPicker.dataSource = self
        pickerVw.isHidden = true
        convertVw.layer.cornerRadius = 10
        doneBT.layer.cornerRadius = 5
    }
    private func convertUnit() {
        let fromUnitIdx = unitPicker.selectedRow(inComponent: 0)
        let toUnitIdx = unitPicker.selectedRow(inComponent: 1)
        
        let fromUnit = Unit.fromString(list[fromUnitIdx])!
        let toUnit = Unit.fromString(list[toUnitIdx])!
        
        if let inputText = numberTextField.text {
            if !inputText.isEmpty {
                let inputNum = Double(inputText)!
                let outputNum = fromUnit.convertTo(unit: toUnit, value: inputNum)
                outputLbl.text = String(outputNum)
            }
        }
    }
}
