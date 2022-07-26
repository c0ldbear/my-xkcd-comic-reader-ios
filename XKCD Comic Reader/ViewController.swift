//
//  ViewController.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import UIKit

class ViewController: UIViewController {
    
    let apiCaller = ApiCaller()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task.init {
            await apiCaller.fetch(url: "https://xkcd.com/info.0.json")
        }
    }


}

