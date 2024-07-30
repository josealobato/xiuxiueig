#  Media Consisteny Service (MCS)

## Legend:

* [MCSxxxx] requirement id.
* [ ] requirement implemented.
* [x] requirement implemented.
* [T] requirement with test coverage.
* [NT] requirement without test coverage (Unit Test). 

## Specification.

M2R == Media to Repository
R2M == Repository to Media

### General

* [MCS0010] [x] [T] On foreground it will scan the media for new files.
    NOTE: tested because that is the interface that all tests use.

### From Media File System to the Repositories

* [MCS0210] [x] [T] Any UNMANAGED file detected will be added to the repo.

* [MCS0220] [x] [T] It will check that all MANAGED files are properly represented on the repo.
* [MCS0230] [x] [T] Any MANAGED file with no representation on the repo will be set to discarded.

* [MCS0240] [x] [T] It will check that all ARCHIVED files are properly represented on the repo.
* [MCS0250] [x] [T] Any ARCHIVED file with no representation on the repo will be set to discarded.

### From the Repositories to the Media File System

* [MCS0510] [x] [T] All NEW LectureDataEntity has a valid Media file. When not, the entity is removed.
* [MCS0520] [x] [T] All MANAGED LectureDataEntity has a valid Media file. When not, the entity is removed.
* [MCS0530] [x] [T] All ARCHIVED LectureDataEntity has a valid Media file. When not, the entity is removed.

### Entity update

Rationale:
When the repo is about to update a data entity it will ask the MCS to update 
the Media file first. If that works (the MediaFile is updated properly), re repo
with use the returned data entity modified (only the URL will be updated) to persist
the update

On request of update of a DataEntity ...
* [MCS0710] [x] [T] MCS will fail if the is no file with the given URL.
* [MCS0720] [x] [T] MCS will update the file when there is no updates in state
                     but title and id has changed.
* [MCS0730] [x] [T] A successful update will end up in an updated entity.

* [MCS0740] [x] [T] Changing from managed to new will throw.
* [MCS0750] [x] [T] We should be able to manage a new file
* [MCS0760] [x] [T] We should be able to archive a new file
* [MCS0770] [x] [T] We should be able to archive a managed file

### Entity delte

* [MCS0910] [x] [T] Deleting an entity that does not have an associated file
                     will throw.
* [MCS0920] [x] [T] User should be able to delete an new entity an its file 
                     will be deleted.
* [MCS0930] [x] [T] User should be able to delete an managed entity an its file 
                     will be deleted.
* [MCS0940] [x] [T] User should be able to delete an archived entity an its file 
                     will be deleted.

