Object subclass: Circulo [
    |  radio  | 
]
    
Circulo subclass: Cilindro [
    |  altura |
]

Cilindro extend [
    altura [
        <category: 'accessing'>
        ^altura
    ]
    
    radio: r altura: h [
        <category: 'initialization'>
        radio:=r.
        altura:=h.
    ]
        
    inicializar: r [
       <category: 'initialization'>
        
       self radio:r altura: 0
    ]
    
    volumen [
    |volumen|
    volumen := (3.14)*(self radio raisedTo: 2)*(self altura).
    ^volumen
    ]
    
    
]

    
Circulo extend  [
    inicializar: r [
       <category: 'initialization'>
       radio:=r.
    ]
    
    radio [
        <category: 'accessing'>
        ^radio
    ]
    
    area [ 
        |area|
        area := (3.14)*(self radio raisedTo: 2).
        ^area
        ]
]



Circulo class extend [
     new: radio [
           | r |
           r:= super new. 
           r inicializar: radio.
           ^r
     ]
]

Cilindro class extend [
     new: radio   [
           | r |
           r := super new.
           r inicializar: radio.
           ^r
     ]
]
   

p := Circulo new: -12.  
r := p radio. 
a := p area. 
ci := Cilindro new: 24.
v := ci volumen.
r displayNl.
a displayNl.
v displayNl.




           

  
  
  

     

