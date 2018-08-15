

# Project breakdown
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
