//
//  ViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/08.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
        
    
    @IBOutlet weak var pickerview: UIPickerView!
    
    @IBAction func doneToPickerViewController(segue: UIStoryboardSegue)
    {
        
    }
    
    var pickerDataSource = [
    
    "가평군","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시", // 10
    "부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","양평군","여주시",    // 10
    "연천군","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시" //11
    
    ]
    
    var url : String = "https://openapi.gg.go.kr/Youngbgactopertinst?KEY=688bb5044d724a149eb7343f27d4681e&SIGUN_CD="
    
    var sigunCD : String = "41820"
    
    // PickerView에 필요한 함수들
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            sigunCD = "41820"  // 가평군
        }else if row == 1 {
            sigunCD = "41280"  // 고양시
        }else if row == 2 {
            sigunCD = "41290"  // 과천시
        }else if row == 3 {
            sigunCD = "41210"  // 광명시
        }else if row == 4 {
            sigunCD = "41610"  // 광주시
        }else if row == 5 {
            sigunCD = "41310"  // 구리시
        }else if row == 6 {
            sigunCD = "41410"  // 군포시
        }else if row == 7 {
            sigunCD = "41570"
        }else if row == 8 {
            sigunCD = "41360"
        }else if row == 9 {
            sigunCD = "41250"
        }else if row == 10 {
            sigunCD = "41190"
        }else if row == 11 {
            sigunCD = "41130"
        }else if row == 12 {
            sigunCD = "41110"
        }else if row == 13 {
            sigunCD = "41390"
        }else if row == 14 {
            sigunCD = "41270"
        }else if row == 15 {
            sigunCD = "41550"
        }else if row == 16 {
            sigunCD = "41170"
        }else if row == 17 {
            sigunCD = "41630"
        }else if row == 18 {
            sigunCD = "41830"
        }else if row == 19 {
            sigunCD = "41670"
        }else if row == 20 {
            sigunCD = "41800"
        }else if row == 21 {
            sigunCD = "41370"
        }else if row == 22 {
            sigunCD = "41460"
        }else if row == 23 {
            sigunCD = "41430"
        }else if row == 24 {
            sigunCD = "41150"
        }else if row == 25 {
            sigunCD = "41500"
        }else if row == 26 {
            sigunCD = "41480"
        }else if row == 27 {
            sigunCD = "41220"
        }else if row == 28 {
            sigunCD = "41650"
        }else if row == 29 {
            sigunCD = "41450"
        }
        else {
           sigunCD = "41590"   // 화성시
        }
    }
    
    // prepare 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToTableView" {
            if let navController = segue.destination as? UINavigationController {
                if let regionTableViewController = navController.topViewController as?
                    RegionTableViewController {
                    regionTableViewController.url = url + sigunCD
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.pickerview.delegate = self;
        self.pickerview.dataSource = self;
    }


}

