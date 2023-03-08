int main(){
    int x,y;
    float z = 10.0;
    char c = 'c';    

    x = 5;
    y = 12;
    
    printf("Hello World!\n");
    printf("x = %d\ny = %d\n", x,y);
    printf("sum: %d\n", add(x,y));
    printf("difference: %d\n", subtract(x,y));

    printf("%d\n", &x);

    return 0;
}


int add(int x, int y){
    // This is a comment
    return x+y;
}


int subtract(int x, int y){
    /* This is another comment */
    return x-y;
}

