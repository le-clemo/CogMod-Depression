

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
   :rt 2.5 ; retrieval threshold (default = 0, Anderson model = 3.2)
   :v t ; enable/disable trace
   ;:lf 1 ; latency-factor (default = 1, Anderson model = 2)
   :trace-detail low ; set level of trace detail
   :act nil ;t/medium/low/nil ;;tracing activation values
   :show-focus t ; show location of visual focus
   :er t ; Makes it so ties in productions are determined randomly (nil = fixed order)
   :bll 0.5 ; Set base-level learning (decay parameter), more frequently/recently retrieved items gain higher activation (default = 0.5)
   :esc t ; use subsymbolic processing
   :auto-attend t ; visual location requests are automatically accompanied by a request to move attention to the location found
   :declarative-num-finsts 30 ; number of items that are kept as recently retrieved  (CSM: 20)
   :declarative-finst-span 30 ; how long items stay in the recently-retrieved state (CSM: 17)
   :ans 0.5 ; activation noise (default = nil, recommended: 0.2 - 0.8, Anderson model = 0.7)
   :egs 0.1 ; noise in utility computation
   :dat 0.05 ; set to its default value (0.05)
   :ol nil ; use base-level equation that requires complete history of a chunk (instead of formula that uses an approximation)
   :model-warnings nil
   #| :visual-onset-span 0.5 ;visual scene change can be noticed up to x seconds after it appeared (default = 0.5) |#
   :unstuff-visual-location nil
   #| :lf 0.8 |# ;as an alternative to visual-onset-span, try this (to reduce the time retrievals take) (default = 1)
   :mp 3.8
#|    :md -1
   :ms 0 |#
)

 
(chunk-type study-words state context first valence1 second valence2 third valence3 fourth valence4 position)
(chunk-type memory word valence context)
(chunk-type goal state context)
(chunk-type recall state context first valence1 second valence2 third valence3 fourth valence4 position)
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
   (context isa chunk)
   (subgoal1 isa chunk)
   (goal isa study-words state start context nil)
   (startrecall isa study-words state beginrecall)   
)

(P find-unattended-word
   =goal>
      isa         study-words
      state       start
      context 	   =context
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
)

(P high-first
   =goal>
      isa         study-words
      state       attend
      context 	   =context
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
   +imaginal>
      isa         memory
      word        =word   
      valence     =col
      context 	   =context
)

(P high-second
   =goal>
      isa         study-words
      state       attend
      context 	   =context
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
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context     
)

(P high-third
   =goal>
      isa         study-words
      state       attend
      context 	   =context
      third       nil
   =visual>
      value       =word
      color       =col       
   ?imaginal>
      state       free
==>
   =goal>
      state       memorize
      context 	  =context
      third       =word
      position    third
      valence3    =col
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
)

(P high-fourth
   =goal>
      isa         study-words
      state       attend
      context 	   =context
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
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
)

(P replace-first
   =goal>
      isa         study-words
      state       attend
      context 	   =context
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
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
)

(P replace-second
   =goal>
      isa         study-words
      state       attend
      context 	   =context
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
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
)

(P replace-third
   =goal>
      isa         study-words
      state       attend
      context 	   =context
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
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
)

(P replace-fourth
   =goal>
      isa         study-words
      state       attend
      context 	   =context
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
   +imaginal>
      isa         memory
      word        =word
      valence     =col
      context 	   =context
)

(P add-to-memory-1
   =goal>
      isa         study-words
      state       memorize
      context 	   =context
      first       =word
      valence1    =col
      position    first
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       reinforce
      context 	   =context
      first       =word
      valence1    =col
      position    first  
)

(P add-to-memory-2
   =goal>
      isa         study-words
      state       memorize
      context 	   =context
      second      =word
      valence2    =col
      position    second
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       reinforce
      context 	   =context
      second      =word
      valence2    =col
      position    second  
)

(P add-to-memory-3
   =goal>
      isa         study-words
      state       memorize
      context 	   =context
      third       =word
      valence3    =col
      position    third
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       reinforce
      context 	   =context
      third       =word
      valence3    =col
      position    third  
)

(P add-to-memory-4
   =goal>
      isa         study-words
      state       memorize
      context 	   =context
      fourth      =word
      valence4    =col
      position    fourth
   =imaginal>
      isa         memory
      word        =word
==>
   =goal>
      isa         study-words
      state       reinforce
      context 	   =context
      fourth      =word
      valence4    =col
      position    fourth  
)


