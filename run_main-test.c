#include <stdio.h>
#include "pstring.h"

void run_func(int, Pstring *, Pstring*);

void run_main() {

    Pstring p1;
    Pstring p2;
    int len;
    int opt;
    int c1, c2;

    // initialize first pstring
    scanf("%d", &len);
    scanf("%s", p1.str);
    p1.len = len;


    // initialize second pstring
    scanf("%d", &len);
    scanf("%s", p2.str);
    p2.len = len;

    //printf("%d\n", p1.len);
    //printf("%d\n", p1);


    // select which function to run
    scanf("%d", &opt);

   // scanf("%d", &c1);
    //scanf("%d", &c2);

    run_func(opt, &p1, &p2);

}
