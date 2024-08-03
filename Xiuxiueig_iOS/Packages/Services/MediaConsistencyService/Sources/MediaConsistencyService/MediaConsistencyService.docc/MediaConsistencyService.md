# ``MediaConsistencyService``

The media consistency service will execute strategically to keep consistency between the 
database storage (repositories) and files in the system (Media File System).

It is a service so It will be associated to a flow (Coordinator) to run.

As a principle the MCS do its best to preserve the user media.

In general it will verify that the status of all items in the repository represent a 
a valid media on the file system. At the same time It will check that all files in the 
file system have a valid representation on the repository.

I will have a second responsibility, change a file when a data entity is updated.

Those two actions act on the file system and to avoid that they interfere with each other
they are run in a serial queue.

DEV NOTE: That queue could be done with and actor but I wanted to try this way.

## Single Responsibility

Keep Consistency between the Media Repository and Media File System.

<!--@START_MENU_TOKEN@-->Summary<!--@END_MENU_TOKEN@-->

## Design

(See the Monopic desing in the desing folder)

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
