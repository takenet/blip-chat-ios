
BLiP Chat for iOS
======

SDK to easily add BLiP Chat widget in your iOS app. For more information see [BLiP portal][1] and [BLiP documentation][2]. See supported versions [here](#support).

Installation
--------

### Prerequisites

To use the BLiP Chat for iOS, you must target iOS 10 or later.

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

### Setting your SDK

After including sdk reference on your project you need to get your api key on [BLiP portal][3]. Go to the left menu and access `Publications > Blip Chat`. You will also need to add your iOS App Id on the `Domains` section, in order to enable your chatbot in your app.

To use location cards set up the Usage Description Key for Location Service on **info.plist** file. Use the key *Privacy - Location When In Use Usage Description* and set a message to ask for user's permission to use location. 

![](images/location.png)

### Opening a new Blip Conversation

1. Importing BlipSKD

	**Swift**
	```swift
	import BlipChat
	```

	**Objective-C**

	```Objective-C
	#import "BlipChat/BlipChat.h"
	```

2. To open a new thread is very simple. Use **BlipClient** helper class and call *openBlipThread* method.

	**Swift**
	```swift
	BlipClient.openBlipThread(myView: self, appKey: "your-app-key", options: nil)
	```

	**Objective-C**

	```Objective-C
	[BlipClient openBlipThreadWithMyView:self appKey:(NSString*) @"your-api-key" options:options error: nil];
	```
	Obs: In Objective-C the method name is *openBlipThreadWithMyView*
	
	For instance, imagine that you want to establish a new conversation between your customer and your chatbot, when your ViewController is loaded.
	
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
            	try BlipClient.openBlipThread(myView: self, appKey: "your-api-key", options: nil)
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
		[BlipClient openBlipThreadWithMyView:self appKey:(NSString*) @"your-api-key" options:nil error: nil];
	}

	- (void)didReceiveMemoryWarning {
		[super didReceiveMemoryWarning];
		// Dispose of any resources that can be recreated.
	}
	@end
	```

## Advanced features

### Defining authentication type

BLiP Chat iOS sdk supports two different user authentication types. It is possible to define which authentication method will be used to identify your client.

* Guest - Users will receive a guest account to interact with the chatbot. In this mode the users have not message history.
* Dev - Users will receive an account identified by developer to interact with the chatbot. User data must be provided passing a BlipOptions instance as parameter on *BlipClient.openThread* method. You must set 2 properties: `userIdentity`, `userPassword`. In this mode the users have message history.

To define what user authetication type use the AuthTypeProvider.AuthType enum on authType propertie of BlipOptions. When using Swift, possible values for authType are: `.Guest` and `.Dev`. When using Objective-C, possible values are: `AuthTypeGuest` and `AuthTypeDev`.

Note: Guest type will be used as default If you do not define 'authType'.

Is also possible to specify the user's informations. For you must create an `Account` object.


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
BLiP Chat lets you to specify user's data like `fullname`, `email` and others.
For mor details about what is supported check [Lime Documentation][4].

To set user data just create an `Account` object and use pass it to `BlipOptions`.

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

### Example setting window title and using Dev auth type:

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
		options.windowTitle = "window-title"
		options = BlipOptions(authType: authConfig, account: account)
		
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
#import "BlipChat/BlipChat-Swift.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear: animated];

	AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"user-identifier" userPassword:@"user-password"];
	Account *account = [[Account alloc] initWithFullname:@"user-name" 	email:@"user-email"];
	options = [options initWithAuthType:authConfig account:account];
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

Objective-C projects can present an error about library not loaded

If this occurs follow this steps:

1) Set your build setting variable *Runpath Search Paths* to **@executable_path/Frameworks**

your_target -> Build Settings -> Linking -> Runpath Search Paths

2) Switch build setting variable *Always Embed Swift Standard Libraries* to **Yes**

your_target -> Build Settings -> Build Options -> Always Embed Swift Standard Libraries

For a more detailed explanation see [this thread](http://stackoverflow.com/questions/26104975/dyld-library-not-loaded-rpath-libswiftcore-dylib-image-not-found) on stackoverflow

B -> **App Transport Security has blocked a HTTP (http://) resource**

If this occurs you have two options:

1) Use only HTTPS resources on your chatbot

2) Add the key NSAppTransportSecurity to your app info.plist.

* Open your Project info.plist file
* Add a Key called NSAppTransportSecurity as a Dictionary.
* Add a Subkey called NSAllowsArbitraryLoads as Boolean and set its value to YES as like following image.
![](images/transportSecurity.png)

### Support
-------

  iOS 10.

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


 [1]: https://blip.ai
 [2]: https://portal.blip.ai/#/docs/home
 [3]: http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22net.take%22
 [4]: http://limeprotocol.org
 [snap]: https://oss.sonatype.org/content/repositories/snapshots/
