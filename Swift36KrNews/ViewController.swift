//
//  ViewController.swift
//  Swift36KrNews
//
//  Created by neolix on 14-9-19.
//  Copyright (c) 2014年 北京启能万维科技有限公司. All rights reserved.
////欢迎加群：106413331学习交流

import UIKit

class ViewController: UIViewController , UITableViewDataSource ,UITableViewDelegate ,NeoKrNewsParserDelegate{
    var tempQueue = NSOperationQueue()
    var krFeedurl = "http://www.36kr.com/feed/"
    var newsList: NSMutableArray = NSMutableArray()
    let krNewsParser:NeoKrNewsParser = NeoKrNewsParser()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(animated: Bool) {
        loadNewsDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10)
    }

    func loadNewsDataSource(){
        var newsURL = NSURL(string: krFeedurl)
        var request = NSURLRequest(URL: newsURL)
        var loadDataQueue: NSOperationQueue  = NSOperationQueue()
        NSURLConnection.sendAsynchronousRequest(request, queue: loadDataQueue) { (response, data, error) -> Void in
            if error != nil {
                println(error)
            }else{
                self.krNewsParser.delegate = self
                self.krNewsParser.parserKrNewsData(data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //NeoKrNewsParserDelegate代理方法
    func neoKrNewsParserFinished(list: NSMutableArray!, success: Bool) {
        self.newsList = list
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newsList.count > 0 ? self.newsList.count : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("NewsCell", forIndexPath: indexPath) as UITableViewCell
        var model = self.newsList.objectAtIndex(indexPath.row) as NeoKrNewsModel
        cell.textLabel?.text = model.title
        cell.detailTextLabel?.text = "作者:" + model.author + "   " + model.date
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var webDetailVC = storyBoard.instantiateViewControllerWithIdentifier("NeoWebDetailVC") as NeoWebDetailVC
        webDetailVC.model = self.newsList.objectAtIndex(indexPath.row) as NeoKrNewsModel
        self.navigationController?.pushViewController(webDetailVC, animated: true)
    }

}

