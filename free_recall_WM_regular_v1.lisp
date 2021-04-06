

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
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Set chunk-types
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(chunk-type study-words state)
(chunk-type working-memory first valence1 second valence2 third valence3 fourth valence4 position context)
(chunk-type memory-token position)
(chunk-type memory word valence)
(chunk-type rehearse position)
(chunk-type output target)
(chunk-type recall state position context)
(chunk-type goal state)
(chunk-type dump-words first second third fourth position context)
(chunk-type token word color context)

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
   (goal isa study-words state start)
   (wm isa working-memory)
   (startrecall isa recall state beginrecall)   
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Define production rules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;; Start learning phase ;;;;;
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

;;;;; Attend new word if available ;;;;;
(p attend-new-word

   =goal>
      isa study-words
      state rehearse

   =visual-location>

   ?visual>
      state free  
==>
   =goal>
      isa study-words
      state rehearse
)

;;;;; Fill empty slot in STM ;;;;;
(P high-first
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      first nil
      
   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      first =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context

)

(P high-second
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      second nil

   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      second =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context
)

(P high-third
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      third nil

   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      third =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context
)

(P high-fourth
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      fourth nil

   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      fourth =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context
)

;;;;; Replace item in WM ;;;;;
(P replace-first
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      - first nil
      - second nil
      - third nil
      - fourth nil

   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      first =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context
)

(P replace-second
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      - first nil
      - second nil
      - third nil
      - fourth nil

   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      second =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context
)

(P replace-third
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      - first nil
      - second nil
      - third nil
      - fourth nil

   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      third =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context
)

(P replace-fourth
   =goal>
      isa study-words
      state attend

   =wm>
      isa study-words
      - first nil
      - second nil
      - third nil
      - fourth nil

   =visual>
      value =word
      color =color

   ?imaginal>
      state free
==>
   =goal>
      isa memory-token
      position first

   =wm>
      isa study-words
      fourth =word

   +imaginal>
      isa token
      word =word
      color =color
;      context =context
)


;;;;; Create memory token ;;;;;
(P create-token
   =goal>
      isa memory-token

   =imaginal>
      isa token
      word =word
      color =color
;      context =context
==>
   =goal>
      isa rehearse
      position first
)


;;;;; Rehearse item in STM ;;;;;
(P rehearse-first
   =goal>
      isa study-words
      position first

   =wm>
      isa study-words
      first =word
==>
   +retrieval>
      isa token
      word =word
;      color =color

   =goal>
      isa rehearse
      position second

   =wm>
      isa study-words
      first =word
)

(P rehearse-second
   =goal>
      isa study-words
      position second

   =wm>
      isa study-words
      second =word
==>
   +retrieval>
      isa token
      word =word
;      color =color

   =goal>
      isa rehearse
      position third

   =wm>
      isa study-words
      second =word
)

(P rehearse-third
   =goal>
      isa study-words
      position third

   =wm>
      isa study-words
      third =word
==>
   +retrieval>
      isa token
      word =word
;      color =color

   =goal>
      isa rehearse
      position fourth

   =wm>
      isa study-words
      third =word
)

(P rehearse-fourth
   =goal>
      isa study-words
      position fourth

   =wm>
      isa study-words
      fourth =word
==>
   +retrieval>
      isa token
      word =word
;      color =color

   =goal>
      isa rehearse

   =wm>
      isa study-words
      fourth =word
)

(P rehearse-it
   =goal>
      isa rehearse

   =retrieval>
      isa token
      word =word
      color =color
==> 
   =goal>
      isa study-words
      position first

   +imaginal>
      isa token
      word =word   
      color =color 

   !eval! ("rehearsed-word" =word) 
)

;;;;; Skip rehearsal for a slot in STM if it is empty ;;;;;
(P skip-first
   =goal>
      isa study-words
      position first

   =wm>
      isa study-words
      first nil
==>
   =goal>
      isa study-words
      position second

   =wm>
      isa study-words
      first nil
)

(P skip-second
   =goal>
      isa study-words
      position second

   =wm>
      isa study-words
      second nil
==>
   =goal>
      isa study-words
      position third

   =wm>
      isa study-words
      second nil
)

(P skip-third
   =goal>
      isa study-words
      position third

   =wm>
      isa study-words
      third nil
==>
   =goal>
      isa study-words
      position fourth

   =wm>
      isa study-words
      third nil
)

(P skip-fourth
   =goal>
      isa study-words
      position fourth

   =wm>
      isa study-words
      fourth nil
==>
   =goal>
      isa study-words
      position first

   =wm>
      isa study-words
      fourth nil
)

;;;;;;;;;;;;;;;;;;; Recall Phase ;;;;;;;;;;;;;;;;;;;;;;;

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

(p retrieve
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

(p harvest
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

(p harvest-first
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
)

(p harvest-second
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
)

(p harvest-third
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
)

(p harvest-fourth
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

)
