Markdown Preview package

# Takeaway
Takeaway challange

Thank you for this challange. It was really exciting to create a challange for Lieferando.
I created this application with MVVM and I used lots of functional programming features as well as taken some advantage of using RxSwift and RxCocoa.

# Project breakdown

I always try to built any application OO approach. Because of that reason I separate all of the components for logical folder both hardware and IDE.

Here is below my Xcode IDE project folder structure:

**WebService**
This folder contains all web service classes and routers.
It also contains web service error handlers

**ViewModel**
This folder contains all business logical classes

**View**
This folder contains all UITableviewCell, UICollectionViewCell or other UI related classes with meaninful related folder.

**Controllers**
This folder as the name suggest contains all controller classes and again it should named excat same or similar naming with view models or views and models.

**DataSource**
Mainly I put all of models items in a datasource for to use in TableViews and UICollectionViews. This makes my controller more lighter and reasuable.

**Extensions**
This folder contains all of the extend classes for example UIColors, Strings, Collections etc. whatever I need to extend I put this folder with a meaningful folder name

**Externals**
Mainly this folder only contains JSON, Fonts, Audio or Video files.

**UI**
This folder only contains Storyboards, XCAssets or Xib files.
I always separate Storyboard for different module to make it easier to work with in a team.
For example: UserProfile.storyboard, ProductList.storyboard etc.
