

;;; Free Recall - General Model V2 [controls]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; [BASIC INFORMATION] ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Creator:                      Clemens Kaiser (s4460065)
; Course:                       First-year Research Project []
; Supervised by:                M.K. van Vugt
; ACT-R version:                7.13
; More information:            
; Contact:                      c.m.kaiser@student.rug.nl
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(clear-all)

(define-model freerecall

(sgp 
   :rt -0.4  ; retrieval threshold (default = 0, Anderson model = 3.2) (0)
   :lf 1.8 ; latency-factor (default = 1, Anderson model = 2) (1.25)
   :v nil ; enable/disable trace
   :trace-detail low ; set level of trace detail
   :act nil ;t/medium/low/nil ;;tracing activation values
   :show-focus t ; show location of visual focus
   :er t ; Makes it so ties in productions are determined randomly (nil = fixed order)
   :bll 0.5 ; Set base-level learning (d75cay parameter), more frequently/recently retrieved items gain higher activation (default = 0.5)
   :esc t ; use subsymbolic processing
   :auto-attend t ; visual location requests are automatically accompanied by a request to move attention to the location found
   :declarative-num-finsts 20 ; number of items that are kept as recently retrieved  (CSM: 20)
   :declarative-finst-span 17 ; how long items stay in the recently-retrieved state (CSM: 17)
   :ans 0.2 ; activation noise (default = nil, recommended: 0.2 - 0.8, Anderson model = 0.7)
   :egs 0.1 ; noise in utility computation
   :dat 0.05 ; set to its default value (0.05)
   :ol nil ; use base-level equation that requires complete history of a chunk (instead of formula that uses an approximation)
   :model-warnings nil
   :visual-onset-span 1 ;visual scene change can be noticed up to x seconds after it appeared (default = 0.5)
   :unstuff-visual-location nil
   :mp 2.6
#|    :md -1
   :ms 0 |#
   :mas 1
   :ga 1
      ; :imaginal-delay 0
)

 
(chunk-type study-words state context first valence1 second valence2 third valence3 fourth valence4 position type target)
(chunk-type memory word valence context type) ;
(chunk-type goal state context)
(chunk-type recall state position context) ;type
(chunk-type subgoal1 state target targetval)

(add-dm 
   (attend isa chunk)
   (beginclear isa chunk)
   (beginrecall isa chunk)
   (respond isa chunk) 
   (done isa chunk)
   (retrieve isa chunk)
   (harvest isa chunk)
   (rehearse isa chunk)
   (memorize isa chunk)
   (first isa chunk)
   (second isa chunk)
   (third isa chunk)
   (fourth isa chunk)
   (valence isa chunk)
   (valence1 isa chunk)
   (valence2 isa chunk)
   (valence3 isa chunk)
   (valence4 isa chunk)
   (target isa chunk)
   (context isa chunk)
   (subgoal1 isa chunk)
   (goal isa study-words state start context nil target nil) ;type on-task
   (startrecall isa recall state beginrecall context nil) ;type on-task   
)


(P finish-recall-1
   =goal>
      isa         recall
      state       retrieve
   =imaginal>
==>
   =goal>
      isa         study-words
      state       start
)

(P finish-recall-2
   =goal>
      isa         recall
      state       harvest
==>
   =goal>
      isa         study-words
      state       start
)


(P find-unattended-word
   =goal>
      isa         study-words
      state       start
      context 	   =context
      ;type        =type
 ==>
   +visual-location>
      :attended    nil
   =goal>
      state       find-location
      context     =context

    !output! (=context)
)

(P attend-word
   =goal>
      isa         study-words
      state       find-location
      context	   =context
      ;type        =type
   =visual-location>
   ?visual>
      state       free
==>
#|    +visual>
      cmd         move-attention
      screen-pos  =visual-location |#
   =goal>
      state       attend
      context 	   =context
      ;type        =type
)

(P high-first
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      ;type        =type
      first       nil
   =visual>
      value       =word
      color       =col
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      first       =word
      position    first     
      valence1    =col 
     ; type        =type
   +imaginal>
      isa         memory
      word        =word   
      valence     =col
      context 	   =context
      type        on-task
)

(P high-second
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      ;type        =type
      second      nil
   =visual>
      value       =word
      color       =col      
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      second      =word
      position    second
      valence2    =col
      ;type        =type
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
      type        on-task    
)

(P high-third
   =goal>
      isa         study-words
      state       attend
      context 	   =context
     ; type        =type
      third       nil
   =visual>
      value       =word
      color       =col       
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      third       =word
      position    third
      valence3    =col
     ; type        =type
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
      type        on-task
)

(P high-fourth
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      ;type        =type
      fourth      nil
   =visual>
      value       =word
      color       =col       
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      fourth      =word
      position    fourth
      valence4    =col
      ;type        =type
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
      type        on-task
)


(P replace-first
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      ;type        =type
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
      color       =col        
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      first       =word
      position    first
      valence1    =col
      ;type        =type
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
      type        on-task
)

(P replace-second
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      ;type        =type
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
      color       =col        
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      second      =word
      position    second
      valence2    =col
      ;type        =type
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
      type        on-task
)

(P replace-third
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      ;type        =type
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
      color       =col        
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      third       =word
      position    third
      valence3    =col
      ;type        =type
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
      type        on-task
)

(P replace-fourth
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      ;type        =type
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
      color       =col        
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	   =context
      fourth      =word
      position    fourth
      valence4    =col
      ;type        =type
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
      type        on-task
)

(P add-to-memory-1
   =goal>
      isa         study-words
      state       memorize
      context     =context
      first       =word
      valence1    =col
      position    first
      ;type        =type
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      first       =word
      valence1    =col
      position    nil  
      ;type        =type
)

(P add-to-memory-2
   =goal>
      isa         study-words
      state       memorize
      context     =context
      second      =word
      valence2    =col
      position    second
      ;type        =type
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      second      =word
      valence2    =col
      position    nil 
      ;type        =type 
)

(P add-to-memory-3
   =goal>
      isa         study-words
      state       memorize
      context     =context
      third       =word
      valence3    =col
      position    third
     ; type        =type
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      third       =word
      valence3    =col
      position    nil 
      ;type        =type 
)

(P add-to-memory-4
   =goal>
      isa         study-words
      state       memorize
      context     =context
      fourth      =word
      valence4    =col
      position    fourth
      ;type        =type
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      fourth      =word
      valence4    =col
      position    nil 
      ;type        =type
)


(P wait-1
   =goal>
      isa         study-words
      state       rehearse
      first       nil
      context     =context
      ;type        =type
==>
   =goal>
      state       rehearse
      context     =context
      ;type        =type
)

(P wait-2
   =goal>
      isa         study-words
      state       rehearse
      second       nil
      context     =context
      ;type        =type
==>
   =goal>
      state       rehearse
      context     =context
      ;type        =type
)

(P wait-3
   =goal>
      isa         study-words
      state       rehearse
      third       nil
      context     =context
      ;type        =type
==>
   =goal>
      state       rehearse
      context     =context
      ;type        =type
)

(P wait-4
   =goal>
      isa         study-words
      state       rehearse
      fourth       nil
      context     =context
      ;type        =type
==>
   =goal>
      state       rehearse
      context     =context
      ;type        =type
)

(P rehearse-first
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      first       =word
      valence1    =col
      ;type        =type
      ;position    first
==>
   =goal>
      state       subgoal1
      context     =context
      target      =word
      ;type        =type
      ;position    second
   +retrieval>
      isa         memory
      context     =context
      word        =word  
      valence     =col 
#|    +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task |#
)

(P rehearse-second
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      second      =word
      valence2    =col  
      ;type        =type    
      ;position    second
==>
   =goal>
      state       subgoal1
      context     =context
      target      =word
      ;type        =type
      ;position    third
   +retrieval>
      isa         memory
      context     =context   
      word        =word   
      valence     =col
#|    +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task |#
)

(P rehearse-third
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      third       =word 
      valence3    =col 
      ;type        =type     
      ;position    third
==>
   =goal>
      state       subgoal1
      context     =context
      target      =word
      ;type        =type
      ;position    fourth
   +retrieval>
      isa         memory
      context     =context   
      word        =word  
      valence     =col
#|    +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task |#
)

(P rehearse-fourth
   =goal>
      isa         study-words
      state       rehearse
      context     =context
      fourth      =word
      valence4    =col   
      ;type        =type     
      ;position    fourth
==>
   =goal>
      state       subgoal1
      context     =context
      target      =word
      ;type        =type
      ;position    first
   +retrieval>
      isa         memory
      context     =context  
      word        =word  
      valence     =col
 #|   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task |#
)



(P rehearse-first-default
   =goal>
     isa          study-words
     context      =context
     state        rehearse
     ;type         =type
     ;position     first
==>
   =goal>
      isa         study-words
      context     =context
      state       rehearse
      ;type        =type
      ;position    second
)

(P rehearse-second-default
   =goal>
     isa          study-words
     context      =context
     state        rehearse
     ;type         =type
     ;position     second
==>
   =goal>
      isa         study-words
      context     =context
      state       rehearse
      ;type        =type
      ;position    third
)

(P rehearse-third-default
   =goal>
     isa          study-words
     context      =context
     state        rehearse
     ;type         =type
     ;position     third
==>
   =goal>
      isa         study-words
      context     =context
      state       rehearse
      ;type        =type
      ;position    fourth
)

(P rehearse-fourth-default
   =goal>
     isa          study-words
     context      =context
     state        rehearse
     ;type         =type
     ;position     fourth
==>
   =goal>
      isa         study-words
      context     =context
      state       rehearse
      ;type        =type
      ;position    first
)


(P rehearse-it 
   =goal>
      state       subgoal1
      context     =context
      ;type        =type
      target      =word
      ;position    =pos
   =retrieval>
      word        =word
      valence     =col
      context     =context
   ?imaginal>
      state       free     
==>
   =goal>
      isa         study-words
      context     =context
      target      =word
      state       rehearse
      ;type        =type
      ;position    =pos
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task

   !eval! ("rehearsed-word" =word)
   !output! (=word)         
)


(P rehearse-it-wrong-word 
   =goal>
      state       subgoal1
      context     =context
      ;type        =type
      ;position    =pos
   =retrieval>
      word        =word
      valence     =col
   ?imaginal>
      state       free     
==>
   =goal>
      isa         study-words
      context     =context
      target      =word
      state       rehearse
      ;type        =type
      ;position    =pos
#|    +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task |#

   !eval! ("rehearsed-word" =word)
   !output! (=word)         
)


(P skip-rehearse-1
   =goal>
      state      subgoal1
      target     =word
      first      =word
      context    =context
      ;type       =type
      ;position   second
   ?retrieval>
      buffer     failure
==>
   =goal>
      isa        study-words
      state      rehearse
      context    =context
      target     =word
      ;type       =type
      ;position   second
)

(P skip-rehearse-2
   =goal>
      state      subgoal1
      target     =word
      second     =word
      context    =context
      ;type       =type
      ;position   third
   ?retrieval>
      buffer     failure
==>
   =goal>
      isa        study-words
      state      rehearse
      context    =context
      target     =word
      ;type       =type
      ;position   third
)

(P skip-rehearse-3
   =goal>
      state      subgoal1
      target     =word
      third      =word
      context    =context
      ;type       =type
      ;position   fourth
   ?retrieval>
      buffer     failure
==>
   =goal>
      isa        study-words
      state      rehearse
      context    =context
      target     =word
      ;type       =type
      ;position   fourth
)

(P skip-rehearse-4
   =goal>
      state      subgoal1
      target     =word
      fourth     =word
      context    =context
      ;type       =type
      ;position   first
   ?retrieval>
      buffer     failure
==>
   =goal>
      isa        study-words
      state      rehearse
      context    =context
      target     =word
      ;type       =type
      ;position   first
)


(P initiate-rumination
   =goal>
      state       subgoal1
   =retrieval>
      word        =word
      valence     =col
      context     rumination
==>
   =goal>
      isa         study-words
      state       ruminate
      target      =word
      valence     =col
)

(P continue-rumination-1
   =goal>
      state       ruminate
      target      =word
   ?retrieval>
      state       free
==>
   =goal>
      isa         study-words
      target      =word
      state       ruminate
   +retrieval>        
      valence     red
#|       type        on-task |#
      :recently-retrieved nil
)

(P continue-rumination-2
   =goal>
      state       ruminate
   =retrieval>
      word        =word
      valence     =col
      context     rumination
   ?imaginal>
      state       free
==>
   =goal>
      state       ruminate
      target      =word
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context     rumination  
)

(P break-rumination
   =goal>
      state       ruminate
   =retrieval>
      word        =word
      valence     =col
      context     =context
      type        on-task
==>
   =goal>
      state       rehearse
      target      =word
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context     =context
      type        on-task 
)


(P attend-new-word
   =goal>
      isa         study-words
      state       rehearse
   =visual-location>
   ?visual>
      state       free  
==>
#|    +visual>
      cmd         move-attention
      screen-pos  =visual-location |#
   =goal>
      state       attend
    ;!output! (=context)
)

(P attend-new-word-2
   =goal>
      isa         study-words
      state       subgoal1
#|    =retrieval> |#
   =visual-location>
   ?visual>
      state       free  
==>
#|    +visual>
      cmd         move-attention
      screen-pos  =visual-location |#
   =goal>
      state       attend
    ;!output! (=context)
)


(P reattend-word
   =goal>
      isa         study-words
      state       attend
   =visual-location>
   ?visual>
      state       free 
==>
   =goal>
      isa         study-words
      state       attend
   +visual>
      cmd         move-attention
      screen-pos  =visual-location
)

(P skip-word
   =goal>
      isa         study-words
      state       attend
      context     =context
   ?imaginal>
      state       free
   =visual-location>
==>
   =goal>
      state       rehearse
      context     =context
)

(P new-word-break-rumination
   =goal>
      isa         study-words
      state       ruminate
      context     =context
   =visual-location>
   ?visual>
      state       free  
==>
#|    +visual>
      cmd         move-attention
      screen-pos  =visual-location |#
   =goal>
      state       attend
      context     =context
      ;type        on-task 
    ;!output! (=context)
)

(P new-word-continue-rumination
   =goal>
      isa         study-words
      state       ruminate
      context     =context
   =visual-location>
   ?visual>
      state       free  
==>
   =goal>
      isa         study-words
      state       ruminate
   +retrieval>        
      valence     red
      :recently-retrieved nil
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;; #| Distraction Task |# ;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;; #| Distraction Task |# ;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;; #| Distraction Task |# ;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(P crowd-out-wm
   =goal>
      isa         study-words
      state       begin-task 
==>
   =goal>
      isa         study-words
      state       work-on-task
      first       nil
      valence1    nil
      second      nil
      valence2    nil
      third       nil
      valence3    nil
      fourth      nil
      valence4    nil
      
)

(P continue-task
   =goal>
      isa         study-words
      state       work-on-task
==>
   =goal>
      isa         study-words
      state       work-on-task
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;; #| Recall Starts Below |# ;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;; #| Recall Starts Below |# ;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;; #| Recall Starts Below |# ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(p start-recall
   =goal>
      isa         recall
      state       beginrecall
      context 	   =context 
      ;type        =type
==>
   =goal>    
      isa         recall
      state       retrieve
      context 	   =context
      position	   first
      ;type        =type
) 

(P finish-retrieval
   =goal>
      isa         recall
      state       retrieve
      context     =context
   =retrieval> 
==>
   =goal>
      isa         recall
      state       retrieve
      context     =context
   )


(P buffer-failure-intercept
   =goal>
      isa         recall
      state       retrieve
      context     =context
      position    first
   ?retrieval>
      buffer      failure
==>
   =goal>
      isa         recall
      state       retrieve
      context     =context
      position    first

)

(p retrieve-first
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      ;type        =type
      position    first
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      context 	   =context
      ;type        =type
      position    first
   +retrieval>
      isa         study-words
      context 	   =context
    - first       nil
)

(p retrieve-second
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      ;type        =type
      position    second
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      context 	   =context 
      ;type        =type 
      position    second
   +retrieval>
      isa         study-words
      context 	   =context
    - second      nil
)

(p retrieve-third
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      ;type        =type
      position    third
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      context 	   =context
      ;type        =type
      position    third   
   +retrieval>
      isa         study-words
      context 	   =context
    - third       nil
)

(p retrieve-fourth
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      ;type        =type
      position    fourth
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      context 	   =context
      ;type        =type 
      position    fourth
   +retrieval>
      isa         study-words
      context 	   =context
    - fourth      nil
)

#| (p retrieve-first-default
	=goal>
	  isa         recall
      state       retrieve
      position    first
==>
	=goal>
      isa         recall
      state       retrieve
      position    second
)

