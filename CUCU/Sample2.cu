int func(int a, char *s) {
    // Removed printf statements inside func
    return 1;
}

int main(int argc, char *argv[]) {
    int i = 2 + 3;
    char *s = "world";
    i = func(i + 2, s);
    int x = func(i / 2, "hello");

    return i;
}
