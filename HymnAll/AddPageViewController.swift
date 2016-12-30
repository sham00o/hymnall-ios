//
//  AddPageViewController.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/11/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

protocol AddPageViewDelegate {
    func isAtEndOfPages(flag: Bool)
}

class AddPageViewController: UIPageViewController {
    
    var index = 0
    
    var addDelegate: AddPageViewDelegate?
    var lyricsController: LyricsViewController!
    var chordsController: ChordsViewController!
    
    var orderedViewControllers: [UIViewController]!
    
    private func newViewController(id: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("\(id)Controller")
    }
    
    private func stylePageControl() {
        let pageControl = UIPageControl.appearanceWhenContainedInInstancesOfClasses([self.dynamicType])
        
        pageControl.currentPageIndicatorTintColor = UIColor.darkGrayColor()
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.backgroundColor = UIColor.clearColor()
    }
    
    private func prepareViewControllers() {
        var viewControllers = [UIViewController]()
        lyricsController = self.newViewController("Lyrics") as! LyricsViewController
        chordsController = self.newViewController("Chords") as! ChordsViewController
        viewControllers.append(lyricsController)
        viewControllers.append(chordsController)
        orderedViewControllers = viewControllers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        
        prepareViewControllers()
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .Forward,
                               animated: true,
                               completion: nil)
        }
        
        stylePageControl()
    }
    
    func passLyrics() {
        if index == 0 {
            chordsController.setLyrics(lyricsController.parseLyrics())
        }
    }
    
    func nextPage() {
        if index < orderedViewControllers.count-1 {
            passLyrics()
            index = index+1
            setViewControllers([orderedViewControllers[index]], direction: .Forward, animated: true, completion: nil)
            addDelegate?.isAtEndOfPages(index == orderedViewControllers.count-1)
        }
    }
    
    func previousPage() {
        if index > 0 {
            index = index-1
            setViewControllers([orderedViewControllers[index]], direction: .Reverse, animated: true, completion: nil)
            addDelegate?.isAtEndOfPages(index == orderedViewControllers.count-1)
        }
    }
    
}

// NOT NEEDED
extension AddPageViewController: UIPageViewControllerDataSource {
    
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        index = previousIndex

        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        passLyrics()
        index = nextIndex

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
}