(p retrieve-second-default
	=goal>
	  isa         recall
      state       retrieve
      position    second
==>
	=goal>
      isa         recall
      state       retrieve
      position    third
)

(p retrieve-third-default
	=goal>
	  isa         recall
      state       retrieve
      position    third
==>
	=goal>
      isa         recall
      state       retrieve
      position    fourth
)

(p retrieve-fourth-default
	=goal>
	  isa         recall
      state       retrieve
      position    fourth
==>
	=goal>
      isa         recall
      state       retrieve
      position    nil
) |#


(P retrieval-failure-1
   =goal>
      isa         recall
      state       harvest
      context 	   =context 
      position    first
   ?retrieval>
      state 	  error
==>
   =goal>
   	  isa 		  recall
   	  state 	     retrieve
   	  context 	  =context
   	  position    second
   -retrieval>
)

(P retrieval-failure-2
   =goal>
      isa         recall
      state       harvest
      context 	   =context 
      position    second
   ?retrieval>
      state 	   error
==>
   =goal>
   	  isa 		  recall
   	  state 	     retrieve
   	  context 	  =context
   	  position    third
   -retrieval>
)

(P retrieval-failure-3
   =goal>
      isa         recall
      state       harvest
      context 	   =context 
      position    third
   ?retrieval>
      state 	   error
==>
   =goal>
   	  isa 		  recall
   	  state 	     retrieve
   	  context 	  =context
   	  position    fourth
   -retrieval>
)

