# ``XCoordinator``

Coordinator facility for the XiuXiueig application.

## Overview

The XCoordinator Package provides two main features to the application:

1. It allows to implements coordinator by conforming to `XCoordinatorProtocol`
2. It allows features to request coordination with the `XCoordinatorRequestProtocol`

## How to use it

First you need to have a coordinator. Create a class an make it conform to `XCoordinatorProtocol`. Inject that class to your feature as a `XCoordinatorRequestProtocol` type. Now, to be able to request for coordination you need to:

1. Declare your feature as been coordinated in `XCoordinated`.
2. Declare your actions in `XCoordinatorRequest`.
3. Call `coordinate(feature:request:)` to request coordination. 

## Topics

No topics at the moment.

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
