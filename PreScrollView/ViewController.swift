//
//  ViewController.swift
//  PreScrollView
//
//  Created by 副島拓哉 on 2021/04/15.
//

import UIKit

class ViewController: UIViewController {
    
    //private var scrollView: UIScrollView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    struct Photo {
            var imageName: String
        }
        
        var photoList = [
            Photo(imageName: "image1"),
            Photo(imageName: "image2"),
            Photo(imageName: "image3")
        ]
        var imageCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(photoList.count + 3), height: self.scrollView.frame.size.height)

        self.scrollView.contentOffset = CGPoint(x: self.view.frame.size.width, y: 0)
        
        self.scrollView.delegate = self

        self.scrollView.isPagingEnabled = true

        self.scrollView.showsHorizontalScrollIndicator = false
        
        self.view.addSubview(scrollView)
                
        self.setUpImageView()
    }
    
        func createImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, image: Photo) -> UIImageView {
            let imageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
            let image = UIImage(named:  image.imageName)
            imageView.image = image
            return imageView
        }
        
        func setUpImageView() {
            
            if self.photoList.count < 2 {
                scrollView.isHidden = true
                let imageView = createImageView(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height, image: photoList[0])
                imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
                self.view.addSubview(imageView)
            } else {
                scrollView.isHidden = false
                for i in 0 ..< self.photoList.count {
                    let photoItem = self.photoList[i]
                    let imageView = createImageView(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height, image: photoItem)
                    imageView.frame = CGRect(origin: CGPoint(x: self.view.frame.size.width * CGFloat(i + 1), y: 0), size: CGSize(width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
                    self.scrollView.addSubview(imageView)
                }
                imageCount = photoList.count
                var imageView = createImageView(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height, image: photoList[imageCount - 1])
                imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
                self.scrollView.addSubview(imageView)
                imageView = createImageView(x: 0, y: 0, width: self.view.frame.size.width, height: self.scrollView.frame.size.height, image: photoList[0])
                imageView.frame = CGRect(origin: CGPoint(x: Int(self.view.frame.size.width) * (imageCount + 1), y: 0), size: CGSize(width: self.view.frame.size.width, height: self.scrollView.frame.size.height))
                self.scrollView.addSubview(imageView)
            }
        }
    
    func generatePager() {
    }
    }
    
    extension ViewController: UIScrollViewDelegate {
        public func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offset = scrollView.contentOffset
            if offset.x < self.view.frame.size.width - (self.view.frame.size.width - 1) {
                self.scrollView.setContentOffset(.init(x: self.view.frame.size.width * CGFloat(imageCount), y: 0), animated: false)
            } else if offset.x > self.view.frame.size.width * (CGFloat(imageCount) + 1){
                self.scrollView.setContentOffset(.init(x: self.view.frame.size.width, y: 0), animated: false)
            }
        }
    }

    /*extension ViewController: UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetX = self.scrollView.contentOffset.x
            
            if (offsetX > self.scrollView.frame.size.width * 1.5) {

                let sortedPhoto = self.photoList[0]
                self.photoList.append(sortedPhoto)

                self.photoList.removeFirst()

                self.setUpImageView()
                

                self.scrollView.contentOffset.x -= self.scrollView.frame.size.width
            }
            
            if (offsetX < self.scrollView.frame.size.width * 0.5) {

                let sortedPhoto = self.photoList[2]
                self.photoList.insert(sortedPhoto, at: 0)

                self.photoList.removeLast()
                
                self.setUpImageView()
                
                self.scrollView.contentOffset.x += self.scrollView.frame.size.width
            }
        }
    }*/

