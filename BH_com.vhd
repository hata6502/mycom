library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
use work.XSADD.all;

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
	
	-- Memory map
	constant ADDR_BOOT: integer := 256;
	constant SIZE_BOOT: integer := 512;

	constant ADDR_STACK: integer := 16776960;
	constant SIZE_STACK: integer := 256;

	constant ADDR_RAND: integer := 3;

	-- CPU
	signal cpu_pc: integer := ADDR_BOOT;
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
	type prom is array (0 to SIZE_BOOT - 1) of integer;
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
is_word(IS_READ, 66), 	-- 290
is_word(IS_READ, 108), 	-- 291
is_word(IS_READ, 117), 	-- 292
is_word(IS_READ, 101), 	-- 293
is_word(IS_READ, 72), 	-- 294
is_word(IS_READ, 111), 	-- 295
is_word(IS_READ, 111), 	-- 296
is_word(IS_READ, 100), 	-- 297
is_word(IS_READ, 32), 	-- 298
is_word(IS_READ, 67), 	-- 299
is_word(IS_READ, 111), 	-- 300
is_word(IS_READ, 109), 	-- 301
is_word(IS_READ, 112), 	-- 302
is_word(IS_READ, 117), 	-- 303
is_word(IS_READ, 116), 	-- 304
is_word(IS_READ, 101), 	-- 305
is_word(IS_READ, 114), 	-- 306
is_word(IS_READ, 32), 	-- 307
is_word(IS_READ, 32), 	-- 308
is_word(IS_READ, 210), 	-- 309
is_word(IS_READ, 178), 	-- 310
is_word(IS_READ, 219), 	-- 311
is_word(IS_READ, 32), 	-- 312
is_word(IS_READ, 190), 	-- 313
is_word(IS_READ, 178), 	-- 314
is_word(IS_READ, 190), 	-- 315
is_word(IS_READ, 178), 	-- 316
is_word(IS_READ, 32), 	-- 317
is_word(IS_READ, 204), 	-- 318
is_word(IS_READ, 223), 	-- 319
is_word(IS_READ, 219), 	-- 320
is_word(IS_READ, 184), 	-- 321
is_word(IS_READ, 222), 	-- 322
is_word(IS_READ, 215), 	-- 323
is_word(IS_READ, 209), 	-- 324
is_word(IS_READ, 0), 	-- 325
is_word(IS_READ, 219), 	-- 326
is_word(IS_READ, 0), 	-- 327
is_word(IS_READ, 765), 	-- 328
is_word(IS_WRITE, 2), 	-- 329
is_word(IS_READ, 764), 	-- 330
is_word(IS_WRITE, 2), 	-- 331
is_word(IS_READ, 763), 	-- 332
is_word(IS_WRITE, 762), 	-- 333
is_word(IS_READ, 761), 	-- 334
is_word(IS_WRITE, 2), 	-- 335
is_word(IS_READ, 760), 	-- 336
is_word(IS_WRITE, 2), 	-- 337
is_word(IS_READ, 759), 	-- 338
is_word(IS_WRITE, 2), 	-- 339
is_word(IS_READ, 758), 	-- 340
is_word(IS_WRITE, 757), 	-- 341
is_word(IS_READ, 756), 	-- 342
is_word(IS_WRITE, 755), 	-- 343
is_word(IS_READ, 196), 	-- 344
is_word(IS_GTE, 754), 	-- 345
is_word(IS_BRANCH, 753), 	-- 346
is_word(IS_READ, 752), 	-- 347
is_word(IS_WRITE, 751), 	-- 348
is_word(IS_READ, 197), 	-- 349
is_word(IS_GTE, 750), 	-- 350
is_word(IS_BRANCH, 749), 	-- 351
is_word(IS_READ, 196), 	-- 352
is_word(IS_EQ, 748), 	-- 353
is_word(IS_BRANCH, 747), 	-- 354
is_word(IS_READ, 196), 	-- 355
is_word(IS_EQ, 746), 	-- 356
is_word(IS_BRANCH, 745), 	-- 357
is_word(IS_READ, 197), 	-- 358
is_word(IS_EQ, 744), 	-- 359
is_word(IS_BRANCH, 743), 	-- 360
is_word(IS_READ, 197), 	-- 361
is_word(IS_EQ, 742), 	-- 362
is_word(IS_BRANCH, 741), 	-- 363
is_word(IS_READ, 196), 	-- 364
is_word(IS_OR, 197), 	-- 365
is_word(IS_AND, 740), 	-- 366
is_word(IS_EQ, 739), 	-- 367
is_word(IS_BRANCH, 738), 	-- 368
is_word(IS_READ, 737), 	-- 369
is_word(IS_WRITE, 736), 	-- 370
is_word(IS_READ, 196), 	-- 371
is_word(IS_MUL, 735), 	-- 372
is_word(IS_ADD, 197), 	-- 373
is_word(IS_ADD, 734), 	-- 374
is_word(IS_WRITE, 733), 	-- 375
is_word(IS_READ, 732), 	-- 376
is_word(IS_WRITE, 2), 	-- 377
is_word(IS_READ, 192), 	-- 378
is_word(IS_WRITE, 2), 	-- 379
is_word(IS_READ, 731), 	-- 380
is_word(IS_WRITE, 2), 	-- 381
is_word(IS_READ, 730), 	-- 382
is_word(IS_WRITE, 729), 	-- 383
is_word(IS_READ, 197), 	-- 384
is_word(IS_ADD, 728), 	-- 385
is_word(IS_WRITE, 727), 	-- 386
is_word(IS_READ, 726), 	-- 387
is_word(IS_WRITE, 725), 	-- 388
is_word(IS_READ, 196), 	-- 389
is_word(IS_ADD, 724), 	-- 390
is_word(IS_WRITE, 723), 	-- 391
is_word(IS_READ, 722), 	-- 392
is_word(IS_WRITE, 721), 	-- 393
is_word(IS_READ, 720), 	-- 394
is_word(IS_WRITE, 719), 	-- 395
is_word(IS_READ, 196), 	-- 396
is_word(IS_GTE, 718), 	-- 397
is_word(IS_BRANCH, 717), 	-- 398
is_word(IS_READ, 3), 	-- 399
is_word(IS_AND, 716), 	-- 400
is_word(IS_WRITE, 715), 	-- 401
is_word(IS_READ, 714), 	-- 402
is_word(IS_WRITE, 2), 	-- 403
is_word(IS_READ, 197), 	-- 404
is_word(IS_WRITE, 2), 	-- 405
is_word(IS_READ, 713), 	-- 406
is_word(IS_WRITE, 2), 	-- 407
is_word(IS_READ, 196), 	-- 408
is_word(IS_WRITE, 2), 	-- 409
is_word(IS_READ, 712), 	-- 410
is_word(IS_WRITE, 711), 	-- 411
is_word(IS_READ, 248), 	-- 412
is_word(IS_BRANCH, 710), 	-- 413
is_word(IS_READ, 196), 	-- 414
is_word(IS_ADD, 709), 	-- 415
is_word(IS_WRITE, 708), 	-- 416
is_word(IS_READ, 707), 	-- 417
is_word(IS_WRITE, 706), 	-- 418
is_word(IS_READ, 705), 	-- 419
is_word(IS_WRITE, 704), 	-- 420
is_word(IS_READ, 196), 	-- 421
is_word(IS_GTE, 703), 	-- 422
is_word(IS_BRANCH, 702), 	-- 423
is_word(IS_READ, 701), 	-- 424
is_word(IS_WRITE, 700), 	-- 425
is_word(IS_READ, 197), 	-- 426
is_word(IS_GTE, 699), 	-- 427
is_word(IS_BRANCH, 698), 	-- 428
is_word(IS_READ, 3), 	-- 429
is_word(IS_AND, 697), 	-- 430
is_word(IS_WRITE, 696), 	-- 431
is_word(IS_EQ, 695), 	-- 432
is_word(IS_BRANCH, 694), 	-- 433
is_word(IS_READ, 693), 	-- 434
is_word(IS_WRITE, 2), 	-- 435
is_word(IS_READ, 192), 	-- 436
is_word(IS_WRITE, 2), 	-- 437
is_word(IS_READ, 196), 	-- 438
is_word(IS_WRITE, 2), 	-- 439
is_word(IS_READ, 197), 	-- 440
is_word(IS_WRITE, 2), 	-- 441
is_word(IS_READ, 692), 	-- 442
is_word(IS_WRITE, 691), 	-- 443
is_word(IS_READ, 248), 	-- 444
is_word(IS_BRANCH, 690), 	-- 445
is_word(IS_READ, 197), 	-- 446
is_word(IS_ADD, 689), 	-- 447
is_word(IS_WRITE, 688), 	-- 448
is_word(IS_READ, 687), 	-- 449
is_word(IS_WRITE, 686), 	-- 450
is_word(IS_READ, 196), 	-- 451
is_word(IS_ADD, 685), 	-- 452
is_word(IS_WRITE, 684), 	-- 453
is_word(IS_READ, 683), 	-- 454
is_word(IS_WRITE, 682), 	-- 455
is_word(IS_READ, 681), 	-- 456
is_word(IS_WRITE, 680), 	-- 457
is_word(IS_READ, 2), 	-- 458
is_word(IS_WRITE, 679), 	-- 459
is_word(IS_ADD, 3), 	-- 460
is_word(IS_WRITE, 678), 	-- 461
is_word(IS_READ, 2), 	-- 462
is_word(IS_WRITE, 677), 	-- 463
is_word(IS_ADD, 3), 	-- 464
is_word(IS_WRITE, 676), 	-- 465
is_word(IS_READ, 2), 	-- 466
is_word(IS_WRITE, 675), 	-- 467
is_word(IS_ADD, 3), 	-- 468
is_word(IS_WRITE, 674), 	-- 469
is_word(IS_READ, 251), 	-- 470
is_word(IS_MUL, 673), 	-- 471
is_word(IS_ADD, 250), 	-- 472
is_word(IS_ADD, 672), 	-- 473
is_word(IS_WRITE, 671), 	-- 474
is_word(IS_READ, 252), 	-- 475
is_word(IS_NEQ, 670), 	-- 476
is_word(IS_BRANCH, 669), 	-- 477
is_word(IS_READ, 249), 	-- 478
is_word(IS_SUB, 668), 	-- 479
is_word(IS_WRITE, 667), 	-- 480
is_word(IS_READ, 666), 	-- 481
is_word(IS_WRITE, 665), 	-- 482
is_word(IS_READ, 252), 	-- 483
is_word(IS_NEQ, 664), 	-- 484
is_word(IS_BRANCH, 663), 	-- 485
is_word(IS_READ, 249), 	-- 486
is_word(IS_ADD, 662), 	-- 487
is_word(IS_WRITE, 661), 	-- 488
is_word(IS_READ, 660), 	-- 489
is_word(IS_WRITE, 659), 	-- 490
is_word(IS_READ, 252), 	-- 491
is_word(IS_NEQ, 658), 	-- 492
is_word(IS_BRANCH, 657), 	-- 493
is_word(IS_READ, 249), 	-- 494
is_word(IS_SUB, 656), 	-- 495
is_word(IS_WRITE, 655), 	-- 496
is_word(IS_READ, 654), 	-- 497
is_word(IS_WRITE, 653), 	-- 498
is_word(IS_READ, 252), 	-- 499
is_word(IS_NEQ, 652), 	-- 500
is_word(IS_BRANCH, 651), 	-- 501
is_word(IS_READ, 249), 	-- 502
is_word(IS_ADD, 650), 	-- 503
is_word(IS_WRITE, 649), 	-- 504
is_word(IS_READ, 648), 	-- 505
is_word(IS_WRITE, 647), 	-- 506
is_word(IS_READ, 249), 	-- 507
is_word(IS_WRITE, 646), 	-- 508
is_word(IS_ADD, 3), 	-- 509
is_word(IS_WRITE, 645), 	-- 510
is_word(IS_READ, 644), 	-- 511
is_word(IS_WRITE, 2), 	-- 512
is_word(IS_READ, 249), 	-- 513
is_word(IS_WRITE, 2), 	-- 514
is_word(IS_READ, 643), 	-- 515
is_word(IS_WRITE, 2), 	-- 516
is_word(IS_READ, 642), 	-- 517
is_word(IS_WRITE, 641), 	-- 518
is_word(IS_READ, 2), 	-- 519
is_word(IS_WRITE, 640), 	-- 520
is_word(IS_ADD, 3), 	-- 521
is_word(IS_WRITE, 639), 	-- 522
is_word(IS_READ, 2), 	-- 523
is_word(IS_WRITE, 638), 	-- 524
is_word(IS_ADD, 3), 	-- 525
is_word(IS_WRITE, 637), 	-- 526
is_word(IS_READ, 253), 	-- 527
is_word(IS_EQ, 636), 	-- 528
is_word(IS_BRANCH, 635), 	-- 529
is_word(IS_READ, 253), 	-- 530
is_word(IS_SUB, 634), 	-- 531
is_word(IS_WRITE, 633), 	-- 532
is_word(IS_READ, 632), 	-- 533
is_word(IS_WRITE, 631), 	-- 534
is_word(IS_READ, 2), 	-- 535
is_word(IS_WRITE, 630), 	-- 536
is_word(IS_ADD, 3), 	-- 537
is_word(IS_WRITE, 629), 	-- 538
is_word(IS_READ, 2), 	-- 539
is_word(IS_WRITE, 628), 	-- 540
is_word(IS_ADD, 3), 	-- 541
is_word(IS_WRITE, 627), 	-- 542
is_word(IS_READ, 2), 	-- 543
is_word(IS_WRITE, 626), 	-- 544
is_word(IS_ADD, 3), 	-- 545
is_word(IS_WRITE, 625), 	-- 546
is_word(IS_READ, 254), 	-- 547
is_word(IS_WRITE, 624), 	-- 548
is_word(IS_ADD, 3), 	-- 549
is_word(IS_EQ, 623), 	-- 550
is_word(IS_BRANCH, 622), 	-- 551
is_word(IS_READ, 254), 	-- 552
is_word(IS_WRITE, 621), 	-- 553
is_word(IS_ADD, 3), 	-- 554
is_word(IS_WRITE, 255), 	-- 555
is_word(IS_READ, 254), 	-- 556
is_word(IS_ADD, 620), 	-- 557
is_word(IS_WRITE, 619), 	-- 558
is_word(IS_READ, 255), 	-- 559
is_word(IS_ADD, 618), 	-- 560
is_word(IS_WRITE, 617), 	-- 561
is_word(IS_READ, 616), 	-- 562
is_word(IS_WRITE, 2), 	-- 563
is_word(IS_READ, 615), 	-- 564
is_word(IS_WRITE, 2), 	-- 565
is_word(IS_READ, 614), 	-- 566
is_word(IS_WRITE, 613), 	-- 567
is_word(IS_READ, 612), 	-- 568
is_word(IS_WRITE, 611), 	-- 569
is_word(IS_READ, 2), 	-- 570
is_word(IS_WRITE, 610), 	-- 571
is_word(IS_ADD, 3), 	-- 572
is_word(IS_WRITE, 609), 	-- 573
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
572, 	-- 610
0, 	-- 611
547, 	-- 612
0, 	-- 613
523, 	-- 614
4096, 	-- 615
568, 	-- 616
255, 	-- 617
1, 	-- 618
254, 	-- 619
1, 	-- 620
554, 	-- 621
570, 	-- 622
0, 	-- 623
549, 	-- 624
255, 	-- 625
545, 	-- 626
254, 	-- 627
541, 	-- 628
0, 	-- 629
537, 	-- 630
0, 	-- 631
527, 	-- 632
253, 	-- 633
1, 	-- 634
535, 	-- 635
0, 	-- 636
253, 	-- 637
525, 	-- 638
0, 	-- 639
521, 	-- 640
0, 	-- 641
539, 	-- 642
326, 	-- 643
519, 	-- 644
248, 	-- 645
509, 	-- 646
0, 	-- 647
507, 	-- 648
249, 	-- 649
1, 	-- 650
507, 	-- 651
3, 	-- 652
0, 	-- 653
507, 	-- 654
249, 	-- 655
1, 	-- 656
499, 	-- 657
2, 	-- 658
0, 	-- 659
507, 	-- 660
249, 	-- 661
40, 	-- 662
491, 	-- 663
1, 	-- 664
0, 	-- 665
507, 	-- 666
249, 	-- 667
40, 	-- 668
483, 	-- 669
0, 	-- 670
249, 	-- 671
1104, 	-- 672
40, 	-- 673
252, 	-- 674
468, 	-- 675
251, 	-- 676
464, 	-- 677
250, 	-- 678
460, 	-- 679
0, 	-- 680
456, 	-- 681
0, 	-- 682
421, 	-- 683
196, 	-- 684
2, 	-- 685
0, 	-- 686
426, 	-- 687
197, 	-- 688
2, 	-- 689
429, 	-- 690
0, 	-- 691
458, 	-- 692
444, 	-- 693
429, 	-- 694
0, 	-- 695
192, 	-- 696
3, 	-- 697
451, 	-- 698
37, 	-- 699
197, 	-- 700
2, 	-- 701
456, 	-- 702
21, 	-- 703
196, 	-- 704
4, 	-- 705
0, 	-- 706
396, 	-- 707
196, 	-- 708
2, 	-- 709
399, 	-- 710
0, 	-- 711
458, 	-- 712
2, 	-- 713
412, 	-- 714
197, 	-- 715
3, 	-- 716
419, 	-- 717
37, 	-- 718
196, 	-- 719
2, 	-- 720
0, 	-- 721
344, 	-- 722
196, 	-- 723
1, 	-- 724
0, 	-- 725
349, 	-- 726
197, 	-- 727
1, 	-- 728
0, 	-- 729
539, 	-- 730
326, 	-- 731
384, 	-- 732
192, 	-- 733
1104, 	-- 734
40, 	-- 735
0, 	-- 736
384, 	-- 737
371, 	-- 738
0, 	-- 739
1, 	-- 740
371, 	-- 741
38, 	-- 742
371, 	-- 743
0, 	-- 744
371, 	-- 745
22, 	-- 746
371, 	-- 747
0, 	-- 748
389, 	-- 749
39, 	-- 750
197, 	-- 751
0, 	-- 752
394, 	-- 753
23, 	-- 754
196, 	-- 755
0, 	-- 756
0, 	-- 757
539, 	-- 758
290, 	-- 759
1024, 	-- 760
342, 	-- 761
0, 	-- 762
523, 	-- 763
65536, 	-- 764
334, 	-- 765
0, 	-- 766
328	-- 767
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

