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
