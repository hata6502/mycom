		is_word(IS_NOP), -- Wait for the power steady
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
	
		-- Program
			is_word(IS_READ, ORG_BOOT+26),	-- 0
			is_word(IS_WRITE, 128),	-- 1
			is_word(IS_READ, ORG_BOOT+24), 	-- 2
			is_word(IS_WRITE, 129), 	-- 3
			is_word(IS_READ, ORG_BOOT+25),	-- 4
			is_word(IS_WRITE, 131),	-- 5

		-- *label_0
				is_word(IS_NOP),	-- 6
				is_word(IS_NOP),	-- 7
				is_word(IS_NOP),	-- 8
				is_word(IS_READ, ORG_BOOT+33),	-- 9
				is_word(IS_WRITE, 130),	-- 10
				is_word(IS_READ, ORG_BOOT+28),	-- 11
				is_word(IS_WRITE, 0),	-- 12
			-- *label_1
				is_word(IS_READ, 132),	-- 13
				is_word(IS_ADD, ORG_BOOT+29),	-- 14
				is_word(IS_WRITE, 132),	-- 15
				is_word(IS_READ, 129),	-- 16
				is_word(IS_ADD, ORG_BOOT+30),	-- 17
				is_word(IS_WRITE, 129),	-- 18
			is_word(IS_AND, 16777215),	-- 19
			is_word(IS_NEQ, ORG_BOOT+31),	-- 20
			is_word(IS_BRANCH, ORG_BOOT+6),	-- 21
			
		-- *label_2
			is_word(IS_READ, ORG_BOOT+32),	-- 22
			is_word(IS_WRITE, 0),	-- 23
			
		-- Data
			is_word(IS_WRITE, 1536),	-- 24
			is_word(IS_WRITE, 0), -- 25
			is_word(IS_READ, 132),	-- 26
			is_word(IS_READ, 0),	--27
			128,	-- 28
			1,	-- 29
			1,	-- 30
			2048,	-- 31
			ORG_BOOT + 22, -- 32
			is_word(IS_READ, ORG_BOOT+34), -- 33	
			ORG_BOOT+13,	-- 34

		is_word(IS_NOP),
		is_word(IS_NOP),
		is_word(IS_NOP),
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		IS_NOP, 0, 
		256,
		35