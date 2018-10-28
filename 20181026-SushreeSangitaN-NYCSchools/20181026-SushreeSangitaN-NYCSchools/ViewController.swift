//
//  ViewController.swift
//  20181026-SushreeSangitaN-NYCSchools
//
//  Created by Sangita on 10/26/18.
//  Copyright © 2018 SushreeSangitaN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITableViewDataSource,
UITableViewDelegate {
   @IBOutlet weak var schoolNameTable: UITableView!
    let listOfSchoolRequestURL="https://data.cityofnewyork.us/resource/97mf-9njv.json"
   
    
    public var schoolNames : [schoolDetail] = []
    var selectedSchoolDetail : SATDetail!
    var selectedSchool : schoolDetail!
    
    var  schoolNameClicked : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="School List"
        schoolNameTable.delegate=self
        schoolNameTable.dataSource=self
        schoolNameTable.register(UINib(nibName:"CustomSchoolTableCellTableViewCell", bundle: nil) , forCellReuseIdentifier: "CustomSchoolTableCellTableViewCell");
        schoolNames = getSchoolList(url : listOfSchoolRequestURL)

        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolNames.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSchoolTableCellTableViewCell", for: indexPath) as! CustomSchoolTableCellTableViewCell
        
        cell.schoolNameLbl.text=schoolNames[indexPath.row].school_name
        cell.backgroundColor=hexStringToUIColor(hex: "#717514")
        
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       schoolNameClicked=schoolNames[indexPath.row].school_name
       selectedSchool=schoolNames[indexPath.row]
       performSegue(withIdentifier:"goToSchoolDetailSegue", sender: self)

        
        
    }
    func getSchoolList(url : String)->[schoolDetail] {
        var tempSchoolNames : [schoolDetail] = []
        guard let url = URL(string: url) else {return tempSchoolNames} //
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            do {
                let jsonData =  try JSONDecoder().decode([schoolDetail].self, from: data)
                tempSchoolNames=jsonData
                DispatchQueue.main.async{
                    self.schoolNames=tempSchoolNames
                    self.schoolNameTable.reloadData()
                }
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            
            }.resume()

        return tempSchoolNames
        }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToSchoolDetailSegue"){
            let destinationVC=segue.destination as! SchoolDetailViewController
            destinationVC.schoolName=schoolNameClicked
            print(selectedSchool)
            destinationVC.selectedSchool=selectedSchool

        }
    }
    /*For converting the hex code to color */
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}


/*Model For storing School list along with other details.*/
struct schoolDetail : Decodable {
    let school_name : String
    let city : String
    let code1 : String
    let website : String
    let primary_address_line_1 : String
    let state_code : String
    let zip : String
}

/*Model For storing SAT Details.*/
struct SATDetail : Decodable {
    let dbn :String
    let num_of_sat_test_takers : String
    let sat_critical_reading_avg_score : String
    let sat_math_avg_score: String
    let sat_writing_avg_score : String
    let school_name : String
}
