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
        
        let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ComicView")
        let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ComicView")
        let page3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "ComicView")

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([page1], direction: .forward, animated: false)
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
        return currentIndex > 0 ? pages[currentIndex - 1] : nil
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        // Infinite loop
        //        let previousIndex = abs((currentIndex + 1) % pages.count)
        //        return pages[previousIndex]
        return currentIndex < pages.count-1 ? pages[currentIndex + 1] : nil
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
