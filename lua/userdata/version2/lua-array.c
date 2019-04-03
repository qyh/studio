#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

typedef struct NumArray {
	int size;
	double values[1];
}NumArray;

static int newarray (lua_State *L) {
	int n = luaL_checkinteger(L, 1);
	size_t nbytes = sizeof(NumArray) + (n - 1)*sizeof(double);
	NumArray *a = (NumArray*)lua_newuserdata(L, nbytes);

	/*set a's metatable to array's metatable*/
	luaL_getmetatable(L, "LuaBook.array");

	/*Pops a table from the stack and sets it as the new metatable for the value at the given index.*/
	lua_setmetatable(L, -2); 
	a->size = n;
	return 1;
}

/**
 * check metatable
 */
static NumArray *checkarray(lua_State *L) {
	void *ud = luaL_checkudata(L, 1, "LuaBook.array");
	luaL_argcheck(L, ud != NULL, 1, "array expected");
	return (NumArray*)ud;
}

static double *getelem(lua_State* L) {
	NumArray *a = checkarray(L);
	int index = luaL_checkinteger(L, 2);

	luaL_argcheck(L, 1 <= index && index <= a->size, 2, "index out of range");

	return &a->values[index-1];
}
static int setarray(lua_State *L) {
	NumArray *a = checkarray(L);
	int index = luaL_checkinteger(L, 2);
	double value = luaL_checknumber(L, 3);

	luaL_argcheck(L, a != NULL, 1, "array expected");

	luaL_argcheck(L, 1 <= index && index <= a->size, 2, "index out of range");

	a->values[index - 1] = value;
	return 0;
}

static int getarray(lua_State *L) {
	NumArray *a = checkarray(L); 
	int index = luaL_checkinteger(L, 2);
	luaL_argcheck(L, a != NULL, 1, "array expected");

	luaL_argcheck(L, 1 <= index && index <= a->size, 2, "index out of range");

	lua_pushnumber(L, a->values[index-1]);

	return 1;
}

static int getsize(lua_State *L) {
	NumArray *a = checkarray(L);
	luaL_argcheck(L, a != NULL, 1, "array expected");
	lua_pushnumber(L, a->size);
	return 1;
}

static const struct luaL_Reg arraylib[] = {
	{"new", newarray},
	{"set", setarray},
	{"get", getarray},
	{"size", getsize},
	{NULL, NULL}
};

int luaopen_array(lua_State *L) {
	/*create metatable of the array*/
	luaL_newmetatable(L, "LuaBook.array");
	luaL_newlib(L, arraylib);
	return 1;
}


