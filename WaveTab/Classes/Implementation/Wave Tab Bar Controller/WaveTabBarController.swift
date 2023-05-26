//
//  WaveTabBarController.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import UIKit

open class WaveTabBarController: UITabBarController, WaveTabBarProtocol {
    
    private struct Constants {
        
        static let tabBarButtonType = "UITabBarButton"
        static let borderWidth: CGFloat = 0.5
        static let borderColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        static let whiteBackgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        static let blackBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        static let fullAlpha: CGFloat = 1.0
        static let emptyAlpha: CGFloat = 0.0
        
    }
    
    private var presenter: WaveTabBarPresenter!
    private var circle: UIView?
    private var imageView: UIImageView?
    
    private var safeSelectedIndex: Int {
        return selectedIndex < tabBarItems.count ? selectedIndex : tabBarItems.count - 1
    }
    
    private let waveSubLayer: CAShapeLayer = {
        let subLayer = CAShapeLayer()
        subLayer.strokeColor = Constants.borderColor
        subLayer.lineWidth = Constants.borderWidth
        return subLayer
    }()
    
    private lazy var tabBarItems: [UIView] = {
        return tabBar.subviews.filter { String(describing: type(of: $0)) == Constants.tabBarButtonType }
    }()
    
    // MARK: - Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = WaveTabBarPresenterBase(view: self)
        presenter.viewDidLoad()
    }
    
//    open override func viewWillAppear(_ animated: Bool) {
//        presenter.viewDidLoad()
//    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter.viewDidAppear(portrait: UIDevice.current.orientation.isPortrait)
    }
    
    // MARK: - Overridden functions
    
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        presenter.tabBarDidSelectItem(with: item.tag)
    }
    open func didTapItem(tag:Int){
        presenter.tabBarDidSelectItem(with: tag)
        
    }
    
    open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        DispatchQueue.main.async {
            self.presenter.viewDidRotate(portrait: UIDevice.current.orientation.isPortrait, at: self.safeSelectedIndex + 1)
        }
    }
    
    open override func viewWillLayoutSubviews() {
        presenter.viewWillLayoutSubviews()
    }
    
    // MARK: - WaveTabBarProtocol functions
    
    func showTabBar(_ show: Bool, animated: Bool, over duration: TimeInterval) {
        guard animated else {
            tabBar.alpha = show ? Constants.fullAlpha : Constants.emptyAlpha
            return
        }
        UIView.animate(withDuration: duration) {
            self.tabBar.alpha = show ? Constants.fullAlpha : Constants.emptyAlpha
        }
    }
    
    func disableTransparentTabBar() {
        tabBar.isTranslucent = true
    }
    
    func setupTabBarTags() {
        viewControllers?.enumerated().forEach { $0.element.tabBarItem.tag = $0.offset + 1 }
    }
    
    func setupCurve(_ radius: Float) {
        let path = UIBezierPath.createCurve(at: tabBarItems[safeSelectedIndex].center.x, radius: CGFloat(radius), on: tabBar)
        waveSubLayer.path = path.cgPath
        tabBar.layer.insertSublayer(waveSubLayer, above: tabBar.layer.sublayers?.first)
    }
    
//    func setupCircle(_ width: Float) {
//        circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(width)))
//        circle?.layer.cornerRadius = CGFloat(width) / 2
//        circle?.center = CGPoint(x: tabBarItems[safeSelectedIndex].center.x, y: 0.0)
//        //circle?.layer.borderWidth = Constants.borderWidth
//        //circle?.layer.borderColor = Constants.borderColor
//       // circle?.layer.cornerRadius = 17
//        circle?.removeFromSuperview()
//        circle?.clipsToBounds = true;
//        circle?.backgroundColor = UIColor.white
//        circle?.layer.shadowColor = UIColor.lightGray.cgColor
//        circle?.layer.shadowOpacity = 0.8
//        circle?.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        circle?.layer.shadowRadius = 6.0
//        circle?.layer.masksToBounds = false
//        tabBar.addSubview(circle!)
//    }
    func setupCircle(_ width: Float) {
        circle?.removeFromSuperview() // ->> Add this line
        circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: CGFloat(width), height: CGFloat(width)))
        circle?.layer.cornerRadius = CGFloat(width) / 2
        circle?.center = CGPoint(x: tabBarItems[safeSelectedIndex].center.x, y: 0.0)
        circle?.clipsToBounds = true;
        //circle?.backgroundColor = UIColor.white
        circle?.layer.shadowColor = UIColor.lightGray.cgColor
        circle?.layer.shadowOpacity = 0.8
        circle?.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        circle?.layer.shadowRadius = 6.0
        circle?.layer.masksToBounds = false
    tabBar.addSubview(circle!)
    }


    
    func updateCircleSize(_ radius: Float) {
        guard let circle = circle else { return }
        circle.frame = CGRect(x: circle.frame.origin.x, y: circle.frame.origin.y, width: CGFloat(radius), height: CGFloat(radius))
        circle.layer.cornerRadius = CGFloat(radius) / 2
    }
    
    func setupTabBarColoring() {
        let backgroundColor: UIColor
        if #available(iOS 13.0, *) {
            switch traitCollection.userInterfaceStyle {
            case .light: backgroundColor = Constants.whiteBackgroundColor
            case .dark: backgroundColor = Constants.blackBackgroundColor
            case .unspecified: backgroundColor = getColorFromTabBarStyle()
            @unknown default: backgroundColor = getColorFromTabBarStyle()
            }
        } else {
            backgroundColor = getColorFromTabBarStyle()
        }
        waveSubLayer.fillColor = backgroundColor.cgColor
        circle?.backgroundColor = backgroundColor
    }
    
    func setupTabBarBackground() {
        tabBar.tintColor = .clear
        if #available(iOS 13.0, *) {
            let barAppearance = UIBarAppearance()
            barAppearance.configureWithTransparentBackground()
            let tabBarAppearance = UITabBarAppearance(barAppearance: barAppearance)
            tabBar.standardAppearance = tabBarAppearance
        } else {
            tabBar.backgroundColor = .clear
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
        }
    }
    
