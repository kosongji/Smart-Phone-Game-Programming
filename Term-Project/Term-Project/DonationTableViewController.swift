//
//  DonationTableViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/22.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit

class DonationTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var tbData: UITableView!
   
    // viewController로 부터 segue 를 통해 전달받은 주소
    var url : String?
    // 한글 변환을 위한 url 받을 변수
    var urlString : URL?
    var encodedString : String = ""
    
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
    
    // parse오브젝트 초기화하고 XMLParserDelegate로 설정하고 XML파싱시작
    func beginParsing()
    {
        // 변환 작업
        encodedString = url!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        urlString = URL(string: encodedString)!
        
        
        posts = []
        print(urlString!)
        parser = XMLParser(contentsOf: urlString!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            name = NSMutableString()
            name = ""
            addr = NSMutableString()
            addr = ""

        }
    }
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "nanmmbyNm"){
            name.append(string)
        }
        else if element.isEqual(to: "adres"){
            addr.append(string)
        }
            
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item") {
            if !name.isEqual(nil) {
                elements.setObject(name, forKey: "nanmmbyNm" as NSCopying)
            }
            if !addr.isEqual(nil) {
                elements.setObject(addr, forKey: "adres" as NSCopying)
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

        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "nanmmbyNm") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "adres") as! NSString as String

        return cell
    }

}
