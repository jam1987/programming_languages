Object subclass: Foo [
    bar: x baz: y [
        |tmp|
        (y==0)
            ifTrue: [tmp := baz value: y-1]
            ifFalse: [tmp:= 1]
        ^ 2 * tmp
    ]
]

foo:= Foo new
a:= foo bar: [:x | foo bar: [:y| ^ y+1 ] baz: 0
a printNl
        
    