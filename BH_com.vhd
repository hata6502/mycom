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
	constant SIZE_BOOT: cpu_int := 512;

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
is_word(IS_ADD, 3), 	-- 256
is_word(IS_ADD, 3), 	-- 257
is_word(IS_ADD, 3), 	-- 258
is_word(IS_ADD, 3), 	-- 259
is_word(IS_ADD, 3), 	-- 260
is_word(IS_ADD, 3), 	-- 261
is_word(IS_ADD, 3), 	-- 262
is_word(IS_ADD, 3), 	-- 263
is_word(IS_ADD, 3), 	-- 264
is_word(IS_ADD, 3), 	-- 265
is_word(IS_ADD, 3), 	-- 266
is_word(IS_ADD, 3), 	-- 267
is_word(IS_ADD, 3), 	-- 268
is_word(IS_ADD, 3), 	-- 269
is_word(IS_ADD, 3), 	-- 270
is_word(IS_ADD, 3), 	-- 271
is_word(IS_ADD, 3), 	-- 272
is_word(IS_ADD, 3), 	-- 273
is_word(IS_ADD, 3), 	-- 274
is_word(IS_ADD, 3), 	-- 275
is_word(IS_ADD, 3), 	-- 276
is_word(IS_ADD, 3), 	-- 277
is_word(IS_ADD, 3), 	-- 278
is_word(IS_ADD, 3), 	-- 279
is_word(IS_ADD, 3), 	-- 280
is_word(IS_ADD, 3), 	-- 281
is_word(IS_ADD, 3), 	-- 282
is_word(IS_ADD, 3), 	-- 283
is_word(IS_ADD, 3), 	-- 284
is_word(IS_ADD, 3), 	-- 285
is_word(IS_ADD, 3), 	-- 286
is_word(IS_ADD, 3), 	-- 287
is_word(IS_READ, 767), 	-- 288
is_word(IS_WRITE, 766), 	-- 289
is_word(IS_READ, 765), 	-- 290
is_word(IS_WRITE, 764), 	-- 291
is_word(IS_READ, 11), 	-- 292
is_word(IS_AND, 763), 	-- 293
is_word(IS_BRANCH, 762), 	-- 294
is_word(IS_READ, 761), 	-- 295
is_word(IS_WRITE, 760), 	-- 296
is_word(IS_READ, 759), 	-- 297
is_word(IS_WRITE, 758), 	-- 298
is_word(IS_READ, 11), 	-- 299
is_word(IS_AND, 757), 	-- 300
is_word(IS_EQ, 756), 	-- 301
is_word(IS_BRANCH, 755), 	-- 302
is_word(IS_READ, 11), 	-- 303
is_word(IS_AND, 754), 	-- 304
is_word(IS_BRANCH, 753), 	-- 305
is_word(IS_READ, 11), 	-- 306
is_word(IS_AND, 752), 	-- 307
is_word(IS_BRANCH, 751), 	-- 308
is_word(IS_READ, 750), 	-- 309
is_word(IS_WRITE, 749), 	-- 310
is_word(IS_READ, 748), 	-- 311
is_word(IS_WRITE, 747), 	-- 312
is_word(IS_READ, 11), 	-- 313
is_word(IS_AND, 746), 	-- 314
is_word(IS_EQ, 745), 	-- 315
is_word(IS_BRANCH, 744), 	-- 316
is_word(IS_READ, 743), 	-- 317
is_word(IS_WRITE, 742), 	-- 318
is_word(IS_READ, 11), 	-- 319
is_word(IS_AND, 741), 	-- 320
is_word(IS_BRANCH, 740), 	-- 321
is_word(IS_READ, 11), 	-- 322
is_word(IS_AND, 739), 	-- 323
is_word(IS_BRANCH, 738), 	-- 324
is_word(IS_READ, 737), 	-- 325
is_word(IS_WRITE, 736), 	-- 326
is_word(IS_READ, 735), 	-- 327
is_word(IS_WRITE, 734), 	-- 328
is_word(IS_READ, 11), 	-- 329
is_word(IS_AND, 733), 	-- 330
is_word(IS_EQ, 732), 	-- 331
is_word(IS_BRANCH, 731), 	-- 332
is_word(IS_READ, 11), 	-- 333
is_word(IS_AND, 730), 	-- 334
is_word(IS_BRANCH, 729), 	-- 335
is_word(IS_READ, 11), 	-- 336
is_word(IS_AND, 728), 	-- 337
is_word(IS_BRANCH, 727), 	-- 338
is_word(IS_READ, 9), 	-- 339
is_word(IS_WRITE, 128), 	-- 340
is_word(IS_READ, 128), 	-- 341
is_word(IS_ADD, 726), 	-- 342
is_word(IS_WRITE, 725), 	-- 343
is_word(IS_READ, 724), 	-- 344
is_word(IS_WRITE, 723), 	-- 345
0, 	-- 346
0, 	-- 347
0, 	-- 348
0, 	-- 349
0, 	-- 350
0, 	-- 351
0, 	-- 352
0, 	-- 353
0, 	-- 354
0, 	-- 355
0, 	-- 356
0, 	-- 357
0, 	-- 358
0, 	-- 359
0, 	-- 360
0, 	-- 361
0, 	-- 362
0, 	-- 363
0, 	-- 364
0, 	-- 365
0, 	-- 366
0, 	-- 367
0, 	-- 368
0, 	-- 369
0, 	-- 370
0, 	-- 371
0, 	-- 372
0, 	-- 373
0, 	-- 374
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
0, 	-- 511
0, 	-- 512
0, 	-- 513
0, 	-- 514
0, 	-- 515
0, 	-- 516
0, 	-- 517
0, 	-- 518
0, 	-- 519
0, 	-- 520
0, 	-- 521
0, 	-- 522
0, 	-- 523
0, 	-- 524
0, 	-- 525
0, 	-- 526
0, 	-- 527
0, 	-- 528
0, 	-- 529
0, 	-- 530
0, 	-- 531
0, 	-- 532
0, 	-- 533
0, 	-- 534
0, 	-- 535
0, 	-- 536
0, 	-- 537
0, 	-- 538
0, 	-- 539
0, 	-- 540
0, 	-- 541
0, 	-- 542
0, 	-- 543
0, 	-- 544
0, 	-- 545
0, 	-- 546
0, 	-- 547
0, 	-- 548
0, 	-- 549
0, 	-- 550
0, 	-- 551
0, 	-- 552
0, 	-- 553
0, 	-- 554
0, 	-- 555
0, 	-- 556
0, 	-- 557
0, 	-- 558
0, 	-- 559
0, 	-- 560
0, 	-- 561
0, 	-- 562
0, 	-- 563
0, 	-- 564
0, 	-- 565
0, 	-- 566
0, 	-- 567
0, 	-- 568
0, 	-- 569
0, 	-- 570
0, 	-- 571
0, 	-- 572
0, 	-- 573
0, 	-- 574
0, 	-- 575
0, 	-- 576
0, 	-- 577
0, 	-- 578
0, 	-- 579
0, 	-- 580
0, 	-- 581
0, 	-- 582
0, 	-- 583
0, 	-- 584
0, 	-- 585
0, 	-- 586
0, 	-- 587
0, 	-- 588
0, 	-- 589
0, 	-- 590
0, 	-- 591
0, 	-- 592
0, 	-- 593
0, 	-- 594
0, 	-- 595
0, 	-- 596
0, 	-- 597
0, 	-- 598
0, 	-- 599
0, 	-- 600
0, 	-- 601
0, 	-- 602
0, 	-- 603
0, 	-- 604
0, 	-- 605
0, 	-- 606
0, 	-- 607
0, 	-- 608
0, 	-- 609
0, 	-- 610
0, 	-- 611
0, 	-- 612
0, 	-- 613
0, 	-- 614
0, 	-- 615
0, 	-- 616
0, 	-- 617
0, 	-- 618
0, 	-- 619
0, 	-- 620
0, 	-- 621
0, 	-- 622
0, 	-- 623
0, 	-- 624
0, 	-- 625
0, 	-- 626
0, 	-- 627
0, 	-- 628
0, 	-- 629
0, 	-- 630
0, 	-- 631
0, 	-- 632
0, 	-- 633
0, 	-- 634
0, 	-- 635
0, 	-- 636
0, 	-- 637
0, 	-- 638
0, 	-- 639
0, 	-- 640
0, 	-- 641
0, 	-- 642
0, 	-- 643
0, 	-- 644
0, 	-- 645
0, 	-- 646
0, 	-- 647
0, 	-- 648
0, 	-- 649
0, 	-- 650
0, 	-- 651
0, 	-- 652
0, 	-- 653
0, 	-- 654
0, 	-- 655
0, 	-- 656
0, 	-- 657
0, 	-- 658
0, 	-- 659
0, 	-- 660
0, 	-- 661
0, 	-- 662
0, 	-- 663
0, 	-- 664
0, 	-- 665
0, 	-- 666
0, 	-- 667
0, 	-- 668
0, 	-- 669
0, 	-- 670
0, 	-- 671
0, 	-- 672
0, 	-- 673
0, 	-- 674
0, 	-- 675
0, 	-- 676
0, 	-- 677
0, 	-- 678
0, 	-- 679
0, 	-- 680
0, 	-- 681
0, 	-- 682
0, 	-- 683
0, 	-- 684
0, 	-- 685
0, 	-- 686
0, 	-- 687
0, 	-- 688
0, 	-- 689
0, 	-- 690
0, 	-- 691
0, 	-- 692
0, 	-- 693
0, 	-- 694
0, 	-- 695
0, 	-- 696
0, 	-- 697
0, 	-- 698
0, 	-- 699
0, 	-- 700
0, 	-- 701
0, 	-- 702
0, 	-- 703
0, 	-- 704
0, 	-- 705
0, 	-- 706
0, 	-- 707
0, 	-- 708
0, 	-- 709
0, 	-- 710
0, 	-- 711
0, 	-- 712
0, 	-- 713
0, 	-- 714
0, 	-- 715
0, 	-- 716
0, 	-- 717
0, 	-- 718
0, 	-- 719
0, 	-- 720
0, 	-- 721
0, 	-- 722
0, 	-- 723
327, 	-- 724
128, 	-- 725
1, 	-- 726
327, 	-- 727
8, 	-- 728
333, 	-- 729
4, 	-- 730
329, 	-- 731
0, 	-- 732
4, 	-- 733
11, 	-- 734
3, 	-- 735
128, 	-- 736
1024, 	-- 737
309, 	-- 738
8, 	-- 739
319, 	-- 740
4, 	-- 741
11, 	-- 742
0, 	-- 743
313, 	-- 744
0, 	-- 745
4, 	-- 746
11, 	-- 747
1, 	-- 748
10, 	-- 749
0, 	-- 750
295, 	-- 751
8, 	-- 752
303, 	-- 753
4, 	-- 754
299, 	-- 755
0, 	-- 756
4, 	-- 757
11, 	-- 758
1, 	-- 759
10, 	-- 760
0, 	-- 761
292, 	-- 762
4, 	-- 763
8, 	-- 764
80, 	-- 765
0, 	-- 766
290	-- 767

	);
	
	-- Stack
	COMPONENT stack
	  PORT (
		 clka : IN STD_LOGIC;
		 wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		 addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		 dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	  );
	END COMPONENT;	
	
	signal stack1_clka : STD_LOGIC;
	signal stack1_wea : STD_LOGIC_VECTOR(0 DOWNTO 0);
	signal stack1_addra : STD_LOGIC_VECTOR(9 DOWNTO 0);
	signal stack1_dina : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal stack1_douta : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
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
		else conv_integer(stack1_douta) when cpu_addr>=ADDR_STACK and cpu_addr<(ADDR_STACK + SIZE_STACK)
		else conv_integer(vram_1_doutb) when cpu_addr>=1024 and cpu_addr<=2047
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
