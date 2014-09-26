OLPC Australia Packages
=======================

This repository contains the necessary files to package the OLPC AU custom
libraries, such as sugar. This is a new attemp to ease the development of
these custom packages.

What is it for?
-----------------------

* Builds packages directly from source repositories.
* No need to maintain a parallel repository for paches.
* Developers can work directly on the source repositories.
* Packagers only needs to know which commit to use.

How do I build a package?
----------------

To generate packages, simply specify the name of the package.

```
./build sugar
```

How does it work?
-----------------

* Tags spec file #GitUrl and #GitCommit (see current projects as examples).
* Use Source0, Name and Version spec fields.