//    func setupImageView(_ center: Float) {
//        let image = viewControllers?[safeSelectedIndex].tabBarItem.selectedImage?.withRenderingMode(.alwaysTemplate)
//        imageView?.removeFromSuperview()
//        imageView = UIImageView(image: image)
//        imageView?.contentMode = UIView.ContentMode.scaleAspectFit
//        imageView?.tintColor = tabBar.tintColor
//        imageView?.contentMode = .scaleAspectFit
//        circle?.addSubview(imageView!)
//        imageView?.center = CGPoint(x: CGFloat(center), y: CGFloat(center))
//    }
    func setupImageView(_ center: Float) {
    let image = viewControllers?[safeSelectedIndex].tabBarItem.selectedImage
    imageView?.removeFromSuperview() // ->> Add this line
    imageView = UIImageView(image: image)
        imageView?.tintColor = UIColor.init(red: 0/255, green: 90.0/255, blue: 159.0/255, alpha: 1)
    imageView?.contentMode = UIView.ContentMode.scaleAspectFit
    circle?.addSubview(imageView!)
    imageView?.center = CGPoint(x: CGFloat(center), y: CGFloat(center))
       // imageView?.backgroundColor = UIColor.red
    }
    
    func updateImageViewSize(_ center: Float) {
        guard let imageView = imageView else { return }
        imageView.center = CGPoint(x: CGFloat(center), y: CGFloat(center))
    }
    
    func updateImageView() {
        imageView?.image = viewControllers?[safeSelectedIndex].tabBarItem.selectedImage?.withRenderingMode(.alwaysTemplate)
    }
    
    func moveCurve(with duration: TimeInterval, to index: Int, with radius: Float) {
        let safeIndex = index == 0 ? tabBarItems.count : index
        let endPath = UIBezierPath.createCurve(at: tabBar.subviews[safeIndex].center.x, radius: CGFloat(radius), on: tabBar)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.waveSubLayer.path = endPath.cgPath
        }
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = waveSubLayer.path
        pathAnimation.toValue = endPath.cgPath
        pathAnimation.duration = duration
        pathAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = CAMediaTimingFillMode.forwards
        waveSubLayer.add(pathAnimation, forKey: "pathAnimation")
        CATransaction.commit()
    }
    
    func moveCircle(over duration: TimeInterval, offset circleOffset: Float, down movingDown: Bool) {
        tabBar.isUserInteractionEnabled = false
        guard let circle = circle else { return }
        UIView.animate(withDuration: duration, animations: {
            let verticalPosition = movingDown ? circle.center.y + CGFloat(circleOffset) : circle.center.y - CGFloat(circleOffset)
            circle.center = CGPoint(x: circle.center.x, y: verticalPosition)
            circle.alpha = movingDown ? Constants.emptyAlpha : Constants.fullAlpha
        }, completion: { _ in
            self.presenter.moveCircleComplete(down: movingDown)
            if !movingDown {
                self.tabBar.isUserInteractionEnabled = true
            }
        })
    }
    
    func updateCircleCenter() {
        guard let circle = circle else { return }
        circle.center = CGPoint(x: self.tabBarItems[self.safeSelectedIndex].center.x, y: circle.center.y)
    }
    
    func moveCircleAnimationDown(_ down: Bool, with offset: Float) {
        guard let circle = circle else { return }
        let verticalPosition = down ? circle.center.y + CGFloat(offset) : circle.center.y - CGFloat(offset)
        circle.center = CGPoint(x: circle.center.x, y: verticalPosition)
        circle.alpha = down ? Constants.emptyAlpha : Constants.fullAlpha
    }
    
    // MARK: - Private functions
    
    private func getColorFromTabBarStyle() -> UIColor {
        switch tabBar.barStyle {
        case .black, .blackTranslucent: return Constants.blackBackgroundColor
        case .default: return Constants.whiteBackgroundColor
        @unknown default: return Constants.whiteBackgroundColor
        }
    }
    
}