(P reinforce-new-word-1
	=goal>
		isa 		   study-words
		state 		reinforce
		context 	   =context
		first 		=word
		valence1 	=col
		position 	first
==>
	=goal>
		state 		subgoal1
		context 	   =context
		position 	nil
		target 		=word
	+retrieval>
		isa 		   memory
      context     =context
		word 		   =word
		valence 	   =col
)

(P reinforce-new-word-2
	=goal>
		isa 		   study-words
		state 		reinforce
		context 	   =context
		second 		=word
		valence2 	=col
		position 	second
==>
	=goal>
		state 		subgoal1
		context 	   =context
		position 	nil
		target 		=word
	+retrieval>
		isa 		   memory
      context     =context
		word 		   =word
		valence 	   =col
)

(P reinforce-new-word-3
	=goal>
		isa 		   study-words
		state 		reinforce
		context 	   =context
		third 		=word
		valence3 	=col
		position 	third
==>
	=goal>
		state 		subgoal1
		context 	   =context
		position 	nil
		target 		=word
	+retrieval>
		isa 		   memory
      context     =context
		word 		   =word
		valence 	   =col
)

(P reinforce-new-word-4
	=goal>
		isa 		   study-words
		state 		reinforce
		context 	   =context
		fourth 		=word
		valence4 	=col
		position 	fourth
==>
	=goal>
		state 		subgoal1
		context 	   =context
		position 	nil
		target 		=word
	+retrieval>
		isa 		   memory
      context     =context
		word 		   =word
		valence     =col
)




(P rehearse-first
   =goal>
      isa         study-words
      state       rehearse
      context 	   =context
      first       =word
      valence1    =col
      ;position    first
==>
   =goal>
      state       subgoal1
      context 	   =context
      target      =word
      ;position    second
   +retrieval>
      isa         memory
      context     =context
      word        =word  
      valence     =col  
)

(P rehearse-second
   =goal>
      isa         study-words
      state       rehearse
      context 	   =context
      second      =word
      valence2    =col      
      ;position    second
==>
   =goal>
      state       subgoal1
      context 	   =context
      target      =word
      ;position    third
   +retrieval>
      isa         memory
      context     =context   
      word        =word   
      valence     =col
)

(P rehearse-third
   =goal>
      isa         study-words
      state       rehearse
      context 	   =context
      third       =word 
      valence3    =col      
      ;position    third
==>
   =goal>
      state       subgoal1
      context 	   =context
      target      =word
      ;position    fourth
   +retrieval>
      isa         memory
      context     =context   
      word        =word  
      valence     =col
)

(P rehearse-fourth
   =goal>
      isa         study-words
      state       rehearse
      context 	   =context
      fourth      =word
      valence4    =col        
      ;position    fourth
==>
   =goal>
      state       subgoal1
      context 	   =context
      target      =word
      ;position    first
   +retrieval>
      isa         memory
      context     =context  
      word        =word  
      valence     =col
)


(P rehearse-first-default
   =goal>
	  isa 	  	   study-words
	  context 	   =context
	  state 	      rehearse
	  ;position     first
==>
   =goal>
   	isa 		   study-words
   	context 	   =context
      state       rehearse
      ;position    second
)

(P rehearse-second-default
   =goal>
	  isa 	  	   study-words
	  context 	   =context
	  state 	      rehearse
	  ;position     second
==>
   =goal>
   	isa 		   study-words
   	context 	   =context
      state       rehearse
      ;position    third
)

(P rehearse-third-default
   =goal>
	  isa 	  	   study-words
	  context 	   =context
	  state 	      rehearse
	  ;position     third
==>
   =goal>
   	isa 		   study-words
   	context 	   =context
      state       rehearse
      ;position    fourth
)

(P rehearse-fourth-default
   =goal>
	  isa 	  	   study-words
	  context 	   =context
	  state 	      rehearse
	  ;position     fourth
==>
   =goal>
   	isa 		   study-words
   	context 	   =context
      state       rehearse
      ;position    first
)


(P rehearse-it 
   =goal>
      state       subgoal1
      context 	   =context
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
      context 	   =context
      state       rehearse
      ;position    =pos
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context 	   =context

   !eval! ("rehearsed-word" =word)
   !output! (=word)         
)

