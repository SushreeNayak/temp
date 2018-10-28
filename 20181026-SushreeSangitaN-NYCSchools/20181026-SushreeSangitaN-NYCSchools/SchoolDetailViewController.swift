//
//  SchoolDetailViewController.swift
//  20181026-SushreeSangitaN-NYCSchools
//
//  Created by Sangita on 10/26/18.
//  Copyright © 2018 SushreeSangitaN. All rights reserved.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    
    @IBOutlet weak var SATMathsLbl: UILabel!
    @IBOutlet weak var SATReadingLbl: UILabel!
    @IBOutlet weak var SATWritingLbl: UILabel!
    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var webVal: UILabel!
    
    @IBOutlet weak var webLbl: UILabel!
    @IBOutlet weak var SATMathsValue: UILabel!
    @IBOutlet weak var SATReadingValue: UILabel!
    @IBOutlet weak var SATWritingValue: UILabel!
    @IBOutlet weak var schoolNameValue: UILabel!
    @IBOutlet weak var addressValue: UILabel!
    @IBOutlet weak var webValue: UILabel!
    
    
   // @IBOutlet weak var websiteVal: UILabel!
    
    
   
    
    
    var schoolName : String?
    var satMaths : String?
    var satReading : String?
    var satWriting : String?
    var address : String?
    var website : String?
    
    // var schoolNames : [schoolDetail] = []
     let satScoreForSchoolRequestURL="https://data.cityofnewyork.us/resource/734v-jeq5.json"
     var schoolDetails : [SATDetail] = []
     var selectedSchoolDetail : SATDetail!
     var selectedSchool : schoolDetail!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SATMathsValue.text="Not Available"
        SATReadingValue.text="Not Available"
        SATWritingValue.text="Not Available"
        addressValue.text="Not Available"
        webValue.text="Not Available"
        schoolNameValue.text=schoolName

        
      
        self.title="School Details"
        schoolDetails=getSATScore(url: satScoreForSchoolRequestURL)
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getSATScore(url : String)->[SATDetail] {
        var tempSATScore : [SATDetail] = []
        guard let url = URL(string: url) else {return tempSATScore} //
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else {return}
            do {
                let jsonData =  try JSONDecoder().decode([SATDetail].self, from: data)
                tempSATScore=jsonData
                DispatchQueue.main.async{
                    self.schoolDetails=tempSATScore
                    var status : Bool = false
                    status=self.schoolDetailAvailable(schoolName: self.schoolName!)

                }
            } catch let jsonErr {
                print("Error serializing json", jsonErr)
            }
            
            }.resume()
        
        return tempSATScore
    }
   
    func schoolDetailAvailable(schoolName : String) -> Bool {
        var temp : Int = 0
        for schooldetail in self.schoolDetails{
            if(schooldetail.school_name.uppercased() == schoolName.uppercased() ){
                self.selectedSchoolDetail=schooldetail
                print(self.selectedSchoolDetail)
                self.SATMathsValue.text=self.selectedSchoolDetail.sat_math_avg_score
                self.SATReadingValue.text=self.selectedSchoolDetail.sat_critical_reading_avg_score
                self.SATWritingValue.text=self.selectedSchoolDetail.sat_writing_avg_score
                self.addressValue.text=self.selectedSchool.primary_address_line_1 + self.selectedSchool.state_code + self.selectedSchool.zip
                self.webValue.text=self.selectedSchool.website
                temp=temp+1
                
            }
        }
        
        if(temp == 0){
            return false
        }
        else{
            return true
        }
    }
}