begin 

	process(clk) begin
		if (rising_edge(clk)) then
			clkcnt <= clkcnt + 1;
		end if;
	end process;

	-- CPU
	process(clkcnt(0))
	--process(clk)
	variable inst: integer;
	variable operand: integer;
	begin
		if (rising_edge(clkcnt(0))) then
		--if (rising_edge(clk)) then
			case cpu_stat is
				when 0 =>	-- Read instruction
					inst := cpu_rdata/16777216;
					operand := cpu_rdata mod 16777216;
					
					cpu_inst <= inst;
					cpu_pc <= cpu_pc + 1;
					
					cpu_raddr <= operand;
					if (operand>=1024 and operand<=2047) then
						vram_1_addrb <= CONV_std_logic_vector(((operand-1024)/32 mod 32)*32 + ((operand-1024)mod 32), 10);
						vram_1_web <= "0";
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
							elsif (cpu_waddr>=ADDR_BOOT and cpu_waddr<ADDR_BOOT + SIZE_BOOT) then
								boot((cpu_waddr - ADDR_BOOT)mod SIZE_BOOT) <= cpu_wdata;
							elsif (cpu_waddr>=1024 and cpu_waddr<=2047) then
								vram_1_addrb <= CONV_std_logic_vector(((cpu_waddr-1024)/32 mod 32)*32 + ((cpu_waddr-1024)mod 32), 10);
								vram_1_dinb <= CONV_std_logic_vector(cpu_wdata, 8);
								vram_1_web <= "1";
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
		else to_integer(rand_rnd_num) when cpu_addr=ADDR_RAND
		else cpu_greg((cpu_addr - 128) mod 128) when cpu_addr>=128 and cpu_addr<=255
		else boot((cpu_addr - ADDR_BOOT) mod SIZE_BOOT) when cpu_addr>=ADDR_BOOT and cpu_addr<(ADDR_BOOT + SIZE_BOOT)
		else stack((cpu_addr - ADDR_STACK) mod SIZE_STACK) when cpu_addr>=ADDR_STACK and cpu_addr<(ADDR_STACK + SIZE_STACK)
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

	A(0) <= '0' when (stat_vsync='0' and stat_hsync='1') or (stat_vsync='1' and ppu_clkcnt>=150) else '1';
	A(1) <= lum when stat_vsync='0' and stat_hsync='0' and ppu_clkcnt>511 and ppu_clkcnt<(1536 + 8*8*4) and ppu_linecnt>=32 and ppu_linecnt<232 else '0';
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

end Behavioral;