(P retrieval-failure-4
   =goal>
      isa         recall
      state       harvest
      context  	=context
      position    fourth
   ?retrieval>
      state 	  error
==>
   =goal>
   	  isa 		  recall
   	  state 	     retrieve
   	  context 	  =context
   	  position    nil
   -retrieval>
)


(p recall-first
   =goal>
      isa         recall
      state       harvest
      context 	   =context 
      position    first     
   =retrieval>
      isa         study-words 
      first       =word
      valence1    =col
      context	   =context
   ?imaginal>
      state       free
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    second
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task

   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)

(p recall-second
   =goal>
      isa         recall
      state       harvest
      context 	   =context   
      position    second   
   =retrieval>
      isa         study-words 
      second      =word
      valence2    =col
      context 	   =context
   ?imaginal>
      state       free
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    third
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task

   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)

(p recall-third
   =goal>
      isa         recall
      state       harvest
      context 	   =context   
      position    third   
   =retrieval>
      isa         study-words 
      third       =word
      valence3    =col
      context     =context
   ?imaginal>
      state       free
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    fourth
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task

   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)

(p recall-fourth
   =goal>
      isa         recall
      state       harvest
      context 	   =context    
      position    fourth  
   =retrieval>
      isa         study-words 
      fourth      =word
      valence4    =col
      context 	   =context
   ?imaginal>
      state       free
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    nil
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task
   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)


