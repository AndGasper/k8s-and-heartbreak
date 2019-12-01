```
%v	the value in a default format
	when printing structs, the plus flag (%+v) adds field names
%#v	a Go-syntax representation of the value
%T	a Go-syntax representation of the type of the value
%%	a literal percent sign; consumes no value
```

- `fmt`
- >  Package fmt implements formatted I/O with functions analogous to C's printf and scanf. The format 'verbs' are derived from C's but are simpler.
- `fmt.Printf` print with formatting

```
fmt.Printf("flagsForTheThingYouWantToPrint", theThingYouWantToPrint)
```