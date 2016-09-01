//
//  ViewScroll.swift
//  DemoUIScrollView
//
//  Created by Hoàng Minh Thành on 8/31/16.
//  Copyright © 2016 Hoàng Minh Thành. All rights reserved.
//

import UIKit

class ViewScroll : UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slider: UISlider!
    
    var photo = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIScrollViewDelegate
        let imgView = UIImageView(image: UIImage(named: "hinh.jpg"))
        imgView.frame = CGRectMake(0, 0, imgView.frame.size.width, imgView.frame.size.height)
        imgView.userInteractionEnabled = true
        imgView.multipleTouchEnabled = true
        imgView.contentMode = .ScaleAspectFit
        let tap = UITapGestureRecognizer(target: self,action: #selector(tapImg))
        tap.numberOfTapsRequired = 1
        imgView.addGestureRecognizer(tap)
        let dougleTap = UITapGestureRecognizer(target: self,action: #selector(doubleTapImg))
        dougleTap.numberOfTapsRequired = 2
        tap.requireGestureRecognizerToFail(dougleTap)
        imgView.addGestureRecognizer(dougleTap)
        photo = imgView
        scrollView.contentSize = CGSizeMake(imgView.bounds.width, imgView.bounds.height)
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 2
        self.scrollView.addSubview(imgView)
    }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return photo
    }
    func tapImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 1.5, center: position)
    }
    func doubleTapImg(gesture: UITapGestureRecognizer)
    {
        let position = gesture.locationInView(photo)
        zoomRectForScale(scrollView.zoomScale * 0.5, center: position)
    }
    func zoomRectForScale(scale: CGFloat,center: CGPoint)
    {
        var zoomRect = CGRect()
        let scrollViewSize = scrollView.bounds.size
        zoomRect.size.height = scrollViewSize.height / scale
        zoomRect.size.width = scrollViewSize.width / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0)
        scrollView.zoomToRect(zoomRect, animated: true)
    }
    func setZoomScale(scale: CGFloat,animated: Bool)
    {
        let position = CGPointMake(photo.bounds.width/2, photo.bounds.height/2)
        zoomRectForScale(scrollView.zoomScale * scale, center: position)
    }
    @IBAction func slider_scrollView(sender: UISlider) {
        slider.value = sender.value
        scrollView.setZoomScale(CGFloat(sender.value), animated: true)
    }
}
