//
//  PageViewController.swift
//  XKCD Comic Reader
//
//  Created by teddy juhlin-henricson on 2022-07-27.
//

import Foundation
import UIKit

final class PageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        for _ in 0...1 {
            let page: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ComicView")
            pages.append(page)
        }
        
        setViewControllers([pages[0]], direction: .forward, animated: false)
    }
   
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        // Infinite loop
        //        let previousIndex = abs((currentIndex - 1) % pages.count)
        //        return pages[previousIndex]
        guard let previousView = (currentIndex > 0 ? pages[currentIndex - 1] : nil) else {
            return nil
        }
        return previousView
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        // Infinite loop
        //        let nextIndex = abs((currentIndex + 1) % pages.count)
        //        return pages[nextIndex]
        
        if (currentIndex + 1) >= pages.count {
            let page: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ComicView")
            self.pages.append(page)
        }
        
        guard let currentView = pages[currentIndex] as? ViewController,
              let nextView = pages[currentIndex + 1] as? ViewController else {
            return nil
        }
        nextView.comicNumber = currentView.comicNumber - 1
        return nextView
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
