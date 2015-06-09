Array extend [
    withCero: neutro foldl: b  [
    	1 to self basicSize do: [:i | b value1: x value2: y
    	                          (i==1)
    	                          ifTrue [ x:= neutro
    	                                   y:= self at:i]
    	                           ifFalse [ y:= self at:i]
    	                           ]
    ]
]