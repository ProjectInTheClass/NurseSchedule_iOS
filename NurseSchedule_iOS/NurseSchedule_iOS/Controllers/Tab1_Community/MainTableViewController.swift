//
//  MainTableViewController.swift
//  NurseSchedule_iOS
//
//  Created by 박흥기 on 2021/01/25.
//

import UIKit
import UIKit
import SafariServices
import FSPagerView

class MainTableViewController: UITableViewController, FSPagerViewDataSource, FSPagerViewDelegate {

   

    // 마일스톤
        fileprivate let imageNames = ["간호사메인.jpeg", "간호사메인.jpeg", "간호사메인.jpeg", "간호사메인.jpeg"]
        
        @IBOutlet weak var leftBtn: UIButton!
        
        @IBOutlet weak var rightBtn: UIButton!
        
        @IBOutlet weak var recentNoticeButton: UIButton!
        
        @IBOutlet weak var freeBoard: UIButton!
        @IBOutlet weak var jobBoard: UIButton!
        @IBOutlet weak var QnABoard: UIButton!
        @IBOutlet weak var infoBoard: UIButton!
        @IBOutlet weak var newBoard: UIButton!
        @IBOutlet weak var moreBoard: UIButton!
        
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
            
            self.freeBoard.imageView?.contentMode  = .scaleAspectFit
            self.jobBoard.imageView?.contentMode  = .scaleAspectFit
            self.QnABoard.imageView?.contentMode  = .scaleAspectFit
            self.infoBoard.imageView?.contentMode  = .scaleAspectFit
            self.newBoard.imageView?.contentMode  = .scaleAspectFit
            self.moreBoard.imageView?.contentMode  = .scaleAspectFit
            
            self.myPagerView.dataSource = self
            self.myPagerView.delegate = self
            
            self.leftBtn.layer.cornerRadius = self.leftBtn.frame.height / 2
            self.rightBtn.layer.cornerRadius = self.rightBtn.frame.height / 2

            // Do any additional setup after loading the view.
            
            recentNoticeButton.setTitle(recentTitle, for: .normal)
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
    //        if segue.identifier == "boardList" {
    //           // let BoardListController = segue.destination as! BoardListController
    //            //안넘어감
    //        }
            
        }
        
        
        
        
        
        
        //using SafariServices
        @IBAction func firstLinkButtonTapped(_ sender: Any) {
            if let url = URL(string: "http://www.koreanurse.or.kr/") {
                let safariViewController = SFSafariViewController(url: url)
                present(safariViewController, animated: true, completion: nil)
            }
            
        }
        
        @IBAction func newtLinkButtonTapped(_ sender: Any) {
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
        
        
        @IBAction func toNoticeTapped(_ sender: Any) {
            performSegue(withIdentifier: "articleList", sender: "공지사항")
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
