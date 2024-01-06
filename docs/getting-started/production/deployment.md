We have built and included all the necessary tools in the `tools` container. To spin it up, run:

```
make tools
```

**OR** if you installed nix-shell, then simply:

```
nix develop
```

Generate a new SSH key if you didn't have one yet and keep it safe:

```
make init
```

Once all things is configured, a single command will deploy everything from the ground up.

```
make
```

And that's it!

Watch the demo video here:

[![demo](https://img.youtube.com/vi/Ax0aPeTCGk0/0.jpg)](https://www.youtube.com/watch?v=Ax0aPeTCGk0)
