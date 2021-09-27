# Fearless Cross-Platform Development with Delphi

<a href="https://www.packtpub.com/in/programming/fearless-cross-platform-development-with-delphi?utm_source=github&utm_medium=repository&utm_campaign=9781800203822"><img src="https://static.packt-cdn.com/products/9781800203822/cover/smaller" alt="Fearless Cross-Platform Development with Delphi" height="256px" align="right"></a>

This is the code repository for [Fearless Cross-Platform Development with Delphi](https://www.packtpub.com/in/programming/fearless-cross-platform-development-with-delphi?utm_source=github&utm_medium=repository&utm_campaign=9781800203822), published by Packt.

**Expand your Delphi skills to build a new generation of Windows, web, mobile, and IoT applications**

## What is this book about?
Delphi is a strongly typed, event-driven programming language with a rich ecosystem of frameworks and support tools. It comes with an extensive set of web and database libraries for rapid application development on desktop, mobile, and internet-enabled devices. This book will help you keep up with the latest IDE features and provide a sound foundation of project management and recent language enhancements to take your productivity to the next level. 

This book covers the following exciting features:
Discover the latest enhancements in the Delphi IDE
Overcome the barriers that hold you back from embracing cross-platform development
Become fluent with FireMonkey controls, styles, LiveBindings, and 3D objects
Build Delphi packages to extend RAD Server or modularize your applications
Use FireDAC to get quick and direct access to any data
Leverage IoT technologies such as Bluetooth and Beacons and learn how to put your app on a Raspberry Pi
Enable remote apps with backend servers on Windows and Linux through REST APIs
Develop modules for IIS and Apache web servers

If you feel this book is for you, get your [copy](https://www.amazon.com/dp/1800203829) today!

<a href="https://www.packtpub.com/?utm_source=github&utm_medium=banner&utm_campaign=GitHubBanner"><img src="https://raw.githubusercontent.com/PacktPublishing/GitHub/master/GitHub.png" 
alt="https://www.packtpub.com/" border="5" /></a>

## Instructions and Navigations
All of the code is organized into folders. For example, Chapter02.

The code will look like the following:
```
procedure TfrmPeopleList.lbPeopleClick(Sender: TObject);
var
APerson: TPerson;
begin
if lbPeople.ItemIndex > -1 then begin
APerson := lbPeople.Items.Objects[lbPeople.ItemIndex]
as TPerson;
lblPersonName.Caption := APerson.FirstName + ' ' +
APerson.LastName;
lblPersonDOB.Caption := FormatDateTime('yyyy-mm-dd',
APerson.DateOfBirth);
end;
end;
```

**Following is what you need for this book:**
his book is for Delphi developers interested in expanding their skillset beyond Windows programming by creating professional-grade applications on multiple platforms, including Windows, Mac, iOS, Android, and back-office servers. You’ll also find this book useful if you’re a developer looking to upgrade your knowledge of Delphi to keep up with the latest changes and enhancements in this powerful toolset. Some Delphi programming experience is necessary to make the most out of this book

With the following software and hardware list you can run all code files present in the book (Chapter 1-15).
### Software and Hardware List
| Chapter | Software required | OS required |
| -------- | ------------------------------------ | ----------------------------------- |
| 1 | Delphi 10.4 Sydney | Windows |
| 10 | Linux applications | Ubuntu 14.04 or RedHat Enterprises 7 |
| 11 | Mac Development| macOS 10.13 High Sierra - 11 Big Sur |
| 12 | iOS Development | iOS 11,12 or 13 |
| 12 | Android Development | Android 6 Marshmallow - Android 10.0 |


We also provide a PDF file that has color images of the screenshots/diagrams used in this book. [Click here to download it](https://static.packt-cdn.com/downloads/9781800203822_ColorImages.pdf).

### Related products
* Delphi GUI Programming with FireMonkey [[Packt]](https://www.packtpub.com/product/delphi-gui-programming-with-firemonkey/9781788624176?utm_source=github&utm_medium=repository&utm_campaign=9781788624176) [[Amazon]](https://www.amazon.com/dp/1788624173)

* Delphi High Performance [[Packt]](https://www.packtpub.com/product/delphi-high-performance/9781788625456?utm_source=github&utm_medium=repository&utm_campaign=9781788625456) [[Amazon]](https://www.amazon.com/dp/1788625455)

* Hands-On Design Patterns with Delphi [[Packt]](https://www.packtpub.com/product/hands-on-design-patterns-with-delphi/9781789343243?utm_source=github&utm_medium=repository&utm_campaign=9781789343243) [[Amazon]](https://www.amazon.com/dp/1789343240)

*  [[Packt]]() [[Amazon]](https://www.amazon.com/dp/)

## Get to Know the Author
**David Cornelius**
is a software engineer in the Pacific Northwest of the US with over 30 years of experience writing applications for education, research, finance, inventory management, and retail. He has been the coordinator for the Oregon Delphi User Group for two decades and keeps active in various online forums. David is the founder and principal developer at Cornelius Concepts, LLC. and an Embarcadero MVP.
In his spare time, he likes to ride his motorcycle, escape the city with his RV, play the tuba or bass guitar, and play strategy board games with friends.

