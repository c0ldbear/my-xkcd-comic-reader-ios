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
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let viewModel = ViewModel()
    
    var comicNumber: Int = -1 {
        didSet {
            viewModel.nextNumber = comicNumber
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = ""
        altTextLabel.text = ""
        
        view.addSubview(activityIndicator)
        
        setupActivityIndicator()
        
        comicImageView.isHidden = true
        activityIndicator.startAnimating()
        
        Task.init {
            let (xkcdData, comicImgData) = await viewModel.fetchXKCD()
            
            guard let xkcdData = xkcdData,
                  let comicImgData = comicImgData else {
                return
            }
            
            titleLabel.text = "\(xkcdData.title!) (\(xkcdData.num!))"
            altTextLabel.text = xkcdData.alt
            comicNumber = xkcdData.num ?? -1
            comicImageView.image = UIImage(data: comicImgData)
            setEqualSizeOnImage(forImageView: comicImageView)
            
            activityIndicator.stopAnimating()
            comicImageView.isHidden = false
        }
    }
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: activityIndicator, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
    }
    
    func setEqualSizeOnImage(forImageView imageView: UIImageView?) {
        guard let imageView = imageView,
              let image = imageView.image else {
            return
        }
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: image.size.width / image.size.height).isActive = true
    }
}

