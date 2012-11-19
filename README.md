ITPathbar
=========

<img src="http://www.ilijatovilo.ch/github/itpathbar.png" />

Usage
-----

You want to use ITPathbar? Cool, I'm glad!

### Copy files

You have to copy the following files in order to get ITPathbar working:

* ITPathbar.h
* ITPathbar.m
* ITPathbarCell.h
* ITPathbarCell.m
* ITPathbarComponentCell.h
* ITPathbarComponentCell.m

Make sure to copy them to the project, and to add them to the target.

You can also either copy all the images from the sample project, or you can draw your own component cells.

### Use in a project

ITPathbar is simple to use.
Just drag a NSView onto your window in Interace Builder.
Then set it's custom class ITParhbar. That's it!

Now just connect an Outlet to it and you can add and remove items like this:

    [self.pathbar insertItemWithTitle:@"Component title" atIndex:0];
    [self.pathbar addItemWithTitle:@"Component title"];
    [self.pathbar removeItemAtIndex:0];
    [self.pathbar removeLastItem];

If you have any questions, feel free to let me know at support@ilijatovilo.ch
