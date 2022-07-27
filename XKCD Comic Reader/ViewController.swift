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
    var comicNumber: Int = -1 {
        didSet {
            viewModel.nextNumber = comicNumber - 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Task.init {
            let (xkcdData, comicImgData) = await viewModel.fetchXKCD()
            
            guard let xkcdData = xkcdData,
                  let comicImgData = comicImgData else {
                return
            }
            
            titleLabel.text = xkcdData.title
            altTextLabel.text = xkcdData.alt
            comicNumber = xkcdData.num ?? -1
            comicImageView.image = UIImage(data: comicImgData)
        }
    }
}

