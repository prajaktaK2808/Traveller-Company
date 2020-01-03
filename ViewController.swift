//
//  ViewController.swift
//  TravelCompanyMachineTest
//
//  Created by Student P_08 on 09/08/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{
    //DECLAIRE DELEGATE 
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    @IBOutlet weak var Picnic: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var StartDatetxt: UITextField!
    @IBOutlet weak var EndDatetxt: UITextField!
    
    @IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var StartDate1: UIDatePicker!
    @IBOutlet weak var EndDate1: UIDatePicker!
    
    var TravelsArrayData = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        readFromCoreDate()
    }

    //DATE PICKER
    @IBAction func StartDate(_ sender: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: StartDate1.date)
        StartDatetxt.text = strDate
    }
    
    @IBAction func EndDate(_ sender: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        let endDate = dateFormatter.string(from: EndDate1.date)
        EndDatetxt.text = endDate
    }
    // END DATE PICKER
    
    //INSERT DATA START
    @IBAction func BookData(_ sender: UIButton)
    {
        let context = delegate.persistentContainer.viewContext
        let travelsObject:NSObject = NSEntityDescription.insertNewObject(forEntityName: "Travels", into: context)
        travelsObject.setValue(self.Picnic.text, forKey: "picnic")
     
        //price convert into double
        let formatter = NumberFormatter()
        let price = formatter.number(from: Price.text!) as! Double
        travelsObject.setValue(price, forKey: "price")
        
        travelsObject.setValue(self.StartDatetxt.text, forKey: "startdate")
        travelsObject.setValue(self.EndDatetxt.text, forKey: "enddate")
        do
        {
            try context.save()
            ClearTextData()
            readFromCoreDate()
        }
        catch
        {
            print("Error")
        }
        print("Insertion:Success")
    }
    //INSERT DATA END

    //RETRIVE DATA START
    func readFromCoreDate()
    {
        let context = delegate.persistentContainer.viewContext
        TravelsArrayData.removeAll()
        let request = NSFetchRequest<NSFetchRequestResult> (entityName:"Travels")
        do
        {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let pic1 = data.value(forKey: "picnic") as! String
                let price1 = String(data.value(forKey: "price") as! Double)
                let strdate1 = data.value(forKey: "startdate") as! String
                let enddate1 = data.value(forKey: "enddate") as! String
                TravelsArrayData.append(pic1)
                TravelsArrayData.append(price1)
                TravelsArrayData.append(strdate1)
                TravelsArrayData.append(enddate1)
                print(TravelsArrayData)
                
            }
            if TravelsArrayData.count > 0
            {
                TableView.reloadData()
            }
            
        }
        catch
        {
            print("Error ")
        }
    }
    //RETRIVE DATE END
    
    
    
    func ClearTextData()
    {
        Picnic.text = ""
        Price.text = ""
        StartDatetxt.text = ""
        EndDatetxt.text = ""
    }
    
    @IBAction func CancleData(_ sender: UIButton)
    {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return TravelsArrayData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = TravelsArrayData[indexPath.row]
        return cell
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }


}

