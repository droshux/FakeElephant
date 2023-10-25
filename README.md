# Fake Elephant

"fep" is a simple wrapper bash script for javac to avoid the pains of Gradle and
Maven for small Java projects! It requires a bare minimum project structure
(where `other.java` and `other.class` are any other `.java` and `.class` files
in the project) and (mostly) works well with the **jdtls** Java language server.
```
myProject/
├── build
│   ├── main.class
│   ├── other.class
└── src
    ├── main.java
    ├── other.java
```

By "mostly" I mean that **jdtls** has proper completions and a few other
features across files but displays the error: `file.java is a non-project file.
Only syntax errors are reported`. This means that the only thing telling you
what you can and can't pass into a method is the little preview of the method
declaration shown when you hover an option in the little suggestion drop-down.

This is my tiny personal tool that helps me and I'm putting it here in case it
helps someone else too <3

---
## Installation
*These are the recommended steps to make it feel like a proper build tool but
you're welcome to just run ./.fepbackup.sh in the project folder.*

Download `.fepbackup.sh` basically anywhere (I would recommend your home
directory or the folder where you keep all your small java projects) then create
a hard link to anywhere in your `$PATH` with the name "fep".
```
ln ~/.fepbackup.sh /usr/local/bin
```
...then edit `~/.bashrc` to add the line: `source fep > /dev/null`. Sending the
output to `/dev/null` is necessary because fep currently outputs a message every
time its run.

---
## Commands

- **`fep buildall`**: Compiles every `.java` file in `src/`.
- **`fep cleanbuild`**: Deletes every `.class` file in `build/` and then runs
  the *buildall* function. This is useful if you have renamed or deleted a Java
  file and don't want the old Class file lying around causing clutter.
- **`fep build`**: Only compile Java files that have been changed since the last
  build. This is useful when your project starts to grow and you don't want to
  recompile unnecessary files.
- **`fep run`**: Runs the file `main.class` in the directory `build/`. Yes I'm
  forcing to use a lower case class name. No I don't have a soul.

---
## TODO and plans:

- [ ] If `build` fails then cancel `buildrun` before running.
- [ ] Add proper error messages and logging.
- [ ] **Figure out how to trick jdtls into thinking this is a valid project
  structure and get rid of `file.java is a non-project file. Only syntax errors
  are reported`.**
- [ ] Recursively compile in subfolders of `src/` to allow for simple package
  usage.
- [ ] Add support to compile to `.jar` files for sending your code to all your
  friends <3
