//
//  CorreoViewController.swift
//  AppGRC
//
//  Created by Crisoper on 10/06/16.
//  Copyright © 2016 Crisoper. All rights reserved.
//

import UIKit

class CorreoViewController: UIViewController, UIWebViewDelegate, NSURLConnectionDelegate {
    
    
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Aplicamos el Delegate
        self.myWebView.delegate = self
        
        /*

        // Do any additional setup after loading the view.
        //Declaramos la constante de donde se va a bajar la data
        let url = NSURL(string: "http://correo.regioncajamarca.gob.pe")!
        //
        //Declaramos una tarea para que descargue el contenido
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) {(data, response, error) -> Void in
            
            if error == nil && data != nil {
                
                //Declaramos una variable en la cual vamos a convertir a String
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                
                // NSString == Permite convertir un objeto a una cadena de texto
                // NSUTF8StringEncoding Codificacion usada para convertir
                
                
                //Esta llamada debemos hacerla siempre pues debemos cargar la vista en el hilo principal
                // Obtenemos el hilo principal y lo ejecutamos
                //Hemos implementado una clausure
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    //Usamos self porque estamos usando una variable en un clausure
                    self.myWebView.loadHTMLString(urlContent, baseURL: url)
                    
                })
                
                
                
                //print(urlContent)
            }
            else {
                print("Se ha producido un error!!")
            }
            
        }
        //Hemos codificado una clausura
        
        //Iniciamos la tarea
        task.resume()
         */
        
        
//        let url = NSURL(string: "http://mad.regioncajamarca.gob.pe/Login.aspx")
//        let urlRequest = NSURLRequest(URL: url!)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (datos, respuesta, error) in
//            
//            if error != nil {
//                
//                print(error)
//                self.myActivityIndicator.stopAnimating()
//                
//            }
//            else {
//                
//                //self.myWebView.loadHTMLString(<#T##string: String##String#>, baseURL: <#T##NSURL?#>)(datos);
//            }
//            
//        }
//        
//        task.resume()

        
        
        
        
        
        
        let url = NSURL (string: "http://correo.regioncajamarca.gob.pe");
        let requestObj = NSURLRequest(URL: url!);
        myWebView.loadRequest(requestObj);
 
 
        
        //
        //let urlConnection:NSURLConnection = NSURLConnection(request: request, delegate: self)!
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
    
    
    //Cuando empieza la carga de datos
    internal func webViewDidStartLoad(webView: UIWebView) {
        self.myActivityIndicator.startAnimating()
    }
    
    //Cuando termina la carga de datos
    internal func webViewDidFinishLoad(webView: UIWebView) {
        self.myActivityIndicator.stopAnimating()
    }
    
    internal func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.myActivityIndicator.stopAnimating()
        print(error)
    }
    
    
    func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge)
    {
        // Trusting and not trusting connection to host: Self-signed certificate
        challenge.sender!.useCredential(NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!), forAuthenticationChallenge: challenge)
        challenge.sender!.continueWithoutCredentialForAuthenticationChallenge(challenge)
        
        if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust)
        {
            let trust = challenge.protectionSpace.serverTrust
            let cred = NSURLCredential(forTrust: trust!)
            
            challenge.sender!.useCredential(cred, forAuthenticationChallenge: challenge)
        }
        
//        let task = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue()).dataTaskWithRequest(request)
    }
    
    
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool
    {
        return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
    }
    
    
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge)
    {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust
        {
            if challenge.protectionSpace.host == "correo.regioncajamarca.gob.pe"
            {
                let credentials = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
                challenge.sender!.useCredential(credentials, forAuthenticationChallenge: challenge)
            }
        }
        
        challenge.sender!.continueWithoutCredentialForAuthenticationChallenge(challenge)
    }
 
    
    
    /*
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError){
        print("didFailWithError")
    }
    
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool{
        print("canAuthenticateAgainstProtectionSpace")
        //return [protectionSpace.authenticationMethodisEqualToString:NSURLAuthenticationMethodServerTrust];
        return true
    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge){
        print("did autherntcationchallenge = \(challenge.protectionSpace.authenticationMethod)")
        
        //if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust && challenge.protectionSpace.host == "myDomain.com" {
        
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust  {
            print("send credential Server Trust")
            let credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            challenge.sender!.useCredential(credential, forAuthenticationChallenge: challenge)
            
        }else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic{
            print("send credential HTTP Basic")
            var defaultCredentials: NSURLCredential = NSURLCredential(user: "username", password: "password", persistence:NSURLCredentialPersistence.ForSession)
            challenge.sender!.useCredential(defaultCredentials, forAuthenticationChallenge: challenge)
            
        }else if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodNTLM{
            print("send credential NTLM")
            if failure_auth < 2 {
                failure_auth = failure_auth + 1
                var defaultCredentials: NSURLCredential = NSURLCredential(user: "username", password: "password", persistence:NSURLCredentialPersistence.ForSession)
                challenge.sender!.useCredential(defaultCredentials, forAuthenticationChallenge: challenge)
            }
            
        } else{
            challenge.sender!.performDefaultHandlingForAuthenticationChallenge!(challenge)
        }
        //challenge.sender.performDefaultHandlingForAuthenticationChallenge!(challenge)
        //challenge.sender.continueWithoutCredentialForAuthenticationChallenge(challenge)
    }
    
    /*
     func connection(connection: NSURLConnection, willSendRequestForAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
     
     
     }*/
    func connection(connection: NSURLConnection, didCancelAuthenticationChallenge challenge: NSURLAuthenticationChallenge){
        print("didCancelAuthenticationChallenge")
    }
    /*
     - (void)connection: (NSURLConnection *)connection willSendRequestForAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge
     {
     [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
     }*/
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse){
        print("-----received response");
        
        
        
        // remake a webview call now that authentication has passed ok.
        
        //_authenticated =YES;
        
        //[_webloadRequest:_request];
        self.myWebView.loadRequest(request)
        
        
        // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
        
        //[_urlConnectioncancel];
    }
     */

}
