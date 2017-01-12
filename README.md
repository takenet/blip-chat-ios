
Blip SDK for iOS
======

SDK to easily add BLiP conversations in your iOS app. For more information see [BLiP portal][1] and [BLiP documentation][2].

Installation
--------

### Prerequisites

To use the Blip SDK for iOS, you will need the following installed on your development machine:

**TODO - Add other prerequisites**

<!-- Xcode 7 or later -->
* iOS 8 or later

Import the Blip SDK for iOS into your project via CocoaPods:

1. If you have not installed CocoaPods, install it by running the command:

        $ gem install cocoapods
        $ pod setup

2. Create a plain text file named `Podfile` (without any file extension) inside your project directory. Add the lines below to your file and replace `YourTarget` with your actual target name.

        # Uncomment the next line to define a global platform for your project
        # platform :ios, '9.0'

        target 'YourTarget' do
          use_frameworks!
          pod "BlipSDK"
        end

3. Run the following command.

        $ pod install

4. Open up `*.xcworkspace` with Xcode and start using the SDK.

    **Note**: Do **NOT** use `*.xcodeproj`.  You receive an error if you open up a project file instead of a workspace.

<!-- ld: library not found for -lPods-AWSCore -->
<!-- clang: error: linker command failed with exit code 1 (use -v to see invocation) -->

How to use
-------------------------

## Quick start

### Setting your SDK

After include sdk reference on your project you must provide a valid **BLiP owner account**.
Only with this special account is possible to use this SDK.

__To get an owner account enter in contact with BLiP team.__

### After getting your owner account

1. Create a new plist file named **blip.plist** on your project.


2. Set your credentials, like bellow, on **blip.plist** file

*TODO


###Opening a new Blip Conversation

1. Importing BlipSKD

    **Swift**
    ```swift
    import BlipSDK
    ```

    **Objective-C**

    ```Objective-C
    import BlipSDK
    ```

2. To open a new thread is very simple. Use **BlipClient** helper class and call *openBlipThread* method.

    **Swift**
    ```swift
    import BlipSDK
    ```

    **Objective-C**

    ```Objective-C
    import BlipSDK
    ```

**TODO - Add code**

*To find your chatbot identifier go to [BLiP Portal](https://portal.blip.ai/#/application), select your chatbot and click 'Settings' on the left bar.


## Advanced features

### Setting information about your client

Sometimes, is very important that your chatbot knows information about your customers, as name or some external identifier for example.
To do this use *setUserAccount* method on **BlipClient** helper class.

**Swift**
```swift
//Add code
```

**Objective-C**

```Objective-C
//Add code
```

For instance,

**Swift**
```swift
//Add code
```

**Objective-C**

```Objective-C
//Add code
```

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
 [snap]: https://oss.sonatype.org/content/repositories/snapshots/
