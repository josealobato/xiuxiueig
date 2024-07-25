# ``MediaConsistencyService``

The media consistency service will execute strategically to keep consistency between the 
database storage (repositories) and files in the system (Media File System).

In general it will verify that the status of all items in the repository represente a 
a valid media on the file system. At the same time It will check that all files in the 
file system have a valid representation on the repository.

It is a service so It will be associated to a flow (Coordinator) to run.

The MCS do its best to preserve the user media.

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