(p retrieve-a-word
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      ;type        =type
      position    nil
   ?retrieval>
      buffer      empty
      state       free     
==>
   =goal>
      isa         recall
      state       harvest
      context 	   =context   
   +retrieval>
      isa         memory
   -  word        nil
      context 	   =context
#|       type        on-task |#
      :recently-retrieved nil ; only get items that were not recently retrieved
)

(p ruminate
   =goal>
      isa         recall
      state       harvest
      ;type        =type 
   =retrieval>
      isa         memory 
      word        =word
      valence     =col
      context     rumination
   ?imaginal>
      state       free
==>
   =goal>
      isa         recall
      state       retrieve
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     rumination

   !output! (=word)
)

#| (p ruminate-2
   =goal>
      isa         recall
      state       rumination
      ;type        =type 
   =imaginal>
==>
   =goal>
      isa         recall
      state       retrieve
) |#


(p recall-a-word
   =goal>
      isa         recall
      state       harvest 
      ;type        =type    
   =retrieval>
      isa         memory 
      word        =word
      valence     =col
      context     =context
      type        on-task
   ?imaginal>
      state       free
==>
   =goal>
      isa         recall
      state       retrieve
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context
      type        on-task

   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)


(P try-again
   =goal>
      isa         recall
      state       harvest
      context     =context
   ?retrieval>
      state      error
==>
   =goal>
      isa         recall
      state       retrieve
      context     =context
      position    nil
   -retrieval>
)

