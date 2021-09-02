//
//  UsersViewController.swift
//  RandomAPIDemo
//
//  Created by 李世文 on 2021/9/1.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet weak var usersSegmentedControll: UISegmentedControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRandomUsers()
        
    }
    
    func getRandomUsers() {
        let urlStr = "https://randomuser.me/api/?results=3&inc=name,location,email,dob,phone,picture"
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { [self] data, urlResponse, error in

                let decoder = JSONDecoder()

                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)
                    if let date = dateFormatter.date(from: dateString) {
                        return date
                    }else {
                        throw DecodingError.dataCorruptedError(in: container, debugDescription: "")
                    }
                })

                if let data = data,
                   let urlResponse = urlResponse as? HTTPURLResponse,
                   error == nil {
                    print("response statusCod = \(urlResponse.statusCode)")
                    do {
                        let searchResult = try decoder.decode(SearchResult.self, from: data)
                        users = searchResult.results
                        DispatchQueue.main.async {
                            setupUserInfo()
                        }
                    } catch {
                        print("JSONDecoder 解析失敗")
                    }
                }

            }.resume()
            
            //卡住 UI 下載法
            /*
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                
                let dateFormatter = ISO8601DateFormatter()
                dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateString = try container.decode(String.self)
                    if let date = dateFormatter.date(from: dateString) {
                        return date
                    }else {
                        throw DecodingError.dataCorruptedError(in: container, debugDescription: "")
                    }
                })
                
                do {
                    let searchResult = try decoder.decode(SearchResult.self, from: data)
                    users = searchResult.results
                    self.setupChildController()
                } catch {
                    print("JSONDecoder 解析失敗")
                }
                
            } catch {
                print("Data(contentsOf: URL) 失效")
            }
            */
            
        }
    }
    
    func setupUserInfo() {
        for (i, child) in children.enumerated() {
            let firstName = users[i].name.first
            usersSegmentedControll.setTitle(firstName, forSegmentAt: i)
            let lastName = users[i].name.last
            let email = users[i].email
            let birthday = users[i].dob.dateString
            let addressStreetNum = users[i].location.street.number.description
            let addressStreetName = users[i].location.street.name
            let phone = users[i].phone
            let picture = users[i].picture.large
            if let controller = child as? UserFirstViewController {
                controller.name = firstName + " " + lastName
                controller.email = email
                controller.birthday = birthday
                controller.address = addressStreetNum + " " + addressStreetName
                controller.phone = phone
                controller.picture = picture
                controller.setupInfo()
            } else if let controller = child as? UserSecondViewController {
                controller.name = firstName + " " + lastName
                controller.email = email
                controller.birthday = birthday
                controller.address = addressStreetNum + " " + addressStreetName
                controller.phone = phone
                controller.picture = picture
                controller.setupInfo()
            } else if let controller = child as? UserThirdViewController {
                controller.name = firstName + " " + lastName
                controller.email = email
                controller.birthday = birthday
                controller.address = addressStreetNum + " " + addressStreetName
                controller.phone = phone
                controller.picture = picture
                controller.setupInfo()
            }
        }
    }
    
    @IBAction func changePage(_ sender: UISegmentedControl) {
        let x = CGFloat(sender.selectedSegmentIndex) * scrollView.bounds.width
        let offset = CGPoint(x: x, y: 0)
        scrollView.setContentOffset(offset, animated: true)
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

extension UsersViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        usersSegmentedControll.selectedSegmentIndex = index
    }
}
