# Do like Countries 🏴‍☠️
Simple iOS Project for search on Countries

The project contains 4 modules:
- Core
- Repository
    - Remote Repository
        - HTTPClient
- App

The **Core** is a Domain module that only keeps pure entities and protocols.
The **Repository** acts like a brain that decide how to prepare data for the App module that right now only uses **RemoteRepostirty** module. Still, one of the future tasks is to add **CacheRepository**.

The **App** module is a presentation layer that has **Module** directory. The module here means feature module that any time you want, you can make it a separate module with minimum dependency to other classes or modules. For communicating between modules, use **Router** approach that brings the most of the class or concreates class from [Github Repository](https://github.com/CassiusPacheco/iOS-Routing-Example/tree/part1)


# Task

- [ ] Draw Diagram for Architecture 
- [ ] Write UnitTest for module and app
- [ ] Implement Caching for keep remote data
- [ ] Impleemt Database for keep selected user data
- [ ] Refactor CountryListViewModel - make better performance with  by observer only on chaning data
