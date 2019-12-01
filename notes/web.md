# Web Notes
- Why? 
    - Working my way through the boilerplate from the original example.
- [Go Sandbox/Playground](https://play.golang.org/)

## Go
- Why `Go`?
    - >  TL;DR: Don't be afraid to be a square.
    - If your teams are more comfortable in:
        ```
        - node
        - python
        - java
        - ruby
        - haskell (sp?)
        - C#
        - WebAssembly (kinky)
        ```
    - Not really sure. I hear good things about it's _efficiency_; likely related to how it handles putting the pedal to the metal of the runtime environment* versus:
        - node
        - python
        - Java
    - `*pedal to the metal of the runtime environment` = My extremely technical way of referring to code actually executing.
- People talk a lot about _efficiency_, but even fewer talk about what is actually being measured. If you pick a screaming fast language, but no one on your team can really write, test, and deploy it, then what good are those theoretical gains again?

```
+--------+             +--------+
| Client | -requestA-> | Server |
+--------+             +--------+
```
```
{
    "name": "requestA",
    "data": {
        "path": "/"
    }
}
```

- So it looks like the `dispatcher.go` ~exposes~ (not quite but the idea is there) the data layer.

### What's the deal with `dispatcher.go`? 

### What's the deal with `&forwarder`?


```
type forwarder struct {
    host string
    port int
}
```
so,
```
type forwarder struct {
    host string
    port int
}
```
says: 
> I want a new type called _forwarder_
> That type is actually more complex than what you have built in, so here's the definition:
```
{
    host string
    port int
}
```
- A more careful explanation of Go `structs` can be found [here](https://gobyexample.com/structs)

`fwd := &forwarder{"words", 8080}`
says:
>  The := syntax is shorthand for declaring and initializing a variable. 
- If I had to make an educated guess, there is likely some memory implications to editing by reference.