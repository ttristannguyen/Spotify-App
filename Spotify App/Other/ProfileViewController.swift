//
//  ProfileViewController.swift
//  Spotify App
//
//  Created by Tristan Nguyen on 11/5/2022.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:  "cell")
        return tableView
    }()
    private var models = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        fetchProfile()

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    private func fetchProfile(){
        APICaller.shared.getCurrentUserProfile{ [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    self?.updateUI(with: model)
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    print("profile error \(error.localizedDescription)")
                    self?.failedToGetProfile()
                }
            }

        }
    }
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        models.append("Username: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("Plan: \(model.product)")
        models.append("User ID: \(model.id)")
        createTableHeader(with: model.images.first?.url)
        tableView.reloadData()
        
    }
    
    private func createTableHeader(with string: String?){
        guard let urlString = string, let url = URL(string: urlString) else{
            return
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        let imageSize: CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x:0,y:0, width: imageSize, height:imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        let data = try? Data(contentsOf: url)
        imageView.image = UIImage(data: data!)
        tableView.tableHeaderView = headerView
        
    }
    
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile"
        label.sizeToFit()
        label.textColor = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
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
