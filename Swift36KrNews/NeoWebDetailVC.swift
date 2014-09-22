//
//  NeoWebDetailVC.swift
//  Swift36KrNews
//
//  Created by neolix on 14-9-19.
//  Copyright (c) 2014年 北京启能万维科技有限公司. All rights reserved.
//

import UIKit

class NeoWebDetailVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    //传值
    var model: NeoKrNewsModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = model.title
        var linkURL = NSURL(string: self.model.detailUrl)
        var webReqest = NSURLRequest(URL: linkURL)
        webView.loadRequest(webReqest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
