//
//  WaveTabBarPresenterUnitTests.swift
//  WaveTab_Tests
//
//  Created by Matthew Pierce on 12/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import WaveTab

final class WaveTabBarPresenterUnitTests: XCTestCase {
    
    private var view: WaveTabBarControllerMock!
    private var presenter: WaveTabBarPresenter!
    
    // MARK: - Setup & tear down

    override func setUp() {
        super.setUp()
        
        view = WaveTabBarControllerMock()
        presenter = WaveTabBarPresenterBase(view: view)
    }

    override func tearDown() {
        view = nil
        presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Unit test methods
    
    func testViewDidLoad() {
        XCTAssertFalse(view.showTabBarCalled)
        XCTAssertFalse(view.disableTransparentTabBarCalled)
        presenter.viewDidLoad()
        XCTAssertTrue(view.showTabBarCalled)
        XCTAssertTrue(view.disableTransparentTabBarCalled)
    }
    
    func testViewDidAppear() {
        XCTAssertFalse(view.showTabBarCalled)
        XCTAssertFalse(view.setupTabBarTagsCalled)
        XCTAssertFalse(view.setupCurveCalled)
        XCTAssertFalse(view.setupCircleCalled)
        XCTAssertFalse(view.setupImageViewCalled)
        XCTAssertFalse(view.setupTabBarColoringCalled)
        XCTAssertFalse(view.setupTabBarBackgroundCalled)
        presenter.viewDidAppear(portrait: true)
        XCTAssertTrue(view.showTabBarCalled)
        XCTAssertTrue(view.setupTabBarTagsCalled)
        XCTAssertTrue(view.setupCurveCalled)
        XCTAssertTrue(view.setupCircleCalled)
        XCTAssertTrue(view.setupImageViewCalled)
        XCTAssertTrue(view.setupTabBarColoringCalled)
        XCTAssertTrue(view.setupTabBarBackgroundCalled)
    }
    
    func testViewDidRotate() {
        XCTAssertFalse(view.updateCircleSizeCalled)
        XCTAssertFalse(view.updateImageViewSizeCalled)
        XCTAssertFalse(view.moveCurveCalled)
        XCTAssertFalse(view.moveCircleCalled)
        presenter.viewDidRotate(portrait: true, at: 1)
        XCTAssertTrue(view.updateCircleSizeCalled)
        XCTAssertTrue(view.updateImageViewSizeCalled)
        XCTAssertTrue(view.moveCurveCalled)
        XCTAssertTrue(view.moveCircleCalled)
    }
    
    func testTabBarDidSelectItem() {
        XCTAssertFalse(view.moveCurveCalled)
        XCTAssertFalse(view.moveCircleCalled)
        presenter.tabBarDidSelectItem(with: 0)
        XCTAssertTrue(view.moveCurveCalled)
        XCTAssertTrue(view.moveCircleCalled)
    }
    
    func testViewWillLayoutSubviews() {
        XCTAssertFalse(view.setupTabBarColoringCalled)
        presenter.viewWillLayoutSubviews()
        XCTAssertTrue(view.setupTabBarColoringCalled)
    }
    
    func testMoveCircleCompleteDown() {
        XCTAssertFalse(view.updateImageViewCalled)
        XCTAssertFalse(view.updateCircleCenterCalled)
        XCTAssertFalse(view.moveCircleCalled)
        presenter.moveCircleComplete(down: true)
        XCTAssertTrue(view.updateImageViewCalled)
        XCTAssertTrue(view.updateCircleCenterCalled)
        XCTAssertTrue(view.moveCircleCalled)
    }
    
    func testMoveCircleCompleteUp() {
        XCTAssertFalse(view.updateImageViewCalled)
        XCTAssertFalse(view.updateCircleCenterCalled)
        XCTAssertFalse(view.moveCircleCalled)
        presenter.moveCircleComplete(down: false)
        XCTAssertTrue(view.updateImageViewCalled)
        XCTAssertTrue(view.updateCircleCenterCalled)
        XCTAssertFalse(view.moveCircleCalled)
    }

}

private class WaveTabBarControllerMock: WaveTabBarProtocol {
    
    var showTabBarCalled = false
    var disableTransparentTabBarCalled = false
    var setupTabBarTagsCalled = false
    var setupCurveCalled = false
    var setupCircleCalled = false
    var updateCircleSizeCalled = false
    var setupTabBarColoringCalled = false
    var setupTabBarBackgroundCalled = false
    var setupImageViewCalled = false
    var updateImageViewSizeCalled = false
    var updateImageViewCalled = false
    var moveCurveCalled = false
    var moveCircleCalled = false
    var updateCircleCenterCalled = false
    
    func showTabBar(_ show: Bool, animated: Bool, over duration: TimeInterval) {
        showTabBarCalled = true
    }
    
    func disableTransparentTabBar() {
        disableTransparentTabBarCalled = true
    }
    
    func setupTabBarTags() {
        setupTabBarTagsCalled = true
    }
    
    func setupCurve(_ radius: Float) {
        setupCurveCalled = true
    }
    
    func setupCircle(_ width: Float) {
        setupCircleCalled = true
    }
    
    func updateCircleSize(_ radius: Float) {
        updateCircleSizeCalled = true
    }
    
    func setupTabBarColoring() {
        setupTabBarColoringCalled = true
    }
    
    func setupTabBarBackground() {
        setupTabBarBackgroundCalled = true
    }
    
    func setupImageView(_ center: Float) {
        setupImageViewCalled = true
    }
    
    func updateImageViewSize(_ center: Float) {
        updateImageViewSizeCalled = true
    }
    
    func updateImageView() {
        updateImageViewCalled = true
    }
    
    func moveCurve(with duration: TimeInterval, to index: Int, with radius: Float) {
        moveCurveCalled = true
    }
    
    func moveCircle(over duration: TimeInterval, offset circleOffset: Float, down movingDown: Bool) {
        moveCircleCalled = true
    }
    
    func updateCircleCenter() {
        updateCircleCenterCalled = true
    }
    
}
