# Interface abstraction for a set of functions

This library provides a way to define an interface (a set of procedures with defined names and parameter count), define interface's implementation(s), and call interface method with specific implementation reference.

While generally interface abstraction is less needed compared to statically typed and / or object oriented languages, it can be handy in certain contexts, such as when implementing "Ports and Adapters" (also known as "Hexagon") architecture, which was the main motivation for the creation of this library.

Report issues at https://github.com/arvyy/r7rs-interface/issues

## Usage

Interface is defined with

```
(define-interface 
  interface-implementation-constructor
  method-signature ...)
```

Where `method-signature` is either

* `(method-name arg ...)`
* `(method-name arg ... . rest)`

For example,

```
(define-interface
  foo
  (bar arg1 arg2))
```

`interface-implementation-constructor` is bound to syntax for constructing implementation of this interface, which shall be used so

```
(interface-implementation-constructor
    (method-signature method-body) ...)
```

For example (using `foo` interface from above),

```
(define foo-impl
  (foo
    ((bar arg1 arg2) (list arg1 arg2))))
```

Finally, to invoke interface's method, call it by supplying implementation instance as a first parameter

For example,

```
(display (bar foo-impl 1 2)) ;; should show "(1 2)"
```

During construction of implementation instance, the syntax verifies that

* implementation provides same amount of methods, in same order, with same method names (parameter names are not checked)
* each method provides call-compatible amount of arguments. Implementation method cannot declare more required arguments than there were in interface declaration. The method may declare less required arguments if it also provides a `rest` argument.