(P rehearse-it-wrong-word 
   =goal>
      state       subgoal1
      context     =context
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
      state       rehearse
      ;position    =pos
   +imaginal>
      isa         memory
      word        =word
      valence     =col   
      context     =context

   !eval! ("rehearsed-word" =word)
   !output! (=word)         
)


#| (P i-am-running-instead
	=goal>
		state 	subgoal1
		context =context
	=imaginal>
		state 	free
==>
	=goal>
		state 	rehearse
		context =context
)
 |#



(P forget-word-1
	=goal>
	   state 	  subgoal1
      target     =word
      first      =word
	   context 	  =context
	   ;position   second
	?retrieval>
		buffer 	  failure
==>
	=goal>
	   isa 		  study-words
	   state   	  rehearse
	   context 	  =context
	   first 	  nil
      valence1   nil
	   ;position   second
)

(P forget-word-2
	=goal>
	   state 	  subgoal1
      target     =word
      second     =word
	   context 	  =context
	   ;position   third
	?retrieval>
		buffer 	  failure
==>
	=goal>
	   isa 		  study-words
	   state   	  rehearse
	   context 	  =context
	   second 	  nil
      valence2   nil
	   ;position   third
)

(P forget-word-3
	=goal>
	   state 	  subgoal1
      target     =word
      third      =word
	   context 	  =context
	   ;position   fourth
	?retrieval>
		buffer 	  failure
==>
	=goal>
	   isa 		  study-words
	   state   	  rehearse
	   context 	  =context
	   third 	  nil
      valence3   nil
	   ;position   fourth
)

(P forget-word-4
	=goal>
	   state 	  subgoal1
      target     =word
      fourth     =word
	   context 	  =context
	   ;position   first
	?retrieval>
		buffer 	  failure
==>
	=goal>
	   isa 		  study-words
	   state   	  rehearse
	   context 	  =context
	   fourth 	  nil
      valence4   nil
	   ;position   first
)



