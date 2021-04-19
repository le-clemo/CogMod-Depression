

;;; Free Recall - General Model [controls]

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
   :rt -1 ; retrieval threshold
   :v nil ; enable/disable trace
   :trace-detail low ; set level of trace detail
   :act nil ;t/medium/low/nil ;;tracing activation values
   :show-focus t ; show location of visual focus
   :er t ; Makes it so ties in productions are determined randomly (nil = fixed order)
   :bll .5 ; Set base-level learning, more frequently/recently retrieved items gain higher activation
   :esc t ; use subsymbolic processing
   :auto-attend t ; visual location requests are automatically accompanied by a request to move attention to the location found
   :declarative-num-finsts 20 ; number of items that are kept as recently retrieved 
   :declarative-finst-span 17 ; how long items stay in the recently-retrieved state 
   :ans 0.1 ; activation noise 
   :egs 0.1 ; noise in utility computation
   :ol nil ; use base-level equation that requires complete history of a chunk (instead of formula that uses an approximation)
   :model-warnings nil 
)
  
(chunk-type study-words state first valence1 second valence2 third valence3 fourth valence4 position)
(chunk-type memory word valence)
(chunk-type goal state)
(chunk-type recall state position)
(chunk-type subgoal1 state target targetval)

(add-dm 
   (start isa chunk) 
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
   (valence1 isa chunk)
   (valence2 isa chunk)
   (valence3 isa chunk)
   (valence4 isa chunk)   
   (subgoal1 isa chunk)
   (goal isa study-words state start)
   (startrecall isa recall state beginrecall)   
)

(P find-unattended-word
   =goal>
      isa         study-words
      state       start
 ==>
   +visual-location>
      :attended    nil
   =goal>
      state       find-location
)

(P attend-word
   =goal>
      isa         study-words
      state       find-location
   =visual-location>
   ?visual>
      state       free
==>
#|    +visual>
      cmd         move-attention
      screen-pos  =visual-location |#
   =goal>
      state       attend
)

(P high-first
   =goal>
      isa         study-words
      state       attend
      first       nil
   =visual>
      value       =word
      color       =col
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      first       =word
      position    first     
      valence1    =col 
   +imaginal>
      isa         memory
      word        =word   
      valence     =col
)

(P high-second
   =goal>
      isa         study-words
      state       attend
      second      nil
   =visual>
      value       =word
      color       =col      
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      second      =word
      position    first
      valence2    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col      
)

(P high-third
   =goal>
      isa         study-words
      state       attend
      third       nil
   =visual>
      value       =word
      color       =col       
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      third       =word
      position    first
      valence3    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col
)

(P high-fourth
   =goal>
      isa         study-words
      state       attend
      fourth      nil
   =visual>
      value       =word
      color       =col       
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      fourth      =word
      position    first
      valence4    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col
)

(P replace-first
   =goal>
      isa         study-words
      state       attend
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
      first       =word
      position    first
      valence1    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col
)

(P replace-second
   =goal>
      isa         study-words
      state       attend
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
      second      =word
      position    first
      valence2    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col
)

(P replace-third
   =goal>
      isa         study-words
      state       attend
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
      third       =word
      position    first
      valence3    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col
)

(P replace-fourth
   =goal>
      isa         study-words
      state       attend
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
      fourth      =word
      position    first
      valence4    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col
)

(P add-to-memory-1
   =goal>
      isa         study-words
      state       memorize
      first       =word
      position    first
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      first       =word
      position    first  
)

(P add-to-memory-2
   =goal>
      isa         study-words
      state       memorize
      second      =word
      position    first
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      second      =word
      position    first  
)

(P add-to-memory-3
   =goal>
      isa         study-words
      state       memorize
      third      =word
      position    first
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      third      =word
      position    first  
)

(P add-to-memory-4
   =goal>
      isa         study-words
      state       memorize
      fourth      =word
      position    first
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      fourth      =word
      position    first  
)

(P rehearse-first
   =goal>
      isa         study-words
      state       rehearse
      first       =word
      valence1    =val
      position    first
==>
   =goal>
      state       subgoal1
      target      =word
      position    second
   +retrieval>
      isa         memory
      word        =word  
      valence     =val    
)

(P rehearse-second
   =goal>
      isa         study-words
      state       rehearse
      second      =word
      valence2    =val      
      position    second
==>
   =goal>
      state        subgoal1
      target      =word
      position    third
   +retrieval>
      isa         memory   
      word        =word   
      valence     =val     
)

(P rehearse-third
   =goal>
      isa         study-words
      state       rehearse
      third       =word 
      valence3    =val      
      position    third
==>
   =goal>
      state       subgoal1
      target      =word
      position    fourth
   +retrieval>
      isa         memory   
      word        =word  
      valence     =val
)

(P rehearse-fourth
   =goal>
      isa         study-words
      state       rehearse
      fourth      =word
      valence4    =val        
      position    fourth
==>
   =goal>
      state       subgoal1
      target      =word
      position    first
   +retrieval>
      isa         memory   
      word        =word  
      valence     =val
)

(p retrieve-it 
   =goal>
      state       subgoal1
      target      =word
      position    =pos
   =retrieval>
      word        =word
      valence     =val
   ?imaginal>
      state       free     
==>
   =goal>
      isa         study-words
      state       rehearse
      position    =pos
   +imaginal>
      isa         memory
      word        =word   
      valence     =val   
   !eval! ("rehearsed-word" =word)            
)

