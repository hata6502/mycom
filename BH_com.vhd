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

	-- Instruction
	constant IS_WRITE: integer := 0;
	constant IS_READ: integer := 1;

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
is_word(IS_READ, 511), 	-- 256
is_word(IS_WRITE, 510), 	-- 257
is_word(IS_READ, 509), 	-- 258
is_word(IS_WRITE, 508), 	-- 259
is_word(IS_READ, 128), 	-- 260
is_word(IS_ADD, 507), 	-- 261
is_word(IS_WRITE, 506), 	-- 262
is_word(IS_ADD, 0), 	-- 263
is_word(IS_EQ, 505), 	-- 264
is_word(IS_BRANCH, 504), 	-- 265
is_word(IS_READ, 128), 	-- 266
is_word(IS_ADD, 503), 	-- 267
is_word(IS_WRITE, 502), 	-- 268
is_word(IS_ADD, 0), 	-- 269
is_word(IS_WRITE, 129), 	-- 270
is_word(IS_READ, 128), 	-- 271
is_word(IS_ADD, 501), 	-- 272
is_word(IS_WRITE, 500), 	-- 273
is_word(IS_READ, 129), 	-- 274
is_word(IS_ADD, 499), 	-- 275
is_word(IS_WRITE, 498), 	-- 276
is_word(IS_READ, 497), 	-- 277
is_word(IS_WRITE, 496), 	-- 278
is_word(IS_READ, 495), 	-- 279
is_word(IS_WRITE, 494), 	-- 280
is_word(IS_WRITE, 34), 	-- 281
is_word(IS_WRITE, 79), 	-- 282
is_word(IS_WRITE, 114), 	-- 283
is_word(IS_WRITE, 97), 	-- 284
is_word(IS_WRITE, 110), 	-- 285
is_word(IS_WRITE, 103), 	-- 286
is_word(IS_WRITE, 101), 	-- 287
is_word(IS_WRITE, 32), 	-- 288
is_word(IS_WRITE, 67), 	-- 289
is_word(IS_WRITE, 111), 	-- 290
is_word(IS_WRITE, 109), 	-- 291
is_word(IS_WRITE, 112), 	-- 292
is_word(IS_WRITE, 117), 	-- 293
is_word(IS_WRITE, 116), 	-- 294
is_word(IS_WRITE, 101), 	-- 295
is_word(IS_WRITE, 114), 	-- 296
is_word(IS_WRITE, 32), 	-- 297
is_word(IS_WRITE, 45), 	-- 298
is_word(IS_WRITE, 45), 	-- 299
is_word(IS_WRITE, 32), 	-- 300
is_word(IS_WRITE, 83), 	-- 301
is_word(IS_WRITE, 116), 	-- 302
is_word(IS_WRITE, 114), 	-- 303
is_word(IS_WRITE, 105), 	-- 304
is_word(IS_WRITE, 110), 	-- 305
is_word(IS_WRITE, 103), 	-- 306
is_word(IS_WRITE, 32), 	-- 307
is_word(IS_WRITE, 84), 	-- 308
is_word(IS_WRITE, 101), 	-- 309
is_word(IS_WRITE, 115), 	-- 310
is_word(IS_WRITE, 116), 	-- 311
is_word(IS_WRITE, 32), 	-- 312
is_word(IS_WRITE, 45), 	-- 313
is_word(IS_WRITE, 45), 	-- 314
is_word(IS_WRITE, 32), 	-- 315
is_word(IS_WRITE, 70), 	-- 316
is_word(IS_WRITE, 80), 	-- 317
is_word(IS_WRITE, 71), 	-- 318
is_word(IS_WRITE, 65), 	-- 319
is_word(IS_WRITE, 32), 	-- 320
is_word(IS_WRITE, 100), 	-- 321
is_word(IS_WRITE, 101), 	-- 322
is_word(IS_WRITE, 32), 	-- 323
is_word(IS_WRITE, 67), 	-- 324
is_word(IS_WRITE, 80), 	-- 325
is_word(IS_WRITE, 85), 	-- 326
is_word(IS_WRITE, 32), 	-- 327
is_word(IS_WRITE, 116), 	-- 328
is_word(IS_WRITE, 117), 	-- 329
is_word(IS_WRITE, 107), 	-- 330
is_word(IS_WRITE, 117), 	-- 331
is_word(IS_WRITE, 116), 	-- 332
is_word(IS_WRITE, 116), 	-- 333
is_word(IS_WRITE, 101), 	-- 334
is_word(IS_WRITE, 44), 	-- 335
is_word(IS_WRITE, 32), 	-- 336
is_word(IS_WRITE, 121), 	-- 337
is_word(IS_WRITE, 97), 	-- 338
is_word(IS_WRITE, 99), 	-- 339
is_word(IS_WRITE, 99), 	-- 340
is_word(IS_WRITE, 32), 	-- 341
is_word(IS_WRITE, 100), 	-- 342
is_word(IS_WRITE, 101), 	-- 343
is_word(IS_WRITE, 32), 	-- 344
is_word(IS_WRITE, 65), 	-- 345
is_word(IS_WRITE, 115), 	-- 346
is_word(IS_WRITE, 115), 	-- 347
is_word(IS_WRITE, 101), 	-- 348
is_word(IS_WRITE, 109), 	-- 349
is_word(IS_WRITE, 98), 	-- 350
is_word(IS_WRITE, 108), 	-- 351
is_word(IS_WRITE, 101), 	-- 352
is_word(IS_WRITE, 114), 	-- 353
is_word(IS_WRITE, 32), 	-- 354
is_word(IS_WRITE, 119), 	-- 355
is_word(IS_WRITE, 111), 	-- 356
is_word(IS_WRITE, 32), 	-- 357
is_word(IS_WRITE, 116), 	-- 358
is_word(IS_WRITE, 117), 	-- 359
is_word(IS_WRITE, 107), 	-- 360
is_word(IS_WRITE, 117), 	-- 361
is_word(IS_WRITE, 116), 	-- 362
is_word(IS_WRITE, 116), 	-- 363
is_word(IS_WRITE, 97), 	-- 364
is_word(IS_WRITE, 46), 	-- 365
is_word(IS_WRITE, 32), 	-- 366
is_word(IS_WRITE, 83), 	-- 367
is_word(IS_WRITE, 116), 	-- 368
is_word(IS_WRITE, 114), 	-- 369
is_word(IS_WRITE, 105), 	-- 370
is_word(IS_WRITE, 110), 	-- 371
is_word(IS_WRITE, 103), 	-- 372
is_word(IS_WRITE, 32), 	-- 373
is_word(IS_WRITE, 119), 	-- 374
is_word(IS_WRITE, 111), 	-- 375
is_word(IS_WRITE, 32), 	-- 376
is_word(IS_WRITE, 68), 	-- 377
is_word(IS_WRITE, 105), 	-- 378
is_word(IS_WRITE, 115), 	-- 379
is_word(IS_WRITE, 112), 	-- 380
is_word(IS_WRITE, 108), 	-- 381
is_word(IS_WRITE, 97), 	-- 382
is_word(IS_WRITE, 121), 	-- 383
is_word(IS_WRITE, 32), 	-- 384
is_word(IS_WRITE, 115), 	-- 385
is_word(IS_WRITE, 117), 	-- 386
is_word(IS_WRITE, 114), 	-- 387
is_word(IS_WRITE, 117), 	-- 388
is_word(IS_WRITE, 110), 	-- 389
is_word(IS_WRITE, 111), 	-- 390
is_word(IS_WRITE, 109), 	-- 391
is_word(IS_WRITE, 111), 	-- 392
is_word(IS_WRITE, 32), 	-- 393
is_word(IS_WRITE, 116), 	-- 394
is_word(IS_WRITE, 97), 	-- 395
is_word(IS_WRITE, 105), 	-- 396
is_word(IS_WRITE, 104), 	-- 397
is_word(IS_WRITE, 101), 	-- 398
is_word(IS_WRITE, 110), 	-- 399
is_word(IS_WRITE, 32), 	-- 400
is_word(IS_WRITE, 100), 	-- 401
is_word(IS_WRITE, 97), 	-- 402
is_word(IS_WRITE, 116), 	-- 403
is_word(IS_WRITE, 116), 	-- 404
is_word(IS_WRITE, 97), 	-- 405
is_word(IS_WRITE, 33), 	-- 406
is_word(IS_WRITE, 32), 	-- 407
is_word(IS_WRITE, 34), 	-- 408
is_word(IS_WRITE, 0), 	-- 409
0, 	-- 410
0, 	-- 411
0, 	-- 412
0, 	-- 413
0, 	-- 414
0, 	-- 415
0, 	-- 416
0, 	-- 417
0, 	-- 418
0, 	-- 419
0, 	-- 420
0, 	-- 421
0, 	-- 422
0, 	-- 423
0, 	-- 424
0, 	-- 425
0, 	-- 426
0, 	-- 427
0, 	-- 428
0, 	-- 429
0, 	-- 430
0, 	-- 431
0, 	-- 432
0, 	-- 433
0, 	-- 434
0, 	-- 435
0, 	-- 436
0, 	-- 437
0, 	-- 438
0, 	-- 439
0, 	-- 440
0, 	-- 441
0, 	-- 442
0, 	-- 443
0, 	-- 444
0, 	-- 445
0, 	-- 446
0, 	-- 447
0, 	-- 448
0, 	-- 449
0, 	-- 450
0, 	-- 451
0, 	-- 452
0, 	-- 453
0, 	-- 454
0, 	-- 455
0, 	-- 456
0, 	-- 457
0, 	-- 458
0, 	-- 459
0, 	-- 460
0, 	-- 461
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
0, 	-- 485
0, 	-- 486
0, 	-- 487
0, 	-- 488
0, 	-- 489
0, 	-- 490
0, 	-- 491
0, 	-- 492
0, 	-- 493
0, 	-- 494
279, 	-- 495
0, 	-- 496
260, 	-- 497
129, 	-- 498
1, 	-- 499
128, 	-- 500
1, 	-- 501
269, 	-- 502
16777216, 	-- 503
279, 	-- 504
0, 	-- 505
263, 	-- 506
16777216, 	-- 507
129, 	-- 508
1024, 	-- 509
128, 	-- 510
281	-- 511
	);
	
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
					
					--case inst is
						--when IS_READ|IS_ADD|IS_SUB|IS_MUL|IS_DIV|IS_AND|IS_OR|IS_XOR|IS_EQ|IS_NEQ|IS_LT|IS_LTE|IS_GT|IS_GTE|IS_BRANCH|IS_WRITE =>
							cpu_raddr <= operand;
						--when IS_WRITE =>
						--	cpu_raddr <= cpu_pc;
						--when others =>
					--end case;

					cpu_stat <= 1;
				when 1 =>	-- Read Memory
					cpu_opdata <= cpu_rdata;
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
							elsif (cpu_waddr>=128 and cpu_waddr<=255) then
								cpu_greg((cpu_waddr - 128)mod 128) <= cpu_wdata;
							elsif (cpu_waddr>=256 and cpu_waddr<=511) then
								boot((cpu_waddr - 256)mod 256) <= cpu_wdata;
							elsif (cpu_waddr>=1024 and cpu_waddr<=2047) then
								vram_1_addrb <= CONV_std_logic_vector(((cpu_waddr-1024)/32 mod 32)*32 + ((cpu_waddr-1024)mod 32), 10);
								vram_1_dinb <= CONV_std_logic_vector(cpu_wdata, 8);
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
		else cpu_greg((cpu_addr - 128) mod 128) when cpu_addr>=128 and cpu_addr<=255
		else boot((cpu_addr - ADDR_BOOT) mod SIZE_BOOT) when cpu_addr>=ADDR_BOOT and cpu_addr<(ADDR_BOOT + SIZE_BOOT);
	
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
