//
//  UserFirstViewController.swift
//  RandomAPIDemo
//
//  Created by 李世文 on 2021/9/1.
//

import UIKit

class UserFirstViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var staticLabel: UILabel!
    @IBOutlet weak var dynamicLabel: UILabel!
    
    var name: String!
    var email: String!
    var birthday: String!
    var address: String!
    var phone: String!
    var picture: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.layer.cornerRadius = imageView.bounds.width / 2
    }
    
    func setupInfo() {
        staticLabel.text = "Hi, My name is"
        dynamicLabel.text = name
        
        URLSession.shared.dataTask(with: picture) { data, urlResponse, error in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
    @IBAction func changeInfo(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            staticLabel.text = "Hi, My name is"
            dynamicLabel.text = name
        case 1:
            staticLabel.text = "My email address is"
            dynamicLabel.text = email
        case 2:
            staticLabel.text = "My birthday is"
            dynamicLabel.text = birthday
        case 3:
            staticLabel.text = "My address is"
            dynamicLabel.text = address
        case 4:
            staticLabel.text = "My phone number is"
            dynamicLabel.text = phone
        default:
            break
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