#| 
(p skip-rehearse 
   =goal>
      state     subgoal1
      target      =word
      position    =pos
   =retrieval>
      isa         memory
      word        =word
   ?imaginal>
      state       free
==>
   =goal>
      isa         study-words
      state       rehearse
      position    =pos     
)
 |#

(p attend-new-word
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
)

(p skip-first
   =goal>
      isa         study-words
      state       rehearse
      first       nil
      position    first 
==>
   =goal>
      isa         study-words
      state       rehearse
      position    second
)

(p skip-second
   =goal>
      isa         study-words
      state       rehearse
      second      nil
      position    second        
==>
   =goal>
      isa         study-words
      state       rehearse
      position    third
)

(p skip-third
   =goal>
      isa         study-words
      state       rehearse
      third       nil
      position    third        
==>
   =goal>
      isa         study-words
      state       rehearse
      position    fourth
)

(p skip-fourth
   =goal>
      isa         study-words
      state       rehearse
      fourth      nil
      position    fourth          
==>
   =goal>
      isa         study-words
      state       rehearse
      position    first
)

(p start-recall
   =goal>
      isa         recall
      state       beginrecall  
==>
   =goal>    
      isa         recall
      state       choose
) 

(p choose-first
   =goal>    
      isa         recall
      state       choose 
==>
   =goal>    
      isa         recall
      state       retrieve
      position    first
)

(p choose-second
   =goal>    
      isa         recall
      state       choose 
==>
   =goal>    
      isa         recall
      state       retrieve
      position    second
)

(p choose-third
   =goal>    
      isa         recall
      state       choose 
==>
   =goal>    
      isa         recall
      state       retrieve
      position    third
)

(p choose-fourth
   =goal>    
      isa         recall
      state       choose 
==>
   =goal>    
      isa         recall
      state       retrieve
      position    fourth
)

(p retrieve-first
   =goal>
      isa         recall
      state       retrieve
      position    first
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest 
      position    first
   +retrieval>
      isa         study-words
    - first       nil
)

(p retrieve-second
   =goal>
      isa         recall
      state       retrieve
      position    second
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest   
      position    second
   +retrieval>
      isa         study-words
    - second      nil
)

(p retrieve-third
   =goal>
      isa         recall
      state       retrieve
      position    third
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      position    third   
   +retrieval>
      isa         study-words
    - third       nil
)

(p retrieve-fourth
   =goal>
      isa         recall
      state       retrieve
      position    fourth
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest   
      position    fourth
   +retrieval>
      isa         study-words
    - fourth       nil
)

(p retrieve-a-word
   =goal>
      isa         recall
      state       retrieve
      position    nil
   ?retrieval>
      buffer      empty
      state       free     
==>
   =goal>
      isa         recall
      state       harvest   
   +retrieval>
      isa         memory
    - word        nil
      :recently-retrieved nil ; only get items that were not recently retrieved
)

(p recall-a-word
   =goal>
      isa         recall
      state       harvest      
   =retrieval>
      isa         memory 
      word        =word
==>
   =goal>
      isa         recall
      state       retrieve
   !eval! ("retrieved-word" =word)
)

(p recall-first
   =goal>
      isa         recall
      state       harvest 
      position    first     
   =retrieval>
      isa         study-words 
      first       =word
==>
   =goal>
      isa         recall
      state       retrieve
      position    second
   !eval! ("retrieved-word" =word)
   !output! (=word)
)

(p recall-second
   =goal>
      isa         recall
      state       harvest   
      position    second   
   =retrieval>
      isa         study-words 
      second      =word
==>
   =goal>
      isa         recall
      state       retrieve
      position    third
   !eval! ("retrieved-word" =word)
   !output! (=word)
)

(p recall-third
   =goal>
      isa         recall
      state       harvest   
      position    third   
   =retrieval>
      isa         study-words 
      third       =word
==>
   =goal>
      isa         recall
      state       retrieve
      position    fourth
   !eval! ("retrieved-word" =word)
   !output! (=word)
)

(p recall-fourth
   =goal>
      isa         recall
      state       harvest    
      position    fourth  
   =retrieval>
      isa         study-words 
      fourth      =word
==>
   =goal>
      isa         recall
      state       retrieve
      position    nil
   !eval! ("retrieved-word" =word)
   !output! (=word)
)

(p stop-recall
   =goal>
      isa         recall
      state       retrieve  
      position    nil
==>
   !stop!
)

(goal-focus goal)


; :u ;; utility of prodiction
; :at ;; action time of production 

#| (spp skip-rehearse :u .5)  |#
(spp high-first :at 0.2)
(spp high-second :at 0.2)
(spp high-third :at 0.2)
(spp high-fourth :at 0.2)
(spp rehearse-it :u 5 :at 0.3) 
(spp attend-new-word :u 10) ; ensure new words are always attended
(spp choose-first :u 0.7)
(spp choose-second :u 0.6)
(spp choose-third :u 0.55)
(spp choose-fourth :u 0.51)
(spp retrieve-a-word :u 2)
(spp stop-recall :u .5)
)