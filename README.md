
BLiP Chat for iOS
======

SDK to easily add BLiP Chat's widget to your iOS app. For more information, see [BLiP portal][1] and [BLiP documentation][2]. See supported versions [here](#support).

Installation
--------

### Prerequisites

To use the BLiP Chat for iOS, you must target iOS 18 or later.

Import the BLiP Chat for iOS into your project via CocoaPods:

1. If you have not installed CocoaPods, install it by running the command:

		$ [sudo] gem install cocoapods
		$ pod setup

2. Create a plain text file named `Podfile` (without any file extension) inside your project directory. Add the lines below to your file and replace `YourTarget` with your actual target name.

		target 'YourTarget' do
		  use_frameworks!
		  pod "BlipChat"
		end

3. Run the following command.

		$ pod install

4. Open up `*.xcworkspace` with Xcode and start using the SDK.

	**Note**: Do **NOT** use `*.xcodeproj`.  You receive an error if you open up a project file instead of a workspace.

How to use
-------------------------

## Quick start
You can open the chat in two ways:

#### 1. Classic way (full screen, navigation push)

```swift
do {
    let options = BlipOptions() // Configure as needed
    try BlipClient.openBlipThread(myView: self, appKey: "your-app-key", options: options)
} catch {
    print("Error opening chat: \(error.localizedDescription)")
}
```

#### 2. Embedding the chat in a portion of the screen (side panel)

```swift
do {
    let options = BlipOptions() // Configure as needed
    let chatVC = try BlipClient.getBlipThreadViewController(appKey: "your-app-key", options: options)
    
    // Add as child view controller
    addChild(chatVC)
    
    // Configure the frame (example: right side of screen, 50% width)
    let width = self.view.bounds.width * 0.5
    chatVC.view.frame = CGRect(x: self.view.bounds.width - width, y: 0, width: width, height: self.view.bounds.height)
    chatVC.view.autoresizingMask = [.flexibleLeftMargin, .flexibleHeight]
    
    // Add to view hierarchy
    self.view.addSubview(chatVC.view)
    chatVC.didMove(toParent: self)
    
    // Optional: keep reference for later removal
    // self.blipChatVC = chatVC
} catch {
    print("Error opening embedded chat: \(error.localizedDescription)")
}
```

This way, the chat will only occupy the right side of the screen and the rest of your app will remain interactive.

### Setting your SDK

After including the SDK reference in your project, you need to get your App Key from [BLiP portal][1]. Go to the left menu and access `Publications > Blip Chat`. On the `Setup` tab you will be able to get the required app key. You will also need to sign up your iOS App Id on the `Domains` section in order to enable the chatbot in your app.

To use location cards, set up the Usage Description Key for Location Service on **info.plist** file. Use the key *Privacy - Location When In Use Usage Description* and set a message to ask for user's permission to use their location. 

![](images/location.png)

### Opening a new Blip Conversation

1. Importing BLiP SDK

	**Swift**
	```swift
	import BlipChat
	```

	**Objective-C**

	```Objective-C
	#import "BlipChat/BlipChat.h"
	```

2. To open a new thread is very simple: use **BlipClient** helper class and call *openBlipThread* method.

	**Swift**
	```swift
	BlipClient.openBlipThread(myView: self, appKey: "your-app-key", options: BlipOptions())
	```

	**Objective-C**

	```Objective-C
	[BlipClient openBlipThreadWithMyView:self appKey:(NSString*) @"your-api-key" options:options error: nil];
	```
	Obs: In Objective-C, the method name is *openBlipThreadWithMyView*
	
	For instance, imagine that you want to establish a new conversation between customer and chatbot when the ViewController is loaded.
	
	**Swift**
	```swift
	import UIKit
	import WebKit
	import BlipChat

	class ViewController: UIViewController {

		override func viewDidLoad() {
			super.viewDidLoad()
		}

		override func viewDidAppear(_ animated: Bool) {
			do {
            	try BlipClient.openBlipThread(myView: self, appKey: "your-api-key", options: BlipOptions())
			} catch {
				print (error.localizedDescription)
			}
		}

		override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
			// Dispose of any resources that can be recreated.
		}
	}
	```

	**Objective-C**

	```Objective-C
	#import "ViewController.h"
	#import "BlipChat/BlipChat.h"

	@interface ViewController ()
	@end

	@implementation ViewController

	- (void)viewDidAppear:(BOOL)animated {
		[super viewDidAppear: animated];
		[BlipClient openBlipThreadWithMyView:self appKey:@"your-app-key" options:nil error: nil];
	}

	- (void)didReceiveMemoryWarning {
		[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
	}
	@end
	```

## Advanced features

### Defining authentication type

BLiP Chat iOS SDK supports two different user authentication types. It is possible to define which authentication method will be used to identify your client.

* Guest - Users will receive a guest account to interact with the chatbot. In this mode, users will not have a message history.
* Dev - Users will receive an account identified by developer to interact with the chatbot. User data must be provided passing a BlipOptions instance as parameter on *BlipClient.openThread* method. You must set 2 properties: `userIdentity`, `userPassword`. In this mode, users have message history.

