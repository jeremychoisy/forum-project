//
//  MyCollectionViewController.swift
//  swiftProject
//
//  Created by mbds on 03/02/2021.
//

import UIKit

private let reuseIdentifier = "PostCell"

class PostCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var dataSource = [Post]()
    private var selectedPostId: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        getPosts()
    }
    
    func getPosts(){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
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
            
            guard let posts = try? JSONDecoder().decode([Post].self, from: data) else {
                print("Error on decoding")
                return
            }
            self.dataSource = posts
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        task.resume();
    }
    
    // Fonction appelée quand on clic sur un élément de la liste
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Stocker dans la variable d'instance, le post choisi
        selectedPostId = dataSource[indexPath.row].id
        
        // Déclencher la transition vers l'écran suivant (Identifier donné dans le Storyboard)
        performSegue(withIdentifier: "SHOW_COMMENTS", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "SHOW_COMMENTS" {
        let destination = segue.destination as! CommentCollectionViewController
        destination.postId = selectedPostId;
       }
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PostCollectionViewCell
    
        cell.titleLabel.text = dataSource[indexPath.row].title
        cell.idLabel.text = "#\(String(dataSource[indexPath.row].id))"
        cell.bodyLabel.text = dataSource[indexPath.row].body
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.size.width - 20, height: 100)
    }
}
