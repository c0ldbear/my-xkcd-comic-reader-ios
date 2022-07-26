//
//  ViewController.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-26.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var altTextLabel: UILabel!
    @IBOutlet private var comicImageView: UIImageView!
    
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task.init {
            let (xkcdData, comicImgData) = await viewModel.fetchComic()
            titleLabel.text = xkcdData?.title
            altTextLabel.text = xkcdData?.alt
            comicImageView.image = UIImage(data: comicImgData!)
        }
    }

}