To define the user authetication type, use the AuthTypeProvider.AuthType enum on authType property of BlipOptions. When using Swift, possible values for authType are: `.Guest` and `.Dev`. When using Objective-C, possible values are: `AuthTypeGuest` and `AuthTypeDev`.

Note: Guest type will be used if 'authType' is not defined.

**Swift**

```swift
let authConfig = AuthConfig(authType: .Dev, userIdentity: "user-identifier", userPassword: "user-password")
options = BlipOptions(authType: authConfig, account: nil)
```

**Objective-C**

```Objective-C
AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"user-identifier" userPassword:@"user-password"];
options = [[BlipOptions alloc] initWithAuthType:authConfig account: nil];
```

### Specifying user data
BLiP Chat allows specification of users' data like `fullname`, `email` and others.
For more details on possible properties and support, check the [Lime Documentation][4].

To set user data, just create an `Account` object and pass it as a parameter to `BlipOptions`.

**Swift**

```swift
let authConfig = AuthConfig(authType: .Dev, userIdentity: "user-identifier", userPassword: "user-password")
let account = Account(fullname: "user-name", email: "user-email")
options = BlipOptions(authType: authConfig, account: account)
```

**Objective-C**

```Objective-C
AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"user-identifier" userPassword:@"user-password"];
Account *account = [[Account alloc] initWithFullname:@"user-name" email:@"user-email"];
options = [[BlipOptions alloc] initWithAuthType:authConfig account: account];
```

### Setting a title for chat window 

In iOS you are able to set a title for the chat view. This title will be shown on the top of the ModalView.

**Swift**
```swift
let options = BlipOptions()
options.windowTitle = "Window Title"
```

**Objective-C**

```Objective-C
BlipOptions *options = [[BlipOptions alloc] init];
options.windowTitle = @"Window Title";
```

### Setting a custom URL for chat 

To use organization in BLiP Chat's iOS SDK, you must assign options to your organization's BLiP Chat URL.

**Swift**
```swift
let authConfig = AuthConfig()

// Use your organization BLiP Chat URL
let options = BlipOptions(authType: authConfig, account: nil, connectionDataConfig: nil, customCommonUrl: "https://take.chat.blip.ai/", customWidgetUrl: nil, windowTitle: nil)
```

**Objective-C**

```Objective-C
AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"user-identifier" userPassword:@"user-password"];
options = [[BlipOptions alloc] initWithAuthType:authConfig account: nil connectionDataConfig: nil customWidgetUrl: nil windowTitle: nil];

// Use your organization BLiP Chat URL
options.customCommonUrl = @"https://take.chat.blip.ai/";
```

### Setting window title with Dev auth type:

**Swift**
```swift
import UIKit
import WebKit
import BlipChat

class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		let authConfig = AuthConfig(authType: .Dev, userIdentity: "user-identifier", userPassword: "user-password")
		let account = Account(fullname: "user-name", email: "user-email")
		let options = BlipOptions(authType: authConfig, account: account)
		options.windowTitle = "window-title"
		
		do {
        		try BlipClient.openBlipThread(myView: self, appKey: "your-app-key", options: options)
        	} catch {
            		print (error.localizedDescription)
        	}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
```

**Objective-C**

```Objective-C
#import "ViewController.h"
#import "BlipChat/BlipChat.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear: animated];

	AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"user-identifier" userPassword:@"user-password"];
	Account *account = [[Account alloc] initWithFullname:@"user-name" 	email:@"user-email"];
	BlipOptions *options = [[BlipOptions alloc] initWithAuthType:authConfig account:account];
	options.windowTitle = @"window-title";
    
    [BlipClient openBlipThreadWithMyView:self appKey: @"your-app-key" options:options error: nil];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
```

Troubleshooting
-------

A -> **dyld: Library not loaded: @rpath/libswiftCore.dylib / Image not found**

Objective-C projects can present an error about library not loaded.

If this occurs, follow the following steps:

1) Set your build settings variable *Runpath Search Paths* to **@executable_path/Frameworks**

your_target -> Build Settings -> Linking -> Runpath Search Paths

2) Switch build setting variable *Always Embed Swift Standard Libraries* to **Yes**

your_target -> Build Settings -> Build Options -> Always Embed Swift Standard Libraries

For a more detailed explanation, see [this thread](http://stackoverflow.com/questions/26104975/dyld-library-not-loaded-rpath-libswiftcore-dylib-image-not-found) on Stack Overflow.

B -> **App Transport Security has blocked a HTTP (http://) resource**

If this occurs, you have two options:

1) Use only HTTPS resources on your chatbot.

2) Add the key NSAppTransportSecurity to your app info.plist.

* Open your Project info.plist file.
* Add a Key called NSAppTransportSecurity as a Dictionary.
* Add a Subkey called NSAllowsArbitraryLoads as Boolean and set its value to YES, as shown in the image below.
![](images/transportSecurity.png)

### Support
-------

  iOS 18+.

License
-------

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.


 [1]: https://portal.blip.ai
 [2]: https://docs.blip.ai/#introduction
 [4]: http://limeprotocol.org
 [snap]: https://oss.sonatype.org/content/repositories/snapshots/
