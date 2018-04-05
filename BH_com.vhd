library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BH_com is
    Port ( A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           C : out  STD_LOGIC_VECTOR (15 downto 0);
                          clk : in STD_LOGIC);
end BH_com;

architecture Behavioral of BH_com is
	function conv_integer(L: BOOLEAN) return integer is 
		begin 
         if L then 
             return(1); 
         else 
             return(0); 
         end if; 
	end function; 
	
	function is_word(inst: integer) return integer is 
		begin 
		return (inst*16777216);
	end function;
	function is_word(inst: integer; operand: integer) return integer is 
		begin 
		return (inst*16777216 + operand);
	end function; 

	signal clkcnt: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	
	-- CPU
	signal cpu_pc: integer := 256;
	signal cpu_stat: integer := 0;
	signal cpu_inst: integer;
	signal cpu_sp: integer := 16777216;

	signal cpu_addr: integer;
	signal cpu_raddr: integer;
	signal cpu_waddr: integer;
	
	signal cpu_rdata: integer;
	signal cpu_wdata: integer;
	signal cpu_opdata: integer;

	signal cpu_work: integer;
	type greg is array (0 to 127) of integer;
	signal cpu_greg: greg;
	
	-- Memory map
	constant ADDR_BOOT: integer := 256;
	constant SIZE_BOOT: integer := 256;

	constant ADDR_STACK: integer := 16776704;
	constant SIZE_STACK: integer := 512;

	-- Instruction
	constant IS_READ: integer := 0;
	constant IS_WRITE: integer := 1;

	constant IS_ADD: integer := 2;
	constant IS_SUB: integer := 3;
	constant IS_MUL: integer := 4;
	constant IS_DIV: integer := 5;
	constant IS_AND: integer := 6;
	constant IS_OR: integer := 7;
	constant IS_XOR: integer := 8;

	constant IS_BRANCH: integer := 9;
	constant IS_EQ: integer := 10;	-- ==
	constant IS_NEQ: integer := 11;	-- !=
	constant IS_LT: integer := 12;	-- <
	constant IS_LTE: integer := 13;	-- <=
	constant IS_GT: integer := 14;	-- >
	constant IS_GTE: integer := 15;	--	>=

	-- Virtual instruction
	--constant IS_NOP: integer := IS_ADD;

	-- BOOT
	constant ORG_BOOT: integer := ADDR_BOOT+16;
	type prom is array (0 to 255) of integer;
	signal boot: prom := (
is_word(IS_ADD, 0), 	-- 256
is_word(IS_ADD, 0), 	-- 257
is_word(IS_ADD, 0), 	-- 258
is_word(IS_ADD, 0), 	-- 259
is_word(IS_ADD, 0), 	-- 260
is_word(IS_ADD, 0), 	-- 261
is_word(IS_ADD, 0), 	-- 262
is_word(IS_ADD, 0), 	-- 263
is_word(IS_ADD, 0), 	-- 264
is_word(IS_ADD, 0), 	-- 265
is_word(IS_ADD, 0), 	-- 266
is_word(IS_ADD, 0), 	-- 267
is_word(IS_ADD, 0), 	-- 268
is_word(IS_ADD, 0), 	-- 269
is_word(IS_ADD, 0), 	-- 270
is_word(IS_ADD, 0), 	-- 271
is_word(IS_ADD, 0), 	-- 272
is_word(IS_ADD, 0), 	-- 273
is_word(IS_ADD, 0), 	-- 274
is_word(IS_ADD, 0), 	-- 275
is_word(IS_ADD, 0), 	-- 276
is_word(IS_ADD, 0), 	-- 277
is_word(IS_ADD, 0), 	-- 278
is_word(IS_ADD, 0), 	-- 279
is_word(IS_ADD, 0), 	-- 280
is_word(IS_ADD, 0), 	-- 281
is_word(IS_ADD, 0), 	-- 282
is_word(IS_ADD, 0), 	-- 283
is_word(IS_ADD, 0), 	-- 284
is_word(IS_ADD, 0), 	-- 285
is_word(IS_ADD, 0), 	-- 286
is_word(IS_ADD, 0), 	-- 287
is_word(IS_READ, 511), 	-- 288
is_word(IS_WRITE, 2), 	-- 289
is_word(IS_READ, 510), 	-- 290
is_word(IS_WRITE, 2), 	-- 291
is_word(IS_READ, 509), 	-- 292
is_word(IS_WRITE, 2), 	-- 293
is_word(IS_READ, 508), 	-- 294
is_word(IS_WRITE, 507), 	-- 295
is_word(IS_READ, 506), 	-- 296
is_word(IS_WRITE, 2), 	-- 297
is_word(IS_READ, 505), 	-- 298
is_word(IS_WRITE, 2), 	-- 299
is_word(IS_READ, 504), 	-- 300
is_word(IS_WRITE, 2), 	-- 301
is_word(IS_READ, 503), 	-- 302
is_word(IS_WRITE, 502), 	-- 303
is_word(IS_READ, 501), 	-- 304
is_word(IS_WRITE, 500), 	-- 305
is_word(IS_READ, 34), 	-- 306
is_word(IS_READ, 84), 	-- 307
is_word(IS_READ, 69), 	-- 308
is_word(IS_READ, 83), 	-- 309
is_word(IS_READ, 84), 	-- 310
is_word(IS_READ, 32), 	-- 311
is_word(IS_READ, 45), 	-- 312
is_word(IS_READ, 45), 	-- 313
is_word(IS_READ, 32), 	-- 314
is_word(IS_READ, 83), 	-- 315
is_word(IS_READ, 117), 	-- 316
is_word(IS_READ, 98), 	-- 317
is_word(IS_READ, 114), 	-- 318
is_word(IS_READ, 111), 	-- 319
is_word(IS_READ, 117), 	-- 320
is_word(IS_READ, 116), 	-- 321
is_word(IS_READ, 105), 	-- 322
is_word(IS_READ, 110), 	-- 323
is_word(IS_READ, 101), 	-- 324
is_word(IS_READ, 32), 	-- 325
is_word(IS_READ, 119), 	-- 326
is_word(IS_READ, 105), 	-- 327
is_word(IS_READ, 116), 	-- 328
is_word(IS_READ, 104), 	-- 329
is_word(IS_READ, 32), 	-- 330
is_word(IS_READ, 72), 	-- 331
is_word(IS_READ, 97), 	-- 332
is_word(IS_READ, 114), 	-- 333
is_word(IS_READ, 100), 	-- 334
is_word(IS_READ, 119), 	-- 335
is_word(IS_READ, 97), 	-- 336
is_word(IS_READ, 114), 	-- 337
is_word(IS_READ, 101), 	-- 338
is_word(IS_READ, 32), 	-- 339
is_word(IS_READ, 83), 	-- 340
is_word(IS_READ, 116), 	-- 341
is_word(IS_READ, 97), 	-- 342
is_word(IS_READ, 99), 	-- 343
is_word(IS_READ, 107), 	-- 344
is_word(IS_READ, 32), 	-- 345
is_word(IS_READ, 45), 	-- 346
is_word(IS_READ, 45), 	-- 347
is_word(IS_READ, 34), 	-- 348
is_word(IS_READ, 0), 	-- 349
is_word(IS_READ, 34), 	-- 350
is_word(IS_READ, 83), 	-- 351
is_word(IS_READ, 116), 	-- 352
is_word(IS_READ, 114), 	-- 353
is_word(IS_READ, 105), 	-- 354
is_word(IS_READ, 110), 	-- 355
is_word(IS_READ, 103), 	-- 356
is_word(IS_READ, 32), 	-- 357
is_word(IS_READ, 119), 	-- 358
is_word(IS_READ, 111), 	-- 359
is_word(IS_READ, 32), 	-- 360
is_word(IS_READ, 68), 	-- 361
is_word(IS_READ, 105), 	-- 362
is_word(IS_READ, 115), 	-- 363
is_word(IS_READ, 112), 	-- 364
is_word(IS_READ, 108), 	-- 365
is_word(IS_READ, 97), 	-- 366
is_word(IS_READ, 121), 	-- 367
is_word(IS_READ, 32), 	-- 368
is_word(IS_READ, 115), 	-- 369
is_word(IS_READ, 117), 	-- 370
is_word(IS_READ, 114), 	-- 371
is_word(IS_READ, 117), 	-- 372
is_word(IS_READ, 32), 	-- 373
is_word(IS_READ, 83), 	-- 374
is_word(IS_READ, 117), 	-- 375
is_word(IS_READ, 98), 	-- 376
is_word(IS_READ, 114), 	-- 377
is_word(IS_READ, 111), 	-- 378
is_word(IS_READ, 117), 	-- 379
is_word(IS_READ, 116), 	-- 380
is_word(IS_READ, 105), 	-- 381
is_word(IS_READ, 110), 	-- 382
is_word(IS_READ, 101), 	-- 383
is_word(IS_READ, 32), 	-- 384
is_word(IS_READ, 119), 	-- 385
is_word(IS_READ, 111), 	-- 386
is_word(IS_READ, 32), 	-- 387
is_word(IS_READ, 116), 	-- 388
is_word(IS_READ, 117), 	-- 389
is_word(IS_READ, 107), 	-- 390
is_word(IS_READ, 117), 	-- 391
is_word(IS_READ, 116), 	-- 392
is_word(IS_READ, 116), 	-- 393
is_word(IS_READ, 97), 	-- 394
is_word(IS_READ, 46), 	-- 395
is_word(IS_READ, 32), 	-- 396
is_word(IS_READ, 115), 	-- 397
is_word(IS_READ, 111), 	-- 398
is_word(IS_READ, 114), 	-- 399
is_word(IS_READ, 111), 	-- 400
is_word(IS_READ, 115), 	-- 401
is_word(IS_READ, 111), 	-- 402
is_word(IS_READ, 114), 	-- 403
is_word(IS_READ, 111), 	-- 404
is_word(IS_READ, 32), 	-- 405
is_word(IS_READ, 67), 	-- 406
is_word(IS_READ, 32), 	-- 407
is_word(IS_READ, 67), 	-- 408
is_word(IS_READ, 111), 	-- 409
is_word(IS_READ, 109), 	-- 410
is_word(IS_READ, 112), 	-- 411
is_word(IS_READ, 105), 	-- 412
is_word(IS_READ, 108), 	-- 413
is_word(IS_READ, 101), 	-- 414
is_word(IS_READ, 114), 	-- 415
is_word(IS_READ, 32), 	-- 416
is_word(IS_READ, 119), 	-- 417
is_word(IS_READ, 111), 	-- 418
is_word(IS_READ, 32), 	-- 419
is_word(IS_READ, 116), 	-- 420
is_word(IS_READ, 117), 	-- 421
is_word(IS_READ, 107), 	-- 422
is_word(IS_READ, 117), 	-- 423
is_word(IS_READ, 114), 	-- 424
is_word(IS_READ, 105), 	-- 425
is_word(IS_READ, 116), 	-- 426
is_word(IS_READ, 97), 	-- 427
is_word(IS_READ, 105), 	-- 428
is_word(IS_READ, 46), 	-- 429
is_word(IS_READ, 32), 	-- 430
is_word(IS_READ, 34), 	-- 431
is_word(IS_READ, 0), 	-- 432
is_word(IS_READ, 2), 	-- 433
is_word(IS_WRITE, 499), 	-- 434
is_word(IS_ADD, 0), 	-- 435
is_word(IS_WRITE, 498), 	-- 436
is_word(IS_READ, 2), 	-- 437
is_word(IS_WRITE, 497), 	-- 438
is_word(IS_ADD, 0), 	-- 439
is_word(IS_WRITE, 496), 	-- 440
is_word(IS_READ, 128), 	-- 441
is_word(IS_WRITE, 495), 	-- 442
is_word(IS_ADD, 0), 	-- 443
is_word(IS_EQ, 494), 	-- 444
is_word(IS_BRANCH, 493), 	-- 445
is_word(IS_READ, 128), 	-- 446
is_word(IS_WRITE, 492), 	-- 447
is_word(IS_ADD, 0), 	-- 448
is_word(IS_WRITE, 129), 	-- 449
is_word(IS_READ, 128), 	-- 450
is_word(IS_ADD, 491), 	-- 451
is_word(IS_WRITE, 490), 	-- 452
is_word(IS_READ, 129), 	-- 453
is_word(IS_ADD, 489), 	-- 454
is_word(IS_WRITE, 488), 	-- 455
is_word(IS_READ, 487), 	-- 456
is_word(IS_WRITE, 486), 	-- 457
is_word(IS_READ, 2), 	-- 458
is_word(IS_WRITE, 485), 	-- 459
is_word(IS_ADD, 0), 	-- 460
is_word(IS_WRITE, 484), 	-- 461
0, 	-- 462
0, 	-- 463
0, 	-- 464
0, 	-- 465
0, 	-- 466
0, 	-- 467
0, 	-- 468
0, 	-- 469
0, 	-- 470
0, 	-- 471
0, 	-- 472
0, 	-- 473
0, 	-- 474
0, 	-- 475
0, 	-- 476
0, 	-- 477
0, 	-- 478
0, 	-- 479
0, 	-- 480
0, 	-- 481
0, 	-- 482
0, 	-- 483
0, 	-- 484
460, 	-- 485
0, 	-- 486
441, 	-- 487
129, 	-- 488
1, 	-- 489
128, 	-- 490
1, 	-- 491
448, 	-- 492
458, 	-- 493
0, 	-- 494
443, 	-- 495
129, 	-- 496
439, 	-- 497
128, 	-- 498
435, 	-- 499
0, 	-- 500
304, 	-- 501
0, 	-- 502
433, 	-- 503
350, 	-- 504
1280, 	-- 505
304, 	-- 506
0, 	-- 507
433, 	-- 508
306, 	-- 509
1024, 	-- 510
296	-- 511

	);
	
	-- Stack
	type stackram is array (0 to SIZE_STACK - 1) of integer;
	signal stack: stackram;
	--COMPONENT stack
	--  PORT (
	--	 a : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
	--	 d : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	--	 clk : IN STD_LOGIC;
	--	 we : IN STD_LOGIC;
	--	 spo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	--  );
	--END COMPONENT;
	--signal stack_a : STD_LOGIC_VECTOR(8 DOWNTO 0);
	--signal stack_d : STD_LOGIC_VECTOR(31 DOWNTO 0);
	--signal stack_clk : STD_LOGIC;
	--signal stack_we : STD_LOGIC;
	--signal stack_spo : STD_LOGIC_VECTOR(31 DOWNTO 0)
	
	-- VRAM
	COMPONENT vram
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 clkb : IN STD_LOGIC;
		 web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addrb : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		 doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	signal vram_1_clka : STD_LOGIC;
	signal vram_1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal vram_1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal vram_1_dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal vram_1_douta : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal vram_1_clkb : STD_LOGIC;
	signal vram_1_web : STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal vram_1_addrb : STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal vram_1_dinb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	signal vram_1_doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	-- CROM
	component crom is
    Port (
		chr: in std_logic_vector(6 downto 0);
		row: in std_logic_vector(2 downto 0);
		col: in std_logic_vector(2 downto 0);
		dot: out std_logic
	 );
	end component;
	signal crom_1_chr: std_logic_vector(6 downto 0);
	signal crom_1_row: std_logic_vector(2 downto 0);
	signal crom_1_col: std_logic_vector(2 downto 0);
	signal crom_1_dot: std_logic;
	
	-- PPU
	signal ppu_clkcnt: integer := 0;
	signal ppu_linecnt: integer := 0;

	signal stat_vsync: std_logic;
	signal stat_hsync: std_logic;

	signal lum: std_logic;
