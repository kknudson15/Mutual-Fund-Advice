;*************************************************************************************************************
;* Programmer: Kyle Knudson                                                                                  *                      
;*                                                                                                           *   
;* Title: Mutal Funds advice program                                                                         *       
;*                                                                                                           *                       
;*                                                                                                           *                          
;* Date: 2/20/19                                                                                             *                   
;*                                                                                                           *                       
;* Description:                                                                                              *                           
;* Write a program that gives advice on investing in mutual funds The output of the program                  *           
;* should indicate the percentage of money to be invested in fixed-income funds; funds mainly                *               
;* investing in bonds and preferred stocks; and stock funds,fundswith higher risk but greater                *           
;*  potential returns.The percentages will be determined by "scoring" the amount of risk the                 *               
;* investor is willing to take beds on the response to questions.                                            *               
;*                                                                                                           *           
;* If the investor is 29 years old or younger, add 4 to the score; 30 - 39 add 3; 40 -49 add 2;              *       
;* 50-59 add 1; and 60 or more, add 0.                                                                       *                   
;* If the investor has 0 to 9 years until retirement, add 0; 10-14 add 1; 15-19 add 2; 20-24                 *                                                
;* add 3; and 25 or more add 4.                                                                              *               
;* If the investor is willing to ride out losses of only 5% or less add 0; 6%-10% add 1; 11%-15%             *                                                     
;* add 2; 16% or more add 3.                                                                                 *       
;* If the investor is very knowledgeable, add 4 to the score;if somewhat knowledgeable add 2;                *               
;* if not knowledgeable add 0 to the score;                                                                  *           
;* If the investor is willing to take significant risk for higher possible returns add 4 to the score;       *           
;* if some risk add 2; and if little risk add 0.                                                             *           
;* If the investor believes his or her retirement goals will be met given his or her current income and      *           
;* assets add 4 to the score; if the goals might possibly be met add 2; if the goals are unlikely to be      *           
;* met add 0.                                                                                                *               
;* If the final score is more than 20 points, then 100% of the investments should be in stock funds;         *                           
;* If 16-20 points 80% should be in stock funds and 20% in fixed-income funds;                               *           
;* If 11-15 points, 60% should be in stock funds and 40% in fixed-income funds;                              *           
;* if 6-10 points, then 40% should be in stock funds and 60% in fixed-income funds;                          *           
;* if 0-5 points, then 20% should be in stock funds and 80% in fixed-income funds;                           *               
;*************************************************************************************************************



;**********************************
;deftemplate                      *
;**********************************
(deftemplate investor 
    (slot name)
    (slot age)
    (slot years-until-retirement)
    (slot loss-percentage)
    (multislot knowledge)
    (slot risk)
    (slot retirement-goal)
)

;**********************************
;deffacts                         *
;**********************************

(deffacts initial-information
(score 0))


;**********************************
;defrules                         *
;**********************************

(defrule get-name 
(declare(salience 50))
=>

(printout t "Welcome to Kyle's Mutual Fund Adivsory Program!" crlf)
(printout t "---------------------------------------------------------------------------------------" crlf)
(printout t "First off, no need to be strangers, what is your name?" crlf)
(bind ?response(read))
f2<- (assert(investor (name ?response))))

(defrule get-age
=> 
(printout t "How old are you?" crlf)
(bind ?age(read))
(modify 2 (age ?age))
)

(defrule get-years-to-retirement
=> 
(printout t "How many years until you retire?" crlf)
(bind ?retirement-years(read))
(modify 2 (years-until-retirement ?retirement-years))
)

(defrule get-losses
=> 
(printout t "What is the max percentage of losses you are willing to ride out?" crlf)
(bind ?loss(read))
(modify 2 (loss-percentage ?loss))
)

(defrule get-knowledge-level
=> 
(printout t "How knowledgeable about investments and the stock market are you? (Very, Somewhat, Little)" crlf)
(bind ?knowledge(read))
(modify 2 (knowledge ?knowledge))
)

(defrule get-retirement-goals-met
=> 
(printout t "How likely are your retirement goals to be met by your current income? (Likely, Possible, Unlikely)" crlf)
(bind ?goals(read))
(modify 2 (retirement-goal ?goals))
)

(defrule get-risk-taker
=> 
(printout t "What level of risk are you willing to take, with more risk potentially netting greater returns? (High, Medium, Little)" crlf)
(bind ?risk-take(read))
(modify 2 (risk ?risk-take))
)


;* If the investor is 29 years old or younger, add 4 to the score; 30 - 39 add 3; 40 -49 add 2;              *       
;* 50-59 add 1; and 60 or more, add 0.  

