#include <stdio.h>
#include <stdlib.h>
#include <sqlite3.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

const char* LIB_NAME = "_sqlite3";

typedef struct sqlite_t {
	sqlite3 *db;
}sqlite_t;

static int newsqlite(lua_State* L) {
	const char* filename = luaL_checkstring(L, 1);
	luaL_argcheck(L, filename != NULL, 1, "database name expected");
	sqlite_t* ud = (sqlite_t*)lua_newuserdata(L, sizeof(struct sqlite_t));
	int rc = sqlite3_open(filename, &ud->db);
	if (rc != 0) {
		luaL_error(L, "open sqlite db failed");
		return 0;
	}
	luaL_getmetatable(L, LIB_NAME);

	lua_setmetatable(L, -2);
	return 1;
}
static sqlite_t* checkarg(lua_State* L) {
	void *ud = luaL_checkudata(L, 1, LIB_NAME);
	luaL_argcheck(L, ud != NULL, 1, "sqlite_t expected");
	return (sqlite_t*)ud;
}
static int _test(lua_State* L) {
	sqlite_t* ud = checkarg(L);	
	lua_pushstring(L, "test func success");
	return 1;
}

static int _gc(lua_State* L) {
	sqlite_t* ud = checkarg(L);	
	if (ud->db) {
		sqlite3_close(ud->db);
		ud->db = NULL;
		lua_pushstring(L, "gc success");
	} else {
		lua_pushstring(L, "gc failed");
	}
	return 1;
}

static const struct luaL_Reg lib_f[] = {
	{"new", newsqlite},
	{NULL, NULL}
};
static const struct luaL_Reg lib_m[] = {
	{"test", _test},
	{"__gc", _gc},
	{NULL, NULL}
};
int luaopen_sqlite(lua_State *L) {
	/*create metatable of the array*/
	luaL_newmetatable(L, LIB_NAME);

	/* metatable.__index = metatable */
	lua_pushvalue(L, -1); /* duplicates the metatable */

	/**
	 * Does the equivalent to t[k] = v, where t is the value at the given index 
	 * and v is the value at the top of the stack. 
	 * This function pops the value from the stack. 
	 * As in Lua, this function may trigger a metamethod for the "newindex" event (see §2.4). 
	 */
	lua_setfield(L, -2, "__index");

	/**
	 * Registers all functions in the array l (see luaL_Reg) into the table on the top of the stack 
	 * (below optional upvalues, see next). 
	 */
	luaL_setfuncs(L, lib_m, 0);
	luaL_newlib(L, lib_f);
	return 1;
}

