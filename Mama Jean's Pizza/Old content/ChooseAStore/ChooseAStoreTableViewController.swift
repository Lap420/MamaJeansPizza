//
//  ChooseAStoreTableViewController.swift
//  Mama Jean's Pizza
//
//  Created by Lap on 13.02.2023.
//

import UIKit

class ChooseAStoreTableViewController: UITableViewController {
    
    let cities = ["Dubai", "Abu-Dhabi"]
    let storesDubai = ["Dubai Marina", "Dubai Internet City", "Dubai Investments park", "Jumairah Lake Towers"]
    let storesAbuDhabi = ["Abu-Dhabi Airport", "Abu-Dhabi F1 Circuit"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Choose a store"
        
        // TODO: Изменить цвет кнопки Back
        // TODO: прописать разное время работы точек
        // TODO: Если точка сейчас не работает, то менять цвет на красный и писать Closed now
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return cities.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return storesDubai.count
        case 1:
            return storesAbuDhabi.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return cities[section]
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Store", for: indexPath)

        var content = cell.defaultContentConfiguration()
        switch indexPath.section {
        case 0:
            content.text = storesDubai[indexPath.row]
        case 1:
            content.text = storesAbuDhabi[indexPath.row]
        default:
            break
        }
        
        content.secondaryText = "10:00 am - 10:00 pm"
        cell.contentConfiguration = content

        return cell
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "FromStoreChoosingToMenu", sender: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
