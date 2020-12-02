//
//  ViewController.swift
//  YourMovie
//
//  Created by Bruno Silva on 01/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        REST.loadMovie { (theMovie) in
            print(theMovie.originalTitle)
            print(theMovie.popularity)
        } onError: { (movieError) in
            print(movieError)
        }
    }
}

