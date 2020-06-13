//
//  RegionTableViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/13.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit

class RegionTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbData: UITableView!
    
    // viewController로 부터 segue 를 통해 전달받은 주소
    var url : String?
    
    //  - xml 파싱 데모 -
    
    // xml파일을 다운로드 및 파싱하는 오브젝트
     var parser = XMLParser()
    // feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    // title과 data같은 feed데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    // 저장 문자열 변수
    var name = NSMutableString()                    // 기관명
    var addr = NSMutableString()                    // 소재지 도로명 주소
    var telno = NSMutableString()
    
    // 지도 표시를 위한 위도 경조 좌표 변수
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
    // parse오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML파싱시작
    func beginParsing()
    {
        posts = []
        print(url!)
        parser = XMLParser(contentsOf: (URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "row")
        {
            elements = NSMutableDictionary()
            elements = [:]
            name = NSMutableString()
            name = ""
            addr = NSMutableString()
            addr = ""
            telno = NSMutableString()
            telno = ""
            // 위도 경도
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "INST_NM"){
            name.append(string)
        }
        else if element.isEqual(to: "REFINE_ROADNM_ADDR"){
            addr.append(string)
        }
        else if element.isEqual(to: "TELNO"){
            telno.append(string)
        }
            
        //위도 경도
        else if element.isEqual(to: "REFINE_WGS84_LAT"){
            XPos.append(string)
        }else if element.isEqual(to: "REFINE_WGS84_LOGT"){
            YPos.append(string)
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "row") {
            if !name.isEqual(nil) {
                elements.setObject(name, forKey: "INST_NM" as NSCopying)
            }
            if !addr.isEqual(nil) {
                elements.setObject(addr, forKey: "REFINE_ROADNM_ADDR" as NSCopying)
            }
            if !telno.isEqual(nil) {
                elements.setObject(telno, forKey: "TELNO" as NSCopying)
            }
            // 위도 경도
            if !XPos.isEqual(nil) {
                elements.setObject(XPos, forKey: "REFINE_WGS84_LAT" as NSCopying)
            }
            if !YPos.isEqual(nil) {
                elements.setObject(YPos, forKey: "REFINE_WGS84_LOGT" as NSCopying)
            }
            posts.add(elements)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //XML 파싱
        beginParsing()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "INST_NM") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "REFINE_ROADNM_ADDR") as! NSString as String

        return cell
    }
    
}
