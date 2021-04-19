

(clear-all)

(define-module wm (wm) nil :version "1.0" :documentation "Working memory module that can hold 4 items at a time."
   :query goal-style-query
   :request goal-style-request
   :buffer-mod goal-style-mod-request
)


(define-model freerecall

(sgp 
   :rt -1 ; retrieval threshold
   :v t ; enable/disable trace
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
   :do-not-harvest wm
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Set chunk-types
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(chunk-type study-words state target)
(chunk-type wm-items first second third fourth position)
(chunk-type memory word)
(chunk-type token word color context)
(chunk-type recall state position target)
(chunk-type goal state)
(chunk-type subgoal1 state target targetval)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Set up declarative memory
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
   (init isa wm-items)
   (goal isa study-words state start)
   (startrecall isa recall state beginrecall)   
)

(goal-focus goal)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Define production rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; Attend first word (start-recall productions) ;;;;;
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
   =wm>
      isa         wm-items
      first       nil
   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      first       =word
      position    first
   +imaginal>
      isa         memory
      word        =word   
)

(P high-second
   =goal>
      isa         study-words
      state       attend
   =wm>
      isa         wm-items
      second       nil

   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      second      =word
      position    first
   +imaginal>
      isa         memory
      word        =word   
)

(P high-third
   =goal>
      isa         study-words
      state       attend
   =wm>
      isa         wm-items
      third       nil
   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      third       =word
      position    first
   +imaginal>
      isa         memory
      word        =word   
)

(P high-fourth
   =goal>
      isa         study-words
      state       attend
   =wm>
      isa         wm-items
      fourth       nil
   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      fourth      =word
      position    first
   +imaginal>
      isa         memory
      word        =word   
)

(P replace-first
   =goal>
      isa         study-words
      state       attend
   =wm>
      isa         wm-items
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      first       =word
      position    first
   +imaginal>
      isa         memory
      word        =word
)

(P replace-second
   =goal>
      isa         study-words
      state       attend
   =wm>
      isa         wm-items
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      second      =word
      position    first
   +imaginal>
      isa         memory
      word        =word
)

(P replace-third
   =goal>
      isa         study-words
      state       attend
   =wm>
      isa         wm-items
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      third       =word
      position    first
   +imaginal>
      isa         memory
      word        =word
)

(P replace-fourth
   =goal>
      isa         study-words
      state       attend
   =wm>
      isa         wm-items
      - first     nil
      - second    nil
      - third     nil
      - fourth    nil
   =visual>
      value       =word
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      target      =word
   =wm>
      fourth      =word
      position    first
   +imaginal>
      isa         memory
      word        =word
)

(P create-token
   =goal>
      isa         study-words
      state       memorize
      target      =word
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       rehearse
      target      nil
)


(P rehearse-first
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      first       =word
      position    first
==>
   =goal>
      state       subgoal1
      target      =word
   =wm>
      first       =word
      position    second
   +retrieval>
      isa         memory
      word        =word

;   !output! (=word)
)

(P rehearse-second
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      second      =word
      position    second
==>
   =goal>
      state       subgoal1
      target      =word
   =wm>
      second      =word
      position    third
   +retrieval>
      isa         memory
      word        =word

;   !output! (=word)
)


(P rehearse-third
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      third       =word
      position    third
==>
   =goal>
      state       subgoal1
      target      =word
   =wm>
      third       =word
      position    fourth
   +retrieval>
      isa         memory
      word        =word

;   !output! (=word)
)

(P rehearse-fourth
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      fourth      =word
      position    fourth
==>
   =goal>
      state       subgoal1
      target      =word
   =wm>
      fourth      =word
      position    first
   +retrieval>
      isa         memory
      word        =word

;   !output! (=word)
)

(P rehearse-it
   =goal>
      state       subgoal1
      target      =word
   =wm>
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
   =wm>
      position    =pos
   +imaginal>
      isa         memory
      word        =word

   !eval! ("rehearsed-word" =word) 
   !output! (=word)
)

