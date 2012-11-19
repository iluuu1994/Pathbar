{\rtf1\ansi\ansicpg1252\cocoartf1187\cocoasubrtf340
{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 Menlo-Regular;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural

\f0\fs24 \cf0 ITPathbar\
========\
\
Usage\
---------\
\
You want to use ITPathbar? Cool, I'm glad!\
\
### Copy files\
\
You have to copy the following files in order to get ITPathbar working:\
\
* ITPathbar.h\
* ITPathbar.m\
* ITPathbarCell.h\
* ITPathbarCell.m\
* ITPathbarComponentCell.h\
* ITPathbarComponentCell.m\
\
Make sure to copy them to the project, and to add them to the target.\
\
You can also either copy all the images from the sample project, or you can draw your own component cells.\
\
### Use in a project\
\
ITPathbar is simple to use.\
Just drag a NSView onto your window in Interace Builder.\
Then set it's custom class ITParhbar. That's it!\
\
Now just connect an Outlet to it and you can add and remove items like this:\
\
\pard\tx529\pardeftab529\pardirnatural

\f1\fs22 \cf0 \CocoaLigature0     [self.pathbar insertItemWithTitle:@"Component title" atIndex:0];\
    [self.pathbar addItemWithTitle:@"Component title"];\
    [self.pathbar removeItemAtIndex:0];\
    [self.pathbar removeLastItem];\
\
If you have any questions, feel free to let me know at support@ilijatovilo.ch\
}