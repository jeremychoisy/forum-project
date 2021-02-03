//
//  AboutUsCollectionViewController.swift
//  swiftProject
//
//  Created by mbds on 03/02/2021.
//

import UIKit

private let reuseIdentifier = "CommentCell"

class CommentCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var postId: Int?
    var dataSource: [Comment] = [Comment]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(CommentCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        getCommentWithPostId()
    }
    
    func getCommentWithPostId(){
        guard let postId = postId else {
            print("postId is nil")
            return
        }
        
        guard let postIdStr: String = String(postId) as String? else {
            print("Could not cast postId to String")
            return
        }
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(postIdStr)/comments") else {
            print("Error on creating URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            if let err = err {
                print("We got an error on url request : ", err)
                return
            }
            
            guard let data = data else {
                print("Error on data")
                return
            }
                
            guard let comments = try? JSONDecoder().decode([Comment].self, from: data) else {
                print("Error on decoding")
                return
            }
            
            self.dataSource = comments
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        task.resume();
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCollectionViewCell
         
        // Configure the cell
        cell.nameLabel.text = dataSource[indexPath.row].name
        cell.idLabel.text = "#\(String(dataSource[indexPath.row].id))"
        cell.bodyLabel.text = dataSource[indexPath.row].body
        cell.emailLabel.text = dataSource[indexPath.row].email
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.size.width - 20, height: 150)
    }
}
