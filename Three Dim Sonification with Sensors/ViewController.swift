//
//  ContentView.swift
//  ios_test
//
//  Created by k on 2/10/2022.
//
import WebKit
import UIKit
import CoreMotion
import JavaScriptCore

class ViewController: UIViewController,WKNavigationDelegate,CMHeadphoneMotionManagerDelegate{
    
    
    let APP = CMHeadphoneMotionManager()
    var webView: WKWebView!
    
    let url = URL(string: "https://zmk5566.github.io/3D-Audio-Visualization-Sonification/examples/ar_linechart_withdata.html")!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(URLRequest(url: url));

        guard APP.isDeviceMotionAvailable else {
            print("AR PRO is not connected");
            return
        }
        APP.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion, error == nil else { return }
            self?.webView.evaluateJavaScript("document.getElementById('pitch').innerHTML="+String(motion.attitude.pitch), completionHandler: nil)
            
            self?.webView.evaluateJavaScript("document.getElementById('yaw').innerHTML="+String(motion.attitude.yaw), completionHandler: nil)
            
            self?.webView.evaluateJavaScript("document.getElementById('roll').innerHTML="+String(motion.attitude.roll), completionHandler: nil)
            
            self?.webView.evaluateJavaScript("global_config.audio_config.audience_location.pitch="+String(motion.attitude.pitch), completionHandler: nil)
            
            self?.webView.evaluateJavaScript("global_config.audio_config.audience_location.yaw="+String(-motion.attitude.yaw), completionHandler: nil)
            
            self?.webView.evaluateJavaScript("global_config.audio_config.audience_location.roll="+String(-motion.attitude.roll), completionHandler: nil)
            
            self?.webView.evaluateJavaScript("update_global_config()", completionHandler: nil)
        })
        
        
        let jsCode =
"""

var func_js = function (){
return "super cool function"

}

"""
        let context = JSContext();
        context!.evaluateScript(jsCode);
        let funcInJS = context!.objectForKeyedSubscript("func_js");
        let returnValue = funcInJS!.call(withArguments:[]);
        print(returnValue);
        
        
        
    }
    
    

}
