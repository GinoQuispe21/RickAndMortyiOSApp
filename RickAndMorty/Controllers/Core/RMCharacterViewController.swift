//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Gino Salvador Quispe Calixto on 23/08/23.
//

import UIKit

/// Controller to show and search for Characters
class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        // Do any additional setup after loading the view.
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let response):
                dump(response)
                print("Total", String(response.info.count))
                print("Page result count: ", String(response.results.count))
                break
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
