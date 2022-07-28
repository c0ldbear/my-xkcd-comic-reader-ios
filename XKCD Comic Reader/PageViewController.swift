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
        
        var page: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ComicView")
        pages.append(page)
        
        for _ in 0...10 {
            page = storyboard?.instantiateViewController(withIdentifier: "ComicView")
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
        guard let currentView = pages[currentIndex] as? ViewController,
              let nextView = (currentIndex < pages.count-1 ? pages[currentIndex + 1] : nil) as? ViewController else {
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
