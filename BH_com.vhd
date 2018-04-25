library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use work.XSADD.all;

entity BH_com is
    Port ( A : inout  STD_LOGIC_VECTOR (15 downto 0);
           B : inout  STD_LOGIC_VECTOR (15 downto 0);
           C : inout  STD_LOGIC_VECTOR (15 downto 0);
                          clk : in STD_LOGIC);
end BH_com;

architecture Behavioral of BH_com is

	subtype cpu_int is integer range 0 to 1048575;
	constant CPU_BIT_WIDTH: integer := 20;
	constant CPU_INST_OFFSET: integer := 65536;

	function conv_integer(L: BOOLEAN) return integer is 
		begin 
         if L then 
             return(1); 
         else 
             return(0); 
         end if; 
	end function; 
	
	function is_word(inst: cpu_int) return cpu_int is 
		begin 
		return (inst*CPU_INST_OFFSET);
	end function;
	function is_word(inst: cpu_int; operand: cpu_int) return cpu_int is 
		begin 
		return (inst*CPU_INST_OFFSET + operand);
	end function; 

	signal clkcnt: std_logic_vector(31 downto 0) := "00000000000000000000000000000000";
	signal A_IN: std_logic_vector(15 downto 0);
	signal B_IN: std_logic_vector(15 downto 0);
	signal C_IN: std_logic_vector(15 downto 0);
	
	-- Memory map
	constant ADDR_BOOT: cpu_int := 256;
	constant SIZE_BOOT: cpu_int := 256;

	constant ADDR_STACK: cpu_int := 64512;
	constant SIZE_STACK: cpu_int := 1024;

	constant ADDR_RAND: cpu_int := 3;
	constant ADDR_A: cpu_int := 4;
	constant ADDR_B: cpu_int := 5;
	constant ADDR_C: cpu_int := 6;

	constant ADDR_CNT_1: cpu_int := 7;
	
	constant ADDR_I2C_ADDR: cpu_int := 8;
	constant ADDR_I2C_RDATA: cpu_int := 9;
	constant ADDR_I2C_WDATA: cpu_int := 10;
	constant ADDR_I2C_STAT: cpu_int := 11;

	constant ADDR_INS_1: cpu_int := 2048;
	constant SIZE_INS_1: cpu_int := 1024;

	-- CPU
	signal cpu_pc: cpu_int := ADDR_BOOT;
	signal cpu_stat: cpu_int := 0;
	signal cpu_inst: cpu_int;
	signal cpu_sp: cpu_int := 2**CPU_BIT_WIDTH - 1;

	signal cpu_addr: cpu_int;
	signal cpu_raddr: cpu_int;
	signal cpu_waddr: cpu_int;
	
	signal cpu_rdata: cpu_int;
	signal cpu_wdata: cpu_int;
	signal cpu_opdata: cpu_int;

	signal cpu_work: cpu_int;
	type greg is array (0 to 127) of cpu_int;
	signal cpu_greg: greg;
	
	-- Instruction
	constant IS_READ: cpu_int := 0;
	constant IS_WRITE: cpu_int := 1;

	constant IS_ADD: cpu_int := 2;
	constant IS_SUB: cpu_int := 3;
	constant IS_MUL: cpu_int := 4;
	constant IS_DIV: cpu_int := 5;
	constant IS_AND: cpu_int := 6;
	constant IS_OR: cpu_int := 7;
	constant IS_XOR: cpu_int := 8;

	constant IS_BRANCH: cpu_int := 9;
	constant IS_EQ: cpu_int := 10;	-- ==
	constant IS_NEQ: cpu_int := 11;	-- !=
	constant IS_LT: cpu_int := 12;	-- <
	constant IS_LTE: cpu_int := 13;	-- <=
	constant IS_GT: cpu_int := 14;	-- >
	constant IS_GTE: cpu_int := 15;	--	>=

	-- Virtual instruction
	--constant IS_NOP: cpu_int := IS_ADD;
	-- BOOT
	type prom is array (0 to SIZE_BOOT - 1) of cpu_int;
	signal boot: prom := (
is_word(IS_ADD, 511), 	-- 256
is_word(IS_ADD, 510), 	-- 257
is_word(IS_ADD, 509), 	-- 258
is_word(IS_ADD, 508), 	-- 259
is_word(IS_ADD, 507), 	-- 260
is_word(IS_ADD, 506), 	-- 261
is_word(IS_ADD, 505), 	-- 262
is_word(IS_ADD, 504), 	-- 263
is_word(IS_ADD, 503), 	-- 264
is_word(IS_ADD, 502), 	-- 265
is_word(IS_ADD, 501), 	-- 266
is_word(IS_ADD, 500), 	-- 267
is_word(IS_ADD, 499), 	-- 268
is_word(IS_ADD, 498), 	-- 269
is_word(IS_ADD, 497), 	-- 270
is_word(IS_ADD, 496), 	-- 271
is_word(IS_ADD, 495), 	-- 272
is_word(IS_ADD, 494), 	-- 273
is_word(IS_ADD, 493), 	-- 274
is_word(IS_ADD, 492), 	-- 275
is_word(IS_ADD, 491), 	-- 276
is_word(IS_ADD, 490), 	-- 277
is_word(IS_ADD, 489), 	-- 278
is_word(IS_ADD, 488), 	-- 279
is_word(IS_ADD, 487), 	-- 280
is_word(IS_ADD, 486), 	-- 281
is_word(IS_ADD, 485), 	-- 282
is_word(IS_ADD, 484), 	-- 283
is_word(IS_ADD, 483), 	-- 284
is_word(IS_ADD, 482), 	-- 285
is_word(IS_ADD, 481), 	-- 286
is_word(IS_ADD, 480), 	-- 287
is_word(IS_READ, 479), 	-- 288
is_word(IS_WRITE, 478), 	-- 289
is_word(IS_READ, 477), 	-- 290
is_word(IS_WRITE, 476), 	-- 291
is_word(IS_READ, 11), 	-- 292
is_word(IS_AND, 475), 	-- 293
is_word(IS_BRANCH, 474), 	-- 294
is_word(IS_READ, 473), 	-- 295
is_word(IS_WRITE, 472), 	-- 296
is_word(IS_READ, 471), 	-- 297
is_word(IS_WRITE, 470), 	-- 298
is_word(IS_READ, 11), 	-- 299
is_word(IS_AND, 469), 	-- 300
is_word(IS_EQ, 468), 	-- 301
is_word(IS_BRANCH, 467), 	-- 302
is_word(IS_READ, 11), 	-- 303
is_word(IS_AND, 466), 	-- 304
is_word(IS_BRANCH, 465), 	-- 305
is_word(IS_READ, 464), 	-- 306
is_word(IS_WRITE, 463), 	-- 307
is_word(IS_READ, 462), 	-- 308
is_word(IS_WRITE, 461), 	-- 309
is_word(IS_READ, 11), 	-- 310
is_word(IS_AND, 460), 	-- 311
is_word(IS_EQ, 459), 	-- 312
is_word(IS_BRANCH, 458), 	-- 313
is_word(IS_READ, 457), 	-- 314
is_word(IS_WRITE, 456), 	-- 315
is_word(IS_READ, 11), 	-- 316
is_word(IS_AND, 455), 	-- 317
is_word(IS_BRANCH, 454), 	-- 318
is_word(IS_READ, 453), 	-- 319
is_word(IS_WRITE, 452), 	-- 320
is_word(IS_READ, 451), 	-- 321
is_word(IS_WRITE, 450), 	-- 322
is_word(IS_READ, 255), 	-- 323
is_word(IS_EQ, 449), 	-- 324
is_word(IS_BRANCH, 448), 	-- 325
is_word(IS_READ, 447), 	-- 326
is_word(IS_WRITE, 446), 	-- 327
is_word(IS_READ, 11), 	-- 328
is_word(IS_AND, 445), 	-- 329
is_word(IS_EQ, 444), 	-- 330
is_word(IS_BRANCH, 443), 	-- 331
is_word(IS_READ, 11), 	-- 332
is_word(IS_AND, 442), 	-- 333
is_word(IS_BRANCH, 441), 	-- 334
is_word(IS_READ, 254), 	-- 335
is_word(IS_NEQ, 440), 	-- 336
is_word(IS_BRANCH, 439), 	-- 337
is_word(IS_READ, 9), 	-- 338
is_word(IS_WRITE, 438), 	-- 339
is_word(IS_READ, 437), 	-- 340
is_word(IS_WRITE, 436), 	-- 341
is_word(IS_READ, 435), 	-- 342
is_word(IS_WRITE, 434), 	-- 343
is_word(IS_READ, 254), 	-- 344
is_word(IS_NEQ, 433), 	-- 345
is_word(IS_BRANCH, 432), 	-- 346
is_word(IS_READ, 9), 	-- 347
is_word(IS_MUL, 431), 	-- 348
is_word(IS_ADD, 253), 	-- 349
is_word(IS_WRITE, 430), 	-- 350
is_word(IS_READ, 429), 	-- 351
is_word(IS_WRITE, 428), 	-- 352
is_word(IS_READ, 427), 	-- 353
is_word(IS_WRITE, 426), 	-- 354
is_word(IS_READ, 254), 	-- 355
is_word(IS_NEQ, 425), 	-- 356
is_word(IS_BRANCH, 424), 	-- 357
is_word(IS_READ, 9), 	-- 358
is_word(IS_MUL, 423), 	-- 359
is_word(IS_ADD, 253), 	-- 360
is_word(IS_WRITE, 422), 	-- 361
is_word(IS_READ, 253), 	-- 362
is_word(IS_WRITE, 255), 	-- 363
is_word(IS_READ, 255), 	-- 364
is_word(IS_ADD, 421), 	-- 365
is_word(IS_WRITE, 420), 	-- 366
is_word(IS_READ, 419), 	-- 367
is_word(IS_WRITE, 418), 	-- 368
is_word(IS_READ, 417), 	-- 369
is_word(IS_WRITE, 416), 	-- 370
is_word(IS_READ, 415), 	-- 371
is_word(IS_WRITE, 414), 	-- 372
is_word(IS_READ, 413), 	-- 373
is_word(IS_WRITE, 412), 	-- 374
0, 	-- 375
0, 	-- 376
0, 	-- 377
0, 	-- 378
0, 	-- 379
0, 	-- 380
0, 	-- 381
0, 	-- 382
0, 	-- 383
0, 	-- 384
0, 	-- 385
0, 	-- 386
0, 	-- 387
0, 	-- 388
0, 	-- 389
0, 	-- 390
0, 	-- 391
0, 	-- 392
0, 	-- 393
0, 	-- 394
0, 	-- 395
0, 	-- 396
0, 	-- 397
0, 	-- 398
0, 	-- 399
0, 	-- 400
0, 	-- 401
0, 	-- 402
0, 	-- 403
0, 	-- 404
0, 	-- 405
0, 	-- 406
0, 	-- 407
0, 	-- 408
0, 	-- 409
0, 	-- 410
0, 	-- 411
0, 	-- 412
2048, 	-- 413
0, 	-- 414
323, 	-- 415
0, 	-- 416
371, 	-- 417
254, 	-- 418
0, 	-- 419
255, 	-- 420
1, 	-- 421
253, 	-- 422
65536, 	-- 423
371, 	-- 424
2, 	-- 425
0, 	-- 426
371, 	-- 427
254, 	-- 428
2, 	-- 429
253, 	-- 430
256, 	-- 431
355, 	-- 432
1, 	-- 433
0, 	-- 434
371, 	-- 435
254, 	-- 436
1, 	-- 437
253, 	-- 438
344, 	-- 439
0, 	-- 440
332, 	-- 441
4, 	-- 442
328, 	-- 443
0, 	-- 444
4, 	-- 445
11, 	-- 446
3, 	-- 447
373, 	-- 448
3072, 	-- 449
255, 	-- 450
2048, 	-- 451
254, 	-- 452
0, 	-- 453
316, 	-- 454
4, 	-- 455
11, 	-- 456
0, 	-- 457
310, 	-- 458
0, 	-- 459
4, 	-- 460
11, 	-- 461
1, 	-- 462
10, 	-- 463
0, 	-- 464
303, 	-- 465
4, 	-- 466
299, 	-- 467
0, 	-- 468
4, 	-- 469
11, 	-- 470
1, 	-- 471
10, 	-- 472
0, 	-- 473
292, 	-- 474
4, 	-- 475
8, 	-- 476
80, 	-- 477
0, 	-- 478
290, 	-- 479
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
0, 	-- 495
0, 	-- 496
0, 	-- 497
0, 	-- 498
0, 	-- 499
0, 	-- 500
0, 	-- 501
0, 	-- 502
0, 	-- 503
0, 	-- 504
0, 	-- 505
0, 	-- 506
0, 	-- 507
0, 	-- 508
0, 	-- 509
0, 	-- 510
0	-- 511
	);
	
	-- Stack
	COMPONENT stack
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
	  );
	END COMPONENT;	
	signal stack1_clka : STD_LOGIC;
	signal stack1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal stack1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal stack1_dina : STD_LOGIC_VECTOR(19 DOWNTO 0);
	signal stack1_douta : STD_LOGIC_VECTOR(19 DOWNTO 0);
	
	-- Divider
	component divider
		port (
		clk: in std_logic;
		rfd: out std_logic;
		dividend: in std_logic_vector(19 downto 0);
		divisor: in std_logic_vector(19 downto 0);
		quotient: out std_logic_vector(19 downto 0);
		fractional: out std_logic_vector(19 downto 0)
		);
	end component;
	signal div1_clk: std_logic;
	signal div1_rfd: std_logic;
	signal div1_dividend: std_logic_vector(19 downto 0);
	signal div1_divisor: std_logic_vector(19 downto 0);
	signal div1_quotient: std_logic_vector(19 downto 0);
	signal div1_fractional: std_logic_vector(19 downto 0);
			
	-- INS RAM
	COMPONENT ins_1k
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
	  );
	END COMPONENT;
	signal ins_1_clka : STD_LOGIC;
	signal ins_1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal ins_1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal ins_1_dina : STD_LOGIC_VECTOR(19 DOWNTO 0);
	signal ins_1_douta : STD_LOGIC_VECTOR(19 DOWNTO 0);

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
		chr: in std_logic_vector(7 downto 0);
		row: in std_logic_vector(2 downto 0);
		col: in std_logic_vector(2 downto 0);
		dot: out std_logic
	 );
	end component;
	signal crom_1_chr: std_logic_vector(7 downto 0);
	signal crom_1_row: std_logic_vector(2 downto 0);
	signal crom_1_col: std_logic_vector(2 downto 0);
	signal crom_1_dot: std_logic;
	
	-- PPU
	signal ppu_clkcnt: integer := 0;
	signal ppu_linecnt: integer := 0;

	signal stat_vsync: std_logic;
	signal stat_hsync: std_logic;

	signal lum: std_logic;
	
	-- Rand
    component  XSADD_GEN
        port (
            CLK         : in  std_logic;
            RST         : in  std_logic;
            INIT        : in  std_logic;
            INIT_PARAM  : in  PSEUDO_RANDOM_NUMBER_GENERATOR_TYPE;
            RND_RUN     : in  std_logic;
            RND_VAL     : out std_logic;
            RND_NUM     : out RANDOM_NUMBER_TYPE
        );
    end component;
	signal rand_clk: std_logic;
   signal rand_rst: std_logic;
   signal rand_init: std_logic;
   signal rand_init_param: PSEUDO_RANDOM_NUMBER_GENERATOR_TYPE;
   signal rand_rnd_run: std_logic;
   signal rand_rnd_val: std_logic;
   signal rand_rnd_num: RANDOM_NUMBER_TYPE;
	
	-- Controller
	signal cnt_1: std_logic_vector(7 downto 0);

	-- I2C
	component i2c_master
	  PORT(
		 clk       : IN     STD_LOGIC;                    --system clock
		 reset_n   : IN     STD_LOGIC;                    --active low reset
		 ena       : IN     STD_LOGIC;                    --latch in command
		 addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
		 rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
		 data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
		 busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
		 data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
		 ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
		 sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
		 scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
	end component;
	
	signal i2c_1_clk       : STD_LOGIC;                    --system clock
	signal i2c_1_reset_n   : STD_LOGIC;                    --active low reset
	signal i2c_1_ena       : STD_LOGIC;                    --latch in command
	signal i2c_1_addr      : STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
	signal i2c_1_rw        : STD_LOGIC;                    --'0' is write, '1' is read
	signal i2c_1_data_wr   : STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
	signal i2c_1_busy      : STD_LOGIC;                    --indicates transaction in progress
	signal i2c_1_data_rd   : STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
	signal i2c_1_ack_error : STD_LOGIC;                    --flag if improper acknowledge from slave
	signal i2c_1_sda       : STD_LOGIC;                    --serial data output of i2c bus
	signal i2c_1_scl       : STD_LOGIC;                   --serial clock output of i2c bus
	signal i2c_1_stat      : std_logic_vector(3 downto 0) := "0000";
	
begin 

	process(clk) begin
		if (rising_edge(clk)) then
			clkcnt <= clkcnt + 1;
		end if;
	end process;

	-- CPU
	process(clk)
	variable inst: cpu_int;
	variable operand: cpu_int;
	begin
		if (falling_edge(clk)) then
			case cpu_stat is
				when 0 =>	-- Read instruction
					inst := cpu_rdata/CPU_INST_OFFSET;
					operand := cpu_rdata mod CPU_INST_OFFSET;
					
					cpu_inst <= inst;
					cpu_pc <= cpu_pc + 1;
					
					cpu_raddr <= operand;
					if (operand>=1024 and operand<=2047) then
						vram_1_addrb <= CONV_std_logic_vector(((operand-1024)/32 mod 32)*32 + ((operand-1024)mod 32), 10);
						vram_1_web <= "0";
					elsif (operand>=ADDR_STACK and operand<ADDR_STACK + SIZE_STACK) then
						stack1_addra <= conv_std_logic_vector(operand-ADDR_STACK, 10);
						stack1_wea <= "0";
					elsif (operand>=ADDR_INS_1 and operand<ADDR_INS_1 + SIZE_INS_1) then
						ins_1_addra <= conv_std_logic_vector(operand-ADDR_INS_1, 10);
						ins_1_wea <= "0";
					end if;

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
					div1_dividend <= conv_std_logic_vector(cpu_work, 16);
					div1_divisor <= conv_std_logic_vector(cpu_rdata, 16);
					
					if (cpu_raddr = 2) then
						case cpu_inst is
							when IS_WRITE =>
							when others =>
								cpu_sp <= cpu_sp + 1;
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
							--div1_fractional <= ;
							cpu_wdata <= conv_integer(div1_quotient);
							cpu_waddr <= 1;
						when IS_AND =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, CPU_BIT_WIDTH) and conv_std_logic_vector(cpu_opdata, CPU_BIT_WIDTH));
							cpu_waddr <= 1;
						when IS_OR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, CPU_BIT_WIDTH) or conv_std_logic_vector(cpu_opdata, CPU_BIT_WIDTH));
							cpu_waddr <= 1;
						when IS_XOR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, CPU_BIT_WIDTH) xor conv_std_logic_vector(cpu_opdata, CPU_BIT_WIDTH));
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

							elsif (cpu_waddr=ADDR_I2C_ADDR) then
								i2c_1_addr <= conv_std_logic_vector(cpu_wdata, 7);
							elsif (cpu_waddr=ADDR_I2C_WDATA) then
								i2c_1_data_wr <= conv_std_logic_vector(cpu_wdata, 8);
							--elsif (cpu_waddr=ADDR_I2C_RDATA) then
							--	i2c_1_data_rd <= conv_std_logic_vector(cpu_wdata, 8);
							elsif (cpu_waddr=ADDR_I2C_STAT) then
								i2c_1_stat(1 downto 0) <= conv_std_logic_vector(cpu_wdata, 2);

							elsif (cpu_waddr>=128 and cpu_waddr<=255) then
								cpu_greg((cpu_waddr - 128)mod 128) <= cpu_wdata;
							elsif (cpu_waddr>=ADDR_BOOT and cpu_waddr<ADDR_BOOT + SIZE_BOOT) then
								boot((cpu_waddr - ADDR_BOOT)mod SIZE_BOOT) <= cpu_wdata;
							elsif (cpu_waddr>=1024 and cpu_waddr<=2047) then
								vram_1_addrb <= CONV_std_logic_vector(((cpu_waddr-1024)/32 mod 32)*32 + ((cpu_waddr-1024)mod 32), 10);
								vram_1_dinb <= CONV_std_logic_vector(cpu_wdata, 8);
								vram_1_web <= "1";
							elsif (cpu_waddr>=ADDR_STACK and cpu_waddr<ADDR_STACK + SIZE_STACK) then
								stack1_addra <= conv_std_logic_vector(cpu_waddr-ADDR_STACK, 10);
								stack1_dina <= conv_std_logic_vector(cpu_wdata, CPU_BIT_WIDTH);
								stack1_wea <= "1";
							elsif (cpu_waddr>=ADDR_INS_1 and cpu_waddr<ADDR_INS_1 + SIZE_INS_1) then
								ins_1_addra <= conv_std_logic_vector(cpu_waddr-ADDR_INS_1, 10);
								ins_1_dina <= conv_std_logic_vector(cpu_wdata, CPU_BIT_WIDTH);
								ins_1_wea <= "1";
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
		else conv_integer(A_IN) when cpu_addr=ADDR_A
		else conv_integer(B_IN) when cpu_addr=ADDR_B
		else conv_integer(C_IN) when cpu_addr=ADDR_C
		else conv_integer(CNT_1) when cpu_addr=ADDR_CNT_1
		else to_integer(rand_rnd_num) when cpu_addr=ADDR_RAND

		else conv_integer(i2c_1_addr) when cpu_addr=ADDR_I2C_ADDR
		else conv_integer(i2c_1_data_wr) when cpu_addr=ADDR_I2C_WDATA
		else conv_integer(i2c_1_data_rd) when cpu_addr=ADDR_I2C_RDATA
		else conv_integer(i2c_1_stat) when cpu_addr=ADDR_I2C_STAT
		
		else cpu_greg((cpu_addr - 128) mod 128) when cpu_addr>=128 and cpu_addr<=255
		else boot((cpu_addr - ADDR_BOOT) mod SIZE_BOOT) when cpu_addr>=ADDR_BOOT and cpu_addr<(ADDR_BOOT + SIZE_BOOT)
		else conv_integer(vram_1_doutb) when cpu_addr>=1024 and cpu_addr<=2047
		else conv_integer(stack1_douta) when cpu_addr>=ADDR_STACK and cpu_addr<(ADDR_STACK + SIZE_STACK)
		else conv_integer(ins_1_douta) when cpu_addr>=ADDR_INS_1 and cpu_addr<(ADDR_INS_1 + SIZE_INS_1)
		;
		
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
	  vram_1_addra <= CONV_std_logic_vector(((ppu_linecnt-32)/8)*40 + ((ppu_clkcnt -512 + 1)/4/8), 10);
	  vram_1_clkb <= clk;

	-- INS RAM
	ins_1 : ins_1k
  PORT MAP (
    clka => ins_1_clka,
    wea => ins_1_wea,
    addra => ins_1_addra,
    dina => ins_1_dina,
    douta => ins_1_douta
  );
   ins_1_clka <= clk;
	  
	-- CROM
	crom_1: crom port map (
		chr => crom_1_chr,
		row => crom_1_row,
		col => crom_1_col,
		dot => crom_1_dot
	 );
	 crom_1_chr <= vram_1_douta(7 downto 0);
	 crom_1_row <= conv_std_logic_vector(ppu_linecnt, 3);
	 crom_1_col <= conv_std_logic_vector(ppu_clkcnt/4, 3);

	-- Stack
	stack_1 : stack
	  PORT MAP (
		 clka => stack1_clka,
		 wea => stack1_wea,
		 addra => stack1_addra,
		 dina => stack1_dina,
		 douta => stack1_douta
	  );
	stack1_clka <= clk;

	-- Rand
   rand_1: XSADD_GEN port map(
		CLK => rand_clk, 
		RST => rand_rst, 
		INIT => rand_init, 
		INIT_PARAM => rand_init_param, 
		RND_RUN => rand_rnd_run, 
		RND_VAL => rand_rnd_val, 
		RND_NUM => rand_rnd_num
    );
	 rand_clk <= clk;
	 rand_rst <= '0';
	 rand_init <= '0';
	 rand_rnd_run <= '1';

	-- Divider
	div_1 : divider
		port map (
			clk => div1_clk,
			rfd => div1_rfd,
			dividend => div1_dividend,
			divisor => div1_divisor,
			quotient => div1_quotient,
			fractional => div1_fractional);
	div1_clk <= clk;
	 
	-- Controller IO
	process(clkcnt(2)) begin
		if (falling_edge(clkcnt(2))) then
			cnt_1(conv_integer(clkcnt(5 downto 3))) <= C(2);
		end if;
	end process;
	
	-- I2C
	i2c_1: i2c_master
	  PORT MAP(
		 clk       => i2c_1_clk,                    --system clock
		 reset_n   => i2c_1_reset_n,                    --active low reset
		 ena       => i2c_1_ena,                    --latch in command
		 addr      => i2c_1_addr, --address of target slave
		 rw        => i2c_1_rw,                    --'0' is write, '1' is read
		 data_wr   => i2c_1_data_wr, --data to write to slave
		 busy      => i2c_1_busy,                    --indicates transaction in progress
		 data_rd   => i2c_1_data_rd, --data read from slave
		 ack_error => i2c_1_ack_error,                    --flag if improper acknowledge from slave
		 sda       => i2c_1_sda,                    --serial data output of i2c bus
		 scl       => i2c_1_scl);                   --serial clock output of i2c bus
	i2c_1_clk <= clk;
	i2c_1_reset_n <= '1';
	i2c_1_ena <= i2c_1_stat(0);
	i2c_1_rw <= i2c_1_stat(1);
	i2c_1_stat(2) <= i2c_1_busy;
	i2c_1_stat(3) <= i2c_1_ack_error;
	
	-- Pin Outputs
	A(0) <= '0' when (stat_vsync='0' and stat_hsync='1') or (stat_vsync='1' and ppu_clkcnt>=150) else '1';
	A(1) <= lum when stat_vsync='0' and stat_hsync='0' and ppu_clkcnt>511 and ppu_clkcnt<(1536 + 8*8*4) and ppu_linecnt>=32 and ppu_linecnt<232 else '0';
	A(15 downto 2) <= "00000000000000";
	B <= "0000000000000000";
	C(0) <= clkcnt(2);
	C(1) <= '1' when clkcnt(5 downto 3)="000" else '0';
	C(2) <= 'Z'; -- input
	c(14) <= i2c_1_scl;
	c(15) <= i2c_1_sda;
	C(13 downto 3) <= "00000000000";
	
	-- Pin Inputs
	A_IN <= A;
	B_IN <= B;
	C_IN <= C;

end Behavioral;
