Object subclass: Par [
  |x y|
  
  x: a y:b [
      x:=a.
      y:=b.
  ]
  
  Par class >> new [
     |r|
     r:= super new.
     r x:0 y:0.
     ^ r
  ]
  
]


a:= Par new
a x:3 y:4.