dnl m4マクロ定義
  define(cat, $1$2$3$4$5$6$7$8$9)

dnl メモリマップ
  define(`pc', 0)
  define(`wreg', 1)
  define(`sp', 2)
  define(`fractional', 3)

  define(`fp', 128)

dnl 拡張命令
  define(`goto', `read $1; write pc')
  define(`mod', `div $1; read *fractional')
  define(`nop', `add 0')

  define(`inread_label_count', 0)
  dnl 間接読み込み
  define(`inread', `
    dnl 自己書き換えコード
    write cat(`inread_label_', inread_label_count);
    cat(`inread_label_', inread_label_count): 0;

    define(`inread_label_count', eval(inread_label_count + 1))
  ')
  dnl スタックからの相対読み込み
  define(`sread', `read *sp; add $1; inread')

  define(`return_label_count', 0)
  define(`push_arguments', `
    ifelse(
      $#, 0, ,
      $#, 1, `read $1; write *sp',
      `push_arguments(shift($@)); read $1; write *sp'
    )
  ')
  define(`call', `
    push_arguments(shift($@), cat(`return_label_', return_label_count));
    goto($1);
    cat(`return_label_', return_label_count):

    define(`return_label_count', eval(return_label_count + 1))
  ')

  define(`define_locals', `
    write *sp;

    ifelse(
      $#, 0, ,
      $#, 1, `
        define($1, local_count);
        define(`local_count', eval(local_count + 1))
      ',
      `
        define($1, local_count);
        define(`local_count', eval(local_count + 1));
        define_locals(shift($@))
      '
    )
  ')
  define(`locals', `
    define(`local_count', 0)
    define_locals($@)
  ')
  define(`arguments', `
    ifelse(
      $#, 0, ,
      $#, 1, `
        define($1, local_count);
        define(`local_count', eval(local_count + 1))
      ',
      `
        define($1, local_count);
        define(`local_count', eval(local_count + 1));
        arguments(shift($@))
      '
    )
  ')
  define(`return', `
    read *sp;
    add eval(local_count + 1);
    write sp;
    sread(-1);
    write pc
  ')

dnl 電源投入時にCPUの安定を待ってプログラム開始
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  nop;
  goto(main);
