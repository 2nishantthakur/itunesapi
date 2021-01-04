//
//  ViewController.swift
//  iTunesAPIConnect
//
//  Created by Nishant Thakur on 04/01/21.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    
        
    var tracks = [Result()]
    var trackDetails = Result()
    
    @IBOutlet var searchTF: UITextField!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tracks = []
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    @IBAction func searchPressed(_ sender: Any) {
        tracks = []
        tableView.reloadData()
        let searchText = searchTF.text
        if searchText == ""{
            let alert = UIAlertController(title: "Alert", message: "Please enter some text to search!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else{
            let trimmedSearchText = String(searchText!.filter { !" \n\t\r".contains($0) })
            callAPI(artistName: trimmedSearchText)
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.trackName.text = tracks[indexPath.row].trackName
        cell.artistName.text = "By-\(tracks[indexPath.row].artistName)"
        return cell
    }
 
    
    
    
    
    
    func callAPI(artistName: String){
        let urlString = "https://itunes.apple.com/search?term=\(artistName)"
        print(urlString)
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    print("Error while API call")
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(safeData)
                    
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data){
        
        do{
            let jsonDict = try JSONSerialization.jsonObject(with: weatherData) as? NSDictionary
//                                 print(jsonDict!)
            if let results = jsonDict!["results"] as? [[String:Any]]{
                print(results)
                
                for dict in results{
                   
                    trackDetails.trackName = dict["trackName"] as! String
//                    print(trackDetails.trackName)
                    trackDetails.artistName = dict["artistName"] as! String
                    tracks.append(trackDetails)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }
      
            
        }catch{
            print("error")
            
        }
        
    }
    
    
}

