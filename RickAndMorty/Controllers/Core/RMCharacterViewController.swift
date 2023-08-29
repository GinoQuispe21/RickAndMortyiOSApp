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
        
        let request = RMRequest(
            endpoint: .character,
            queryParameters: [
                URLQueryItem(name: "name", value: "rick"),
                URLQueryItem(name: "status", value: "alive")
            ]
        )
        print(request.url ?? "")
        RMService.shared.execute(request, expecting: RMCharacter.self) { result in
            switch result {
            case .success(let character):
                print("Response", character)
            case .failure(let error):
                print("Error", error)
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