(defrule sum-score-age
(declare (salience -20))
(investor (age ?age&~nill))
=> 
(if (<= ?age 29)
then
(assert (add-to-sum 4)))

(if (and(> ?age 29) (< ?age 40))
then 
(assert (add-to-sum 3)))

(if (and(> ?age 39) (< ?age 50))
then 
(assert (add-to-sum 2)))

(if (and(> ?age 49) (< ?age 60))
then 
(assert (add-to-sum 1)))
)


;* If the investor has 0 to 9 years until retirement, add 0; 10-14 add 1; 15-19 add 2; 20-24                 *                                                
;* add 3; and 25 or more add 4.  

(defrule sum-retirement
(declare (salience -20))
(investor (years-until-retirement ?yur&~nill))
=> 
(if (<= ?yur 9)
then
(assert (add-to-sum 0)))

(if (and(> ?yur 9) (< ?yur 15))
then 
(assert (add-to-sum 1)))

(if (and(> ?yur 14) (< ?yur 20))
then 
(assert (add-to-sum 2)))

(if (and(> ?yur 19) (< ?yur 25))
then 
(assert (add-to-sum 3)))

(if (> ?yur 24) 
then 
(assert (add-to-sum 4)))
)


 ;If the investor is willing to ride out losses of only 5% or less add 0; 6%-10% add 1; 11%-15%             *                                                     
;* add 2; 16% or more add 3.   

(defrule sum-loss-percentage
(declare (salience -20))
(investor (loss-percentage ?lp&~nill))
=> 
(if (<= ?lp 5)
then
(assert (add-to-sum 0)))

(if (and(> ?lp 5) (< ?lp 11))
then 
(assert (add-to-sum 1)))

(if (and(> ?lp 10) (< ?lp 16))
then 
(assert (add-to-sum 2)))

(if (> ?lp 15) 
then 
(assert (add-to-sum 3)))
)


;* If the investor is very knowledgeable, add 4 to the score;if somewhat knowledgeable add 2;                *               
;* if not knowledgeable add 0 to the score;  

(defrule sum-knowledge
(declare (salience -20))
(investor (knowledge ?knowledge&~nill))
=> 
(if (eq ?knowledge Very)
then
(assert (add-to-sum 4)))

(if (eq ?knowledge Somewhat)
then 
(assert (add-to-sum 2)))

(if (eq ?knowledge Little) 
then 
(assert (add-to-sum 0)))
)

;* If the investor is willing to take significant risk for higher possible returns add 4 to the score;       *           
;* if some risk add 2; and if little risk add 0.  

(defrule sum-risk
(declare (salience -20))
(investor (risk ?risk&~nill))
=> 
(if (eq ?risk High)
then
(assert (add-to-sum 4)))

(if (eq ?risk Medium)
then 
(assert (add-to-sum 2)))

(if (eq ?risk Little) 
then 
(assert (add-to-sum 0)))
)


;* If the investor believes his or her retirement goals will be met given his or her current income and      *           
;* assets add 4 to the score; if the goals might possibly be met add 2; if the goals are unlikely to be      *           
;* met add 0. 

(defrule sum-goals
(declare (salience -20))
(investor (retirement-goal ?rg&~nill))
=> 
(if (eq ?rg Likely)
then
(assert (add-to-sum 4)))

(if (eq ?rg Possible)
then 
(assert (add-to-sum 2)))

(if (eq ?rg Unlikely) 
then 
(assert (add-to-sum 0)))
)

(defrule sum-scores
?sum <- (score ?total)
?new-score <- (add-to-sum ?score)
=>
(retract ?sum ?new-score)
(assert (score (+ ?total ?score)))
)



;* If the final score is more than 20 points, then 100% of the investments should be in stock funds;         *                           
;* If 16-20 points 80% should be in stock funds and 20% in fixed-income funds;                               *           
;* If 11-15 points, 60% should be in stock funds and 40% in fixed-income funds;                              *           
;* if 6-10 points, then 40% should be in stock funds and 60% in fixed-income funds;                          *           
;* if 0-5 points, then 20% should be in stock funds and 80% in fixed-income funds;                           


