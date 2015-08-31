//
//  DetailHelpingScreenViewController.swift
//  Tarotvn_Ver1
//
//  Created by Nhan Nguyen on 8/21/15.
//  Copyright (c) 2015 Nhan Nguyen. All rights reserved.
//

import UIKit

class DetailHelpingScreenViewController: UIViewController, TTTAttributedLabelDelegate {
    
    var nameOfHelping: String!
    
    @IBOutlet weak var label1: TTTAttributedLabel!
    @IBOutlet weak var label: TTTAttributedLabel!

    @IBOutlet weak var txtAbout: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.delegate = self
        label1.delegate = self
        
        if nameOfHelping == "Tarot.vn" {
            
            var str : NSString = "Link: http://tarot.vn"
            label.text = str as String
            var range : NSRange = str.rangeOfString("http://tarot.vn")
            label.addLinkToURL(NSURL(string: "http://tarot.vn")!, withRange: range)
            
            var str1 : NSString = "Facebook: /groups/TarotVietNam"
            label1.text = str1 as String
            var range1 : NSRange = str1.rangeOfString("/groups/TarotVietNam")
            label1.addLinkToURL(NSURL(string: "https://facebook.com/groups/TarotVietNam")!, withRange: range1)
           
            
            var text1: String = "Tarot.vn là trang thông tin & chia sẻ kiến thức Tarot chính thống đầu tiên và duy nhất bằng tiếng Việt. Tarot.vn được thành lập và vận hành phi lợi nhuận với mục đích hỗ trợ và phục vụ cộng đồng người sử dụng Tarot tại Việt Nam, đóng vai trò như một kênh liên kết người dùng Tarot tại Việt Nam với những nguồn tư liệu uy tín quốc tế thông qua các bài dịch sách và tài liệu Tarot được thực hiện bởi các đơn vị dịch thuật có chuyên môn và danh tiếng tại Việt Nam. Tarot.vn cũng là nhà bảo trợ cho các Khóa học tìm hiểu Tarot từ cơ bản đến nâng cao chính quy nhất tại Việt Nam hiện nay, và là đồng sáng lập của group Facebook Tarot Việt Nam."
            
            var text2: String = "Tarot Việt Nam là một Facebook group được thành lập dưới sự bảo trợ của Tarot.vn với mục đích tạo một sân chơi kiêm môi trường học tập dành cho những ai đam mê Tarot và các lĩnh vực liên quan như Chiêm tinh học, Hoàng đạo, Tử vi… cùng trao đổi, chia sẻ, giao lưu và học hỏi lẫn nhau, không phân biệt tuổi tác, giới tính hay địa vị, kiến thức hiểu biết chuyên sâu trong giới. Đây cũng là địa chỉ tuyệt vời dành cho các Tarot reader tập sự có nhu cầu thực hành thông qua việc xem Tarot online cho những ai cần. Group hiện được quản lý bởi 10 tình nguyện viên vốn là các Tarot reader tự do, và được thiết lập nhóm mở để mọi người đều có thể tham gia."
            
            txtAbout.text = String(format: "%@\n\n%@", text1, text2)
            
            
        }else if nameOfHelping ==  "Mystic House" {
            
            var str : NSString = "Link: http://mystichouse.vn"
            label.text = str as String
            var range : NSRange = str.rangeOfString("http://mystichouse.vn")
            label.addLinkToURL(NSURL(string: "http://mystichouse.vn")!, withRange: range)
            
            var str1 : NSString = "Facebook page: Mystic House"
            label1.text = str1 as String
            var range1 : NSRange = str1.rangeOfString("Mystic House")
            label1.addLinkToURL(NSURL(string: "http://facebook.com/SG.Mystic.House")!, withRange: range1)
            
            
            var text1: String = "Mystic House (Saigon Mystic House hay Mystic Tarot) là cửa hàng bán bài Tarot và các phụ kiện liên quan đến Tarot gốc đầu tiên và lớn nhất Việt Nam. Đây cũng là cửa hàng duy nhất trên cả nước có tư cách pháp nhân, thuộc sở hữu doanh nghiệp. Mystic House hiện đang bày bán khoảng 500 tựa bài xuất xứ khắp thế giới và hàng trăm mặt hàng phụ kiện, tài liệu liên quan với các chính sách bán hàng và chăm sóc khách hàng vô cùng chuyên nghiệp: giao hàng miễn phí toàn quốc; ưu đãi khách hàng thân thiết; bảo hành sản phẩm Tarot bị lỗi; hỗ trợ người dùng Tarot các nguồn tư liệu hữu ích… Mystic House cũng có hệ thống các chi nhánh tại các thành phố lớn tại Việt Nam, và là chiếc cầu nối giữa cộng đồng Tarot Việt Nam với các nhà xuất bản, các họa sỹ và nhà nghiên cứu Tarot quốc tế."
            
            var text2: String = ""
            
            txtAbout.text = String(format: "%@\n\n%@", text1, text2)

           
            
        }else{
            
            var str : NSString = "Link: http://wichita.vn"
            label.text = str as String
            var range : NSRange = str.rangeOfString("http://wichita.vn")
            label.addLinkToURL(NSURL(string: "http://wichita.vn")!, withRange: range)
            
            var str1 : NSString = "Facebook page: Wichita Coffee"
            label1.text = str1 as String
            var range1 : NSRange = str1.rangeOfString("Wichita Coffee")
            label1.addLinkToURL(NSURL(string: "http://facebook.com/WichitaCoffee")!, withRange: range1)
            
            
            
            
            var text1: String = "Wichita Coffee (Wichita Coffee and Tea House) là chuỗi cửa hàng đồ uống tổ chức xem Tarot chuyên nghiệp duy nhất trên cả nước hiện nay. Tại quán cà phê này, dịch vụ xem Tarot được tổ chức liên tục hàng ngày từ sáng đến tối với hơn 10 reader giàu kinh nghiệm và có uy tín trong cộng đồng Tarot Việt Nam. Wichita hỗ trợ hệ thống đa dạng dành cho việc đặt lịch hẹn xem Tarot và lấy phản hồi, nhận xét của khách hàng. Hiện tại, tỷ lệ khách hàng hài lòng với dịch vụ xem Tarot tại quán này lên đến trên 95%. Bên cạnh đó, Wichita Coffee and Tea House cũng là địa điểm tổ chức các khóa học Tarot do Tarot.vn bảo trợ."
            
            var text2: String = ""
            
            txtAbout.text = String(format: "%@\n\n%@", text1, text2)

            
            
        }
        // Do any additional setup after loading the view.
    }
    
    func attributedLabel(label: TTTAttributedLabel!, didSelectLinkWithURL url: NSURL!)
    {
        
        if nameOfHelping == "Tarot.vn" {
            
                UIApplication.sharedApplication().openURL(url)
          
            
        }else if nameOfHelping == "Mystic House" {
            
            if url.absoluteString == "http://mystichouse.vn"{
                
                
                 UIApplication.sharedApplication().openURL(url)
                
            }else{
                
                var urlApp: NSURL = NSURL(string: "fb://profile/454186987948994")!
                var urlWeb: NSURL = NSURL(string: "http://facebook.com/SG.Mystic.House")!
                
                if UIApplication.sharedApplication().canOpenURL(urlApp){
                    
                    UIApplication.sharedApplication().openURL(urlApp)
                }
                    
                else {
                    
                    UIApplication.sharedApplication().openURL(urlWeb)
                }
 
                
            }
            
            
            
            
            
        }else{
            
            if url.absoluteString == "http://wichita.vn"{
                
                 UIApplication.sharedApplication().openURL(url)
                
            }else{
                
                var urlApp: NSURL = NSURL(string: "fb://profile/598291676967768")!
                var urlWeb: NSURL = NSURL(string: "http://facebook.com/WichitaCoffee")!
                
                if UIApplication.sharedApplication().canOpenURL(urlApp){
                    
                    UIApplication.sharedApplication().openURL(urlApp)
                }
                    
                else{
                    
                    UIApplication.sharedApplication().openURL(urlWeb)
                }
  
            }
        }
       
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
