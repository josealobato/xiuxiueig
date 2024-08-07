# ``MediaFileSystem``

The MediaFileSystem is in charge of abstracting the file system. That way the rest of the system doesn't need to know
where and how the media files are stored. 

The MediaFileSystem shares three concepts with the rest of the system (NOTE: "consumer system" is the system using MFS.):

* **Managed Files**: Files that have been managed before. In the sense that they are not new to the consumer system, so that
the system has those files under control on its records.
 
* **Unmanaged Files**: Files that are new to the system and might not be available on the consumer systems records.

* **Archived Files**: Managed Files that are saved to a separed location to keep the system clean.

The consumer system can: 

* Access to the manange, unmanaged and archived files.
* Modify the main file data (id, name)
* Mark files as managed.
* Mark files as archived/unarchived.
* Delete files.

## Single Responsibility

Abstract the file system details to the rest of the application.

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Design

(See the Monopic desing in the desing folder)

```
                     ┌──────────────────────────────────────┐                                     
                     │<<actor>>                             │                                     
                     │MediaFileSystem                       │                                     
                     │---------------------------------     │                                     
                     │managedFiles() -> [MediaFile]         │            MFS - Abstracts the file 
                     │unmanagedFiles() -> [MediaFile]       │            system and knows how     
                     │                                      │─ ─ ─ ─ ─ ─ files are managed on the 
                     │manageFile(MediaFile) -> MediaFile?   │            file system              
                     │archiveFile(MediaFile) -> MediaFile?  │                                     
                     │unarchiveFile(MediaFile) -> MediaFile?│                                     
                     │deleteFile(MediaFile)                 │                                     
                     └──────────────────────────────────────┘                                     
                                         │                                                        
                                         │                                                        
                                         │                                                        
                                         ▼                                                        
┌─────────────────────────────────────────────────────────────────────────────────┐               
│FileSystem                                                                       │               
│                                                                                 │               
│         ┌─────────────────┐    ┌─────────────────┐   ┌─────────────────┐        │               
│         │      inbox      │    │    unmanage     │   │     archive     │        │               
│         │    (folder)     │    │    (folder)     │   │    (folder)     │        │               
│         │                 │    │                 │   │                 │        │               
│         └─────────────────┘    └─────────────────┘   └─────────────────┘        │               
│                                                                                 │               
│                                                                                 │               
└─────────────────────────────────────────────────────────────────────────────────┘                           
```


## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
