//
//  WaveTabBarController.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import UIKit

class WaveTabBarController: UITabBarController, WaveTabBarProtocol {
    
    private struct Constants {
        
        static let tabBarButtonType = "UITabBarButton"
        static let waveColor: CGColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        
    }
    
    var presenter: WaveTabBarPresenter!
    private var waveCurve: UIBezierPath!
    private var circle: UIView!
    private var imageView: UIImageView!
    
    private let waveSubLayer: CAShapeLayer = {
        let subLayer = CAShapeLayer()
        subLayer.fillColor = Constants.waveColor
        return subLayer
    }()
    
    private lazy var tabBarItems: [UIView] = {
        return tabBar.subviews.filter { String(describing: type(of: $0)) == Constants.tabBarButtonType }
    }()
    
    // MARK: - Initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        presenter = WaveTabBarPresenterBase(view: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        presenter = WaveTabBarPresenterBase(view: self)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear()
    }
    
    // MARK: - Overridden functions
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        super.tabBar(tabBar, didSelect: item)
        print("didselect")
        
        presenter.tabBarDidSelectItem(with: item.tag + 1)
    }
    
    // MARK: - WaveTabBarProtocol functions
    
    func setupTabBarTags() {
        tabBarItems.enumerated().forEach { $0.element.tag = $0.offset }
    }
    
    func setupCurve(_ radius: Float) {
        let path = UIBezierPath.createCurve(at: tabBarItems[selectedIndex].center.x, radius: CGFloat(radius), on: tabBar)
        waveSubLayer.path = path.cgPath
        tabBar.layer.insertSublayer(waveSubLayer, above: tabBar.layer.sublayers?.first)
    }
    
    func setupCircle(_ width: Float) {
        circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(width)))
        circle.layer.cornerRadius = CGFloat(width) / 2
        circle.center = CGPoint(x: tabBarItems[selectedIndex].center.x, y: 0.0)
        circle.backgroundColor = .green
        tabBar.addSubview(circle)
    }
    
    func setupTabBarStyling() {
        tabBar.tintColor = UIColor.clear
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
    }
    
    func setupImageView(_ center: Float) {
        let image = viewControllers?[selectedIndex].tabBarItem.selectedImage?.withRenderingMode(.alwaysTemplate)
        imageView = UIImageView(image: image)
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        imageView.tintColor = .blue
        circle.addSubview(imageView)
        imageView.center = CGPoint(x: CGFloat(center), y: CGFloat(center))
    }
    
    func updateImageView() {
        imageView.image = viewControllers?[selectedIndex].tabBarItem.selectedImage
    }
    
    func moveCurve(to index: Int, with radius: Float) {
        let endPath = UIBezierPath.createCurve(at: tabBarItems[index].center.x, radius: CGFloat(radius), on: tabBar)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.waveSubLayer.path = endPath.cgPath
        }
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = waveSubLayer.path
        pathAnimation.toValue = endPath.cgPath
        pathAnimation.duration = 0.4
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = CAMediaTimingFillMode.forwards
        waveSubLayer.add(pathAnimation, forKey: "pathAnimation")
        CATransaction.commit()
    }
    
    func moveCircle(with duration: TimeInterval, and circleOffset: Float) {
        tabBar.isUserInteractionEnabled = false
        UIView.animate(withDuration: duration, animations: {
            self.circle.center = CGPoint(x: self.circle.center.x, y: self.circle.center.y + CGFloat(circleOffset))
            self.circle.alpha = 0.0
        }) { _ in
            self.circle.center = CGPoint(x: self.tabBarItems[self.selectedIndex].center.x, y: self.circle.center.y)
            self.presenter.moveCircleComplete()
            UIView.animate(withDuration: duration, animations: {
                self.circle.center = CGPoint(x: self.circle.center.x, y: self.circle.center.y - CGFloat(circleOffset))
                self.circle.alpha = 1.0
            }) { _ in
                self.tabBar.isUserInteractionEnabled = true
            }
        }
    }
    
}
