//
//  MovieCell.swift
//  AppleTVApp
//
//  Created by macbookpro on 20.06.2019.
//  Copyright © 2019 halilozel. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieLbl : UILabel!
    
    
    func configureCell(movie: Movie){
        
        if let title = movie.title{
            movieLbl.text = title
        }
        
        if let path = movie.posterPath{
            let url = NSURL(string: path)!
        
            let data = NSData(contentsOf: url as URL)!
            
            let img = UIImage(data: data as Data)
            
            self.movieImg.image = img
                
            }
        }
    }
    

