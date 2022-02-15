# zooper_flutter_id3

The best library written in dart for reading and writing id3 tags.
As far as I am aware also the only one supporting ID3 tags for version 1.0, 1.1, 2.2, 2.3 and 2.4.

**NOTE**
This package is actually in alpha stage. Though it should work as intended, we recommend keeping your original files and check if the written file is in a good format.

**NOTE**
Not all frames are supported yet, but they will be written exactly as they have been read, so no data loss. If you wish to support a specific frame, do a pull request or file an issue [[here](https://github.com/zooper-lib/zooper_flutter_id3/issues)]

# Zooper

The zooper family is a list of useful open source packages written in dart/flutter and C# containing helper classes and wrappers for other libraries.
You can check the other packages [[here](https://github.com/zooper-lib)] 

## Getting started

Add this line to your `pubspec.yaml`:

``` yaml
zooper_flutter_id3: <latest>
```

and inside your dart class:

``` dart 
import 'package:zooper_flutter_id3/zooper_flutter_id3.dart';
```

# Usage

## Decoding

The `ZooperAudioFile` stores the Id3v2 and Id3v1 Tag after reading, but also the audio data itself.
You can read a file (You need check the compatibility of a file by yourself) as follows:

``` dart
final file = File(filePath);
final bytes = await file.readAsBytes();

final audioFile = ZooperAudioFile.decode(bytes);
```

## Reading Frames

After that you can access the frames easily via

``` dart
final frame = audioFile.id3v2?.getFrameByNameOrNull(FrameName.track);
```

But this is not the recommended way to retrieve data. This package is developed with models in mind. 
This means that every frame has a model which you can get and edit as you want.
For example:

``` dart
var frameContent = audioFile.id3v2?.getContentGroupDescriptionModel();
frameContent?.value = 'Hello World';
```

## Adding frames

To add a new Frame, there is also a helper method:

``` dart
// Adds a new frame
audioFile.id3v2?.addFrame(frame);
```

This presumes you have created a frame by yourself. Beware to connect the FrameHeader with the FrameContent correctly, 
else it will result in an corrupted file.
The better way to do this is using a helper method:

``` dart
// Adds a new artist frame if possible
audioFile.id3v2?.addArtist('This is an artist test');
```

## Deleting frames

``` dart
// Deletes a specific frame
audioFile.id3v2?.deleteFrame(frame);

// Deletes all frames with the given identifier
audioFile.id3v2?.deleteFramesByName(FrameName.title);
```

# Buy me a Coffee if you like this package

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate?hosted_button_id=Q4QALYJXEDH5Q)

[![Buy me a coffee](https://cdn.fritz-services.com/pdm54_20220215070219/images/yellow-button.png)](https://www.buymeacoffee.com/zooperlib)