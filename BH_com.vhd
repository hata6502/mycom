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
	signal A_IN: std_logic_vector(15 downto 0);
	signal B_IN: std_logic_vector(15 downto 0);
	signal C_IN: std_logic_vector(15 downto 0);
	
	-- Memory map
	constant ADDR_BOOT: integer := 256;
	constant SIZE_BOOT: integer := 512;

	constant ADDR_STACK: integer := 16776192;
	constant SIZE_STACK: integer := 1024;

	constant ADDR_RAND: integer := 3;
	constant ADDR_A: integer := 4;
	constant ADDR_B: integer := 5;
	constant ADDR_C: integer := 6;

	constant ADDR_CNT_1: integer := 7;
	
	constant ADDR_I2C_ADDR: integer := 8;
	constant ADDR_I2C_RDATA: integer := 9;
	constant ADDR_I2C_WDATA: integer := 10;
	constant ADDR_I2C_STAT: integer := 11;

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
is_word(IS_READ, 206), 	-- 326
is_word(IS_READ, 222), 	-- 327
is_word(IS_READ, 192), 	-- 328
is_word(IS_READ, 221), 	-- 329
is_word(IS_READ, 166), 	-- 330
is_word(IS_READ, 32), 	-- 331
is_word(IS_READ, 181), 	-- 332
is_word(IS_READ, 190), 	-- 333
is_word(IS_READ, 33), 	-- 334
is_word(IS_READ, 32), 	-- 335
is_word(IS_READ, 0), 	-- 336
is_word(IS_READ, 219), 	-- 337
is_word(IS_READ, 0), 	-- 338
is_word(IS_READ, 765), 	-- 339
is_word(IS_WRITE, 2), 	-- 340
is_word(IS_READ, 764), 	-- 341
is_word(IS_WRITE, 2), 	-- 342
is_word(IS_READ, 763), 	-- 343
is_word(IS_WRITE, 2), 	-- 344
is_word(IS_READ, 762), 	-- 345
is_word(IS_WRITE, 761), 	-- 346
is_word(IS_READ, 760), 	-- 347
is_word(IS_WRITE, 2), 	-- 348
is_word(IS_READ, 759), 	-- 349
is_word(IS_WRITE, 2), 	-- 350
is_word(IS_READ, 758), 	-- 351
is_word(IS_WRITE, 2), 	-- 352
is_word(IS_READ, 757), 	-- 353
is_word(IS_WRITE, 756), 	-- 354
is_word(IS_READ, 7), 	-- 355
is_word(IS_EQ, 755), 	-- 356
is_word(IS_BRANCH, 754), 	-- 357
is_word(IS_READ, 753), 	-- 358
is_word(IS_WRITE, 752), 	-- 359
is_word(IS_READ, 196), 	-- 360
is_word(IS_GTE, 751), 	-- 361
is_word(IS_BRANCH, 750), 	-- 362
is_word(IS_READ, 749), 	-- 363
is_word(IS_WRITE, 748), 	-- 364
is_word(IS_READ, 197), 	-- 365
is_word(IS_GTE, 747), 	-- 366
is_word(IS_BRANCH, 746), 	-- 367
is_word(IS_READ, 196), 	-- 368
is_word(IS_EQ, 745), 	-- 369
is_word(IS_BRANCH, 744), 	-- 370
is_word(IS_READ, 196), 	-- 371
is_word(IS_EQ, 743), 	-- 372
is_word(IS_BRANCH, 742), 	-- 373
is_word(IS_READ, 197), 	-- 374
is_word(IS_EQ, 741), 	-- 375
is_word(IS_BRANCH, 740), 	-- 376
is_word(IS_READ, 197), 	-- 377
is_word(IS_EQ, 739), 	-- 378
is_word(IS_BRANCH, 738), 	-- 379
is_word(IS_READ, 196), 	-- 380
is_word(IS_OR, 197), 	-- 381
is_word(IS_AND, 737), 	-- 382
is_word(IS_EQ, 736), 	-- 383
is_word(IS_BRANCH, 735), 	-- 384
is_word(IS_READ, 734), 	-- 385
is_word(IS_WRITE, 733), 	-- 386
is_word(IS_READ, 196), 	-- 387
is_word(IS_MUL, 732), 	-- 388
is_word(IS_ADD, 197), 	-- 389
is_word(IS_ADD, 731), 	-- 390
is_word(IS_WRITE, 730), 	-- 391
is_word(IS_READ, 729), 	-- 392
is_word(IS_WRITE, 2), 	-- 393
is_word(IS_READ, 192), 	-- 394
is_word(IS_WRITE, 2), 	-- 395
is_word(IS_READ, 728), 	-- 396
is_word(IS_WRITE, 2), 	-- 397
is_word(IS_READ, 727), 	-- 398
is_word(IS_WRITE, 726), 	-- 399
is_word(IS_READ, 197), 	-- 400
is_word(IS_ADD, 725), 	-- 401
is_word(IS_WRITE, 724), 	-- 402
is_word(IS_READ, 723), 	-- 403
is_word(IS_WRITE, 722), 	-- 404
is_word(IS_READ, 196), 	-- 405
is_word(IS_ADD, 721), 	-- 406
is_word(IS_WRITE, 720), 	-- 407
is_word(IS_READ, 719), 	-- 408
is_word(IS_WRITE, 718), 	-- 409
is_word(IS_READ, 717), 	-- 410
is_word(IS_WRITE, 716), 	-- 411
is_word(IS_READ, 196), 	-- 412
is_word(IS_GTE, 715), 	-- 413
is_word(IS_BRANCH, 714), 	-- 414
is_word(IS_READ, 3), 	-- 415
is_word(IS_AND, 713), 	-- 416
is_word(IS_WRITE, 712), 	-- 417
is_word(IS_READ, 711), 	-- 418
is_word(IS_WRITE, 2), 	-- 419
is_word(IS_READ, 197), 	-- 420
is_word(IS_WRITE, 2), 	-- 421
is_word(IS_READ, 710), 	-- 422
is_word(IS_WRITE, 2), 	-- 423
is_word(IS_READ, 196), 	-- 424
is_word(IS_WRITE, 2), 	-- 425
is_word(IS_READ, 709), 	-- 426
is_word(IS_WRITE, 708), 	-- 427
is_word(IS_READ, 248), 	-- 428
is_word(IS_BRANCH, 707), 	-- 429
is_word(IS_READ, 196), 	-- 430
is_word(IS_ADD, 706), 	-- 431
is_word(IS_WRITE, 705), 	-- 432
is_word(IS_READ, 704), 	-- 433
is_word(IS_WRITE, 703), 	-- 434
is_word(IS_READ, 702), 	-- 435
is_word(IS_WRITE, 701), 	-- 436
is_word(IS_READ, 196), 	-- 437
is_word(IS_GTE, 700), 	-- 438
is_word(IS_BRANCH, 699), 	-- 439
is_word(IS_READ, 698), 	-- 440
is_word(IS_WRITE, 697), 	-- 441
is_word(IS_READ, 197), 	-- 442
is_word(IS_GTE, 696), 	-- 443
is_word(IS_BRANCH, 695), 	-- 444
is_word(IS_READ, 3), 	-- 445
is_word(IS_AND, 694), 	-- 446
is_word(IS_WRITE, 693), 	-- 447
is_word(IS_EQ, 692), 	-- 448
is_word(IS_BRANCH, 691), 	-- 449
is_word(IS_READ, 690), 	-- 450
is_word(IS_WRITE, 2), 	-- 451
is_word(IS_READ, 192), 	-- 452
is_word(IS_WRITE, 2), 	-- 453
is_word(IS_READ, 196), 	-- 454
is_word(IS_WRITE, 2), 	-- 455
is_word(IS_READ, 197), 	-- 456
is_word(IS_WRITE, 2), 	-- 457
is_word(IS_READ, 689), 	-- 458
is_word(IS_WRITE, 688), 	-- 459
is_word(IS_READ, 248), 	-- 460
is_word(IS_BRANCH, 687), 	-- 461
is_word(IS_READ, 197), 	-- 462
is_word(IS_ADD, 686), 	-- 463
is_word(IS_WRITE, 685), 	-- 464
is_word(IS_READ, 684), 	-- 465
is_word(IS_WRITE, 683), 	-- 466
is_word(IS_READ, 196), 	-- 467
is_word(IS_ADD, 682), 	-- 468
is_word(IS_WRITE, 681), 	-- 469
is_word(IS_READ, 680), 	-- 470
is_word(IS_WRITE, 679), 	-- 471
is_word(IS_READ, 7), 	-- 472
is_word(IS_DIV, 678), 	-- 473
is_word(IS_ADD, 677), 	-- 474
is_word(IS_WRITE, 676), 	-- 475
is_word(IS_READ, 7), 	-- 476
is_word(IS_AND, 675), 	-- 477
is_word(IS_ADD, 674), 	-- 478
is_word(IS_WRITE, 673), 	-- 479
is_word(IS_READ, 672), 	-- 480
is_word(IS_WRITE, 671), 	-- 481
is_word(IS_READ, 2), 	-- 482
is_word(IS_WRITE, 670), 	-- 483
is_word(IS_ADD, 3), 	-- 484
is_word(IS_WRITE, 669), 	-- 485
is_word(IS_READ, 2), 	-- 486
is_word(IS_WRITE, 668), 	-- 487
is_word(IS_ADD, 3), 	-- 488
is_word(IS_WRITE, 667), 	-- 489
is_word(IS_READ, 2), 	-- 490
is_word(IS_WRITE, 666), 	-- 491
is_word(IS_ADD, 3), 	-- 492
is_word(IS_WRITE, 665), 	-- 493
is_word(IS_READ, 251), 	-- 494
is_word(IS_MUL, 664), 	-- 495
is_word(IS_ADD, 250), 	-- 496
is_word(IS_ADD, 663), 	-- 497
is_word(IS_WRITE, 662), 	-- 498
is_word(IS_READ, 252), 	-- 499
is_word(IS_NEQ, 661), 	-- 500
is_word(IS_BRANCH, 660), 	-- 501
is_word(IS_READ, 249), 	-- 502
is_word(IS_SUB, 659), 	-- 503
is_word(IS_WRITE, 658), 	-- 504
is_word(IS_READ, 657), 	-- 505
is_word(IS_WRITE, 656), 	-- 506
is_word(IS_READ, 252), 	-- 507
is_word(IS_NEQ, 655), 	-- 508
is_word(IS_BRANCH, 654), 	-- 509
is_word(IS_READ, 249), 	-- 510
is_word(IS_ADD, 653), 	-- 511
is_word(IS_WRITE, 652), 	-- 512
is_word(IS_READ, 651), 	-- 513
is_word(IS_WRITE, 650), 	-- 514
is_word(IS_READ, 252), 	-- 515
is_word(IS_NEQ, 649), 	-- 516
is_word(IS_BRANCH, 648), 	-- 517
is_word(IS_READ, 249), 	-- 518
is_word(IS_SUB, 647), 	-- 519
is_word(IS_WRITE, 646), 	-- 520
is_word(IS_READ, 645), 	-- 521
is_word(IS_WRITE, 644), 	-- 522
is_word(IS_READ, 252), 	-- 523
is_word(IS_NEQ, 643), 	-- 524
is_word(IS_BRANCH, 642), 	-- 525
is_word(IS_READ, 249), 	-- 526
is_word(IS_ADD, 641), 	-- 527
is_word(IS_WRITE, 640), 	-- 528
is_word(IS_READ, 639), 	-- 529
is_word(IS_WRITE, 638), 	-- 530
is_word(IS_READ, 249), 	-- 531
is_word(IS_WRITE, 637), 	-- 532
is_word(IS_ADD, 3), 	-- 533
is_word(IS_WRITE, 636), 	-- 534
is_word(IS_READ, 635), 	-- 535
is_word(IS_WRITE, 2), 	-- 536
is_word(IS_READ, 249), 	-- 537
is_word(IS_WRITE, 2), 	-- 538
is_word(IS_READ, 634), 	-- 539
is_word(IS_WRITE, 2), 	-- 540
is_word(IS_READ, 633), 	-- 541
is_word(IS_WRITE, 632), 	-- 542
is_word(IS_READ, 2), 	-- 543
is_word(IS_WRITE, 631), 	-- 544
is_word(IS_ADD, 3), 	-- 545
is_word(IS_WRITE, 630), 	-- 546
is_word(IS_READ, 2), 	-- 547
is_word(IS_WRITE, 629), 	-- 548
is_word(IS_ADD, 3), 	-- 549
is_word(IS_WRITE, 628), 	-- 550
is_word(IS_READ, 253), 	-- 551
is_word(IS_EQ, 627), 	-- 552
is_word(IS_BRANCH, 626), 	-- 553
is_word(IS_READ, 253), 	-- 554
is_word(IS_SUB, 625), 	-- 555
is_word(IS_WRITE, 624), 	-- 556
is_word(IS_READ, 623), 	-- 557
is_word(IS_WRITE, 622), 	-- 558
is_word(IS_READ, 2), 	-- 559
is_word(IS_WRITE, 621), 	-- 560
is_word(IS_ADD, 3), 	-- 561
is_word(IS_WRITE, 620), 	-- 562
is_word(IS_READ, 2), 	-- 563
is_word(IS_WRITE, 619), 	-- 564
is_word(IS_ADD, 3), 	-- 565
is_word(IS_WRITE, 618), 	-- 566
is_word(IS_READ, 2), 	-- 567
is_word(IS_WRITE, 617), 	-- 568
is_word(IS_ADD, 3), 	-- 569
is_word(IS_WRITE, 616), 	-- 570
is_word(IS_READ, 254), 	-- 571
is_word(IS_WRITE, 615), 	-- 572
is_word(IS_ADD, 3), 	-- 573
is_word(IS_EQ, 614), 	-- 574
is_word(IS_BRANCH, 613), 	-- 575
is_word(IS_READ, 254), 	-- 576
is_word(IS_WRITE, 612), 	-- 577
is_word(IS_ADD, 3), 	-- 578
is_word(IS_WRITE, 255), 	-- 579
is_word(IS_READ, 254), 	-- 580
is_word(IS_ADD, 611), 	-- 581
is_word(IS_WRITE, 610), 	-- 582
is_word(IS_READ, 255), 	-- 583
is_word(IS_ADD, 609), 	-- 584
is_word(IS_WRITE, 608), 	-- 585
is_word(IS_READ, 607), 	-- 586
is_word(IS_WRITE, 606), 	-- 587
is_word(IS_READ, 2), 	-- 588
is_word(IS_WRITE, 605), 	-- 589
is_word(IS_ADD, 3), 	-- 590
is_word(IS_WRITE, 604), 	-- 591
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
590, 	-- 605
0, 	-- 606
571, 	-- 607
255, 	-- 608
1, 	-- 609
254, 	-- 610
1, 	-- 611
578, 	-- 612
588, 	-- 613
0, 	-- 614
573, 	-- 615
255, 	-- 616
569, 	-- 617
254, 	-- 618
565, 	-- 619
0, 	-- 620
561, 	-- 621
0, 	-- 622
551, 	-- 623
253, 	-- 624
1, 	-- 625
559, 	-- 626
0, 	-- 627
253, 	-- 628
549, 	-- 629
0, 	-- 630
545, 	-- 631
0, 	-- 632
563, 	-- 633
337, 	-- 634
543, 	-- 635
248, 	-- 636
533, 	-- 637
0, 	-- 638
531, 	-- 639
249, 	-- 640
1, 	-- 641
531, 	-- 642
3, 	-- 643
0, 	-- 644
531, 	-- 645
249, 	-- 646
1, 	-- 647
523, 	-- 648
2, 	-- 649
0, 	-- 650
531, 	-- 651
249, 	-- 652
40, 	-- 653
515, 	-- 654
1, 	-- 655
0, 	-- 656
531, 	-- 657
249, 	-- 658
40, 	-- 659
507, 	-- 660
0, 	-- 661
249, 	-- 662
1104, 	-- 663
40, 	-- 664
252, 	-- 665
492, 	-- 666
251, 	-- 667
488, 	-- 668
250, 	-- 669
484, 	-- 670
0, 	-- 671
472, 	-- 672
1025, 	-- 673
48, 	-- 674
15, 	-- 675
1024, 	-- 676
48, 	-- 677
16, 	-- 678
0, 	-- 679
437, 	-- 680
196, 	-- 681
2, 	-- 682
0, 	-- 683
442, 	-- 684
197, 	-- 685
2, 	-- 686
445, 	-- 687
0, 	-- 688
482, 	-- 689
460, 	-- 690
445, 	-- 691
0, 	-- 692
192, 	-- 693
3, 	-- 694
467, 	-- 695
37, 	-- 696
197, 	-- 697
2, 	-- 698
472, 	-- 699
21, 	-- 700
196, 	-- 701
4, 	-- 702
0, 	-- 703
412, 	-- 704
196, 	-- 705
2, 	-- 706
415, 	-- 707
0, 	-- 708
482, 	-- 709
2, 	-- 710
428, 	-- 711
197, 	-- 712
3, 	-- 713
435, 	-- 714
37, 	-- 715
196, 	-- 716
2, 	-- 717
0, 	-- 718
360, 	-- 719
196, 	-- 720
1, 	-- 721
0, 	-- 722
365, 	-- 723
197, 	-- 724
1, 	-- 725
0, 	-- 726
563, 	-- 727
337, 	-- 728
400, 	-- 729
192, 	-- 730
1104, 	-- 731
40, 	-- 732
0, 	-- 733
400, 	-- 734
387, 	-- 735
0, 	-- 736
1, 	-- 737
387, 	-- 738
38, 	-- 739
387, 	-- 740
0, 	-- 741
387, 	-- 742
22, 	-- 743
387, 	-- 744
0, 	-- 745
405, 	-- 746
39, 	-- 747
197, 	-- 748
0, 	-- 749
410, 	-- 750
23, 	-- 751
196, 	-- 752
0, 	-- 753
355, 	-- 754
0, 	-- 755
0, 	-- 756
563, 	-- 757
326, 	-- 758
1104, 	-- 759
355, 	-- 760
0, 	-- 761
563, 	-- 762
290, 	-- 763
1024, 	-- 764
347, 	-- 765
0, 	-- 766
339	-- 767
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
		dividend: in std_logic_vector(15 downto 0);
		divisor: in std_logic_vector(15 downto 0);
		quotient: out std_logic_vector(15 downto 0);
		fractional: out std_logic_vector(15 downto 0)
		);
	end component;
	
	signal div1_clk: std_logic;
	signal div1_rfd: std_logic;
	signal div1_dividend: std_logic_vector(15 downto 0);
	signal div1_divisor: std_logic_vector(15 downto 0);
	signal div1_quotient: std_logic_vector(15 downto 0);
	signal div1_fractional: std_logic_vector(15 downto 0);
			
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
	signal i2c_1_stat      : std_logic_vector(3 downto 0);
	
begin 

	process(clk) begin
		if (rising_edge(clk)) then
			clkcnt <= clkcnt + 1;
		end if;
	end process;

	-- CPU
	process(clkcnt(3))
	variable inst: integer;
	variable operand: integer;
	begin
		if (rising_edge(clkcnt(3))) then
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
								stack1_dina <= conv_std_logic_vector(cpu_wdata, 32);
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