(p skip-first
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    first
      first       nil
==>
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    second
)

(p skip-second
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    second
      second      nil      
==>
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    third
)

(p skip-third
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    third
      third       nil   
==>
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    fourth
)

(p skip-fourth
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    fourth
      fourth      nil       
==>
   =goal>
      isa         study-words
      state       rehearse
   =wm>
      isa         wm-items
      position    first
)

(p attend-new-word
   =goal>
      isa         study-words
      state       rehearse
   =visual-location>
   ?visual>
      state       free
   =wm> 
      position    =pos
==>
   =goal>
      state       attend 
   =wm> 
      position    =pos
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;; Recall phase ;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
   =wm>
==>
   =goal>    
      isa         recall
      state       retrieve
   =wm>
      position    first
)

(p choose-second
   =goal>    
      isa         recall
      state       choose
   =wm>
==>
   =goal>    
      isa         recall
      state       retrieve
   =wm>
      position    second
)

(p choose-third
   =goal>    
      isa         recall
      state       choose
   =wm> 
==>
   =goal>    
      isa         recall
      state       retrieve
   =wm>
      position    third
)

(p choose-fourth
   =goal>    
      isa         recall
      state       choose
   =wm> 
==>
   =goal>    
      isa         recall
      state       retrieve
   =wm>
      position    fourth
)

(p retrieve-first
   =goal>
      isa         recall
      state       retrieve
   =wm>
      position    first
      first       =word
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      target      =word
   =wm>
      position    second
   +retrieval>
      isa         memory
      word        =word
)

(p retrieve-second
   =goal>
      isa         recall
      state       retrieve
   =wm>
      position    second
      second      =word
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      target      =word
   =wm>  
      position    third
   +retrieval>
      isa         memory
      word        =word
)

(p retrieve-third
   =goal>
      isa         recall
      state       retrieve
   =wm>
      position    third
      third       =word
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      target      =word
   =wm>
      position    fourth   
   +retrieval>
      isa         memory
      word        =word
)

(p retrieve-fourth
   =goal>
      isa         recall
      state       retrieve
   =wm>
      position    fourth
      fourth      =word
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       harvest
      target      =word
   =wm> 
      position    nil
   +retrieval>
      isa         memory
      word        =word
)

(P recall-it
   =goal>
      isa         recall
      state       harvest
      target      =word
   =retrieval>
      isa         memory
      word        =word
==>
   =goal>
      isa         recall
      state       retrieve
      target      nil
   !eval! ("retrieved-word" =word)
   !output! (=word)
)

(p retrieve-a-word
   =goal>
      isa         recall
      state       retrieve
   =wm>
      position    nil
   ?retrieval>
      buffer      empty
      state       free     
==>
   =goal>
      isa         recall
      state       harvest
      target      nil  
   +retrieval>
      isa         memory
    - word        nil
      :recently-retrieved nil ; only get items that were not recently retrieved
)

(p recall-a-word
   =goal>
      isa         recall
      state       harvest
      target      nil     
   =retrieval>
      isa         memory 
      word        =word
==>
   =goal>
      isa         recall
      state       retrieve
   !eval! ("retrieved-word" =word)
   !output! (=word)
)


(p stop-recall
   =goal>
      isa         recall
      state       retrieve
   =wm> 
      position    nil
==>
   !stop!
)


(spp high-first :at .5)
(spp high-second :at .5)
(spp high-third :at .5)
(spp high-fourth :at .5)
(spp rehearse-it :u 5 :at .4)
(spp attend-new-word :u 10) ; ensure new words are always attended
(spp choose-first :u .6)
(spp choose-second :u .5)
(spp choose-third :u .45)
(spp choose-fourth :u .4)
(spp retrieve :u 2 :at 1)
(spp stop-recall :u .5)

)
