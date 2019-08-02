//
//  CollectionViewController.swift
//  Mars
//
//  Created by Macbook on 31/07/2019.
//  Copyright © 2019 Technology&Design LLC. All rights reserved.
//

import UIKit
import Alamofire


private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var images:[String] = []
    let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadImages()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> ImagesCollectionViewCell {
        
        let cell:ImagesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImagesCollectionViewCell

        let imageString = self.images[indexPath.row]
        let imageUrl = NSURL(string: imageString)
        let imageData = NSData(contentsOf: imageUrl! as URL)
        
        if(imageData != nil){
            cell.imageView.image = UIImage(data: imageData! as Data)
        }
        
        return cell
    }
    
    func loadImages() {
        
            request(self.url, parameters: ["api_key": "9y9cxT4iKefdnMkir3gh9AuEYaMqvKD8vP38hQWU","sol": "1000","page":"1"]).validate().responseJSON { responseJSON in
                switch responseJSON.result {
                case .success:
                    guard let data = responseJSON.data else { return }
                    guard let res = try? JSONDecoder().decode(Result.self, from: data) else{ return }
                    for image in res.photos {
                        self.images.append(image.imgSrc)
                    }
                    DispatchQueue.main.async() {
                    self.collectionView?.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}
