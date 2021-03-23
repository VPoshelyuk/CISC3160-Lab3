calculate_grade:
	# 1. Process yacc grammar file 
	yacc -d grade_calc.y
	
	# 2. Process the lex specification file
	lex grade_calc.l

	# 3. Compile and link to program name calc
	cc y.tab.c lex.yy.c -o grade_calc

	# 4. Run calc program
	./grade_calc