begin 

	process(clk) begin
		if (rising_edge(clk)) then
			clkcnt <= clkcnt + 1;
		end if;
	end process;

	-- CPU
	process(clk)
	variable inst: integer;
	variable operand: integer;
	begin
		if (rising_edge(clk)) then
			case cpu_stat is
				when 0 =>	-- Read instruction
					inst := cpu_rdata/16777216;
					operand := cpu_rdata mod 16777216;
					
					cpu_inst <= inst;
					cpu_pc <= cpu_pc + 1;
					
					cpu_raddr <= operand;
					if (operand = 2) then
						case inst is
							when IS_WRITE =>
								cpu_sp <= cpu_sp - 1;
							when others =>
						end case;
					end if;

					cpu_stat <= 1;
				when 1 =>	-- Read Memory
					cpu_opdata <= cpu_rdata;
					
					if (cpu_raddr = 2) then
						case cpu_inst is
							when IS_READ|IS_ADD|IS_SUB|IS_MUL|IS_DIV|IS_AND|IS_OR|IS_XOR|IS_EQ|IS_NEQ|IS_LT|IS_LTE|IS_GT|IS_GTE|IS_BRANCH =>
								cpu_sp <= cpu_sp + 1;
							when others =>
						end case;
					end if;

					cpu_stat <= 2;
				when 2 =>	-- Operation
					operand := cpu_opdata mod 16777216;

					case cpu_inst is
						when IS_READ =>
							cpu_wdata <= cpu_opdata;
							cpu_waddr <= 1;
						when IS_WRITE =>
							cpu_wdata <= cpu_work;
							cpu_waddr <= operand;
							
						when IS_ADD =>
							cpu_wdata <= cpu_work + cpu_opdata;
							cpu_waddr <= 1;
						when IS_SUB =>
							cpu_wdata <= cpu_work - cpu_opdata;
							cpu_waddr <= 1;
						when IS_MUL =>
							cpu_wdata <= cpu_work * cpu_opdata;
							cpu_waddr <= 1;
						when IS_DIV =>
							--cpu_wdata <= cpu_work / cpu_opdata;
							cpu_waddr <= 1;
						when IS_AND =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, 32) and conv_std_logic_vector(cpu_opdata, 32));
							cpu_waddr <= 1;
						when IS_OR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, 32) or conv_std_logic_vector(cpu_opdata, 32));
							cpu_waddr <= 1;
						when IS_XOR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, 32) xor conv_std_logic_vector(cpu_opdata, 32));
							cpu_waddr <= 1;

						when IS_BRANCH =>
							if (cpu_work/=0) then
								cpu_wdata <= operand;
							else
								cpu_wdata <= cpu_pc;
							end if;
							cpu_waddr <= 0;
						when IS_EQ =>
							cpu_wdata <= conv_integer(cpu_work = cpu_opdata);
							cpu_waddr <= 1;
						when IS_NEQ =>
							cpu_wdata <= conv_integer(cpu_work /= cpu_opdata);
							cpu_waddr <= 1;
						when IS_LT =>
							cpu_wdata <= conv_integer(cpu_work < cpu_opdata);
							cpu_waddr <= 1;
						when IS_LTE =>
							cpu_wdata <= conv_integer(cpu_work <= cpu_opdata);
							cpu_waddr <= 1;
						when IS_GT =>
							cpu_wdata <= conv_integer(cpu_work > cpu_opdata);
							cpu_waddr <= 1;
						when IS_GTE =>
							cpu_wdata <= conv_integer(cpu_work >= cpu_opdata);
							cpu_waddr <= 1;
						when others =>
					end case;
							
					cpu_stat <= 3;
				when 3 =>	-- Write memory
					--case cpu_inst is
						--when IS_READ|IS_WRITE|IS_ADD|IS_SUB|IS_MUL|IS_DIV|IS_AND|IS_OR|IS_XOR| =>
							if (cpu_waddr=0) then
								cpu_pc <= cpu_wdata;
							elsif (cpu_waddr=1) then
								cpu_work <= cpu_wdata;
							elsif (cpu_waddr=2) then
								cpu_sp <= cpu_wdata;
							elsif (cpu_waddr>=128 and cpu_waddr<=255) then
								cpu_greg((cpu_waddr - 128)mod 128) <= cpu_wdata;
							elsif (cpu_waddr>=256 and cpu_waddr<=511) then
								boot((cpu_waddr - 256)mod 256) <= cpu_wdata;
							elsif (cpu_waddr>=1024 and cpu_waddr<=2047) then
								vram_1_addrb <= CONV_std_logic_vector(((cpu_waddr-1024)/32 mod 32)*32 + ((cpu_waddr-1024)mod 32), 10);
								vram_1_dinb <= CONV_std_logic_vector(cpu_wdata, 8);
							elsif (cpu_waddr>=ADDR_STACK and cpu_waddr<ADDR_STACK + SIZE_STACK) then
								stack((cpu_waddr - ADDR_STACK)mod SIZE_STACK) <= cpu_wdata;
							end if;
						--when others =>
					--end case;
							
					cpu_stat <= 0;
				when others =>
			end case;
		end if;
	end process;
	
	cpu_addr <= cpu_pc when cpu_stat=0
		else cpu_raddr when cpu_stat=1;

	cpu_rdata <= cpu_pc when cpu_addr=0
		else cpu_work when cpu_addr=1
		else cpu_sp when cpu_addr=2
		else cpu_greg((cpu_addr - 128) mod 128) when cpu_addr>=128 and cpu_addr<=255
		else boot((cpu_addr - ADDR_BOOT) mod SIZE_BOOT) when cpu_addr>=ADDR_BOOT and cpu_addr<(ADDR_BOOT + SIZE_BOOT)
		else stack((cpu_addr - ADDR_STACK) mod SIZE_STACK) when cpu_addr>=ADDR_STACK and cpu_addr<(ADDR_STACK + SIZE_STACK);
	
	-- PPU
	process(clk) begin
		if (rising_edge(clk)) then
			case ppu_clkcnt is
				when 2032 =>
					ppu_clkcnt <= 0;
					
					case ppu_linecnt is
						when 262 =>
							ppu_linecnt <= 0;
						when others =>
							ppu_linecnt <= ppu_linecnt + 1;
					end case;
					
				when others =>
					ppu_clkcnt <= ppu_clkcnt + 1;
			end case;
		end if;
	end process;
	
	stat_vsync <= '1' when ppu_linecnt<3 else '0';
	stat_hsync <= '1' when ppu_clkcnt<150 else '0';
	
	lum <= crom_1_dot;

	A(0) <= '0' when (stat_vsync='0' and stat_hsync='1') or (stat_vsync='1' and ppu_clkcnt>=150) else '1';
	A(1) <= lum when stat_vsync='0' and stat_hsync='0' and ppu_clkcnt>511 and ppu_clkcnt<1536 and ppu_linecnt>=32 else '0';
	A(15 downto 2) <= "00000000000000";
	B <= "0000000000000000";
	C <= "0000000000000000";

	-- Stack
	--stack_1 : stack
	--  PORT MAP (
	--	 a => stack_a,
	--	 d => stack_d,
	--	 clk => stack_clk,
	--	 we => stack_we,
	--	 spo => stack_spo
	--  );
	--stack_clk <= clk;
	--stack_a <= conv_std_logic_vector(cpu_addr, 9);
	
	-- VRAM
	vram_1 : vram
	  PORT MAP (
		 clka => vram_1_clka,
		 wea => vram_1_wea,
		 addra => vram_1_addra,
		 dina => vram_1_dina,
		 douta => vram_1_douta,
		 clkb => vram_1_clkb,
		 web => vram_1_web,
		 addrb => vram_1_addrb,
		 dinb => vram_1_dinb,
		 doutb => vram_1_doutb
	  );
	  vram_1_clka <= clk;
	  vram_1_wea <= "0";
	  vram_1_addra <= CONV_std_logic_vector(((ppu_linecnt-32)/8 mod 32)*32 + ((ppu_clkcnt -512 + 1)/4/8 mod 32), 10);
	  vram_1_clkb <= clk;
	  vram_1_web <= "1";
	  
	  -- CROM
	crom_1: crom port map (
		chr => crom_1_chr,
		row => crom_1_row,
		col => crom_1_col,
		dot => crom_1_dot
	 );
	 crom_1_chr <= vram_1_douta(6 downto 0);
	 crom_1_row <= conv_std_logic_vector(ppu_linecnt, 3);
	 crom_1_col <= conv_std_logic_vector(ppu_clkcnt/4, 3);

end Behavioral;
