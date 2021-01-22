//
//  CommunityController.swift
//  NurseSchedule_iOS
//
//  Created by 이주원 on 2021/01/05.
//

import UIKit
import SafariServices
import FSPagerView

// 마일스톤
class CommunityController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    fileprivate let imageNames = ["imageSlide1.png", "imageSlide2.png", "imageSlide3.png", "imageSlide4.png"]
    
    @IBOutlet weak var leftBtn: UIButton!
    
    @IBOutlet weak var rightBtn: UIButton!
    
    @IBOutlet weak var myPagerView: FSPagerView!{
        didSet{
            // 페이저뷰에 쎌을 등록한다.
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            // 아이템 크기 설정
            self.myPagerView.itemSize = FSPagerView.automaticSize
            // 무한스크롤 설정
            self.myPagerView.isInfinite = true
            // 자동 스크롤
            self.myPagerView.automaticSlidingInterval = 4.0
        }
        
    }
    
    @IBOutlet weak var myPageControl: FSPageControl!{
        didSet{
            self.myPageControl.numberOfPages = self.imageNames.count
            self.myPageControl.contentHorizontalAlignment = .center
            self.myPageControl.itemSpacing = 10
            self.myPageControl.interitemSpacing = 10
          
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myPagerView.dataSource = self
        self.myPagerView.delegate = self
        
        self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height / 2
        self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height / 2

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLeftBtnClicked(_ sender: UIButton) {
        print("ViewContorller - onLeftBtnClicked() called")
        
        self.myPageControl.currentPage = self.myPageControl.currentPage - 1
        
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
        
    }
    
    @IBAction func onRightBtnClicked(_ sender: UIButton) {
        print("ViewController - onRightBtnClicked() called")
        
        if(self.myPageControl.currentPage == self.imageNames.count - 1){
            self.myPageControl.currentPage = 0
        } else {
            self.myPageControl.currentPage = self.myPageControl.currentPage + 1
        }
        
        self.myPagerView.scrollToItem(at: self.myPageControl.currentPage, animated: true)
        
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
      
    // 각 쎌에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }

    //MARK: - FSPagerView delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "articleList" {
            let ContentListController = segue.destination as! ContentListController
            ContentListController.boardType = sender as? String
        }
    }
    
    
    
    
    
    
    //using SafariServices
    @IBAction func firstLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://www.koreanurse.or.kr/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func secondLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://www.nursejob.co.kr/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    @IBAction func thirdLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://recruit.nurscape.net/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    @IBAction func fourthLinkButtonTapped(_ sender: Any) {
        if let url = URL(string: "http://www.nursestory.co.kr/") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func board1Tapped(_ sender: Any) {
        performSegue(withIdentifier: "articleList", sender: "자유게시판")
        
    }
    
    @IBAction func board2Tapped(_ sender: Any) {
        performSegue(withIdentifier: "articleList", sender: "취업게시판")
    }
    @IBAction func board3Tapped(_ sender: Any) {
        performSegue(withIdentifier: "articleList", sender: "간호지식QnA")
    }
    
    @IBAction func board4Tapped(_ sender: Any) {
        performSegue(withIdentifier: "articleList", sender: "정보게시판")
    }
    
    @IBAction func board5Tapped(_ sender: Any) {
        performSegue(withIdentifier: "articleList", sender: "신입게시판")
    }
    
    
}
