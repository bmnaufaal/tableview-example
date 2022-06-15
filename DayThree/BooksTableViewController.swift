//
//  BooksTableViewController.swift
//  DayThree
//
//  Created by Berlian on 15/06/22.
//

import UIKit

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
        
        cell?.titleView.text = booksList[indexPath.row].title
        cell?.authorView.text = "By " + booksList[indexPath.row].author
        cell?.yearView.text = String(booksList[indexPath.row].year)
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
