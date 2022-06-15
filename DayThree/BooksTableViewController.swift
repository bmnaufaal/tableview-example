//
//  BooksTableViewController.swift
//  DayThree
//
//  Created by Berlian on 15/06/22.
//

import UIKit
import Alamofire
import AlamofireImage

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
        cell?.isbnView.text = booksList[indexPath.row].isbn ?? "No ISBN"
        let image = AF.request("https://httpbin.org/image/png").responseImage { response in
            if case .success(let image) = response.result {
                cell?.urlView.image = image
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