(P attend-new-word
   =goal>
      isa         study-words
      state       rehearse
      context 	   =context
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
    ;!output! (=context)
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;; #| Recall Starts Below |# ;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;; #| Recall Starts Below |# ;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;; #| Recall Starts Below |# ;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



(p start-recall
   =goal>
      isa         study-words
      state       beginrecall
#|       first       =word1 
      second      =word2 
      third       =word3 
      fourth      =word4  |#
      ;context 	   =context 
==>
   =goal>    
      isa         recall
      state       retrieve
#|       first       =word1 
      second      =word2 
      third       =word3 
      fourth      =word4 |#
      ;context 	   =context
      position	   first
) 

(P start-recall-no-WM
   =goal>
      isa         study-words
      state       beginrecall
      first       nil
      second      nil
      third       nil
      fourth      nil
==>
   =goal>
      isa         recall
      state       retrieve
      position    nil

)

(p retrieve-first
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      first       =word
      valence1    =col
      position    first
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       dump
      context 	   =context 
      position    first
   +retrieval>
      isa         memory
      context 	   =context
      word        =word
      valence     =col
)

(p retrieve-second
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      second      =word
      valence2    =col
      position    second
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       dump
      context 	   =context   
      position    second
   +retrieval>
      isa         memory
      context 	   =context
      word        =word
      valence     =col
)

(p retrieve-third
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      third       =word
      valence3    =col
      position    third
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       dump
      context 	   =context
      position    third   
   +retrieval>
      isa         memory
      context 	   =context
      word        =word
      valence     =col
)

(p retrieve-fourth
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      fourth      =word
      valence4    =col
      position    fourth
   ?retrieval>
      buffer      empty
      state       free 
==>
   =goal>
      isa         recall
      state       dump
      context 	   =context  
      position    fourth
   +retrieval>
      isa         memory
      context 	   =context
      word        =word
      valence     =col
)

(p retrieve-first-empty
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

(p retrieve-second-empty
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

(p retrieve-third-empty
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

(p retrieve-fourth-empty
	=goal>
	   isa         recall
      state       retrieve
      position    fourth
==>
	=goal>
      isa         recall
      state       retrieve
      position    nil
)


(P retrieval-failure-1
   =goal>
      isa         recall
      state       dump
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
      state       dump
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
      state       dump
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
      state       dump
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
      state       dump
      first       =word
      context 	   =context 
      position    first     
   =retrieval>
      isa         memory 
      word        =word
      context	   =context
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    second
   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)

(p recall-second
   =goal>
      isa         recall
      state       dump
      second      =word
      context 	   =context   
      position    second   
   =retrieval>
      isa         memory 
      word        =word
      context 	   =context
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    third
   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)

(p recall-third
   =goal>
      isa         recall
      state       dump
      third       =word
      context 	   =context   
      position    third   
   =retrieval>
      isa         memory 
      word        =word
      context     =context
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    fourth
   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)

(p recall-fourth
   =goal>
      isa         recall
      state       dump
      fourth      =word
      context 	   =context    
      position    fourth  
   =retrieval>
      isa         memory 
      word        =word
      context 	   =context
==>
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
      position    nil
   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
)


(p retrieve-a-word
   =goal>
      isa         recall
      state       retrieve
      context 	   =context
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
      context 	   =context
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
      context     =context
==>
   =goal>
      isa         recall
      state       retrieve
   !eval! ("retrieved-word" =word =context)
   !output! (=word =context)
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

#| (spp high-first :at 0.2) ; from firing high-n to the end of add-to-memory-n it now takes the value set here for :at + 0.1 sec
(spp high-second :at 0.2)
(spp high-third :at 0.2)
(spp high-fourth :at 0.2)

(spp replace-first :at 0.2) ; from firing replace-n to the end of add-to-memory-n it now takes the value set here for :at + 0.1 sec
(spp replace-second :at 0.2)
(spp replace-third :at 0.2)
(spp replace-fourth :at 0.2) |#

#| (spp add-to-memory-1 :at 0.2) ; Anderson = 0.2
(spp add-to-memory-2 :at 0.2)
(spp add-to-memory-3 :at 0.2)
(spp add-to-memory-4 :at 0.2) |#

#| (spp rehearse-it :u 5 :at 0.5) ; Anderson = :at 0.5 |#
(spp attend-new-word :u 100) ; ensure new words are always attended
#| (spp no-new-word :u 0 :at 0.01) |#

(spp rehearse-first :u 1); :at 0.3)
(spp rehearse-second :u 1); :at 0.3)
(spp rehearse-third :u 1); :at 0.3)
(spp rehearse-fourth :u 1); :at 0.3)
(spp rehearse-first-default :u 0.7) ; to make it very unlikely the model defaults on rehearsing first item in WM
(spp rehearse-second-default :u 0.7) ; slightly more likely for each subsequent position (because time passes and model is occupied with recalling previous items)
(spp rehearse-third-default :u 0.7)
(spp rehearse-fourth-default :u 0.7) ; but likelihood to default on any of them should be pretty low

;utility noise (:egs) is set to 0.1
(spp retrieve-first :u 1)
(spp retrieve-second :u 1)
(spp retrieve-third :u 1)
(spp retrieve-fourth :u 1)
#| (spp retrieve-first-default :u 0.6) ; to make it very unlikely the model defaults on recalling first item in WM
(spp retrieve-second-default :u 0.6) ; slightly more likely for each subsequent position (because time passes and model is occupied with recalling previous items)
(spp retrieve-third-default :u 0.6)
(spp retrieve-fourth-default :u 0.6) ; but likelihood to default on any of them should be pretty low |#

#| (spp retrieval-failure-1 :at 0.01)
(spp retrieval-failure-2 :at 0.01)
(spp retrieval-failure-3 :at 0.01)
(spp retrieval-failure-4 :at 0.01) |#

(spp forget-word-1 :u -10)
(spp forget-word-2 :u -10)
(spp forget-word-3 :u -10)
(spp forget-word-4 :u -10)

(spp recall-first :at 0.5) ; Anderson = 0.5
(spp recall-second :at 0.5)
(spp recall-third :at 0.5)
(spp recall-fourth :at 0.5)

(spp recall-a-word :at 0.5) ; Anderson model = 0.5

(spp rehearse-it-wrong-word :u -10)

(spp retrieve-a-word :u 10)
(spp stop-recall :u 0)

#| (set-all-base-levels 500 -1000) ;settings in Anderson's Murdock model --> 500 -1000 |#
(goal-focus goal)

)

