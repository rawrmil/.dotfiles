#include <stdio.h>
#include <string.h>

#define DDS_IMPLEMENTATION
#include "dds.h"

#define DEBUG 1

#define UT_ASSERT(cond_) \
	if (DEBUG) { printf("  UT_ASSERT: %s\n", #cond_); } \
	if (!(cond_)) { \
		return 0; \
		if (DEBUG) exit(1); \
	}

// T E S T S

char utf_barr_new_part1() {
	ddsbarr barr = ddsbarr_new("some", 4);
	UT_ASSERT(barr.len == 4);
	UT_ASSERT(barr.cap == 8);
	UT_ASSERT(strncmp(barr.buf, "some", 4) == 0);
	ddsbarr_free(barr);
	return 1;
}

char utf_barr_new_part2() {
	ddsbarr barr = ddsbarr_new("012345689abcdef0123456789ABCDEF!!!", 35);
	UT_ASSERT(barr.len == 35);
	UT_ASSERT(barr.cap == 64);
	UT_ASSERT(strncmp(barr.buf, "012345689abcdef0123456789ABCDEF!!!", 35) == 0);
	ddsbarr_free(barr);
	return 1;
}

char utf_barr_cat_part1() {
	ddsbarr barr = ddsbarr_new("something", 9);
	UT_ASSERT(strncmp(barr.buf, "something", 9) == 0);
	barr = ddsbarr_cat(barr, "123", 3);
	UT_ASSERT(barr.len == 12);
	UT_ASSERT(barr.cap == 16);
	UT_ASSERT(strncmp(barr.buf, "something123", 12) == 0);
	barr = ddsbarr_cat(barr, "abcde", 5);
	UT_ASSERT(barr.len == 17);
	UT_ASSERT(barr.cap == 32);
	UT_ASSERT(strncmp(barr.buf, "something123abcde", 17) == 0);
	ddsbarr_free(barr);
	return 1;
}

char utf_stk_new_part1() {
	ddsstk stk = ddsstk_new((int[]){ 1, 2, 3, 4 }, 4, sizeof(int));
	UT_ASSERT(stk.top == 4);
	UT_ASSERT(stk.stride == sizeof(int));
	UT_ASSERT(strncmp(stk.barr.buf, (char*)(int[]){ 1, 2, 3, 4 }, stk.stride*sizeof(int)) == 0);
	ddsstk_free(stk);
	return 1;
}

char utf_stk_new_part2() {
	struct test { int i; char c; float f; double d; };
	struct test testarr[333] = {0};
	for (size_t i = 0; i < 333; i++) {
		testarr[i] = (struct test){ .i = i, .c = '0'+(i%10), .f = (float)i/10, .d = (float)i/3 };
	}
	ddsstk stk = ddsstk_new(testarr, 333, sizeof(struct test));
	UT_ASSERT(stk.top == 333);
	UT_ASSERT(stk.stride == sizeof(struct test));
	UT_ASSERT(strncmp(stk.barr.buf, (char*)testarr, stk.stride*sizeof(struct test)) == 0);
	ddsstk_free(stk);
	return 1;
}

char utf_stk_pop_part1() {
	ddsstk stk = ddsstk_new((int[]){ 1, 2, 3, 4 }, 4, sizeof(int));
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 4);
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 3);
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 2);
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 1);
	ddsstk_free(stk);
	return 1;
}

char utf_stk_push_part1() {
	ddsstk stk = ddsstk_new(NULL, 0, sizeof(int));
	ddsstk_push(&stk, &(int){1});
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 1);
	printf("stk.top: %d\n", stk.top);
	printf("stk.stride: %d\n", stk.stride);
	ddsstk_push(&stk, &(int){1});
	ddsstk_push(&stk, &(int){2});
	ddsstk_push(&stk, &(int){3});
	ddsstk_push(&stk, &(int){4});
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 4);
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 3);
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 2);
	UT_ASSERT(*(int*)ddsstk_pop(&stk) == 1);
	ddsstk_free(stk);
	return 1;
}

// M A I N

size_t ut_count = 0;

#define UNIT_TEST(utf_) \
	printf("%d. %s: %s\n", ut_count++, #utf_, utf_() ? "[SUCC]" : "[FAIL]");

int main() {
	UNIT_TEST(utf_barr_new_part1);
	UNIT_TEST(utf_barr_new_part2);
	UNIT_TEST(utf_barr_cat_part1);
	UNIT_TEST(utf_stk_new_part1);
	UNIT_TEST(utf_stk_new_part2);
	UNIT_TEST(utf_stk_pop_part1);
	UNIT_TEST(utf_stk_push_part1);
	return 0;
}
