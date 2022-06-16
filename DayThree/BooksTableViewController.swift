//
//  BooksTableViewController.swift
//  DayThree
//
//  Created by Berlian on 15/06/22.
//

import UIKit
import Alamofire

class BooksTableViewController: UITableViewController {
    
    var booksList:[Books] = [Books]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return booksList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell
        let joinedAuthors = booksList[indexPath.row].authors.joined(separator: ", ")
        cell?.titleView.text = booksList[indexPath.row].title
        cell?.authorsView.text = joinedAuthors
        cell?.isbnView.text = booksList[indexPath.row].isbn
        if let url = booksList[indexPath.row].thumbnailUrl {
            AF.request(url).response { (response) in
                if let image = response.data {
                    cell?.urlView.image = UIImage(data: image)
                }else {
                    cell?.urlView.image = UIImage(named: "no-cover")
                }
            }
        }
        
        return cell!
    }

    func fetchData() {
        if let fileLocation = Bundle.main.url(forResource: "books", withExtension: "json") {
            do{
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Books].self, from: data)
                self.booksList = dataFromJson
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch{
                print(error)
            }
        }
    }

}
