//
//  Movie.swift
//  AppleTVApp
//
//  Created by macbookpro on 20.06.2019.
//  Copyright © 2019 halilozel. All rights reserved.
//

import Foundation


class Movie{
    
    let URL_BASE = "https://image.tmdb.org/t/p/w500/"
    
    var title : String!
    var overview : String!
    var posterPath : String!
    
    init(movieDict : Dictionary<String, AnyObject>) {
        
        
        if let title = movieDict["title"] as? String{
        
            self.title = title
        }
        
        if let overview = movieDict["overview"] as? String{
            
            self.overview = overview
        }
        
        if let path = movieDict["poster_path"] as? String{
            
            self.posterPath = "\(URL_BASE)\(path)"
        }
        
    }
}