(p stop-recall
   =goal>
      isa         recall
      state       retrieve
#|       context 	  =context  |# 
      position    nil
==>
   !stop!
)


; :u ;; utility of prodiction
; :at ;; action time of production 

#| (spp add-to-memory-1 :at 0.2) ; Anderson = 0.2
(spp add-to-memory-2 :at 0.2)
(spp add-to-memory-3 :at 0.2)
(spp add-to-memory-4 :at 0.2) |#

(spp attend-new-word :u 100) ; ensure new words are always attended
(spp attend-new-word-2 :u 100)

#| (spp no-new-word :u 0 :at 0.01) |#

(spp rehearse-it :u 5 :at 0.3) ; Anderson = :at 0.5

#| (spp rehearse-first :at 0.1)
(spp rehearse-second :at 0.1)
(spp rehearse-third :at 0.1)
(spp rehearse-fourth :at 0.1) |#
(spp rehearse-first-default :u -1) ; to make it very unlikely the model defaults on rehearsing first item in WM
(spp rehearse-second-default :u -1) ; slightly more likely for each subsequent position (because time passes and model is occupied with recalling previous items)
(spp rehearse-third-default :u -1)
(spp rehearse-fourth-default :u -1) ; but likelihood to default on any of them should be pretty low

;utility noise (:egs) is set to 0.1
(spp dump-first :u 1 :at 0.2)
(spp dump-second :u 1 :at 0.2)
(spp dump-third :u 1 :at 0.2)
(spp dump-fourth :u 1 :at 0.2)

