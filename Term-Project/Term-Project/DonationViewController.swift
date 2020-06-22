//
//  DonationViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/22.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit

class DonationViewController: UIViewController {

    @IBOutlet weak var sidoTextField: UITextField!
    @IBOutlet weak var keywordTextField: UITextField!
    
    var url : String =
    "http://openapi.1365.go.kr/openapi/service/rest/ContributionGroupService/getCntrSearchWordGrpList?serviceKey=nyTZfGIdeHLvYBVX39%2B%2B5kbf%2Bi%2FDbrcZ5nfvpF3V8nN4z4fgC47XblX%2Fv6qhvYVZiTUNWC1gw1JdQmKgc0BKRQ%3D%3D&numOfRows=30"
    
    var sidoText : String = ""
    var keywordText : String = ""
    
    // schSido=&schSign=&schCntrClCode=&keyword=
    
    @IBAction func doneToDonationViewController(segue: UIStoryboardSegue)
    {
           
    }
    
    // prepare 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToDonationView" {
            if let navController = segue.destination as? UINavigationController {
                if let donationTableViewController = navController.topViewController as?
                    DonationTableViewController {
                    
                    // 시도코드로 변환
                    if(sidoTextField.text == "서울특별시" || sidoTextField.text == "서울시"){
                       sidoText = "&schSido=" + "6110000"
                    }
                    else if(sidoTextField.text == "부산광역시" || sidoTextField.text == "부산시"){
                        sidoText = "&schSido=" + "6260000"
                    }else if (sidoTextField.text == "대구광역시" || sidoTextField.text == "대구시") {
                        sidoText = "&schSido=" + "6270000"
                    }else if (sidoTextField.text == "인천광역시" || sidoTextField.text == "인천시") {
                        sidoText = "&schSido=" + "6280000"
                    }else if (sidoTextField.text == "광주광역시" || sidoTextField.text == "광주시"){
                        sidoText = "&schSido=" + "6290000"
                    }else if (sidoTextField.text == "대전광역시" || sidoTextField.text == "대전시") {
                        sidoText = "&schSido=" + "6300000"
                    }else if (sidoTextField.text == "울산광역시" || sidoTextField.text == "울산시"){
                        sidoText = "&schSido=" + "6310000"
                    }else if (sidoTextField.text == "세종특별자치시" || sidoTextField.text == "세종시"){
                        sidoText = "&schSido=" + "5690000"
                    }else if (sidoTextField.text == "경기도" || sidoTextField.text == "경기"){
                        sidoText = "&schSido=" + "6410000"
                    }else if (sidoTextField.text == "강원도" || sidoTextField.text == "강원"){
                        sidoText = "&schSido=" + "6420000"
                    }else if (sidoTextField.text == "충청북도") {
                        sidoText = "&schSido=" + "6430000"
                    }else if (sidoTextField.text == "충청남도") {
                        sidoText = "&schSido=" + "6440000"
                    }else if (sidoTextField.text == "전라북도") {
                        sidoText = "&schSido=" + "6450000"
                    }else if (sidoTextField.text == "전라남도"){
                        sidoText = "&schSido=" + "6460000"
                    }else if (sidoTextField.text == "경상북도"){
                        sidoText = "&schSido=" + "6470000"
                    }else if (sidoTextField.text == "경상남도"){
                        sidoText = "&schSido=" + "6480000"
                    }else if (sidoTextField.text == "제주특별자치도" || sidoTextField.text == "제주도"){
                        sidoText = "&schSido=" + "6500000"
                    }
                    
                    keywordText = "&keyword=" + keywordTextField.text!
                    donationTableViewController.url = url + sidoText + keywordText
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
