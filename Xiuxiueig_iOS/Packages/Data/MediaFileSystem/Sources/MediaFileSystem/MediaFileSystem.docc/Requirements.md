# MediaFileSystem (MFS)

## Legend:

* [MMSxxxx] requirement id.
* [ ] requirement implemented.
* [x] requirement implemented.
* [T] requirement with test coverage.
* [NT] requirement without test coverage (Unit Test). 

## Specification.

* [MFS0010] [x] [T] On initialization it will create the Manage and Inbox folders.
* [MFS0020] [x] [T] On initialization it will create the archive folders.
* [MFS0030] [x] [T] On initialization, if the inbox folder has just been created, the package media resources will be copied there.
* [MFS0031] [x] [NT] There should be a way to copy againg the demo media files.
* [MFS0040] [x] [T] The user should be able to mark files as managed. When done it will received un updated file.
* [MFS0050] [x] [T] The user should be able to mark files as archived. When done it will received un updated file.
* [MFS0060] [x] [NT] The user should be able to mark files as unarchived (back to managed). When done it will received un updated file.
* [MFS0070] [x] [T] The user should be able to delete a file new or managed.

### About MediaFiles creation

* [MFS1010] [x] [T] When creating a Media file from new URL the file name is the name and the ID is nil
* [MFS1020] [x] [T] When creating a Media file from managed URL the file name is `id - name`

### About MediaFiles state

* [MFS1110] [x] [T] Whe a media file is not modified it is not dirty.
* [MFS1120] [x] [T] Whe a media file is modified it is dirty.
* [MFS1130] [x] [NT] A Dirty file means that the Media File contains data changes that has not be refected on the file system yet. You should use the update/manage/archive methods to persist those changes.

## Settings

None.

