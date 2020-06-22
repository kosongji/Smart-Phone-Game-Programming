//
//  DetailDonationTableViewController.swift
//  Term-Project
//
//  Created by KPUGAME on 2020/06/22.
//  Copyright © 2020 KPUGAME. All rights reserved.
//

import UIKit

class DetailDonationTableViewController: UITableViewController, XMLParserDelegate {
    @IBOutlet var detailTableView: UITableView!
    
    var url : URL?
    
    var parser = XMLParser()
    let postsname : [String] = ["단체명", "주소", "전화번호", "우편번호", "홈페이지","모집분야", "대표자명"]
    var posts : [String] = ["","","","","","",""]
    
    var element = NSString()
    
    var name = NSMutableString()
    var addr = NSMutableString()
    var telno = NSMutableString()
    var zip = NSMutableString()
    var hmpg = NSMutableString()
    var rcrit = NSMutableString()
    var rprsntNm = NSMutableString()
    
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf: url!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
          element = elementName as NSString
          if (elementName as NSString).isEqual(to: "item")
          {
              posts = ["","","","","","",""]
            
              name = NSMutableString()
              name = ""
            
              addr = NSMutableString()
              addr = ""
              
              telno = NSMutableString()
              telno = ""
          
              zip = NSMutableString()
              zip = ""
            
              hmpg = NSMutableString()
              hmpg = ""
            
              rcrit = NSMutableString()
              rcrit = ""
            
              rprsntNm = NSMutableString()
              rprsntNm = ""
        
        }
      }
      func parser(_ parser: XMLParser, foundCharacters string: String)
      {
          if element.isEqual(to: "nanmmbyNm"){
              name.append(string)
          } else if element.isEqual(to: "adres"){
              addr.append(string)
          }else if element.isEqual(to: "dmstcTelno"){
              telno.append(string)
          }else if element.isEqual(to: "zip"){
              zip.append(string)
          }else if element.isEqual(to: "hmpgAdres"){
              hmpg.append(string)
          }else if element.isEqual(to: "rcritRealm"){
              rcrit.append(string)
          }else if element.isEqual(to: "rprsntvNm"){
              rprsntNm.append(string)
          }
        
          
      }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item") {
            if !name.isEqual(nil) {
                posts[0] = name as String
            }
            if !addr.isEqual(nil) {
               posts[1] = addr as String
            }
            if !telno.isEqual(nil) {
               posts[2] = telno as String
            }
            if !zip.isEqual(nil) {
               posts[3] = zip as String
            }
            if !hmpg.isEqual(nil) {
               posts[4] = hmpg as String
            }
            if !rcrit.isEqual(nil) {
               posts[5] = rcrit as String
            }
            if !rprsntNm.isEqual(nil) {
               posts[6] = rprsntNm as String
            }
           
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DonationCell", for: indexPath)

        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