(defrule advice
(declare (salience -100))
(score ?score)
=>
(if (>= ?score 20)
then 
(printout t "---------------------------------------------------------------------------------------" crlf)
(printout t "100% of your investments should be in stock funds" crlf))

(if (and (>= ?score 16) (< ?score 20))
then 
(printout t "---------------------------------------------------------------------------------------" crlf)
(printout t "80% of your investments should be in stock funds and 20% in fixed-income funds" crlf))

(if (and (>= ?score 11) (< ?score 16))
then 
(printout t "---------------------------------------------------------------------------------------" crlf)
(printout t "60% of your investments should be in stock funds and 40% in fixed-income funds" crlf))

(if (and (>= ?score 6) (< ?score 11))
then 
(printout t "---------------------------------------------------------------------------------------" crlf)
(printout t "40% of your investments should be in stock funds and 60% in fixed-income funds" crlf))

(if (and (>= ?score 0) (< ?score 6))
then 
(printout t "---------------------------------------------------------------------------------------" crlf)
(printout t "20% of your investments should be in stock funds and 80% in fixed-income funds" crlf))
)


;**********************************
;Test Runs                        *
;**********************************
;
;CLIPS> (clear)
;CLIPS> (load C:\\Users\\kylek\\Code\\expert-systems\\Mutual-Fund-Advice\\advice.clp)
;%$***************
;TRUE
;CLIPS> (reset)
;CLIPS> (run)
;Welcome to Kyle's Mutial Fund adivsory!
;---------------------------------------------------------------------------------------
;First off, no need to be strangers, what is your name?
;Kyle
;How old are you?
;25
;How many years until you retire?
;20
;What is the max percentage of losses you are willing to ride out?
;2
;How knowledgeable about investments and the stock market are you? (Very, Somewhat, Little)
;Somewhat
;How likely are your retirement goals to be met by your current income? (Likely, Possible, Unlikely)
;Possible
;What level of risk are you willing to take, with more risk potentially netting greater returns? (High, Medium, Little)
;High
;---------------------------------------------------------------------------------------
;60% of your investments should be in stock funds and 40% in fixed-income funds
;CLIPS> (clear)
;CLIPS> (load C:\\Users\\kylek\\Code\\expert-systems\\Mutual-Fund-Advice\\advice.clp)
;%$***************
;TRUE
;CLIPS> (reset)
;CLIPS> (run)
;Welcome to Kyle's Mutual Fund Adivsory Program!
;---------------------------------------------------------------------------------------
;First off, no need to be strangers, what is your name?
;John
;How old are you?
;68
;How many years until you retire?
;1
;What is the max percentage of losses you are willing to ride out?
;20
;How knowledgeable about investments and the stock market are you? (Very, Somewhat, Little)
;Somewhat
;How likely are your retirement goals to be met by your current income? (Likely, Possible, Unlikely)
;Likely
;What level of risk are you willing to take, with more risk potentially netting greater returns? (High, Medium, Little)
;Little
;---------------------------------------------------------------------------------------
;40% of your investments should be in stock funds and 60% in fixed-income funds
;CLIPS> (clear)
;CLIPS> (load C:\\Users\\kylek\\Code\\expert-systems\\Mutual-Fund-Advice\\advice.clp)
;%$***************
;TRUE
;CLIPS> (reset)
;CLIPS> (run)
;Welcome to Kyle's Mutual Fund Adivsory Program!
;---------------------------------------------------------------------------------------
;First off, no need to be strangers, what is your name?
;Kip
;How old are you?
;40
;How many years until you retire?
;15
;What is the max percentage of losses you are willing to ride out?
;6
;How knowledgeable about investments and the stock market are you? (Very, Somewhat, Little)
;Somewhat
;How likely are your retirement goals to be met by your current income? (Likely, Possible, Unlikely)
;Possible
;What level of risk are you willing to take, with more risk potentially netting greater returns? (High, Medium, Little)
;High
;---------------------------------------------------------------------------------------
;60% of your investments should be in stock funds and 40% in fixed-income funds
;CLIPS> (clear)
;CLIPS> (load C:\\Users\\kylek\\Code\\expert-systems\\Mutual-Fund-Advice\\advice.clp)
;%$***************
;TRUE
;CLIPS> (reset)
;CLIPS> (run)
;Welcome to Kyle's Mutual Fund Adivsory Program!
;---------------------------------------------------------------------------------------
;First off, no need to be strangers, what is your name?
;Joe
;How old are you?
;30
;How many years until you retire?
;26
;What is the max percentage of losses you are willing to ride out?
;15
;How knowledgeable about investments and the stock market are you? (Very, Somewhat, Little)
;Very
;How likely are your retirement goals to be met by your current income? (Likely, Possible, Unlikely)
;Likely
;What level of risk are you willing to take, with more risk potentially netting greater returns? (High, Medium, Little)
;High
;---------------------------------------------------------------------------------------
;100% of your investments should be in stock funds
;CLIPS> 