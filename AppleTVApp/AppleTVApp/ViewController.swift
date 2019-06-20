//
//  ViewController.swift
//  AppleTVApp
//
//  Created by macbookpro on 20.06.2019.
//  Copyright © 2019 halilozel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let URL_BASE = "https://api.themoviedb.org/3/movie/popular?api_key=b1d9264bb1f15d2ea9505e58f0ba99b2"
    
    @IBOutlet weak var collectionView : UICollectionView!
    
    var movies = [Movie]()

    let defaultSize = CGSize(width: 280,height: 432)
    
    let focusSize = CGSize(width: 308, height: 464)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadData()
        
    }
    
    
    func downloadData(){
        
        let url = NSURL(string: URL_BASE)!
        
        let request = NSURLRequest(url:url as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest){
            (data, response, error) ->
            
            Void in
            
            if error != nil{
                
                print(error.debugDescription)
            }else{
                
                do{
                    let dict = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? Dictionary<String, AnyObject>
                    
                    if let results = dict!["results"] as? [Dictionary<String,AnyObject>]{
                        
                        //print(results)
                        
                        for obj in results{
                            
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        
                        // Main UI Thread
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }catch{
                    
                }
            }
        }
        
        task.resume()
        
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell",for: indexPath) as? MovieCell{
            
            let movie = movies[indexPath.row]
            
            cell.configureCell(movie: movie)
            
            return cell
        }else{
            
            return MovieCell()
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 443,height: 557)
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? MovieCell{
            
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                prev.movieImg.frame.size = self.defaultSize
                
            })
        }
        
        if let next = context.nextFocusedView as? MovieCell{
            
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                next.movieImg.frame.size = self.focusSize
                
            })
        }
    }

}

