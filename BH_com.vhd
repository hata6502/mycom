LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;
USE work.XSADD.ALL;

ENTITY BH_com IS
	PORT (
		A : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		B : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		C : INOUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		clk : IN STD_LOGIC);
END BH_com;

ARCHITECTURE Behavioral OF BH_com IS

	SUBTYPE cpu_int IS INTEGER RANGE 0 TO 1048575;
	CONSTANT CPU_BIT_WIDTH : INTEGER := 20;
	CONSTANT CPU_INST_OFFSET : INTEGER := 65536;

	FUNCTION conv_integer(L : BOOLEAN) RETURN INTEGER IS
	BEGIN
		IF L THEN
			RETURN(1);
		ELSE
			RETURN(0);
		END IF;
	END FUNCTION;

	FUNCTION is_word(inst : cpu_int) RETURN cpu_int IS
	BEGIN
		RETURN (inst * CPU_INST_OFFSET);
	END FUNCTION;
	FUNCTION is_word(inst : cpu_int; operand : cpu_int) RETURN cpu_int IS
	BEGIN
		RETURN (inst * CPU_INST_OFFSET + operand);
	END FUNCTION;

	SIGNAL clkcnt : STD_LOGIC_VECTOR(31 DOWNTO 0) := "00000000000000000000000000000000";
	SIGNAL A_IN : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL B_IN : STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL C_IN : STD_LOGIC_VECTOR(15 DOWNTO 0);

	-- Memory map
	CONSTANT ADDR_BOOT : cpu_int := 256;
	CONSTANT SIZE_BOOT : cpu_int := 256;

	CONSTANT ADDR_STACK : cpu_int := 64512;
	CONSTANT SIZE_STACK : cpu_int := 1024;

	CONSTANT ADDR_RAND : cpu_int := 3;
	CONSTANT ADDR_A : cpu_int := 4;
	CONSTANT ADDR_B : cpu_int := 5;
	CONSTANT ADDR_C : cpu_int := 6;

	CONSTANT ADDR_CNT_1 : cpu_int := 7;

	CONSTANT ADDR_I2C_ADDR : cpu_int := 8;
	CONSTANT ADDR_I2C_RDATA : cpu_int := 9;
	CONSTANT ADDR_I2C_WDATA : cpu_int := 10;
	CONSTANT ADDR_I2C_STAT : cpu_int := 11;

	CONSTANT ADDR_INS_1 : cpu_int := 2048;
	CONSTANT SIZE_INS_1 : cpu_int := 1024;

	-- CPU
	SIGNAL cpu_pc : cpu_int := ADDR_BOOT;
	SIGNAL cpu_stat : cpu_int := 0;
	SIGNAL cpu_inst : cpu_int;
	SIGNAL cpu_sp : cpu_int := 2 ** CPU_BIT_WIDTH - 1;

	SIGNAL cpu_addr : cpu_int;
	SIGNAL cpu_raddr : cpu_int;
	SIGNAL cpu_waddr : cpu_int;

	SIGNAL cpu_rdata : cpu_int;
	SIGNAL cpu_wdata : cpu_int;
	SIGNAL cpu_opdata : cpu_int;

	SIGNAL cpu_work : cpu_int;
	TYPE greg IS ARRAY (0 TO 127) OF cpu_int;
	SIGNAL cpu_greg : greg;

	-- Instruction
	CONSTANT IS_READ : cpu_int := 0;
	CONSTANT IS_WRITE : cpu_int := 1;

	CONSTANT IS_ADD : cpu_int := 2;
	CONSTANT IS_SUB : cpu_int := 3;
	CONSTANT IS_MUL : cpu_int := 4;
	CONSTANT IS_DIV : cpu_int := 5;
	CONSTANT IS_AND : cpu_int := 6;
	CONSTANT IS_OR : cpu_int := 7;
	CONSTANT IS_XOR : cpu_int := 8;

	CONSTANT IS_BRANCH : cpu_int := 9;
	CONSTANT IS_EQ : cpu_int := 10; -- ==
	CONSTANT IS_NEQ : cpu_int := 11; -- !=
	CONSTANT IS_LT : cpu_int := 12; -- <
	CONSTANT IS_LTE : cpu_int := 13; -- <=
	CONSTANT IS_GT : cpu_int := 14; -- >
	CONSTANT IS_GTE : cpu_int := 15; --	>=

	-- Virtual instruction
	--constant IS_NOP: cpu_int := IS_ADD;
	-- BOOT
	TYPE prom IS ARRAY (0 TO SIZE_BOOT - 1) OF cpu_int;
	SIGNAL boot : prom := (
		is_word(IS_ADD, 511), -- 256
		is_word(IS_ADD, 510), -- 257
		is_word(IS_ADD, 509), -- 258
		is_word(IS_ADD, 508), -- 259
		is_word(IS_ADD, 507), -- 260
		is_word(IS_ADD, 506), -- 261
		is_word(IS_ADD, 505), -- 262
		is_word(IS_ADD, 504), -- 263
		is_word(IS_ADD, 503), -- 264
		is_word(IS_ADD, 502), -- 265
		is_word(IS_ADD, 501), -- 266
		is_word(IS_ADD, 500), -- 267
		is_word(IS_ADD, 499), -- 268
		is_word(IS_ADD, 498), -- 269
		is_word(IS_ADD, 497), -- 270
		is_word(IS_ADD, 496), -- 271
		is_word(IS_ADD, 495), -- 272
		is_word(IS_ADD, 494), -- 273
		is_word(IS_ADD, 493), -- 274
		is_word(IS_ADD, 492), -- 275
		is_word(IS_ADD, 491), -- 276
		is_word(IS_ADD, 490), -- 277
		is_word(IS_ADD, 489), -- 278
		is_word(IS_ADD, 488), -- 279
		is_word(IS_ADD, 487), -- 280
		is_word(IS_ADD, 486), -- 281
		is_word(IS_ADD, 485), -- 282
		is_word(IS_ADD, 484), -- 283
		is_word(IS_ADD, 483), -- 284
		is_word(IS_ADD, 482), -- 285
		is_word(IS_ADD, 481), -- 286
		is_word(IS_ADD, 480), -- 287
		is_word(IS_READ, 479), -- 288
		is_word(IS_WRITE, 478), -- 289
		is_word(IS_READ, 477), -- 290
		is_word(IS_WRITE, 476), -- 291
		is_word(IS_READ, 11), -- 292
		is_word(IS_AND, 475), -- 293
		is_word(IS_BRANCH, 474), -- 294
		is_word(IS_READ, 473), -- 295
		is_word(IS_WRITE, 472), -- 296
		is_word(IS_READ, 471), -- 297
		is_word(IS_WRITE, 470), -- 298
		is_word(IS_READ, 11), -- 299
		is_word(IS_AND, 469), -- 300
		is_word(IS_EQ, 468), -- 301
		is_word(IS_BRANCH, 467), -- 302
		is_word(IS_READ, 11), -- 303
		is_word(IS_AND, 466), -- 304
		is_word(IS_BRANCH, 465), -- 305
		is_word(IS_READ, 464), -- 306
		is_word(IS_WRITE, 463), -- 307
		is_word(IS_READ, 462), -- 308
		is_word(IS_WRITE, 461), -- 309
		is_word(IS_READ, 11), -- 310
		is_word(IS_AND, 460), -- 311
		is_word(IS_EQ, 459), -- 312
		is_word(IS_BRANCH, 458), -- 313
		is_word(IS_READ, 457), -- 314
		is_word(IS_WRITE, 456), -- 315
		is_word(IS_READ, 11), -- 316
		is_word(IS_AND, 455), -- 317
		is_word(IS_BRANCH, 454), -- 318
		is_word(IS_READ, 453), -- 319
		is_word(IS_WRITE, 452), -- 320
		is_word(IS_READ, 451), -- 321
		is_word(IS_WRITE, 450), -- 322
		is_word(IS_READ, 255), -- 323
		is_word(IS_EQ, 449), -- 324
		is_word(IS_BRANCH, 448), -- 325
		is_word(IS_READ, 447), -- 326
		is_word(IS_WRITE, 446), -- 327
		is_word(IS_READ, 11), -- 328
		is_word(IS_AND, 445), -- 329
		is_word(IS_EQ, 444), -- 330
		is_word(IS_BRANCH, 443), -- 331
		is_word(IS_READ, 11), -- 332
		is_word(IS_AND, 442), -- 333
		is_word(IS_BRANCH, 441), -- 334
		is_word(IS_READ, 254), -- 335
		is_word(IS_NEQ, 440), -- 336
		is_word(IS_BRANCH, 439), -- 337
		is_word(IS_READ, 9), -- 338
		is_word(IS_WRITE, 438), -- 339
		is_word(IS_READ, 437), -- 340
		is_word(IS_WRITE, 436), -- 341
		is_word(IS_READ, 435), -- 342
		is_word(IS_WRITE, 434), -- 343
		is_word(IS_READ, 254), -- 344
		is_word(IS_NEQ, 433), -- 345
		is_word(IS_BRANCH, 432), -- 346
		is_word(IS_READ, 9), -- 347
		is_word(IS_MUL, 431), -- 348
		is_word(IS_ADD, 253), -- 349
		is_word(IS_WRITE, 430), -- 350
		is_word(IS_READ, 429), -- 351
		is_word(IS_WRITE, 428), -- 352
		is_word(IS_READ, 427), -- 353
		is_word(IS_WRITE, 426), -- 354
		is_word(IS_READ, 254), -- 355
		is_word(IS_NEQ, 425), -- 356
		is_word(IS_BRANCH, 424), -- 357
		is_word(IS_READ, 9), -- 358
		is_word(IS_MUL, 423), -- 359
		is_word(IS_ADD, 253), -- 360
		is_word(IS_WRITE, 422), -- 361
		is_word(IS_READ, 253), -- 362
		is_word(IS_WRITE, 255), -- 363
		is_word(IS_READ, 255), -- 364
		is_word(IS_ADD, 421), -- 365
		is_word(IS_WRITE, 420), -- 366
		is_word(IS_READ, 419), -- 367
		is_word(IS_WRITE, 418), -- 368
		is_word(IS_READ, 417), -- 369
		is_word(IS_WRITE, 416), -- 370
		is_word(IS_READ, 415), -- 371
		is_word(IS_WRITE, 414), -- 372
		is_word(IS_READ, 413), -- 373
		is_word(IS_WRITE, 412), -- 374
		0, -- 375
		0, -- 376
		0, -- 377
		0, -- 378
		0, -- 379
		0, -- 380
		0, -- 381
		0, -- 382
		0, -- 383
		0, -- 384
		0, -- 385
		0, -- 386
		0, -- 387
		0, -- 388
		0, -- 389
		0, -- 390
		0, -- 391
		0, -- 392
		0, -- 393
		0, -- 394
		0, -- 395
		0, -- 396
		0, -- 397
		0, -- 398
		0, -- 399
		0, -- 400
		0, -- 401
		0, -- 402
		0, -- 403
		0, -- 404
		0, -- 405
		0, -- 406
		0, -- 407
		0, -- 408
		0, -- 409
		0, -- 410
		0, -- 411
		0, -- 412
		2048, -- 413
		0, -- 414
		323, -- 415
		0, -- 416
		371, -- 417
		254, -- 418
		0, -- 419
		255, -- 420
		1, -- 421
		253, -- 422
		65536, -- 423
		371, -- 424
		2, -- 425
		0, -- 426
		371, -- 427
		254, -- 428
		2, -- 429
		253, -- 430
		256, -- 431
		355, -- 432
		1, -- 433
		0, -- 434
		371, -- 435
		254, -- 436
		1, -- 437
		253, -- 438
		344, -- 439
		0, -- 440
		332, -- 441
		4, -- 442
		328, -- 443
		0, -- 444
		4, -- 445
		11, -- 446
		3, -- 447
		373, -- 448
		3072, -- 449
		255, -- 450
		2048, -- 451
		254, -- 452
		0, -- 453
		316, -- 454
		4, -- 455
		11, -- 456
		0, -- 457
		310, -- 458
		0, -- 459
		4, -- 460
		11, -- 461
		1, -- 462
		10, -- 463
		0, -- 464
		303, -- 465
		4, -- 466
		299, -- 467
		0, -- 468
		4, -- 469
		11, -- 470
		1, -- 471
		10, -- 472
		0, -- 473
		292, -- 474
		4, -- 475
		8, -- 476
		80, -- 477
		0, -- 478
		290, -- 479
		0, -- 480
		0, -- 481
		0, -- 482
		0, -- 483
		0, -- 484
		0, -- 485
		0, -- 486
		0, -- 487
		0, -- 488
		0, -- 489
		0, -- 490
		0, -- 491
		0, -- 492
		0, -- 493
		0, -- 494
		0, -- 495
		0, -- 496
		0, -- 497
		0, -- 498
		0, -- 499
		0, -- 500
		0, -- 501
		0, -- 502
		0, -- 503
		0, -- 504
		0, -- 505
		0, -- 506
		0, -- 507
		0, -- 508
		0, -- 509
		0, -- 510
		0 -- 511
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
	SIGNAL stack1_clka : STD_LOGIC;
	SIGNAL stack1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL stack1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL stack1_dina : STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL stack1_douta : STD_LOGIC_VECTOR(19 DOWNTO 0);

	-- Divider
	COMPONENT divider
		PORT (
			clk : IN STD_LOGIC;
			rfd : OUT STD_LOGIC;
			dividend : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
			divisor : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
			quotient : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
			fractional : OUT STD_LOGIC_VECTOR(19 DOWNTO 0)
		);
	END COMPONENT;
	SIGNAL div1_clk : STD_LOGIC;
	SIGNAL div1_rfd : STD_LOGIC;
	SIGNAL div1_dividend : STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL div1_divisor : STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL div1_quotient : STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL div1_fractional : STD_LOGIC_VECTOR(19 DOWNTO 0);

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
	SIGNAL ins_1_clka : STD_LOGIC;
	SIGNAL ins_1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL ins_1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL ins_1_dina : STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL ins_1_douta : STD_LOGIC_VECTOR(19 DOWNTO 0);

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

	SIGNAL vram_1_clka : STD_LOGIC;
	SIGNAL vram_1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL vram_1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL vram_1_dina : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL vram_1_douta : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL vram_1_clkb : STD_LOGIC;
	SIGNAL vram_1_web : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL vram_1_addrb : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL vram_1_dinb : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL vram_1_doutb : STD_LOGIC_VECTOR(7 DOWNTO 0);

	-- CROM
	COMPONENT crom IS
		PORT (
			chr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			row : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			col : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			dot : OUT STD_LOGIC
		);
	END COMPONENT;
	SIGNAL crom_1_chr : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL crom_1_row : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL crom_1_col : STD_LOGIC_VECTOR(2 DOWNTO 0);
	SIGNAL crom_1_dot : STD_LOGIC;

	-- PPU
	SIGNAL ppu_clkcnt : INTEGER := 0;
	SIGNAL ppu_linecnt : INTEGER := 0;

	SIGNAL stat_vsync : STD_LOGIC;
	SIGNAL stat_hsync : STD_LOGIC;

	SIGNAL lum : STD_LOGIC;

	-- Rand
	COMPONENT XSADD_GEN
		PORT (
			CLK : IN STD_LOGIC;
			RST : IN STD_LOGIC;
			INIT : IN STD_LOGIC;
			INIT_PARAM : IN PSEUDO_RANDOM_NUMBER_GENERATOR_TYPE;
			RND_RUN : IN STD_LOGIC;
			RND_VAL : OUT STD_LOGIC;
			RND_NUM : OUT RANDOM_NUMBER_TYPE
		);
	END COMPONENT;
	SIGNAL rand_clk : STD_LOGIC;
	SIGNAL rand_rst : STD_LOGIC;
	SIGNAL rand_init : STD_LOGIC;
	SIGNAL rand_init_param : PSEUDO_RANDOM_NUMBER_GENERATOR_TYPE;
	SIGNAL rand_rnd_run : STD_LOGIC;
	SIGNAL rand_rnd_val : STD_LOGIC;
	SIGNAL rand_rnd_num : RANDOM_NUMBER_TYPE;

	-- Controller
	SIGNAL cnt_1 : STD_LOGIC_VECTOR(7 DOWNTO 0);

	-- I2C
	COMPONENT i2c_master
		PORT (
			clk : IN STD_LOGIC; --system clock
			reset_n : IN STD_LOGIC; --active low reset
			ena : IN STD_LOGIC; --latch in command
			addr : IN STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
			rw : IN STD_LOGIC; --'0' is write, '1' is read
			data_wr : IN STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
			busy : OUT STD_LOGIC; --indicates transaction in progress
			data_rd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
			ack_error : BUFFER STD_LOGIC; --flag if improper acknowledge from slave
			sda : INOUT STD_LOGIC; --serial data output of i2c bus
			scl : INOUT STD_LOGIC); --serial clock output of i2c bus
	END COMPONENT;

	SIGNAL i2c_1_clk : STD_LOGIC; --system clock
	SIGNAL i2c_1_reset_n : STD_LOGIC; --active low reset
	SIGNAL i2c_1_ena : STD_LOGIC; --latch in command
	SIGNAL i2c_1_addr : STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
	SIGNAL i2c_1_rw : STD_LOGIC; --'0' is write, '1' is read
	SIGNAL i2c_1_data_wr : STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
	SIGNAL i2c_1_busy : STD_LOGIC; --indicates transaction in progress
	SIGNAL i2c_1_data_rd : STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
	SIGNAL i2c_1_ack_error : STD_LOGIC; --flag if improper acknowledge from slave
	SIGNAL i2c_1_sda : STD_LOGIC; --serial data output of i2c bus
	SIGNAL i2c_1_scl : STD_LOGIC; --serial clock output of i2c bus
	SIGNAL i2c_1_stat : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";

BEGIN

	PROCESS (clk) BEGIN
		IF (rising_edge(clk)) THEN
			clkcnt <= clkcnt + 1;
		END IF;
	END PROCESS;

	-- CPU
	PROCESS (clk)
		VARIABLE inst : cpu_int;
		VARIABLE operand : cpu_int;
	BEGIN
		IF (falling_edge(clk)) THEN
			CASE cpu_stat IS
				WHEN 0 => -- Read instruction
					inst := cpu_rdata/CPU_INST_OFFSET;
					operand := cpu_rdata MOD CPU_INST_OFFSET;

					cpu_inst <= inst;
					cpu_pc <= cpu_pc + 1;

					cpu_raddr <= operand;
					IF (operand >= 1024 AND operand <= 2047) THEN
						vram_1_addrb <= CONV_std_logic_vector(((operand - 1024)/32 MOD 32) * 32 + ((operand - 1024)MOD 32), 10);
						vram_1_web <= "0";
					ELSIF (operand >= ADDR_STACK AND operand < ADDR_STACK + SIZE_STACK) THEN
						stack1_addra <= conv_std_logic_vector(operand - ADDR_STACK, 10);
						stack1_wea <= "0";
					ELSIF (operand >= ADDR_INS_1 AND operand < ADDR_INS_1 + SIZE_INS_1) THEN
						ins_1_addra <= conv_std_logic_vector(operand - ADDR_INS_1, 10);
						ins_1_wea <= "0";
					END IF;

					IF (operand = 2) THEN
						CASE inst IS
							WHEN IS_WRITE =>
								cpu_sp <= cpu_sp - 1;
							WHEN OTHERS =>
						END CASE;
					END IF;

					cpu_stat <= 1;
				WHEN 1 => -- Read Memory
					cpu_opdata <= cpu_rdata;
					div1_dividend <= conv_std_logic_vector(cpu_work, 16);
					div1_divisor <= conv_std_logic_vector(cpu_rdata, 16);

					IF (cpu_raddr = 2) THEN
						CASE cpu_inst IS
							WHEN IS_WRITE =>
							WHEN OTHERS =>
								cpu_sp <= cpu_sp + 1;
						END CASE;
					END IF;

					cpu_stat <= 2;
				WHEN 2 => -- Operation
					operand := cpu_opdata MOD 16777216;

					CASE cpu_inst IS
						WHEN IS_READ =>
							cpu_wdata <= cpu_opdata;
							cpu_waddr <= 1;
						WHEN IS_WRITE =>
							cpu_wdata <= cpu_work;
							cpu_waddr <= operand;

						WHEN IS_ADD =>
							cpu_wdata <= cpu_work + cpu_opdata;
							cpu_waddr <= 1;
						WHEN IS_SUB =>
							cpu_wdata <= cpu_work - cpu_opdata;
							cpu_waddr <= 1;
						WHEN IS_MUL =>
							cpu_wdata <= cpu_work * cpu_opdata;
							cpu_waddr <= 1;
						WHEN IS_DIV =>
							--div1_fractional <= ;
							cpu_wdata <= conv_integer(div1_quotient);
							cpu_waddr <= 1;
						WHEN IS_AND =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, CPU_BIT_WIDTH) AND conv_std_logic_vector(cpu_opdata, CPU_BIT_WIDTH));
							cpu_waddr <= 1;
						WHEN IS_OR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, CPU_BIT_WIDTH) OR conv_std_logic_vector(cpu_opdata, CPU_BIT_WIDTH));
							cpu_waddr <= 1;
						WHEN IS_XOR =>
							cpu_wdata <= conv_integer(conv_std_logic_vector(cpu_work, CPU_BIT_WIDTH) XOR conv_std_logic_vector(cpu_opdata, CPU_BIT_WIDTH));
							cpu_waddr <= 1;

						WHEN IS_BRANCH =>
							IF (cpu_work /= 0) THEN
								cpu_wdata <= operand;
							ELSE
								cpu_wdata <= cpu_pc;
							END IF;
							cpu_waddr <= 0;
						WHEN IS_EQ =>
							cpu_wdata <= conv_integer(cpu_work = cpu_opdata);
							cpu_waddr <= 1;
						WHEN IS_NEQ =>
							cpu_wdata <= conv_integer(cpu_work /= cpu_opdata);
							cpu_waddr <= 1;
						WHEN IS_LT =>
							cpu_wdata <= conv_integer(cpu_work < cpu_opdata);
							cpu_waddr <= 1;
						WHEN IS_LTE =>
							cpu_wdata <= conv_integer(cpu_work <= cpu_opdata);
							cpu_waddr <= 1;
						WHEN IS_GT =>
							cpu_wdata <= conv_integer(cpu_work > cpu_opdata);
							cpu_waddr <= 1;
						WHEN IS_GTE =>
							cpu_wdata <= conv_integer(cpu_work >= cpu_opdata);
							cpu_waddr <= 1;
						WHEN OTHERS =>
					END CASE;

					cpu_stat <= 3;
				WHEN 3 => -- Write memory
					--case cpu_inst is
					--when IS_READ|IS_WRITE|IS_ADD|IS_SUB|IS_MUL|IS_DIV|IS_AND|IS_OR|IS_XOR| =>
					IF (cpu_waddr = 0) THEN
						cpu_pc <= cpu_wdata;
					ELSIF (cpu_waddr = 1) THEN
						cpu_work <= cpu_wdata;
					ELSIF (cpu_waddr = 2) THEN
						cpu_sp <= cpu_wdata;

					ELSIF (cpu_waddr = ADDR_I2C_ADDR) THEN
						i2c_1_addr <= conv_std_logic_vector(cpu_wdata, 7);
					ELSIF (cpu_waddr = ADDR_I2C_WDATA) THEN
						i2c_1_data_wr <= conv_std_logic_vector(cpu_wdata, 8);
						--elsif (cpu_waddr=ADDR_I2C_RDATA) then
						--	i2c_1_data_rd <= conv_std_logic_vector(cpu_wdata, 8);
					ELSIF (cpu_waddr = ADDR_I2C_STAT) THEN
						i2c_1_stat(1 DOWNTO 0) <= conv_std_logic_vector(cpu_wdata, 2);

					ELSIF (cpu_waddr >= 128 AND cpu_waddr <= 255) THEN
						cpu_greg((cpu_waddr - 128)MOD 128) <= cpu_wdata;
					ELSIF (cpu_waddr >= ADDR_BOOT AND cpu_waddr < ADDR_BOOT + SIZE_BOOT) THEN
						boot((cpu_waddr - ADDR_BOOT)MOD SIZE_BOOT) <= cpu_wdata;
					ELSIF (cpu_waddr >= 1024 AND cpu_waddr <= 2047) THEN
						vram_1_addrb <= CONV_std_logic_vector(((cpu_waddr - 1024)/32 MOD 32) * 32 + ((cpu_waddr - 1024)MOD 32), 10);
						vram_1_dinb <= CONV_std_logic_vector(cpu_wdata, 8);
						vram_1_web <= "1";
					ELSIF (cpu_waddr >= ADDR_STACK AND cpu_waddr < ADDR_STACK + SIZE_STACK) THEN
						stack1_addra <= conv_std_logic_vector(cpu_waddr - ADDR_STACK, 10);
						stack1_dina <= conv_std_logic_vector(cpu_wdata, CPU_BIT_WIDTH);
						stack1_wea <= "1";
					ELSIF (cpu_waddr >= ADDR_INS_1 AND cpu_waddr < ADDR_INS_1 + SIZE_INS_1) THEN
						ins_1_addra <= conv_std_logic_vector(cpu_waddr - ADDR_INS_1, 10);
						ins_1_dina <= conv_std_logic_vector(cpu_wdata, CPU_BIT_WIDTH);
						ins_1_wea <= "1";
					END IF;
					--when others =>
					--end case;

					cpu_stat <= 0;
				WHEN OTHERS =>
			END CASE;
		END IF;
	END PROCESS;

	cpu_addr <= cpu_pc WHEN cpu_stat = 0
		ELSE
		cpu_raddr WHEN cpu_stat = 1;

	cpu_rdata <= cpu_pc WHEN cpu_addr = 0
		ELSE
		cpu_work WHEN cpu_addr = 1
		ELSE
		cpu_sp WHEN cpu_addr = 2
		ELSE
		conv_integer(A_IN) WHEN cpu_addr = ADDR_A
		ELSE
		conv_integer(B_IN) WHEN cpu_addr = ADDR_B
		ELSE
		conv_integer(C_IN) WHEN cpu_addr = ADDR_C
		ELSE
		conv_integer(CNT_1) WHEN cpu_addr = ADDR_CNT_1
		ELSE
		to_integer(rand_rnd_num) WHEN cpu_addr = ADDR_RAND

		ELSE
		conv_integer(i2c_1_addr) WHEN cpu_addr = ADDR_I2C_ADDR
		ELSE
		conv_integer(i2c_1_data_wr) WHEN cpu_addr = ADDR_I2C_WDATA
		ELSE
		conv_integer(i2c_1_data_rd) WHEN cpu_addr = ADDR_I2C_RDATA
		ELSE
		conv_integer(i2c_1_stat) WHEN cpu_addr = ADDR_I2C_STAT

		ELSE
		cpu_greg((cpu_addr - 128) MOD 128) WHEN cpu_addr >= 128 AND cpu_addr <= 255
		ELSE
		boot((cpu_addr - ADDR_BOOT) MOD SIZE_BOOT) WHEN cpu_addr >= ADDR_BOOT AND cpu_addr < (ADDR_BOOT + SIZE_BOOT)
		ELSE
		conv_integer(vram_1_doutb) WHEN cpu_addr >= 1024 AND cpu_addr <= 2047
		ELSE
		conv_integer(stack1_douta) WHEN cpu_addr >= ADDR_STACK AND cpu_addr < (ADDR_STACK + SIZE_STACK)
		ELSE
		conv_integer(ins_1_douta) WHEN cpu_addr >= ADDR_INS_1 AND cpu_addr < (ADDR_INS_1 + SIZE_INS_1)
		;

	-- PPU
	PROCESS (clk) BEGIN
		IF (rising_edge(clk)) THEN
			CASE ppu_clkcnt IS
				WHEN 2032 =>
					ppu_clkcnt <= 0;

					CASE ppu_linecnt IS
						WHEN 262 =>
							ppu_linecnt <= 0;
						WHEN OTHERS =>
							ppu_linecnt <= ppu_linecnt + 1;
					END CASE;

				WHEN OTHERS =>
					ppu_clkcnt <= ppu_clkcnt + 1;
			END CASE;
		END IF;
	END PROCESS;

	stat_vsync <= '1' WHEN ppu_linecnt < 3 ELSE
		'0';
	stat_hsync <= '1' WHEN ppu_clkcnt < 150 ELSE
		'0';

	lum <= crom_1_dot;

	-- VRAM
	vram_1 : vram
	PORT MAP(
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
	vram_1_addra <= CONV_std_logic_vector(((ppu_linecnt - 32)/8) * 40 + ((ppu_clkcnt - 512 + 1)/4/8), 10);
	vram_1_clkb <= clk;

	-- INS RAM
	ins_1 : ins_1k
	PORT MAP(
		clka => ins_1_clka,
		wea => ins_1_wea,
		addra => ins_1_addra,
		dina => ins_1_dina,
		douta => ins_1_douta
	);
	ins_1_clka <= clk;

	-- CROM
	crom_1 : crom PORT MAP(
		chr => crom_1_chr,
		row => crom_1_row,
		col => crom_1_col,
		dot => crom_1_dot
	);
	crom_1_chr <= vram_1_douta(7 DOWNTO 0);
	crom_1_row <= conv_std_logic_vector(ppu_linecnt, 3);
	crom_1_col <= conv_std_logic_vector(ppu_clkcnt/4, 3);

	-- Stack
	stack_1 : stack
	PORT MAP(
		clka => stack1_clka,
		wea => stack1_wea,
		addra => stack1_addra,
		dina => stack1_dina,
		douta => stack1_douta
	);
	stack1_clka <= clk;

	-- Rand
	rand_1 : XSADD_GEN PORT MAP(
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
	PORT MAP(
		clk => div1_clk,
		rfd => div1_rfd,
		dividend => div1_dividend,
		divisor => div1_divisor,
		quotient => div1_quotient,
		fractional => div1_fractional);
	div1_clk <= clk;

	-- Controller IO
	PROCESS (clkcnt(2)) BEGIN
		IF (falling_edge(clkcnt(2))) THEN
			cnt_1(conv_integer(clkcnt(5 DOWNTO 3))) <= C(2);
		END IF;
	END PROCESS;

	-- I2C
	i2c_1 : i2c_master
	PORT MAP(
		clk => i2c_1_clk, --system clock
		reset_n => i2c_1_reset_n, --active low reset
		ena => i2c_1_ena, --latch in command
		addr => i2c_1_addr, --address of target slave
		rw => i2c_1_rw, --'0' is write, '1' is read
		data_wr => i2c_1_data_wr, --data to write to slave
		busy => i2c_1_busy, --indicates transaction in progress
		data_rd => i2c_1_data_rd, --data read from slave
		ack_error => i2c_1_ack_error, --flag if improper acknowledge from slave
		sda => i2c_1_sda, --serial data output of i2c bus
		scl => i2c_1_scl); --serial clock output of i2c bus
	i2c_1_clk <= clk;
	i2c_1_reset_n <= '1';
	i2c_1_ena <= i2c_1_stat(0);
	i2c_1_rw <= i2c_1_stat(1);
	i2c_1_stat(2) <= i2c_1_busy;
	i2c_1_stat(3) <= i2c_1_ack_error;

	-- Pin Outputs
	A(0) <= '0' WHEN (stat_vsync = '0' AND stat_hsync = '1') OR (stat_vsync = '1' AND ppu_clkcnt >= 150) ELSE
	'1';
	A(1) <= lum WHEN stat_vsync = '0' AND stat_hsync = '0' AND ppu_clkcnt > 511 AND ppu_clkcnt < (1536 + 8 * 8 * 4) AND ppu_linecnt >= 32 AND ppu_linecnt < 232 ELSE
	'0';
	A(15 DOWNTO 2) <= "00000000000000";
	B <= "0000000000000000";
	C(0) <= clkcnt(2);
	C(1) <= '1' WHEN clkcnt(5 DOWNTO 3) = "000" ELSE
	'0';
	C(2) <= 'Z'; -- input
	c(14) <= i2c_1_scl;
	c(15) <= i2c_1_sda;
	C(13 DOWNTO 3) <= "00000000000";

	-- Pin Inputs
	A_IN <= A;
	B_IN <= B;
	C_IN <= C;

END Behavioral;