(spp dump-first-default :u 0.5) ; to make it very unlikely the model defaults on recalling first item in WM
(spp dump-second-default :u 0.5) ; slightly more likely for each subsequent position (because time passes and model is occupied with recalling previous items)
(spp dump-third-default :u 0.5)
(spp dump-fourth-default :u 0.5) ; but likelihood to default on any of them should be pretty low

(spp skip-rehearse-1 :u 10)
(spp skip-rehearse-2 :u 10)
(spp skip-rehearse-3 :u 10)
(spp skip-rehearse-4 :u 10)

(spp wait-1 :u 0 :at 0.4) ;test: :u -0.1 :at 0.3
(spp wait-2 :u 0 :at 0.4)
(spp wait-3 :u 0 :at 0.4)
(spp wait-4 :u 0 :at 0.4)

#| (spp forget-word-1 :u 1)
(spp forget-word-2 :u 1)
(spp forget-word-3 :u 1) 
(spp forget-word-4 :u 1) |#

(spp rehearse-it-wrong-word :u -10)

(spp continue-rumination-1 :u 1 :at 1)
(spp continue-rumination-2 :u 10 :at 1)
(spp break-rumination :u 10)
(spp new-word-break-rumination :u 0)
(spp new-word-continue-rumination :u 0)

(spp finish-retrieval :u -10)
(spp reattend-word :u -5)
(spp skip-word :u -10)
#| (spp wait-for-word :u -5 :at 0.5) |#
(spp retrieve-a-word :u 10 :at 0.5) ; Anderson model = 0.5
(spp ruminate :u 10 :at 0.5)

(spp try-again :at 1)
(spp stop-recall :u -10)

#| (set-all-base-levels 500 -1000) ;settings in Anderson's Murdock model --> 500 -1000 |#
(goal-focus goal)

)

