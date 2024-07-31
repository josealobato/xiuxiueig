#  Repositories (REP)

The repositories provides a simple persistent storage capabilities, to store 
and retrive data individualy or on batch.

## Legend:

* [REPxxxx] requirement id.
* [ ] requirement implemented.
* [x] requirement implemented.
* [T] requirement with test coverage.
* [NT] requirement without test coverage (Unit Test).
* [-] Test not applicable because the requirement is structural or make no 
      to test it.

## Specification.

Here the term "user" refers to the user o the repositories (not the user of the app)

### General

* [REP0010] [x] [-] The repositories do not depend on other modules (just toolkit)
* [REP0020] [x] [-] The repositories offer "data Entities" and use it in 
                    is interface
* [REP0030] [x] [-] The repositories offer different initerfaces for every entity,
                    including builder and interface.
* [REP0040] [x] [-] The repositories can be configured to persist on every changing 
                    method call or only on explicit call `persist`. 
                    (NOTE: configured on repository creation)

### Lectures repositories

* [REP0110] [x] [T]  User can add a lecture.
* [REP0120] [x] [T]  User can retrive intividual lecture or all lectures.
* [REP0130] [x] [T]  User can delete individual lectures.
* [REP0140] [ ] [ ]  User can delete all lectures.
* [REP0150] [x] [T]  User can update (modify) a lecture.
* [REP0151] [x] [T]  When User updates a lecture the consistecy system will be requested
                     to update that lecture. Only if that operation succeed the lecture
                     will be updated.
* [REP0160] [x] [-]  User can explicitly request to persist the lectures.

### Category repositories

* [REP0310] [x] [ ]  User can add a category.
* [REP0320] [x] [ ]  User can retrive intividual category or all categories.
* [REP0330] [x] [ ]  User can delete individual categories.
* [REP0340] [ ] [ ]  User can delete all categories.
* [REP0350] [ ] [ ]  User can update (modify) a category.
* [REP0360] [ ] [ ]  User can explicitly request to persist the categories.
